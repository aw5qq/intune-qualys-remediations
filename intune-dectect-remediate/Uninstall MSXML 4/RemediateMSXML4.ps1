# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script removes XML Parser (MSXML) 4.0

$msxml4Products = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE 'Microsoft XML Parser%' OR Name LIKE 'Microsoft XML Core Services 4.0%'"

if ($null -eq $msxml4Products) {
    Write-Host "No Microsoft XML Parser or Microsoft XML Core Services (MSXML) 4.0 installations found."

    # Define the path of the msxml4.dll file
    $msxml4Path = "$env:windir\SysWOW64\msxml4.dll"

    # Check if the file exists
    if (Test-Path $msxml4Path) {
        Remove-Item $msxml4Path -Force
        Write-Output "msxml4.dll successfully removed." 
    } 
    else {
        Write-Output "msxml4.dll does not exist."
    }

    return
}