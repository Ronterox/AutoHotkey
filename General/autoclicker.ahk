#SingleInstance, force

;GUI SETUP
;---------------------------------------------
GUI, +AlwaysOnTop
GUI, Font, , Georgia
;GUI, Color, cBlack
GUI, show, xCenter yCenter w225 h250, AutoClicker

;GUI BUTTONS
;---------------------------------------------

;TODO: Show window coordinates to help set the click pos
GUI, Add, Text, x50, Coordinates to Click `n(Optional)
GUI, Add, Text, x50, X
GUI, Add, Edit, Number w35 vUserPosX x+10
GUI, Add, Text, x50 x+10, Y
GUI, Add, Edit, Number w35 vUserPosY x+10

GUI, Add, Text, x50, Clicking Delay
GUI, Add, Edit, Number w50
Gui, Add, UpDown, vUserDelay, 2
GUI, Add, Text, x+5, Seconds

GUI, Add, Text, x50, Which Click to Use
GUI, Add, DDL, vUserClick, Right|Left||

GUI, Add, Text, ,Set Start/Stop Key
GUI, Add, Edit, x+10 w20 vUserKey gSaveChanges ;TODO: Add click quantity

GUI, Add, Button, gStartClicking w100 x10, Start Clicking
GUI, Add, Button, gStopClicking w100 x+10, Stop Clicking
Return

;FUNCTIONS AND LABELS
;---------------------------------------------

GuiClose:
    ExitApp

SaveChanges:
    GUI, Submit, NoHide
    if(UserKey != "")
    {
        Hotkey, %UserKey%, KeyCommand, On ;TODO: Fix Hotkey second time hit to deactivate
    }
Return

StartClicking:
    Gosub, SaveChanges

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
        Sleep, userDelay * 1000
    }
Return

StopClicking:
    clicking := false
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
    MouseClick, %WhichClick%, %posX%, %posY%, , 0
}