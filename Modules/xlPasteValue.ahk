;--------------------------------------------------------------
; Paste cells values only
;--------------------------------------------------------------
~^!V::
; On Ctrl + Alt + V
#IfWinActive ahk_class XLMAIN
{
; Let hotkey through to Excel to bring up the special paste window
    WinWaitActive ahk_class bosa_sdm_XL9, , 2
    Send v{Enter}
}
return