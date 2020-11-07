DetectHiddenWindows, On
SetTitleMatchMode, 2
Loop {
   WinClose, .ahk
   IfWinNotExist, .ahk
      Break     ;No [more] matching windows found
}

#IfWinExist, Autohotkey.exe
Process, Close, Autohotkey.exe