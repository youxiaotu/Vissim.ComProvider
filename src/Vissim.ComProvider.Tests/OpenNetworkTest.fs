﻿open System

type Vissim = COM.``Vissim Object Library 20.0 64 Bit``.``14.0-win64``

[<EntryPoint; STAThread>]
let main argv =
    let vissim = Vissim.VissimClass()
    vissim.LoadNet @"C:\Users\Public\Documents\PTV Vision\PTV Vissim 2020\Examples Demo\Urban Intersection Beijing.CN\Intersection Beijing.inpx"
    0
