﻿// MIT License
// Copyright (c) Wuping Xin 2020.
//
// Permission is hereby  granted, free of charge, to any  person obtaining a copy
// of this software and associated  documentation files (the "Software"), to deal
// in the Software  without restriction, including without  limitation the rights
// to  use, copy,  modify, merge,  publish, distribute,  sublicense, and/or  sell
// copies  of  the Software,  and  to  permit persons  to  whom  the Software  is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE  IS PROVIDED "AS  IS", WITHOUT WARRANTY  OF ANY KIND,  EXPRESS OR
// IMPLIED,  INCLUDING BUT  NOT  LIMITED TO  THE  WARRANTIES OF  MERCHANTABILITY,
// FITNESS FOR  A PARTICULAR PURPOSE AND  NONINFRINGEMENT. IN NO EVENT  SHALL THE
// AUTHORS  OR COPYRIGHT  HOLDERS  BE  LIABLE FOR  ANY  CLAIM,  DAMAGES OR  OTHER
// LIABILITY, WHETHER IN AN ACTION OF  CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE  OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

namespace Vissim.ComProvider.Utilities;

uses
  rtl;

  [SymbolName('HideVissim'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method HideVissim(aVissim: IUnknown);
  begin
    var pid: DWORD := 0;
    if not Succeeded(CoGetServerPID(aVissim, var pid)) then exit;
    var (success, hnd) := FindMainWindow(pid);
    if success then ShowWindow(hnd, SW_HIDE);
  end;

  [SymbolName('ShowVissim'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method ShowVissim(aVissim: IUnknown);
  begin
    var pid: DWORD := 0;
    if not Succeeded(CoGetServerPID(aVissim, var pid)) then exit;
    var (success, hnd) := FindMainWindow(pid);
    if success then ShowWindow(hnd, SW_NORMAL);
  end;

  [SymbolName('GetVissimSeverPID'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method GetVissimSeverPID(aVissim: IUnknown): DWORD;
  begin
    result := 0;
    CoGetServerPID(aVissim, var result);
  end;

  [SymbolName('GetVissimMainWindowHandle'), DLLExport, CallingConvention(CallingConvention.Stdcall)]
  method GetVissimMainWindowHandle(aVissim: IUnknown): HWND;
  begin
    var pid: DWORD := 0;
    if not Succeeded(CoGetServerPID(aVissim, var pid)) then exit nil;
    (_, result) := FindMainWindow(pid);
  end;

  {/*! Dll entry point. */}
  [SymbolName('__elements_dll_main', ReferenceFromMain := true)]
  method DllMain(aModule: HMODULE; aReason: DWORD; aReserved: ^Void): Boolean;
  begin
    method GetPluginDllPath: String;
    begin
      var lBuffer: array of Char := new Char[MAX_PATH];
      GetModuleFileName(aModule, lBuffer, MAX_PATH);
      exit String.FromCharArray(lBuffer);
    end;

    case aReason of
      DLL_PROCESS_ATTACH:
        exit true; 
      DLL_PROCESS_DETACH:
        exit true;
      DLL_THREAD_ATTACH:
        exit true;
      DLL_THREAD_DETACH:
        exit true;
    end;
  end;

end. 