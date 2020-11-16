#SingleInstance, force
#NoEnv

clicking := false
CoordMode, Pixel, Screen

;GUI SETUP
;---------------------------------------------

GUI, +AlwaysOnTop
GUI, Font, cBlack, Verdana
GUI, Color, CCDBF8
GUI, show, xCenter yCenter w225 h225, AutoClicker

;GUI BUTTONS
;---------------------------------------------

GUI, Add, Tab, h20, General|Extra|

GUI, Tab, General

GUI, Add, Text, x50, Clicking Delay
GUI, Add, Edit, Number w50
Gui, Add, UpDown, vUserDelay, 2
GUI, Add, Text, x+5 yp+6, Seconds

GUI, Add, Text, x50 y+15, Which Click to Use
GUI, Add, DDL, vUserClick, Right|Left||

GUI, Add, Text, x15 y+15 gSeeHotkey, Set Start/Stop Key
GUI, Add, Hotkey, x+10 w25 vUserKey, f1
GUI, Add, Button, x+1 w55 gSaveChanges, Set Key

GUI, Add, Button, gSaveAndClick w100 x10 y+15, Start Clicking
GUI, Add, Button, gStopClicking w100 x+10, Stop Clicking

GUI, Tab, Extra

GUI, Add, Text, x50 y35, Coordinates to Click `n(Optional)
GUI, Add, Text, x50 y+10, X
GUI, Add, Edit, Number w40 vUserPosX x+10 limit4
GUI, Add, Text, x50 yp x+10, Y
GUI, Add, Edit, Number w40 vUserPosY x+10 limit4

GUI, Add, Text, x50 y+20, Clicks Per Click
GUI, Add, Edit, Number w50 x+5
Gui, Add, UpDown, vUserClicks, 1

GUI, Add, Text, x50 y+20, Mouse Position
GUI, Add, Edit, ReadOnly vM_X, Coord X
GUI, Add, Edit, ReadOnly x+10 vM_Y, Coord Y

SetTimer, FollowMouse, 250
Return

;FUNCTIONS AND LABELS
;---------------------------------------------

GuiClose:
    ExitApp

SeeHotkey:
    Gosub, SaveChanges
    MouseGetPos, x, y
    ToolTip, %UserKey%, x, y
    Sleep, 1000
    ToolTip
Return

SaveAndClick:
    Gosub, SaveChanges
    Gosub, StartClicking
Return

SaveChanges:
    GUI, Submit, NoHide
    if(UserKey != "")
    {
        Hotkey, %UserKey%, KeyCommand
    }
Return

StartClicking:
    if(UserDelay == "")
    {
        MsgBox, 4, Warning, You didn't set a clicking delay`, continue?
        IfMsgBox, No
        Return 
    }
    clicking := true
    While clicking
    {
        MouseGetPos, posX, posY
        AutoClick(userClick, userPosX == ""? posX : userPosX, userPosY == ""? posY : userPosY)
        ;ToolTip, Click, posX, posY
        Sleep, userDelay * 1000
    }
Return

StopClicking:
    clicking := false
Return

FollowMouse:
    MouseGetPos, new_X, new_Y
    GuiControl,, m_X, %new_X%
    GuiControl,, m_Y, %new_Y%
Return

KeyCommand:
    clicking:= !clicking
    if(clicking)
    {
        Gosub, StartClicking
    }
Return

AutoClick(WhichClick, posX, posY)
{
    MouseClick, %WhichClick%, %posX%, %posY%, UserClicks, 0
}