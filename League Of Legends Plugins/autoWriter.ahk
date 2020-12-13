;Made by Ricardo Montserrat
#SingleInstance, Force
#NoEnv
#UseHook On
SetWorkingDir, %A_WorkingDir%

counter:=0
hasSetKeys := False

;GUI SETTINGS
;---------------------------------------

;GUI, +AlwaysOnTop
GUI, Font, cBFBFBF s11, Verdana
GUI, Color, 03588C
GUI, Show, xCenter yCenter w350 h350, Auto Writer

;ADDING BUTTONS GUI
;---------------------------------------

GUI, Add, Text, , === Welcome To The Lol Auto Writer! ===`n===========================
GUI, Add, Button, x20 gAddHotkey w150, Add New Hotkey
GUI, Add, Button, x+10 gSaveChanges w150, Set Hotkeys
GuiControl, disable, Set Hotkeys
Goto, OnCreate
Return

;LABELS and its FUNCTIONS
;---------------------------------------

GuiClose:
ExitApp, 0

OnCreate:
if(FileExist("lolwriter_config.ini"))
{
    IniRead, hotkeys,lolwriter_config.ini,UserConfig,hotkeys
    if(hotkeys == "" or hotkeys == "ERROR")
    {
        Return
    } else if (hotkeys >= 8)
    {
        GuiControl, disable, Add New Hotkey
    }
    counter := hotkeys
    Loop, %counter%
    {
        IniRead, keyValue,lolwriter_config.ini,Keys,key_%A_Index%
        IniRead, textValue,lolwriter_config.ini,Text,keytext_%A_Index%
        GUI, Add, Hotkey, w120 h22 x40 vKey%A_Index%, %keyValue%
        GUI, Add, Edit, w150 h22 x+10 cBlack Multi vEdit%A_Index%, %textValue%
        GuiControl, Enable, Set Hotkeys
    }   
    Gosub, SaveChanges
}
Return

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
    GUI, Add, Edit, w150 h22 x+10 cBlack Multi vEdit%counter%, Text to print
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
    IniWrite, %counter%,lolwriter_config.ini,UserConfig,hotkeys
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
        IniWrite, %key%,lolwriter_config.ini,Keys,key_%A_Index%
        editValue := Edit%A_Index%
        IniWrite, %editValue%,lolwriter_config.ini,Text,keytext_%A_Index%
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
            SetKeyDelay, -1
            Send, {Enter}
            Sleep, 50
            Send, %textTo%
            Sleep, 50
            Send, {Enter}
            Break
        }
    }
}
Return