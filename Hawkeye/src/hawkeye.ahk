; Author : DestroFox
; Based on the work of plul (Asger Juul Brunshøj)

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
CoordMode, Mouse, Screen
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2   ; Match window title if it contains a substring of the searched text.
#SingleInstance Force

;-------------------------------------------------------
;   CONSTANTS
;-------------------------------------------------------
; Maximum delay in seconds before launch of the PSA'Lib web interface
vmStartupDelay := 30

; Maximum duration in seconds for the user to enter his credentials
; after the PSA'Lib interface has been opened
vmLoginDelay := 30

; Maximum delay in seconds between the launch and the auto-close
; of PSA'Lib. If the user successfully logs in before the timeout
; the timer is interrupted.
vmCleanupDelay := 10

; The delay (ms) between the creation of the new window and its snapping
snapDelay := 800

; Error margin on pixel coordinates comparison
errorMargin := 20

;-------------------------------------------------------
; AUTO EXECUTE SECTION FOR INCLUDED SCRIPTS
; Scripts being included need to have their auto execute
; section in a function or subroutine which is then
; executed below.
;-------------------------------------------------------
Gosub, gui_autoexecute
;-------------------------------------------------------
; END AUTO EXECUTE SECTION
return
;-------------------------------------------------------

; Load the GUI code
#Include %A_ScriptDir%\GUI\GUI.ahk

; General settings
#Include %A_ScriptDir%\Miscellaneous\miscellaneous.ahk

; Custom key mapping and shortcuts
#Include %A_ScriptDir%\custom\keymap.ahk

; Non-inline custom functions
#Include %A_ScriptDir%\custom\my_udf.ahk

; Custom hotstrings
#Include %A_ScriptDir%\custom\hotstrings.ahk
#Include %A_ScriptDir%\custom\hotstrings_home.ahk
#Include %A_ScriptDir%\custom\throwaway_hotstrings.ahk
