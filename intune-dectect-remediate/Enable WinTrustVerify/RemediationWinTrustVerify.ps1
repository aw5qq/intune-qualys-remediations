# Remediation Script: EnableCertPaddingCheck Registry Fix
# Purpose: Ensure REG_DWORD value is correctly set for CVE-2024-30080 remediation (QID 378332)

$registryEntries = @(
    @{
        Path  = "HKLM:\SOFTWARE\Microsoft\Cryptography\Wintrust\Config"
        Name  = "EnableCertPaddingCheck"
        Value = 1
    },
    @{
        Path  = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Cryptography\Wintrust\Config"
        Name  = "EnableCertPaddingCheck"
        Value = 1
    }
)

$success = $true

foreach ($entry in $registryEntries) {
    try {
        # Ensure registry path exists
        if (!(Test-Path -Path $entry.Path)) {
            New-Item -Path $entry.Path -Force | Out-Null
            Write-Output "Created registry path: $($entry.Path)"
        }

        # Create or update the registry value as REG_DWORD
        New-ItemProperty -Path $entry.Path `
                         -Name $entry.Name `
                         -Value $entry.Value `
                         -PropertyType DWord `
                         -Force | Out-Null
        Write-Output "Set '$($entry.Name)' as REG_DWORD with value '$($entry.Value)' in $($entry.Path)"
    } catch {
        Write-Output "Failed to configure $($entry.Path): $_"
        $success = $false
    }
}

if ($success) {
    Write-Output "Remediation completed successfully."
    Exit 0
} else {
    Write-Output "Remediation encountered errors."
    Exit 1
}