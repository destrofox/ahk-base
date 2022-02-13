/*
Use Caps Lock for Hand-Friendly Text Navigation
http://lifehacker.com/5277383/use-caps-lock-for-hand+friendly-text-navigation

Written by Philipp Otto, Germany

Script Function:
Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)

    Normal usage with capslock as a modifier:
    j: left
    k: down
    l: right
    i: up
---    h: simulates CTRL+left (jumps to the next word)
---    ö: simulates CTRL+right (commented out, you will need to adjust for your keyboard layout)
---    ,: simulates CTRL+Down
---    8: simulates CTRL+Up
---    u: simulates "Home" (jumps to the beginning of the current line) (i forgot to mention this in my comment)
---    o: simulates "End"
---    Backspace: simulates "Delete"
---    b: cut
---    c: copy
---    v: paste

    If you keep pressing Alt in addition to Capslock it works as if you are pressing "Shift" —> you highlight the text. Shift + Capslock activates the actual Capslock functionality (normal capslock-hitting deactivates it again).

*/
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir 
;_ScriptDir%  ; Ensures a consistent starting directory.


CapsLock & Z::
       if getkeystate("alt") = 0
               Send,{Up}
       else
               Send,+{Up}
return

CapsLock & D::
       if getkeystate("alt") = 0
               Send,{Right}
       else
               Send,+{Right}
return

CapsLock & Q::
       if getkeystate("alt") = 0
               Send,{Left}
       else
               Send,+{Left}
return

CapsLock & S::
       if getkeystate("alt") = 0
               Send,{Down}
       else
               Send,+{Down}
return

;Prevents CapsState-Shifting
CapsLock & Space::Send,{Space}

*Capslock::SetCapsLockState, AlwaysOff
+Capslock::SetCapsLockState, On