# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script sets the Office Update Branch

$officeUpdatePath = "HKLM:\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate"
$officeUpdateBranch = "MonthlyEnterprise"
#$officeUpdateBranch = "Current"
#$officeUpdateBranch = "PerpetualVL2021"

Set-Location -Path $officeUpdatePath

if (Test-Path $officeUpdatePath) {
    $currentBranch = (Get-ItemProperty -Path $officeUpdatePath).UpdateBranch

    # check if the branch is not set to MonthlyEnterprise
    if ($currentBranch -ne $officeUpdateBranch) {
        try {
            Set-ItemProperty -Path $officeUpdatePath -Name "UpdateBranch" -Value $officeUpdateBranch -Force
            Write-Output "Office update branch has been set to $officeUpdateBranch."
        }
        catch {
            Write-Output "Error: Failed to set the Office update branch."
            Write-Output $_.Exception.Message
        }   

    } else {
        Write-Host "Office update branch is already set to $officeUpdateBranch."
    }

} else {
    Write-Host "Office update branch policy not found"
}