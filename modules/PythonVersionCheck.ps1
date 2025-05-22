function PythonVersionCheck {
    # Load site with newest Python versions
    $html = Invoke-WebRequest -Uri "https://www.python.org/downloads/windows/" -UseBasicParsing

    # Search for link to newest version
    $latestRelease = ($html.Links | Where-Object { $_.href -match "/downloads/release/python-\d{4}/" })[0].href

    # Get version number (ie. 3133)
    $rawVersion = $latestRelease -replace ".*/python-(\d{4})/.*", '$1'

    # Format: 3133 → Python 3.13.3
    $major = $rawVersion.Substring(0,1)
    $minor = $rawVersion.Substring(1,2)
    $patch = $rawVersion.Substring(3,1)
    $latestVersionFormatted = "Python $major.$minor.$patch"
    $latestVersionNumber = "$major.$minor.$patch"

    # Check currently installed version
    $installedVersionRaw = (python --version 2>&1) -replace "Python ", ""
    $installedVersionFormatted = "Python $installedVersionRaw"

    # Compare versions
    $latestVersionObj = [version]$latestVersionNumber
    $installedVersionObj = [version]$installedVersionRaw

    # Write-Host "OK"
    Write-Host "Newest Python Version: $latestVersionFormatted"

    if ($installedVersionObj -lt $latestVersionObj) {
        Write-Host "Your Pythona version: $installedVersionFormatted"
        Write-Host "Your have an older Python version." -ForegroundColor Yellow
        $choice = Read-Host "Do you want to update to version $latestVersionNumber? (y/n)"
        if ($choice -eq "y") {
            Install-Python
        } else {
            Write-Host "Python version update was canceled by user." -ForegroundColor Cyan
        }
    } else {
        Write-Host "Your Python version $installedVersionRaw is the newest one." -ForegroundColor Green
    }
}
