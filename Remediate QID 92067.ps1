# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script sets the "EnableHttp2Tls" registry key to prevent the "HTTP/2 Protocol Vulnerability".
# QID: 92067

# Define the registry key paths and values to add
$Key1Path = "HKLM:\SYSTEM\CurrentControlSet\Services\HTTP\Parameters"
$Key1ValueName = "EnableHttp2Tls"
$Key1ValueData = "1"

try {
    # Create the registry key path for Key1 if it doesn't exist
    if (!(Test-Path $Key1Path)) {
        New-Item -Path $Key1Path -Force
        Write-Output "$Key1Path Created"
    }
    
    # Create the registry key and value for Key1
    Set-ItemProperty -Path $Key1Path -Name $Key1ValueName -Value $Key1ValueData
    Write-Output "$Key1ValueName added to $Key1Path"

    Write-Output "Registry updated successfully."
}
catch {
    Write-Output "Error occurred while updating the registry: $_"
}