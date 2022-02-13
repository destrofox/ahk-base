; Created by Asger Juul Brunshøj
; Modded by DestroFox 

; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in ¯\_(ツ)_/¯ that wouldn't work otherwise.
; Notepad will save UTF-8 files with BOM automatically (even though it does not say so).
; Some editors however save without BOM, and then special characters look messed up in the AHK GUI.

; Write your own AHK commands in this file to be recognized by the GUI. Take inspiration from the samples provided here.

;-------------------------------------------------------------------------------
;;; SEARCH GOOGLE and others
;-------------------------------------------------------------------------------
if user_command = go%A_Space% ; Search Google
{
    gui_search_title := "LMGTFY"
    gui_search("https://www.google.com/search?hl=en&q=REPLACEME")
}
else if user_command = m%A_Space% ; Open more than one URL
{
    gui_search_title := "multiple"
    gui_search("https://www.google.com/search?&q=REPLACEME")
    gui_search("https://www.bing.com/search?q=REPLACEME")
    gui_search("https://duckduckgo.com/?q=REPLACEME")
}
else if user_command = gox%A_Space% ; Search Google as Incognito
;   A note on how this works:
;   The function name "gui_search()" is poorly chosen.
;   What you actually specify as the parameter value is a command to run. It does not have to be a URL.
;   Before the command is run, the word REPLACEME is replaced by your input.
;   It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
;   So what this does is that it runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.
{
    gui_search_title = Google Search as Incognito
    gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?safe=off&q=REPLACEME")
}

;-------------------------------------------------------------------------------
;;; SEARCH OTHER THINGS ;;;
;-------------------------------------------------------------------------------
; else if user_command = swe ; Translate Swedish to English
; {
;     gui_search_title = Swedish to English
;     gui_search("https://translate.google.com/#sv/en/REPLACEME")
; }


;-------------------------------------------------------------------------------
;;; LAUNCH WEBSITES AND PROGRAMS ;;;
;-------------------------------------------------------------------------------
else if user_command = / ; Go to subreddit. This is a quick way to navigate to a specific URL.
{
    gui_search_title := "/r/"
    gui_search("chrome.exe -incognito https://www.reddit.com/r/REPLACEME")

;    gui_search("https://www.reddit.com/r/REPLACEME")
}

else if user_command = commitahk ; Copy ahk scripts from wip to released
{
    gui_destroy()
    Run, c:\users\%A_Username%\Documents\scripts\ahk\releaseScripts.bat
}

;**************************************************************************************** Web page
else if user_command = nectar ; Nectar
{
    gui_destroy()
    Run, chrome.exe /new-tab "Nectar link"
}

;**************************************************************************************** EXTRA
else if user_command = url ; Open an URL from the clipboard (naive - will try to run whatever is in the clipboard)
{
    gui_destroy()
    run %ClipBoard%
}


;-------------------------------------------------------------------------------
;;; INTERACT WITH THIS AHK SCRIPT ;;;
;-------------------------------------------------------------------------------
else if user_command = rel ; Reload this script
{
    gui_destroy() ; removes the GUI even when the reload fails
    Reload
}

/*else if user_command = dir ; Open the directory for this script
{
    gui_destroy()
    Run, %A_ScriptDir%
}
else if user_command = host ; Edit host script
{
    gui_destroy()
    run, notepad.exe "%A_ScriptFullPath%"
}
else if user_command = user ; Edit GUI user commands
{
    gui_destroy()
    run, notepad.exe "%A_ScriptDir%\GUI\UserCommands.ahk"
}

*/


;-------------------------------------------------------------------------------
;;; Enter text
;-------------------------------------------------------------------------------
else if user_command = @%A_Space% ; Email address
{
    gui_destroy()
    Send, firstname.lastname@email.domain
}
else if user_command = logo ; ¯\_(ツ)_/¯
{
    gui_destroy()
    Send ¯\_(ツ)_/¯
}

;-------------------------------------------------------------------------------
;;; OPEN FILES OR FOLDERS ;;;
;-------------------------------------------------------------------------------
else if user_command = ahk ; AutoHotkey runnables folder
{
    gui_destroy()
    run c:\users\%A_Username%\scripts\ahk\Runnables
}

;-------------------------------------------------------------------------------
;;; String generator/modifier ;;;
;-------------------------------------------------------------------------------
; else if user_command = xpath ; Copy path to X to the clipboard
; {
;     gui_destroy()
;     Clipboard := "\\path\to\X"
; }
else if user_command = pconv ; Convert a Windows-style path to a Linux one (replace all \ with /) 
{
    gui_destroy()
    Clipboard := StrReplace(Clipboard, "\", "/")
}

;-------------------------------------------------------------------------------
;;; VLC / system sound control ;;;
;-------------------------------------------------------------------------------
else if user_command = ff ; Mute system audio
{
    gui_destroy()
    Send {Volume_Mute}
}
else if user_command = jj ; Pause VLC track
{
    gui_destroy()
    SetTitleMatchMode, RegEx
    DetectHiddenWindows, On
    ControlSend,, {Space}, Lecteur multimédia VLC$ ahk_class i)^Qt5QWindowIcon$
    DetectHiddenWindows, Off
    SetTitleMatchMode, 1
}
else if user_command = jn ; Next VLC playlist item
{
    gui_destroy()
    SetTitleMatchMode, RegEx
    DetectHiddenWindows, On
    ControlSend,, n, Lecteur multimédia VLC$ ahk_class i)^Qt5QWindowIcon$
    DetectHiddenWindows, Off
    SetTitleMatchMode, 1
}
else if user_command = jp  ; Previous VLC playlist item
{
    gui_destroy()
    SetTitleMatchMode, RegEx
    DetectHiddenWindows, On
    ControlSend,, p, Lecteur multimédia VLC$ ahk_class i)^Qt5QWindowIcon$
    DetectHiddenWindows, Off
    SetTitleMatchMode, 1
}
else if user_command = ju ; VLC volume up
{
    gui_destroy()
    SetTitleMatchMode, RegEx
    DetectHiddenWindows, On
    ControlSend,, {Up}, Lecteur multimédia VLC$ ahk_class i)^Qt5QWindowIcon$
    DetectHiddenWindows, Off
    SetTitleMatchMode, 1
}
else if user_command = jd ; VLC volume down
{
    gui_destroy()
    SetTitleMatchMode, RegEx
    DetectHiddenWindows, On
    ControlSend,, {Down}, Lecteur multimédia VLC$ ahk_class i)^Qt5QWindowIcon$
    DetectHiddenWindows, Off
    SetTitleMatchMode, 1
}
 
;-------------------------------------------------------------------------------
;;; MISCELLANEOUS
;-------------------------------------------------------------------------------
else if user_command = date ; What is the date?
{
    gui_destroy()
    FormatTime, date,, LongDate
    MsgBox %date%
    date =
}
else if user_command = tbak ; Timestamp for backup file names
{
    gui_destroy()
    FormatTime, timestamp,, yyyyMMdd_HHmm
    Clipboard := timestamp
    date =
}
else if user_command = week ; Which week is it?
{
    gui_destroy()
    FormatTime, weeknumber,, YWeek
    StringTrimLeft, weeknumbertrimmed, weeknumber, 4
    if (weeknumbertrimmed = 53)
        weeknumbertrimmed := 1
    MsgBox It is currently week %weeknumbertrimmed%
    weeknumber =
    weeknumbertrimmed =
}
else if user_command = ? ; Tooltip with list of commands
{
    GuiControl,, user_command, ; Clear the input box
    Gosub, gui_commandlibrary
}


