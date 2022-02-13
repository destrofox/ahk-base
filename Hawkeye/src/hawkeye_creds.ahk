#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force

;--------------------------------------------------------------
; Input user ID
;--------------------------------------------------------------
^!+U::
; On Ctrl + Shift + Alt + U
;Send ^l
;Sleep, 250
;Send ^c{Tab}
; Only allow credential input after checking the url
;If (InStr(Clipboard, ".inetpsa.") or InStr(Clipboard, ".mpsa."))
;{
    SendInput, user_id{Tab}user_password{Enter} ;Jeb4ited
;}
return
