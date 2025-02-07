# QID: 378332

# PowerShell script to enable CertPaddingCheck and ensure DWORD type

# Define the registry key paths
$regPaths = @(
    "HKLM:\Software\Microsoft\Cryptography\Wintrust\Config",
    "HKLM:\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config"
)

# Registry key value name and data
$keyName = "EnableCertPaddingCheck"
$keyValue = 1  # DWORD value

# Function to check if the registry value is DWORD, delete if not
function Ensure-DWORDValue {
    param (
        [string]$path,
        [string]$name,
        [int]$value
    )

    # Check if the registry key exists
    if (Test-Path $path) {
        # Check if the registry value exists
        if (Test-Path "$path\$name") {
            # Get the current value type
            $currentValueType = (Get-ItemProperty -Path $path -Name $name).PSObject.Properties[$name].TypeNameOfValue
            
            if ($currentValueType -ne 'System.Int32') {
                # If it's not DWORD (System.Int32), delete the key
                Write-Host "Deleting existing registry value because it is not DWORD."
                Remove-ItemProperty -Path $path -Name $name
            }
        }
    }

    # Create or update the registry value as DWORD
    Set-ItemProperty -Path $path -Name $name -Value $value
    Write-Host "Set registry key: $path\$name = $value"
}

# Apply changes for both registry paths
foreach ($path in $regPaths) {
    # Ensure the registry path exists
    if (-not (Test-Path $path)) {
        Write-Host "Creating registry path: $path"
        New-Item -Path $path -Force
    }

    # Ensure DWORD value for CertPaddingCheck
    Ensure-DWORDValue -path $path -name $keyName -value $keyValue
}

Write-Host "Successfully enabled CertPaddingCheck with DWORD value. Please test thoroughly in your environment."

# End of script
