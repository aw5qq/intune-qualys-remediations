# Remediation Script for RestrictAnonymous with Intune Exit Codes
# Fixes the RestrictAnonymous setting in the registry to prevent anonymous access to the system.
# QID: 90044 

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA"
$regName = "RestrictAnonymous"
$currentValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue

if ($null -eq $currentValue -or $currentValue.RestrictAnonymous -eq 0) {
    Write-Output "Remediating RestrictAnonymous setting..."
    Set-ItemProperty -Path $regPath -Name $regName -Value 1
    if ($? -eq $true) {
        Write-Output "Remediation complete. RestrictAnonymous is now set to 1."
        exit 0  # Exit code 0 indicates successful remediation
    } else {
        Write-Output "Failed to remediate RestrictAnonymous setting."
        exit 3  # Exit code 3 indicates remediation failed
    }
} else {
    Write-Output "RestrictAnonymous is already set to 1. No action needed."
    exit 0  # Exit code 0 indicates no action needed
}
