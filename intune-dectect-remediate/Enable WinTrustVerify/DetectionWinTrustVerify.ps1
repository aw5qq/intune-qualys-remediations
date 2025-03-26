# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: Checks if the WinTrustVerify setting is enabled with proper type

$registryKey1 = "HKLM:\SOFTWARE\Microsoft\Cryptography\Wintrust\Config"
$registryKey2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Cryptography\Wintrust\Config"

$valueName = "EnableCertPaddingCheck"
$expectedData = 1  # Use integer for proper comparison

$issues = @()

function CheckValues {
    param (
        [string]$Path,
        [string]$Name,
        [int]$ExpectedData
    )

    if (Test-Path $Path) {
        try {
            $reg = Get-ItemProperty -Path $Path -ErrorAction Stop
            $data = $reg.$Name

            if ($null -eq $data) {
                $issues += "Value '$Name' does not exist in '$Path'"
            } elseif ($data -ne $ExpectedData) {
                $issues += "Value '$Name' in '$Path' does not match expected data. Found: '$data', Expected: '$ExpectedData'"
            } elseif ($reg.$Name.GetType().Name -ne "Int32") {
                $issues += "Value '$Name' in '$Path' is not of type D-WORD"
            }
        } catch {
            $issues += "Failed to read registry at '$Path'. Error: $_"
        }
    } else {
        $issues += "Registry Key does not exist: '$Path'"
    }
}

# Perform checks
CheckValues -Path $registryKey1 -Name $valueName -ExpectedData $expectedData
CheckValues -Path $registryKey2 -Name $valueName -ExpectedData $expectedData

# Output results
if ($issues.Count -gt 0) {
    Write-Output "Issues found:`n$($issues -join "`n")"
    Exit 1
} else {
    Write-Output "All checks passed."
    Exit 0
}