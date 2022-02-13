; On Ctrl + Click

#IfWinActive ahk_class CabinetWClass

; Get first two monitors resolutions
; Todo : reformat alg to use array for indefinite monitor count

SysGet, Monitor1, Monitor, 1
SysGet, Monitor2, Monitor, 2

; Error margin on the pixel comparisons
errorMargin = 20

; The delay (ms) between the creation of the new window and its snapping
snapDelay = 500

~LControl & LButton::
{
    WinGetActiveStats, title, w, h, x, y
    
    ; Determine the monitor on which the current window is displayed
    
    ; On monitor 2
    if (x > Monitor2Left - errorMargin)
    {
        MonitorLeft := Monitor2Left
        MonitorRight := Monitor2Right
    }

    ; On monitor 1
    else
    {
        MonitorLeft := Monitor1Left
        MonitorRight := Monitor1Right
    }

    ;MsgBox "MonitorLeft : %MonitorLeft%`nMonitorRight : %MonitorRight%"
    
    ; Compute where to snap the old and new windows
    
    if (abs(x - MonitorLeft) < errorMargin)
    {
        snapCurrentWindow := false
        snapNewWindowLeft := false
    }
    else if (abs(x - (MonitorLeft + (MonitorRight - MonitorLeft) / 2)) < errorMargin)
    {
        snapCurrentWindow := false
        snapNewWindowLeft := true
    }
    else
    {
        MsgBox "x : %x%`nMonitorLeft : %MonitorLeft%"
        snapCurrentWindow := true
        snapNewWindowLeft := false
    }
    
    ;MsgBox, snapCurrentWindow : %snapCurrentWindow%`n snapNewWindowLeft : %snapNewWindowLeft%
    
    ; Spawn new window and snap everything
    if snapCurrentWindow
    {
        if snapNewWindowLeft
            Send {LWin down}{Right down}{LWin up}{Right up}
        else
            Send {LWin down}{Left down}{LWin up}{Left up}
    }
    
    SendInput, ^n
    
    Sleep, snapDelay
    
    if snapNewWindowLeft
        Send {LWin down}{Left down}{LWin up}{Left up}    
    else
        Send {LWin down}{Right down}{LWin up}{Right up}
}

#IfWinActive
