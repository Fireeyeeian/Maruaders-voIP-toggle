#NoEnv  ; Recommended for performance and compatcapslockibility with future AutoHotkey releases.
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
;gui setup
Gui,1: Color, 1f1f1f
Gui,1: Font, s35 cffffff , Calibri
Gui,1: add, Text, ,MARUADERS voIP toggle
Gui,1: Font, s15 cff9026 , Calibri
Gui,1: Add, Text, , This script is running!`n You can now go in game and play`n`n•Double press capslock to toggle voIP to an open state`n•When red dot is showing at the bottom voip is open`n•Also note that MARUADERS shows a wave form at the top left of the screen to show when mic is being transmitted`n`n**SMALL BUG: If you alt+tab while transmitting via this it will need to be re toggled on when you get back to the game even if red dot is showing.`n>>Enjoy
Gui,1: Add, Button, x20 y340 w80 h40 gExitScript, Exit
Gui,1: Font, s12 cff9026 , Calibri
Gui,1: add, Text, x900 y360, By FireEyeEian
Gui,1: Show,,MAIN_GUI
OnMessage(0x112, "WM_SYSCOMMAND")

diam = 45	; diameter of dot
    Gui,2: -Caption +AlwaysOnTop
    Gui,2: margin,0,0
    Gui,2: add, ListView, w%diam% h%diam% -Hdr -E0x200 BackgroundRed
    SysGet, mon, MonitorWorkArea ; get screen size (to include taskbar height delete text 'WorkArea')
    Gui,2: Show, % "x" monRight//2-(diam//2) " y" monBottom//1-(diam//1)
    WinSet, Region, 0-0 W%diam% H%diam% E, A		; make it circular
    Gui,2: hide
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


  
; Initialize the loop status variable to false
loopRunning := false

; Set up the capslock key to toggle the loop
$CapsLock::






If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
{
    ; Toggle the loop status variable
    loopRunning := !loopRunning
    
    ; If the loop is now running, start the function loop
    If (loopRunning)
    {
       Gui,2: show, NoActivate
       MouseClick, Left
      SetTimer, FunctionLoop, 500
    }
    ; If the loop is not running, stop the function loop
    Else
    {
      Gui,2: hide
      Send, v
        SetTimer, FunctionLoop, Off
    }
}
Return

; This function will run repeatedly while the loop is running and the specified window is active
FunctionLoop:
    ; Check whether the specified window is still active
    If (not WinActive("RaidGame"))
    {
        ; Pause the loop if the specified window becomes unfocused
        Gui,2: hide
        SetTimer, FunctionLoop, Off
        While not WinActive("RaidGame")
        {
            Sleep, 100
        }
        Gui,2: show, NoActivate
       MouseClick, Left
      SetTimer, FunctionLoop, 500
    }
    
    ; Put your code here that you want to run repeatedly while the loop is running and the specified window is active
    SendInput, {v down}
Return

