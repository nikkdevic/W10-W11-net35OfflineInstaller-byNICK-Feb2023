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

:: Install from Installation media (USB, DVD, IsoMounted) =======================
@echo off
Title .NET Framework 3.5 Offline Installer
for %%I in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%I:\\sources\install.wim" set setupdrv=%%I
for %%I in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%I:\\sources\install.esd" set setupdrv=%%I
if defined setupdrv (
echo Found drive %setupdrv%
echo Installing .NET Framework 3.5...
Dism /online /enable-feature /featurename:NetFX3 /All /Source:%setupdrv%:\sources\sxs /LimitAccess
echo.
echo .NET Framework 3.5 should be installed
echo.
) else (
echo No installation media found!
echo Insert DVD or USB flash drive and run this file once again.
echo.
)
pause