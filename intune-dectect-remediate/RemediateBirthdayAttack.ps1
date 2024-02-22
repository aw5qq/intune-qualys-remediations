# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script remediates weak cipher suites by disabling them.
# https://nvd.nist.gov/vuln/detail/CVE-2016-2183

$WeakCipherSuites = @(
    "DES",
    "3DES",
    "IDEA",
    "RC"
)

$weakCipherList = ""

foreach ($WeakCipherSuite in $WeakCipherSuites) {
    Write-Host "Processing cipher suite: $WeakCipherSuite"
    $CipherSuites = Get-TlsCipherSuite -Name $WeakCipherSuite

    if ($CipherSuites) {
        foreach ($CipherSuite in $CipherSuites) {
            $weakCipherList += "$($CipherSuite.Name), "
            Disable-TlsCipherSuite -Name $CipherSuite.Name
        }
    } 
}

if ($weakCipherList) {
    $weakCipherList = $weakCipherList.TrimEnd(", ")
    Write-Host "Weak cipher suites fixed: $weakCipherList"
    exit 0
}
else {
    Write-Host "No weak cipher suites detected."
    exit 0
}