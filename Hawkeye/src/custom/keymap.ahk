; Commented lines as the script is included in hawkeye
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;CoordMode, Mouse, Screen

;--------------------------------------------------------------
; Window tracker
;--------------------------------------------------------------
~Alt UP::
~Tab UP::
    Sleep, 50
    WinGetPos, WinXPos, WinYPos, WinWidth, WinHeight, A
    MouseMove, % (WinXPos + WinWidth/2), % (WinYPos + WinHeight/2), 0
    return

;--------------------------------------------------------------
; 
;--------------------------------------------------------------
^!+B::
; On Ctrl + Shift + Alt + B
    return

;--------------------------------------------------------------
; 
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + C
^!+C::
    return

;--------------------------------------------------------------
; 
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + D
^!+D::
    return

;--------------------------------------------------------------
; 
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + E
^!+E::
    return

;--------------------------------------------------------------
; 
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + F
^!+F::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + G
^!+G::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + I
^!+I::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + J
^!+J::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + K
^!+K::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + L
^!+L::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + M
^!+M::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + O
^!+O::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + P
^!+P::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
; On Ctrl + Shift + Alt + T
^!+T::
    return

;--------------------------------------------------------------
;
;--------------------------------------------------------------
~^!+V::
; On Ctrl + Shift + Alt + V
    return

;--------------------------------------------------------------
; Keys remap
;--------------------------------------------------------------
; Remap Esc to Backspace in WinExplorer
#IfWinActive ahk_class CabinetWClass
    Esc::BackSpace
#IfWinActive

; Remap F1 to F2 in Ms Excel
#IfWinActive ahk_class XLMAIN
    F1::F2
#IfWinActive

; Remap ² key (key under Esc, ~ on Qwerty layouts) to Enter
SC029::Enter

; Remap ² key to input a semicolon at the end of the current in VS Code
#IfWinActive Visual Studio Code
SC029::Send {End};
#IfWinActive

; Excel 
#IfWinActive ahk_class XLMAIN
    ; Remap mouse 4 and 5 to switch sheets
    XButton1::Send ^{PgUp}
    XButton2::Send ^{PgDn}
    ; Keystrokes chain : search text from clipboard in the current sheet
    ^E::
        SendInput, ^f
        SendInput, ^v
        Sleep, 100
        SendInput, {Enter}
    return
#IfWinActive

; Sublime Text specific
#IfWinActive ahk_class PX_WINDOW_CLASS
    ; Keystrokes chain : search clipboard text in all open files
    ^+F::
        SendInput, ^c
        Sleep, 100
        SendInput, ^+f
        SendInput, ^v
        SendInput, {Enter} 
    return       
#IfWinActive

; Remap CapsLock as modifier for text navigation
; Based on the hand-friendly text navigation by Philipp Otto

; Disable CapsLock key
SetCapsLockState, AlwaysOff

CapsLock & Z::
if GetKeyState("Alt") = 0
    SendInput,{Up}
else
    SendInput,+{Up}
return

CapsLock & Q::
if GetKeyState("Alt") = 0
    SendInput,{Left}
else
    SendInput,+{Left}
return

CapsLock & S::
if GetKeyState("Alt") = 0
    SendInput,{Down}
else
    SendInput,+{Down}
return

CapsLock & D::
if GetKeyState("Alt") = 0
    SendInput,{Right}
else
    SendInput,+{Right}
return

CapsLock & A::
if GetKeyState("Alt") = 0
    SendInput,{PgUp}
else
    SendInput,+{PgUp}
return

CapsLock & E::
if GetKeyState("Alt") = 0
    SendInput,{PgDn}
else
    SendInput,+{PgDn}
return

CapsLock & W::
SendInput,{WheelUp}
return

CapsLock & C::
SendInput,{WheelDown}
return

; Quick window on-screen shifting

; Move the active window to the next screen (left / right)
LAlt & WheelLeft::
KeyWait LAlt ; Change due to Win10 20H2 update, which opens an office tab on a browser whenever this hotkey is used.
SendInput,{LWin down}{LShift down}{Left down}{LWin up}{LShift up}{Left up}
return

LAlt & WheelRight::
KeyWait LAlt ; Change due to Win10 20H2 update, which opens an office tab on a browser whenever this hotkey is used.
SendInput,{LWin down}{LShift down}{Right down}{LWin up}{LShift up}{Right up}
return

; Minimize/maximize current window
CapsLock & WheelDown::
SendInput,{LWin down}{Down down}{LWin up}{Down up}
return

CapsLock & WheelUp::
SendInput,{LWin down}{Up down}{LWin up}{Up up}
return

; Anchor left/right the active window
CapsLock & WheelLeft::
SendInput,{LWin down}{Left down}{LWin up}{Left up}
return

CapsLock & WheelRight::
SendInput,{LWin down}{Right down}{LWin up}{Right up}
return

; Caps state management

; Keep CapsLock off even if the key is pressed in combination with another key
*Capslock::SetCapsLockState, AlwaysOff

; Only reenable CapsLock with Shift+Caps
+Capslock::SetCapsLockState, On

;-----------------------------------
; In Explorer, fast win open/close
;-----------------------------------
; In WinExplorer, use Shift+Click to open/close windows
#IfWinActive ahk_class CabinetWClass

; Open window
~LShift & LButton::
    udf_spawnWinExplorer(snapDelay, errorMargin)
    return

; Close window
~LShift & RButton::SendInput, ^w
#IfWinActive

;---------------------
; Single-click nav
;---------------------

; Caps + LClick -> Double click
CapsLock & LButton::
    Click, 2
return

; Caps + RClick -> Alt+Up
CapsLock & RButton::
    SendInput, !{Up}
return

;--------------------------------------------------------------
;--------------------------------------------------------------

^!Esc::Suspend      ; Press Ctrl+Alt+Esc to suspend/enable hotkeys
^Esc::ExitApp 		; Press Ctrl+Esc to exit the script