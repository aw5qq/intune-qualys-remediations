# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script removes old versions of .NET Core and installs the latest ASP.NET Core Runtime.
# QID: 106089

# 2024-07-01 Update: Added removal of .NET Core below 8.0.6
# 2024-12-19 Update: Modified removal of .NET Core below 8.0.10 & consolidated path removals for .NET Core 3, 5, 6, and 7
# 2025-02-18 Update: Added more logical error handling for .NET Core Uninstall Tool installation and .NET Core version removal

# Function to install the .NET Core Uninstall Tool using MSI installer
function InstallDotNetCoreUninstallTool {
    # Define MSI download URL and the local file path
    $msiUrl = "https://github.com/dotnet/cli-lab/releases/download/1.6.0/dotnet-core-uninstall-1.6.0.msi"
    $msiFilePath = "$env:TEMP\dotnet-core-uninstall.msi"

    try {
        # Download the MSI installer
        Write-Host "Downloading .NET Core Uninstall Tool MSI..."
        Invoke-WebRequest -Uri $msiUrl -OutFile $msiFilePath -ErrorAction Stop

        # Install the MSI
        Write-Host "Installing .NET Core Uninstall Tool..."
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$msiFilePath`" /qn /norestart" -Wait -NoNewWindow -ErrorAction Stop

        # Remove the MSI installer file
        Remove-Item -Path $msiFilePath -ErrorAction Stop

        Write-Host ".NET Core Uninstall Tool installed successfully"
    } catch {
        Write-Error "Failed to install the .NET Core Uninstall Tool: $_"
        return $false
    }

    return $true
}

# Function to install the latest ASP.NET Core Runtime
function InstallLatestAspNetCoreRuntime {
    try {
        Write-Host "Installing latest ASP.NET Core Runtime..."
        Invoke-Expression "& { $(Invoke-RestMethod 'https://dot.net/v1/dotnet-install.ps1') } -Runtime aspnetcore -ErrorAction Stop"
        Write-Host "Latest ASP.NET Core Runtime installed successfully"
    } catch {
        Write-Error "Failed to install the latest ASP.NET Core Runtime: $_"
    }
}

# Install the .NET Core Uninstall Tool
if (-not (InstallDotNetCoreUninstallTool)) {
    Write-Error "Skipping uninstallation of old .NET Core versions due to failure in installing the Uninstall Tool."
    exit 1
}

# Uninstall any ASP.NET Core Runtime versions below 8.0.10
if (Get-Command dotnet-core-uninstall -ErrorAction SilentlyContinue) {
    Write-Host "Uninstalling old ASP.NET Core Runtime versions..."
    dotnet-core-uninstall remove --aspnet-runtime --all-below 8.0.10 -y
    dotnet-core-uninstall remove --runtime --all-below 8.0.10 -y
    dotnet-core-uninstall remove --sdk --all-below 8.0.10 -y
    dotnet-core-uninstall remove --hosting-bundle --all-below 8.0.10 -y
    Write-Host "Old ASP.NET Core Runtime versions uninstalled successfully"
} else {
    Write-Error "dotnet-core-uninstall tool is not installed."
}

# Clean up old .NET Core versions from the file system
$paths = @("3.*", "5.*", "6.*", "7.*")

foreach ($path in $paths) {
    Write-Host "Removing old .NET Core versions matching pattern: $path"
    Get-ChildItem -Path "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\" -Filter $path | ForEach-Object {
        if (Test-Path $_.FullName) {
            try {
                Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction Stop
                Write-Host "Removed: $_.FullName"
            } catch {
                Write-Error "Failed to remove: $_.FullName"
            }
        }
    }
}

# Install the latest ASP.NET Core Runtime
InstallLatestAspNetCoreRuntime