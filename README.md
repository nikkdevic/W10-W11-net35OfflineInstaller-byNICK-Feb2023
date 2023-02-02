# W10-W11-net35OfflineInstaller-byNICK

2023

Run One of the following:

For standalone install RUN = " 01-dotnet35installer-local.bat "

To install from USB RUN = " 02-dotnet35installer-fromusb.bat "

To uninstall RUN = " 03-dotnet35uninstaller.bat "


Working :

The bat files use DISM to install the Net3.5.

The 'sources' folder contains .Net3.5 files from Windows installer ISO for Windows 10 and Windows 11.

The '01-dotnet35installer-local.bat' installer uses files from 'sources' folder.

The '02-dotnet35installer-fromusb.bat' automatically searches for connected windows installation USB media.

The '03-dotnet35uninstaller.bat' uninstalls Net3.5.
