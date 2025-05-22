function Install-Python {
    Write-Host "Downloading the newest Python version..." -ForegroundColor Cyan

    $html = Invoke-WebRequest -Uri "https://www.python.org/downloads/windows/" -UseBasicParsing
    $latestRelease = ($html.Links | Where-Object { $_.href -match "/downloads/release/python-\d+/" })[0]

    if ($latestRelease -eq $null) {
        Write-Host "Nie udało się pobrać najnowszej wersji." -ForegroundColor Red
        return
    }

    $releasePage = "https://www.python.org" + $latestRelease.href
    $releaseHtml = Invoke-WebRequest -Uri $releasePage -UseBasicParsing

    # Search for 64-bit Windows installer
    $installerLink = ($releaseHtml.Links | Where-Object {
        $_.href -match "windows.*amd64.*\.exe$" -and $_.href -notmatch "webinstall"
    })[0].href

    if ($installerLink -notlike "http*") {
        $installerLink = "https://www.python.org" + $installerLink
    }

    $installerPath = "$env:TEMP\python-installer.exe"
    Write-Host "Downloading installer from: $installerLink" -ForegroundColor Yellow
    Invoke-WebRequest -Uri $installerLink -OutFile $installerPath

    Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    Remove-Item $installerPath

    Write-Host "Python has been installed." -ForegroundColor Green
}
