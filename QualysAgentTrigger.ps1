# Author: Andrew Welch (aw5qq@lawschool.virginia.edu)
# This script is designed to trigger a Qualys user agent to perform a scan.

# Set the ScanOnDemand variable to 1 to trigger a scan.
$ScanOnDemand = 1

$paths = @(
    "HKLM:\SOFTWARE\Qualys\QualysAgent\ScanOnDemand\Inventory",
    "HKLM:\SOFTWARE\Qualys\QualysAgent\ScanOnDemand\Vulnerability"
)

foreach ($path in $paths) {
    Set-ItemProperty –Path $path -Name "ScanOnDemand" -Value $ScanOnDemand
}
