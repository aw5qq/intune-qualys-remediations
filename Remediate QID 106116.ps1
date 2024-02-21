# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script removes Microsoft Visual C++ 2010 Redistributable and installs Visual C++ 2015-2022 Redistributable.
# QID: 106116

# Remove Microsoft Visual C++ 2010 Redistributable

$wmiFilter = "Name LIKE 'Microsoft Visual C++ 2010%' AND (Name LIKE '%x86 Redistributable%' OR Name LIKE '%x64 Redistributable%')"

$vc2010Redist = Get-WmiObject -Class Win32_Product -Filter $wmiFilter

if ($vc2010Redist) {
    foreach ($redist in $vc2010Redist) {
        Write-Host "Uninstalling $($redist.Name)..."
        $redist.Uninstall()
        Write-Host "$($redist.Name) uninstalled successfully."
    }

    # Install Visual C++ 2015-2022

    # Define URLs for the Visual C++ 2015 Redistributable
    $vcRedistUrls = @{
        "x86" = "https://aka.ms/vs/17/release/vc_redist.x86.exe";
        "x64" = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
    }

    # Define the download folder
    $downloadFolder = "$env:USERPROFILE\Downloads\VCRedist"

    # Create the download folder if it doesn't exist
    if (-not (Test-Path $downloadFolder)) {
        New-Item -Path $downloadFolder -ItemType Directory | Out-Null
    }

    # Check if Invoke-WebRequest cmdlet is available
    if (-not (Get-Command Invoke-WebRequest -ErrorAction SilentlyContinue)) {
        Write-Host "Invoke-WebRequest cmdlet is not available. Installing required package..."
        Install-PackageProvider -Name NuGet -Force | Out-Null
        Install-Module -Name PowerShellGet -Force | Out-Null
        Install-Module -Name PackageManagement -Force | Out-Null
        Install-Package -Name PowerShellGet -Force | Out-Null
        Install-Package -Name PackageManagement -Force | Out-Null
        Install-Package -Name PowerShellGet -Force | Out-Null
        Install-Package -Name PackageManagement -Force | Out-Null
        Write-Host "Required package installed successfully."
    }

    # Download and install the Visual C++ Redistributables for x86 and x64
    foreach ($architecture in $vcRedistUrls.Keys) {
        $url = $vcRedistUrls[$architecture]
        $fileName = Split-Path $url -Leaf
        $filePath = Join-Path $downloadFolder $fileName

        # Download the redistributable package
        Invoke-WebRequest -Uri $url -OutFile $filePath

        # Install the redistributable package with passive (unattended) mode
        Start-Process -FilePath $filePath -ArgumentList "/install", "/quiet", "/norestart" -Wait -NoNewWindow
    }

    # Remove the downloaded files
    Remove-Item -Path $downloadFolder -Recurse -Force
    
    Write-Host "Visual C++ Redistributables have been updated successfully."
} 

else {
    Write-Host "Visual C++ 2010 Redistributables not found."
}

