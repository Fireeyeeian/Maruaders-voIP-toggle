#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;                         ████            ████                            
;                     ░░██████            ░░████                          
;                   ░░████████        ██▒▒  ████                          
;                 ▒▒██████████        ████    ████                        
;     ░░░░░░░░░░▓▓████████████  ░░██    ████  ████                        
;   ██████████████████████████  ▒▒██░░  ████  ▒▒██                        
;   ██████████████████████████    ████  ▒▒██    ██▒▒                      
;   ██████████████████████████    ████    ██░░  ████                      
;   ██████████████████████████    ████    ████  ████                      
;   ██████████████████████████    ████    ██▒▒  ████                      
;   ██████████████████████████    ████    ██░░  ████                      
;   ██████████████████████████    ████  ▒▒██    ██▒▒                      
;   ██████████████████████████  ▒▒██░░  ████  ▒▒██                        
;               ▒▒████████████    ░░  ░░██▒▒  ████                        
;                 ░░██████████        ████    ██▒▒                        
;                     ████████        ██░░  ████                          
;                       ██████            ▒▒██▒▒                          
;                         ████            ████                            
;;;;;;;;;;;;;;functions
DisableCloseButton(hWnd) {
  hSysMenu:=DllCall("GetSystemMenu","Int",hWnd,"Int",FALSE)
  nCnt:=DllCall("GetMenuItemCount","Int",hSysMenu)
  DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-1,"Uint","0x400")
  DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-2,"Uint","0x400")
  DllCall("DrawMenuBar","Int",hWnd)
  Return ""
  }
;;;;;;;;;;;;;;
; main gui
Gui,1: Add, Text, , This script is running!`n You can now go in game and play`n`n•Double press capslock to toggle voIP to an open state`n•When red dot is showing at the bottom voip is open`n•Also note that MARUADERS shows a wave form at the top left of the screen to show when mic is being transmitted`n>>Enjoy
Gui,1: Add, Button, x20 y100 w80 h40 gExitScript, Exit
Gui,1: Show,,MAIN_GUI
OnMessage(0x112, "WM_SYSCOMMAND")
Return

WM_SYSCOMMAND(wParam)
{
    if (A_Gui = 1 && wParam = 0xF060) ; SC_CLOSE
    {
       MsgBox,,, Thanks for using MVT by FireEyeEian :)`n (App will close now in 4 seconds),4
       ExitApp
        return 0
    }
}
return

ExitScript:
MsgBox,,, Thanks for using MVT by FireEyeEian :)`n (App will close now in 4 seconds),4
  ExitApp

;DisableCloseButton(MAIN_GUI)

$*Capslock::
If (A_PriorHotkey = A_ThisHotkey and A_TimeSincePriorHotkey < 400)
{
  ; Double-click detected, toggle holding V key down
  Toggle := !Toggle
  If (Toggle)
  {
    ; Press down V key
    SendInput {v down}
    diam = 45	; diameter of dot
    Gui,2: -Caption +AlwaysOnTop
    Gui,2: margin,0,0
    Gui,2: add, ListView, w%diam% h%diam% -Hdr -E0x200 BackgroundRed
    SysGet, mon, MonitorWorkArea ; get screen size (to include taskbar height delete text 'WorkArea')
    Gui,2: Show, % "x" monRight//2-(diam//2) " y" monBottom//1-(diam//1)
    WinSet, Region, 0-0 W%diam% H%diam% E, A		; make it circular
    return
  }
  Else
  {
    ; Release V key
    SendInput {v up}
    Gui,2: Hide
    return
  }
}
