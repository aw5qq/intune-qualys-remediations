# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script remediates weak cipher suites by disabling them.
# https://nvd.nist.gov/vuln/detail/CVE-2016-2183

$WeakCipherSuites = @(
    "DES",
    "3DES",
    "IDEA",
    "RC"
)

$weakCipherDetected = $false
$weakCipherList = ""

Foreach ($WeakCipherSuite in $WeakCipherSuites) {
    Write-Host "Processing cipher suite: $WeakCipherSuite"
    $CipherSuites = Get-TlsCipherSuite -Name $WeakCipherSuite

    if ($CipherSuites) {
        Foreach ($CipherSuite in $CipherSuites) {
            $weakCipherDetected = $true
            $weakCipherList += "$($CipherSuite.Name), "
            Disable-TlsCipherSuite -Name $($CipherSuite.Name)
        }
    } 
    
    else {
        #Write-Host "No cipher suites found for: $WeakCipherSuite"
    }
}

if ($weakCipherDetected) {
    $weakCipherList = $weakCipherList.TrimEnd(", ")
    Write-Host "Weak cipher suites fixed: $weakCipherList"
    exit 0
}
else {
    Write-Host "No weak cipher suites detected."
    exit 0
}