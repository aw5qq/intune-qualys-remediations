# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script disables Fast Boot

# Define the registry key
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$Name = "HiberbootEnabled"
$Value = 0

# Check if the registry key already exists
if (Test-Path -Path $Path) {
    # Set the registry key
    try {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -ErrorAction Stop
        Write-Output "Fast Boot has been disabled"
        Exit 0
    }
    catch {
        Write-Output "Failed to set the registry key: $_"
        Exit 1
    }
}
else {
    Write-Output "Registry key does not exist"
    Exit 1
}