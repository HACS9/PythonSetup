# PythonSetup
This script checks if Python is installed, if Python and pip are the newest, if list of libs are installed. If not it installs it under user approval

run_installer.bat runs the main script
PythonSetup.ps1 does the main logic

Modules:
InstallPython.ps1 installs the newest Python version automatically if its not installed
PythonVersionCheck.ps1 checks if there is a newer version of Python issued, and installs the newest one under user approval
ManagePip.ps1 checks if pip is installed and if there is a newer version that can be installed under user approval
CheckLibraries.ps1 checks if a set of libraries is installed, and if not then installs it under user approval

You can edit required libraries list in CheckLibraries.ps1 line 2
