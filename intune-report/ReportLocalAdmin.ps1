# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script will return a list of all local administrators, excluding specific accounts.

# Define the administrator accounts to exclude
$excludedAdmins = @("account1", "account2", "account3")

$localAdmins = net localgroup administrators | Where-Object {$_ -and $_ -notmatch "command completed successfully" -and $_ -notmatch '^Administrator$' -and $_ -notmatch 'Domain Admins'} | Select-Object -skip 4

foreach ($LocalAdmin in $LocalAdmins) {
    if ($excludedAdmins -notcontains $LocalAdmin.ToLower()) {
        $adminNames += "$LocalAdmin, "
    }
}

if ([string]::IsNullOrEmpty($adminNames)) {
    Write-Output "No unknown local administrators were found on this device"
} else {
    # Remove the trailing comma and space
    $adminNames = $adminNames.TrimEnd(", ")
    Write-Output "Local Administrators:" $adminNames
}

