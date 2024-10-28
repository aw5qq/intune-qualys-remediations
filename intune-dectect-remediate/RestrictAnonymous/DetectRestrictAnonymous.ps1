# Detection Script for RestrictAnonymous with Intune Exit Codes
# QID: 90044 

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA"
$regName = "RestrictAnonymous"
$currentValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    Write-Output "The registry key does not exist."
    exit 1  # Exit code 1 indicates the key does not exist
} elseif ($currentValue.RestrictAnonymous -eq 0) {
    Write-Output "RestrictAnonymous is set to 0. Remediation is needed."
    exit 2  # Exit code 2 indicates remediation is needed
} else {
    Write-Output "RestrictAnonymous is set to 1. No action needed."
    exit 0  # Exit code 0 indicates no action needed
}
