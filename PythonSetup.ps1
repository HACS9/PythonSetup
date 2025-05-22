# Load Library - .NET for MessageBox
Add-Type -AssemblyName System.Windows.Forms

# Load functions from separate files
. .\modules\InstallPython.ps1
. .\modules\ManagePip.ps1
. .\modules\CheckLibraries.ps1
. .\modules\PythonVersionCheck.ps1  # Load PythonVersionCheck Module


# Check if Python is installed already
if (-not (Get-Command "python" -ErrorAction SilentlyContinue)) {
    Write-Host "Python is not installed. Installing now..." -ForegroundColor Yellow
    Install-Python
} else {
    $version = python --version
    # Show modal window with Python version
    [System.Windows.Forms.MessageBox]::Show("Installed Python: $version", "Python OK", "OK", "Information")

    # Call Python version check function 
    PythonVersionCheck
}

# Managing pip
Manage-Pip

# Checking and installing libraries
Check-Libraries
