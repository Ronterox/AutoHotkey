;Made by Ricardo Montserrat
#SingleInstance, Force
#NoEnv

counter:=0
hasSetKeys := False

;GUI SETTINGS
;---------------------------------------

;GUI, +AlwaysOnTop
GUI, Font, cCEA63B s11, Verdana
GUI, Color, 025159
GUI, Show, xCenter yCenter w350 h350, Auto Writer

;ADDING BUTTONS GUI
;---------------------------------------

GUI, Add, Text, , === Welcome To The Lol Auto Writer! ===`n===========================
GUI, Add, Button, x20 gAddHotkey w150, Add New Hotkey
GUI, Add, Button, x+10 gSaveChanges w150, Set Hotkeys
GuiControl, disable, Set Hotkeys
Return

;LABELS and its FUNCTIONS
;---------------------------------------

GuiClose:
    ExitApp, 0

AddHotkey:
    counter:= counter + 1
    if(counter == 1)
    {
        GuiControl, Enable, Set Hotkeys
    } 
    else if(counter == 8)
    {
        GuiControl, disable, Add New Hotkey
    }
    GUI, Add, Hotkey, w120 h22 x40 vKey%counter%, f1
    GUI, Add, Edit, w150 h22 x+10 Multi vEdit%counter%, Text to print
Return

DisableAllHotkeys:
    Loop, %counter%
    {
        key := Key%A_Index%
        if (key == "")
        {
            Continue
        }
        functionRef := Func("SendMessageLol").Bind(A_Index)
        Hotkey, %key%, %functionRef%, Off
    }
Return

SaveChanges:
    if(hasSetKeys)
    {
        Gosub, DisableAllHotkeys
    }
    GUI, Submit, NoHide
    ;MsgBox, , Title, % counter
    Loop, %counter%
    {
        ;MsgBox, , Title, Key%A_index%
        key := Key%A_Index%
        if (key == "")
        {
            Continue
        }
        functionRef := Func("SendMessageLol").Bind(A_Index)
        Hotkey, %key%, %functionRef%, On
    }
    if(!hasSetKeys)
    {
        hasSetKeys := True
    }
    MsgBox, , Successful Operation, Hotkeys Set Successfully
Return

SendMessageLol(position)
{
    global
    ;MsgBox, , Title, % counter
    Loop, %counter%
    {
        if(position == A_Index)
        {
            textTo:= Edit%A_Index%
            Send, %textTo%
            Break
        }
    }
}
Return

