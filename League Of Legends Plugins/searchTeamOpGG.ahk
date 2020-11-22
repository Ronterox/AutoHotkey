;Made by Ricardo Montserrat
;Most of the commented things are for debugging
#SingleInstance, Force
#NoEnv

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
GUI, Add, DDL, x75 vRegion w200, EUW||EUN|NA|KOREA|LAN|LAS|

GUI, Add, Text, x30, What does it say when you enter the lobby?
GUI, Add, Edit, x100 vJoinMsg cBlack h22 w140 Lowercase, joined the lobby

GUI, Add, Text, x80, Select the explorer to use:
GUI, Add, ListBox, vExplorer w200 h60 x70 cBlack, chrome||firefox|opera

GUI, Add, Text, x30, Assign a search key:
GUI, Add, Hotkey, x+10 yp w120 vUserKey, f1

GUI, Add, Button, w100 h30 x115 gSaveChanges, Use Settings

GUI, Add, Button, w70 h25 x130 gAutoSearchOpGG, Search

GuiControl, Hide, Search

Goto, OnCreate
Return

;LABELS and its FUNCTIONS
;---------------------------------------

GuiClose:
ExitApp

OnCreate:
if(FileExist("auto_search_config.ini"))
{
    IniRead, setKey,auto_search_config.ini, UserConfig,hotkey
    IniRead, setRegion,auto_search_config.ini, UserConfig,region
    IniRead, setMsg,auto_search_config.ini, UserConfig,message
    IniRead, setExplorer,auto_search_config.ini, UserConfig,explorer

    GuiControl,, UserKey, %setKey%
    GuiControl, ChooseString, Explorer, %setExplorer%
    GuiControl, Text, joined the lobby, %setMsg%
    GuiControl, ChooseString, Region, %setRegion%

    GuiControl, Show, Search
}
Return

SaveChanges:
    if(UserKey != "" and UserKey != "ERROR")
    {
        Hotkey, %UserKey%, AutoSearchOpGG, Off
    }
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
    if(UserKey != "")
    {
        Hotkey, %UserKey%, AutoSearchOpGG, On
        ;MsgBox, 0, Key Assign Successfully, Key %UserKey% was assign
    }

    GuiControl, Show, Search

    IniWrite, %UserKey%,auto_search_config.ini, UserConfig,hotkey
    IniWrite, %Region%,auto_search_config.ini, UserConfig,region
    IniWrite, %JoinMsg%,auto_search_config.ini, UserConfig,message
    IniWrite, %Explorer%,auto_search_config.ini, UserConfig,explorer

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
        ;Clipboard := "ochinchintsuki joined the lobby`nicon joined the lobby`nfirah joined the lobby`nimnotsogud joined the lobby`nunfriendly clown joined the lobby`n"
        if(Clipboard != "")
        {
            counter := 0
            oldClipboard := Clipboard
            Clipboard := ""
            loop, parse, oldClipboard, `n, `r
            {
                counter := counter + 1
                Clipboard:= Clipboard A_LoopField A_Space
                MsgBox, , Title, %Clipboard%
                if(counter == 5)
                {
                    Break
                }
            }
            StringReplace, result, Clipboard, %JoinMsg%, `%2C, All
            StringReplace, result, result, %A_Space%,, All
            ;Clipboard:=result
            Run, %Explorer%.exe https://%Region%.op.gg/multi/query=%result%
        }
    } 
    Else
    {
        MsgBox, 0, Attention, You need to have the lol client opened
    }
Return

F1::Run, chrome.exe https://www.youtube.com/watch?v=dQw4w9WgXcQ