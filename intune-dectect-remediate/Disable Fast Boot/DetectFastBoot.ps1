# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects if Fast Boot is enabled

# Define the registry key
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$Name = "HiberbootEnabled"
$Value = 0

# Check if the registry key exists and if it does, check if the value is correct
Try {
    if (Test-Path -Path $Path) {
        $Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
        If ($Registry -eq $Value){
            Write-Output "Fast Boot is not enabled"
            Exit 0
        } 
    }
    Write-Output "Fast Boot is enabled"
    Exit 1
} 
Catch {
    Write-Output "Unable to determine if Fast Boot is enabled"
    Exit 1
}