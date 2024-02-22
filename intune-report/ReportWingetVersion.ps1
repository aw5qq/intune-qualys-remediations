# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects if winget is installed

try {
    # Attempt to run 'winget' with the --version argument to check if it is available
    $wingetVersion = winget --version
    if ($null -ne $wingetVersion) {
        Write-Output "winget version: $wingetVersion"
        Exit 0
    }
} catch {
    Write-Output "winget is not available on this machine"
    Exit 1
}