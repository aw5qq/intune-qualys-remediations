# Remediate QID 105943


# Check if Flash Player is installed
$flashPlayer = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "Adobe Flash" }

if ($flashPlayer) {
    # Uninstall Flash Player
    $uninstallResult = Start-Process -FilePath "msiexec.exe" -ArgumentList "/x $($flashPlayer.IdentifyingNumber) /qn" -Wait -PassThru
    if ($uninstallResult.ExitCode -eq 0) {
        Write-Host "Uninstalled $($flashPlayer.Name) successfully."
    } else {
        Write-Host "Failed to uninstall $($flashPlayer.Name). Exit code: $($uninstallResult.ExitCode)"
    }
} else {
    Write-Host "Adobe Flash Player is not installed on this computer."
}