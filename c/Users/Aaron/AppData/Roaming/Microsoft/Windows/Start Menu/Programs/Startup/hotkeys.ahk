#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#c::Run chrome.exe
#t::Run, wt.exe, %UserProfile%\AppData\Local\Microsoft\WindowsApps\
#k::Send, aaron.fischer@mail.rockstarcoders.com

#+a::
WinGetClass, class, A
MsgBox, The active window's class is "%class%".
return


#c::
WinGet, wList, List, ahk_class Chrome_WidgetWin_1
if !wList { ; if wList is empty/zero
  Run, chrome.exe
  return
}
if (wList = 1) { ; if only one window exists
  WinActivate, % "ahk_id " wList1
  return
}
Loop, %wList% { ; if multiple windows exist
  WinActivate, % "ahk_id " wList%A_Index%
  MsgBox, 4, , Is this the correct instance of WindowsTerminal to activate?
  IfMsgBox Yes
    break
  else
    WinMinimize, % "ahk_id " wList%A_Index%
}
return


#+n::Run, *RunAs notepad.exe C:\Windows\System32\drivers\etc\hosts
#n::
WinGet, wList, List, ahk_class Notepad
if !wList { ; if wList is empty/zero (no Notepad windows exist)
  Run, notepad.exe
  return
}
if (wList = 1) { ; if only one Notepad window exists
  WinActivate, % "ahk_id " wList1
  return
}
Loop, %wList% { ; if multiple Notepad windows exist
  WinActivate, % "ahk_id " wList%A_Index%
  MsgBox, 4, , Is this the correct instance of Notepad to activate?
  IfMsgBox Yes
    break
  else
    WinMinimize, % "ahk_id " wList%A_Index%
}
return



#t::
WinGet, wList, List, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
if !wList { ; if wList is empty/zero
  Run, wt.exe
  return
}
if (wList = 1) { ; if only one window exists
  WinActivate, % "ahk_id " wList1
  return
}
Loop, %wList% { ; if multiple windows exist
  WinActivate, % "ahk_id " wList%A_Index%
  MsgBox, 4, , Is this the correct instance of WindowsTerminal to activate?
  IfMsgBox Yes
    break
  else
    WinMinimize, % "ahk_id " wList%A_Index%
}
return