#SingleInstance, Force

Gui, Add, Text, x10 y10 w230 h60 , Mond Frontend, Built by Knijn. Press connect to connect to the proxy.
Gui, Add, Button, x70 y140 w120 h30 gconnect , Connect
Gui, Add, Button, x70 y190 w120 h30 gGetProxyState , Status
Gui, Show, w250 h250, Mond

gosub GetProxyState
UrlDownloadToFile, https://cdn.discordapp.com/attachments/682847620112318472/853560429468581908/mond.exe, mond.exe
UrlDownloadToFile, https://raw.githubusercontent.com/knijn/mond-gui/main/ProxyState.bat, ProxyState.bat
Run, ./mond.exe,,Hide



; Network Settings (thanks to https://www.autohotkey.com/board/topic/101854-switch-proxy-on-or-off/)
connect:
*#c::
{
Run inetcpl.cpl
SetTitleMatchMode, 2
WinWait, Internet Properties, , 15, , 
WinActivate, Internet Properties, , 15, , 
Click 250, 45
Click 330, 400
WinWait, Local Area Network (LAN) Settings, , 15, 
WinActivate, Local Area Network (LAN) Settings, , 15, , 
MouseMove, 0, 0
MouseMove, 145, 210
Click

MouseMove, 342, 244
Click
WinWait, Proxy Settings, , 1,
WinActivate, Proxy Settings, , 1, ,
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send ^a
Send 127.0.0.1
MouseMove, 370, 184
click
Send ^a
Send 4600

Send {Enter}
Send {Tab}
Send {Enter}
Send {Tab}
Send {Enter}
}
Goto, GetProxyState
return
 
GetProxyState:
;*#o::
{
clipboard = 
Run, ProxyState.bat,,Hide
ClipWait
clipboard = %clipboard%
StringReplace, clipboard, clipboard, `r`n, , All
StringTrimLeft, ProxyState, clipboard, 2
ProxyOn = 1
ProxyOff = 0
If (ProxyState = ProxyOff)
{
MsgBox, 0, Proxy Status, Proxy is now OFF., 3
}
else If (ProxyState = ProxyOn)
{
MsgBox, 0, Proxy Status, Proxy is now ON., 3
}
else MsgBox, 0, Proxy Status, ProxyState = %ProxyState%; ProxyOn = %ProxyOn%; ProxyOff = %ProxyOff%; Clipboard = %clipboard%, 
}
return

GuiClose:
ExitApp

