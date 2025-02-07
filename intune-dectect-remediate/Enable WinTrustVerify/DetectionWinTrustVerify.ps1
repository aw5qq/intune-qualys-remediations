# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script checks if the WinTrustVerify setting is enabled 

$registryKey1 = "HKLM:\SOFTWARE\Microsoft\Cryptography\Wintrust\Config"
$registryKey2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Cryptography\Wintrust\Config"

$value1 = "EnableCertPaddingCheck"
$expectedData1 = "1"

$value2 = "EnableCertPaddingCheck"
$expectedData2 = "1"

$issues = @()

# Function to check a registry value
function CheckValues {
    param (
        [string]$Path,
        [string]$Name,
        [string]$ExpectedData
    )

    if (Test-Path $Path) {
        $data = (Get-ItemProperty -Path $Path).$Name
        if ($null -eq $data) {
            $issues += "Value '$Name' does not exist in '$Path'"
        } elseif ($data -ne $ExpectedData) {
            $issues += "Value '$Name' in '$Path' does not match expected data. Found: '$data', Expected: '$ExpectedData'"
        } elseif ((Get-ItemProperty -Path $Path).$Name.GetType().Name -ne "Int32") {
            $issues += "Value '$Name' in '$Path' is not of type DWORD"
        }
    } else {
        $issues += "Registry Key does not exist: '$Path'"
    }
}

# Check the registry values
CheckValues -Path $registryKey1 -Name $value1 -ExpectedData $expectedData1
CheckValues -Path $registryKey2 -Name $value2 -ExpectedData $expectedData2

# Output the results
if ($issues.Count -gt 0) {
    Write-Output "Issues found: $($issues -join ', ')"
    Exit 1
} else {
    Write-Output "All checks passed."
    Exit 0
}
