; On Ctrl + Click

#IfWinActive ahk_class CabinetWClass

; Error margin on the pixel comparisons
errorMargin = 20

; The delay (ms) between the creation of the new window and its snapping
snapDelay = 800

~LControl & LButton::
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
        snapCurrentWindow := false
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
return

#IfWinActive
