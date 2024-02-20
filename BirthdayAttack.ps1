# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script detects and remediates weak cipher suites by disabling them.
# https://nvd.nist.gov/vuln/detail/CVE-2016-2183

Import-Module -Name TlsCipherSuite

$WeakCipherSuites = @(
    "DES",
    "3DES",
    "IDEA",
    "RC"
)

Foreach($WeakCipherSuite in $WeakCipherSuites){
    Write-Host "Processing cipher suite: $WeakCipherSuite"
    $CipherSuites = Get-TlsCipherSuite -Name $WeakCipherSuite

    if($CipherSuites){
        Foreach($CipherSuite in $CipherSuites){
            try {
                Disable-TlsCipherSuite -Name $($CipherSuite.Name)
                Write-Host "Successfully disabled cipher suite: $($CipherSuite.Name)"
            } catch {
                Write-Host "Error disabling cipher suite: $($CipherSuite.Name). Error: $_"
            }
        }
    } else {
        Write-Host "No cipher suites found for: $WeakCipherSuite"
    }
}