# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects weak cipher suites
# https://nvd.nist.gov/vuln/detail/CVE-2016-2183

$WeakCipherSuites = @(
    "3DES",
    "IDEA",
    "RC",
    "DES"
)

$weakCipherDetected = $false

Foreach ($WeakCipherSuite in $WeakCipherSuites) {
    $CipherSuites = Get-TlsCipherSuite -Name $WeakCipherSuite

    if ($CipherSuites) {
        $weakCipherDetected = $true
        break
    }
}

if ($weakCipherDetected) {
    Write-Host "Weak cipher suites found."
    exit 1
}
else {
    Write-Host "No weak cipher suites detected."
    exit 0
}