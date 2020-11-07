#SingleInstance, Force

;GUI SETTINGS
;---------------------------------------

;GUI, +AlwaysOnTop
GUI, Font, cWhite s10, Verdana
GUI, Color, 5383e8
GUI, Show, xCenter yCenter w340 h350, Op GG Auto Searcher

;ADDING BUTTONS GUI
;---------------------------------------

GUI, Add, Text, , === Welcome To The Op GG Auto Searcher! ===`n====================================

GUI, Add, Text, x90, Select your op.gg region:
GUI, Add, DDL, x75 vRegion w200, EUW|EUN|NA|KOREA|LAN|LAS|

GUI, Add, Text, x30, What does it say when you enter the lobby?
GUI, Add, Edit, x100 vJoinMsg cBlack

GUI, Add, Text, x80, Select the explorer to use:
GUI, Add, ListBox, vExplorer w200 h60 x70 cBlack, chrome|firefox|opera

GUI, Add, Text, x80, Assign a search key:
GUI, Add, Edit, x+10 yp w25 vUserKey cBlack

GUI, Add, Button, w100 h30 x115 gSaveChanges, Use Settings

GUI, Add, Button, w70 h25 x130 gAutoSearchOpGG, Search

GuiControl, Hide, Search
Return

;LABELS and its FUNCTIONS
;---------------------------------------

GuiClose:
    ExitApp

SaveChanges:
    GUI, Submit, NoHide
    if(Region == "")
    {
        MsgBox, 0, Attention, Please, select a region first!
        Return
    }
    if(JoinMsg == "")
    {
        MsgBox, 0, Attention, Please, write the joining message!
        Return
    }
    if(Explorer == "")
    {
        MsgBox, 0, Attention, Please, select a the explorer to use!
        Return
    }
    if(StrLen(UserKey) > 2)
    {
        MsgBox, 0, Assign Key Error, That's not a real key command!
    }

    if(UserKey != "")
    {
        Hotkey, %UserKey%, AutoSearchOpGG
        MsgBox, 0, Key Assign Successfully, Key %UserKey% was assign
    }

    GuiControl, Show, Search

    MsgBox, 0, Success, Settings Were Saved Successfully
Return

AutoSearchOpGG:
    IfWinExist, ahk_class RCLIENT
    {
        WinGetPos , , , Width, Height
        WinActivate
        WinWaitActive
        CoordMode, Mouse, Relative
        MouseMove, 170, Width>1024? 550:500, 0
        Clipboard := ""
        Click
        Send, ^a
        Send, ^c
        if(Clipboard != "")
        {
            StringReplace, Clipboard, Clipboard, %A_Space%,, All
            StringReplace, result, Clipboard, %JoinMsg%, `%2C, Limit=4
            Clipboard:=result
            Run, %Explorer%.exe https://%Region%.op.gg/multi/query=%result%
        }
    } 
    Else
    {
        MsgBox, 0, Attention, You need to have the lol client opened
    }
Return

F1::Run, chrome.exe https://www.youtube.com/watch?v=dQw4w9WgXcQ