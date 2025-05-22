function Manage-Pip {
    $pipExists = Get-Command "pip" -ErrorAction SilentlyContinue

    if (-not $pipExists) {
        $userChoice = Read-Host "Pip is not installed. Install the newest version? (y/n)"
        if ($userChoice -eq 'y') {
            python -m ensurepip
            python -m pip install --upgrade pip
        }
    } else {
        $currentVersion = pip --version
        # Getting version number only 
        $currentVersionNumber = $currentVersion.Split()[1]
        Write-Host "Pip installed version: $currentVersionNumber" -ForegroundColor Green

        # Download newest pip version from PyPI (API)
        $response = Invoke-RestMethod -Uri "https://pypi.org/pypi/pip/json"
        $latestVersion = $response.info.version

        # Showing newest version only if its different from installed one
        if ($currentVersionNumber -ne $latestVersion) {
            Write-Host "Newer pip available version: $latestVersion" -ForegroundColor Yellow
            $userChoice = Read-Host "Update pip to version $latestVersion? (y/n)"
            if ($userChoice -eq 'y') {
                python -m pip install --upgrade pip
            }
        } else {
            Write-Host "Your pip version ($currentVersionNumber) is the newest." -ForegroundColor Green
        }
    }
}
