function Check-Libraries {
    $requiredLibs = @("requests", "pandas", "plotly", "tqdm")
    $missingLibs = @()

    foreach ($lib in $requiredLibs) {
        try {
            # Chek if library is installed with pip show
            $result = python -m pip show $lib 2>$null
            if (-not $result) {
                $missingLibs += $lib
            }
        } catch {
            $missingLibs += $lib
        }
    }

    if ($missingLibs.Count -eq 0) {
        Write-Host "All required libraries are installed." -ForegroundColor Green
    } else {
        Write-Host "Missing libraries: $($missingLibs -join ", ")" -ForegroundColor Yellow
        $userChoice = Read-Host "Do you want to install missing libraries? (y/n)"
        if ($userChoice -eq 'y') {
            foreach ($lib in $missingLibs) {
                Write-Host "Installing libraries: $lib..." -ForegroundColor Yellow
                python -m pip install $lib
            }
        }
    }
}
