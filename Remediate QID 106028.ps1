# Remediate QID 106028

$applicationName = "Microsoft Silverlight"

$installedApp = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*$applicationName*" }

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