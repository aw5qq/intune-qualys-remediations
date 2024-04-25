# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects if MSXML 4 is installed


$msxml4Products = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE 'Microsoft XML Parser%' OR Name LIKE 'Microsoft XML Core Services 4.0%'"

if ($null -eq $msxml4Products) {
    Write-Host "MSXML 4 is not installed"
    #exit 0
} else {
    Write-Host "MSXML 4 is installed"
    #exit 1
}