@echo off
setlocal ENABLEEXTENSIONS
set KEY_NAME=HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings
set VALUE_NAME=ProxyEnable
for /F "usebackq tokens=3" %%A IN (`reg query "%KEY_NAME%" /v "%VALUE_NAME%" 2^>nul ^| find "%VALUE_NAME%"`) do (
  echo %%A | clip
)