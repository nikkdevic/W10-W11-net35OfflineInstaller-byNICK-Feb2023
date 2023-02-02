:: Run as Admin ================================================================
@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

:: ----------------------------------------------------------------------------------

:: Check for Win 10 and Above =======================================================
@echo off
if exist "%Windir%\Sysnative\reg.exe" (set "SysPath=%Windir%\Sysnative") else (set "SysPath=%Windir%\System32")
set "Path=%SysPath%;%Windir%;%SysPath%\Wbem"
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G
if %winbuild% LSS 10240 (
  if not "%1"=="" goto :eof
  echo ==== ERROR ====
  echo This package is only for Windows 10 and Above
  echo Press any Key to Exit.
  pause >nul
  goto :eof
)

:: ----------------------------------------------------------------------------------

:: Select OS W10 or W11 ========================================================
for /f "tokens=3*" %%i in ('systeminfo ^|findstr /B /C:"OS Name"') do set OS_NAME=%%j
set OS=W%OS_NAME:~8,2%

:: ----------------------------------------------------------------------------------

:: Assign Source ===============================================================
set source=%~dp0sources\%OS%\

:: ----------------------------------------------------------------------------------

:: Print OS_NAME and Source =======================================================
echo ============================
echo OS_NAME = %OS_NAME%
echo source  = %source%
echo ============================

:: ----------------------------------------------------------------------------------

:: Install .netfx 3.5 offline from "source"
Dism /online /enable-feature /featurename:NetFX3 /All /Source:%source% /LimitAccess

pause
