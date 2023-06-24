#Requires AutoHotkey v2.0

#Numpad7::Send "#{1}"
#Numpad8::Send "#{2}"
#Numpad9::Send "#{3}"

#Numpad4::Send "#{4}"
#Numpad5::Send "#{5}"
#Numpad6::Send "#{6}"


#Numpad1::Run "C:\Users\amfis\AppData\Local\TogglDesktop\TogglDesktop.exe"

#Numpad2::Run "C:\Program Files\Alacritty\alacritty.exe"


#c::
{
  if WinExist("ahk_exe chrome.exe")
    WinActivate
  else
    Run "C:\Program Files\Google\Chrome\Application\chrome.exe"
}



#n::
{
  if WinExist("ahk_class Notepad")
    WinActivate  ; Activate the window found above
  else
    Run "notepad"  ; Open a new Notepad window
}


#+n::Run '*RunAs notepad.exe C:\Windows\System32\drivers\etc\hosts'


