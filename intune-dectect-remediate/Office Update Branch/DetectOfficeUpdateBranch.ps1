# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script sets the Office Update Branch

$officeUpdatePath = "HKLM:\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate"
$officeUpdateBranch = "MonthlyEnterprise"

if (Test-Path $officeUpdatePath) {
    $currentBranch = (Get-ItemProperty -Path $officeUpdatePath).UpdateBranch

    if ($currentBranch -eq $officeUpdateBranch) {
        Write-Host "Office update branch is set to $currentBranch"
        #Exit 1
    } else {
        Write-Host "Office update branch is not set to $currentBranch"
        #Exit 0
    }
} 

else {
    Write-Host "Office update branch policy not found"
    #Exit 0
}