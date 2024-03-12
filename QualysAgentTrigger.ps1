# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script triggers a Qualys user agent scan.

$ScanOnDemand = 1

$paths = @(
    "HKLM:\SOFTWARE\Qualys\QualysAgent\ScanOnDemand\Inventory",
    "HKLM:\SOFTWARE\Qualys\QualysAgent\ScanOnDemand\Vulnerability"
)

foreach ($path in $paths) {
    try {
        if (Test-Path $path) {
            Set-ItemProperty -Path $path -Name "ScanOnDemand" -Value $ScanOnDemand
            Write-Host "Successfully set 'ScanOnDemand' property for path: $path"
        } else {
            Write-Host "Registry key does not exist: $path"
        }
    } catch {
        Write-Host "Failed to set 'ScanOnDemand' property for path: $path"
        Write-Host "Error: $_"
    }
}
