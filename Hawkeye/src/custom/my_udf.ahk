;--------------------------------------------------------------
; Run Win snipping tool, deprecate and switch to Win + Shift + S when possible
;--------------------------------------------------------------
udf_snippingTool()
{
    If WinExist("Snipping Tool")
    {
    	WinActivate
    }
    else
    {
    	Run "C:\windows\system32\SnippingTool.exe"
    }

    WinWaitActive, Outil Capture d'écran
    Send ^n
}

;--------------------------------------------------------------
; Open any file which spawns a new window per file like Ms Excel
;--------------------------------------------------------------
udf_openFile(fileFullPath)
{
    ; Extract the file name from the full path string
    ; No actual check of the filesystem is done.
    ; SplitPath returns everything after the last \
    SplitPath, fileFullPath, fileName
    
    ; If the file is already open, set it as the active window
    If WinExist(fileName)
    {
    	WinActivate
    }
    ; Open it otherwise.
    else
    {
        Run, %fileFullPath%
    }
}

;--------------------------------------------------------------
; Launch PSA'Lib VM, reconfigure for reuse, if possible.
;--------------------------------------------------------------
udf_launchVM(browser := "chrome", vmStartupDelay := 40, vmLoginDelay := 40, vmCleanupDelay := 40)
{
    ; Use window-relative coordinates for mouse actions
    CoordMode, Mouse, Window

    ; Location of the VM icon relative to the browser window
    
    ; First VM position
    clickX = 0
    clickY = 0

    
    clickOffsetFromImageTopLeft = 30

    ; Second VM position
    ;clickX = 400
    ;clickY = 245
    
    ; Search region bounds
    searchTopLeftX = 100
    searchTopLeftY = 400
    searchBotRightX = 250
    searchBotRightY = 525

    ; Sleep duration between two consecutive searches (ms)
    delayBetweenSearches := 500

    ; Max number of time a search of the target image should be performed
    maxSearch := vmLoginDelay * 1000 / delayBetweenSearches

    searchCount := 0

    ; MsgBox, delays are %vmStartupDelay% - %vmLoginDelay%
    ; Activate the window if it exists...
    if WinExist("ahk_exe CDViewer.exe")
    {   
    	WinActivate
    }
    ; ...open the web interface to launch it if it doesn't
    else
    {
        ; Launch web interface to boot the VM
        if (browser = "chrome")
        {
            Run, chrome.exe /new-window "PSA'Lib link'"
        }
        else if (browser = "iExplorer")
        {
            Run, iexplore.exe "PSA'Lib link"
        }
        else
        {
            return
        }

        ; Wait for the PSA'Lib login page
        WinWait, PSALib, , vmStartupDelay
        WinMaximize
        
        ; SSOX should log us in at this point

        Loop
        {
            ImageSearch, xFound, yFound, searchTopLeftX, searchTopLeftY, searchBotRightX, searchBotRightY, img/vm_icon.png
            searchCount++
            ; If the search cannot be done (ex. image could not be loaded, ...)
            if (ErrorLevel = 2)
            {
                MsgBox, Could not perform the search. Switch to manual mode.
                goto reset_env
            }
            ; If the image was found or the max number of searches has been made
            else if (ErrorLevel = 0 || searchCount == maxSearch)
            {
                clickX := xFound + clickOffsetFromImageTopLeft
                clickY := yFound + clickOffsetFromImageTopLeft
                break
            }

            ; Wait 500 ms between two consecutive searches
            Sleep, 500
        }

        if (searchCount < maxSearch)
        {
            Click, %clickX%, %clickY%
            WinWait, ahk_exe CDViewer.exe, , vmCleanupDelay
            if WinExist("ahk_exe CDViewer.exe")
            {
                If WinExist("PSALib")
                {
                    WinClose
                }
            }
        }
        else
        {
            MsgBox, You did not login or start the VM fast enough (%vmLoginDelay% seconds). Switch to manual mode.
        }
    }

    reset_env:
        CoordMode, Mouse, Screen
}

;--------------------------------------------------------------
; Open a DocInfo page, re-configure for reuse
;--------------------------------------------------------------
udf_openDocInfo(reference, version := "vc", browser := "iExplorer")
{
    if (browser = "chrome")
    {
        Run, chrome.exe /new-tab "DocInfo Link"
    }
    else if (browser = "iExplorer")
    {
        Run, iexplore.exe "DocInfo Link"
    }
    else
    {
        return
    }
}

;-----------------------------------
; In Explorer, fast win open/close
;-----------------------------------

; Spawn a new WinExplorer window
; Snap the existing one to the closest edge (left / right) of its parent monitor
; Snap the new window to the other edge, effectively splitting the monitor in two
;   between the two WinExplorer windows.
udf_spawnWinExplorer(snapDelay, errorMargin)
{
    WinGetPos, x, y, , A
    
    ; Get the monitor which displays the current window
    winHandle := winExist("A")
    VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
    monitorHandle := DllCall("MonitorFromWindow", "Ptr", winHandle, "UInt", 0x2)
    DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo)

    leftEdge      := NumGet(monitorInfo, 20, "Int") ; Left
    rightEdge     := NumGet(monitorInfo, 28, "Int") ; Right
    ; workTop       := NumGet(monitorInfo, 24, "Int") ; Top
    ; workBottom    := NumGet(monitorInfo, 32, "Int") ; Bottom

    ; MsgBox "MonitorLeft : %leftEdge%`nMonitorRight : %rightEdge%"

    ; Compute where to snap the old and new windows

    if (abs(x - leftEdge) < errorMargin)
    {
        ; MsgBox, Win snapped left

        ; Current window is already snapped to the left edge,
        ; or close enough : no need to snap it.
        snapCurrentWindow := false

        ; Snap newly spawn window to the right edge of the screen
        snapNewWindowLeft := false
    }

    else if (abs(x - (leftEdge + (rightEdge - leftEdge) / 2)) < errorMargin)
    {
        ; MsgBox, Win snapped right
        snapCurrentWindow := false
        snapNewWindowLeft := true
    }
    else
    {
        ; MsgBox, Win not snapped

        ; Current window doesn't apppear to be snapped to either side.
        ; Snap it left and the new window right.
        snapCurrentWindow := true
        snapNewWindowLeft := false
    }
    
    ;MsgBox, snapCurrentWindow : %snapCurrentWindow%`n snapNewWindowLeft : %snapNewWindowLeft%
    
    ; Snap current window (if needed)
    if snapCurrentWindow
    {
        if snapNewWindowLeft
            Send {LWin down}{Right down}{LWin up}{Right up}
        else
            Send {LWin down}{Left down}{LWin up}{Left up}
    }
    
    ; Spawn and snap new window
    SendInput, ^n
    Sleep, snapDelay
    
    if snapNewWindowLeft
        Send {LWin down}{Left down}{LWin up}{Left up}    
    else
        Send {LWin down}{Right down}{LWin up}{Right up}
}

trim_diag_trace(ini_file)
{
	Clipboard := ""
    Send, ^c
	ClipWait 1
	trace_file := Clipboard
	RunWait, c:\user\U561142\Doc\python\framExtract\framExtract\trace_extract.exe -i "%ini_file%" -t "%trace_file%"
    ret_code := ErrorLevel
	
    if (ret_code = 10)
    {
        MsgBox, "Trace file does not exist."
    }
    else if (ret_code = 11)
    {
        MsgBox, "No DIAG frames (0x752 or 0x652) found in the trace file."
    }
}