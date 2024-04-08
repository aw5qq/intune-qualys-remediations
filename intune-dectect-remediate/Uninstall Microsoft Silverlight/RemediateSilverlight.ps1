# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script removes Microsoft Silverlight 5
# QID: 106028

$applicationName = "Microsoft Silverlight"

# Check if the "Win32_Product" class is available
if (Get-CimClass -ClassName "Win32_Product" -ErrorAction SilentlyContinue) {
    $installedApp = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*$applicationName*" }
} else {
    # Use "Get-WmiObject" cmdlet with "Class" parameter to query installed applications
    $installedApp = Get-WmiObject -Query "SELECT * FROM Win32Reg_AddRemovePrograms" | Where-Object { $_.DisplayName -like "*$applicationName*" }
}

if ($installedApp) {
    Write-Host "Found $($installedApp.Name). Uninstalling..."
    $uninstallResult = Start-Process -FilePath "msiexec.exe" -ArgumentList "/x $($installedApp.IdentifyingNumber) /qn" -Wait -PassThru
    if ($uninstallResult.ExitCode -eq 0) {
        Write-Host "Uninstalled $($installedApp.Name) successfully."
    } else {
        Write-Host "Failed to uninstall $($installedApp.Name). Exit code: $($uninstallResult.ExitCode)"
    }
} else {
    Write-Host "Microsoft Silverlight 5 not found."
}