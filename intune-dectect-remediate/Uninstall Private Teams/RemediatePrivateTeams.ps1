# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script removes the Private Teams app

try{
    Get-AppxPackage -Name MicrosoftTeams -allusers | Remove-AppxPackage -ErrorAction stop
    Write-Host "Private MS Teams app successfully removed"
}catch{
    Write-Error "Error removing Microsoft Teams app"
}