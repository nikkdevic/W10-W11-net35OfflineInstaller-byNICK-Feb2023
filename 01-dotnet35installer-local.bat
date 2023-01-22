:: Run as Admin ================================================================
@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

:: ----------------------------------------------------------------------------------

:: Check for Win 10 Only =======================================================
@echo off
if exist "%Windir%\Sysnative\reg.exe" (set "SysPath=%Windir%\Sysnative") else (set "SysPath=%Windir%\System32")
set "Path=%SysPath%;%Windir%;%SysPath%\Wbem"
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G
if %winbuild% LSS 10240 (
  if not "%1"=="" goto :eof
  echo ==== ERROR ====
  echo This package is only for Windows 10
  echo Press any Key to Exit.
  pause >nul
  goto :eof
)

:: ----------------------------------------------------------------------------------

:: Select Arch - x64-86 ========================================================
set arch=x64
if /i "%PROCESSOR_ARCHITECTURE%"=="x86" (
if "%PROCESSOR_ARCHITEW6432%"=="" set arch=x86
)

:: ----------------------------------------------------------------------------------

:: Assign Source ===============================================================
set source=%~dp0sources\%arch%\
::set source=sources\%arch%\

:: ----------------------------------------------------------------------------------

:: Print Arch and Source =======================================================
echo ============================
echo arch = %arch%
echo source = %source%
echo ============================

:: ----------------------------------------------------------------------------------

:: Install .netfx 3.5 offline from "source"
Dism /online /enable-feature /featurename:NetFX3 /All /Source:%source% /LimitAccess

pause