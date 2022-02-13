;--------------------------------------------------------------
; Close Excel and discard changes
;--------------------------------------------------------------
#IfWinActive ahk_class XLMAIN ;NUIDialog
{
^!W::
; On Ctrl + Shift + W

Send, ^w

Send, {Tab}{Enter}
;    WinGetClass, active, A
;    MsgBox %active%
    ; Wait for the prompt dialog
;    WinWaitActive, Microsoft Excel, , 2
 ;   If WinActive ahk_class NUIDialog
 ;   {
 ;       Send, {Tab}{Enter}
 ;   }
return
}
#IfWinActive
;return
