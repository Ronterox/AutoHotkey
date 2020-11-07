#SingleInstance, Force
;TODO: preguntar region
;TODO: preguntar frase de entrada
;TODO: explorer specific to use
;All above with GUI

;GUI SYSTEM
;---------------------------------------

GUI, Show, xCenter yCenter w500 h500, Hello World
GUI, Add, Button, x200 y200 w100 h50 gFuckYou, If you press me...
Return

;GUI LABELS
;---------------------------------------

GuiClose:
    ExitApp

gFuckYou:
    FuckYou()
Return

;GUI Functions
;---------------------------------------

FuckYou()
{
    loop 5
        SoundBeep, 250, 1000
        Sleep, 1000
Return
}

;END of GUI
;---------------------------------------

F1::
    IfWinExist, ahk_class RCLIENT
    {
        WinGetPos , , , Width, Height, ahk_class RCLIENT
        WinActivate, ahk_class RCLIENT
        CoordMode, Mouse, Relative
        if(Width>1024)
        {
            MouseMove, 170, 550
        }
        Else
        {
            MouseMove, 170, 500
        }
        Click
        Send, ^a
        Send, ^c
        ;Run, chrome.exe "https://op.gg/multi/"
        ;Sleep, 3000
        ;MouseMove, 650, 300

        ;----------------------Version 2.0 From Here---------------------------
        StringReplace, result, Clipboard, joined the lobby, `%2C, All
        result:=Trim(result)
        Clipboard:=result
        Run, chrome.exe https://op.gg/multi/query=%result%
        Return
    }

    F2::Run, chrome.exe https://www.youtube.com/watch?v=dQw4w9WgXcQ