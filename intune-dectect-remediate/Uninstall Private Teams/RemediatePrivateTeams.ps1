# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script removes the Private Teams app

try{
    $teamsPackage = Get-AppxPackage -Name MicrosoftTeams -AllUsers -ErrorAction Stop

    if ($teamsPackage) {
        $teamsPackage | Remove-AppxPackage -ErrorAction Stop
        Write-Host "Private MS Teams app successfully removed"
    } else {
        Write-Host "Microsoft Teams app not found"
    }
}catch{
    Write-Error "Error removing Microsoft Teams app"
}