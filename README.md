# PythonSetup
This script checks if Python is installed, if Python and pip are the newest, if list of libs are installed. If not it installs it under user approval

Main files
1. run_installer.bat runs the main script
2. PythonSetup.ps1 does the main logic

Modules:
1. InstallPython.ps1 installs the newest Python version automatically if its not installed
2. PythonVersionCheck.ps1 checks if there is a newer version of Python issued, and installs the newest one under user approval
3. ManagePip.ps1 checks if pip is installed and if there is a newer version that can be installed under user approval
4. CheckLibraries.ps1 checks if a set of libraries is installed, and if not then installs it under user approval

You can edit required libraries list in CheckLibraries.ps1 line 2
