#SingleInstance force
#NoEnv
#Persistent

LALT & f4::CloseApplication()

CloseApplication()
{
    WinGet, PID, PID, % "ahk_id " WinExist("A")
    Process, Close, %PID%
}