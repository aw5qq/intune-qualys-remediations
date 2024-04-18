# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script enables the WinTrustVerify setting

# Define the registry key paths and values to add
$Key1Path = "HKLM:\SOFTWARE\Microsoft\Cryptography\Wintrust\Config"
$Key1ValueName = "EnableCertPaddingCheck"
$Key1ValueData = "1"

$Key2Path = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Cryptography\Wintrust\Config"
$Key2ValueName = "EnableCertPaddingCheck"
$Key2ValueData = "1"


# Create the registry key path for Key1 if it doesn't exist
if (!(Test-Path $Key1Path)) {
    New-Item -Path $Key1Path -Force
    Write-Output "$Key1Path Created"
}
        
# Create the registry key and value for Key1
Set-ItemProperty -Path $Key1Path -Name $Key1ValueName -Value $Key1ValueData
Write-Output "$Key1ValueName added to $Key1Path"

# Create the registry key path for Key2 if it doesn't exist
if (!(Test-Path $Key2Path)) {
    New-Item -Path $Key2Path -Force 
    Write-Output "$Key2Path Created"
}

# Create the registry key and value for Key2
Set-ItemProperty -Path $Key2Path -Name $Key2ValueName -Value $Key2ValueData

Write-Output "$Key2ValueName added to $Key2Path"

Write-Output "Registry updated successfully."