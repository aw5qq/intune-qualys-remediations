# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects if Private Teams is installed

if ($null -eq (Get-AppxPackage -Name MicrosoftTeams -allusers)) {
	Write-Host "Private MS Teams client is not installed"
	exit 0
} Else {
	Write-Host "Private MS Teams client is installed"
	Exit 1
}