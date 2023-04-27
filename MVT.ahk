#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
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
    Gui -Caption +AlwaysOnTop
    Gui margin,0,0
    Gui add, ListView,	w%diam% h%diam%	-Hdr -E0x200 BackgroundRed
    SysGet, mon, MonitorWorkArea ; get screen size (to include taskbar height delete text 'WorkArea')
    Gui show, % "x" monRight//2-(diam//2) " y" monBottom//1-(diam//1)
    WinSet, Region, 0-0 W%diam% H%diam% E, A		; make it circular
return
  }
  Else
  {
    ; Release V key
    SendInput {v up}
    Gui Hide
  }
}
!del::ExitApp,
Return