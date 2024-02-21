# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script sets the CachedLogonsCount registry key to 0
# QID: 90007

# Define the registry key
$Path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$Name = "CachedLogonsCount"
$Value = 0

# Check if the registry key exists and if it does, set the value to 0
Try {
    if (Test-Path -Path $Path) {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -ErrorAction Stop
        Write-Output "CachedLogonsCount has been set to 0"
        Exit 0
    }
    Write-Output "Unable to set CachedLogonsCount to 0"
    Exit 1
} 
Catch {
    Write-Output "Unable to set CachedLogonsCount to 0"
    Exit 1
}
