# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script removes old versions of .NET Core and installs the latest ASP.NET Core Runtime.
# QID: 106089

# 2024-07-01 Update: Added removal of .NET Core below 8.0.6
# 2024-12-19 Update: Modified removal of .NET Core below 8.0.10 & consolidated path removals for .NET Core 3, 5, 6, and 7
# 2025-02-18 Update: Added more logical error handling for .NET Core Uninstall Tool installation and .NET Core version removal
# 2025-02-18 Update: Added environment variable to remove drive letter dependency for file system cleanup

# Install the .NET Core Uninstall Tool using MSI installer
function InstallDotNetCoreUninstallTool {
    # Define MSI download URL and the local file path
    $msiUrl = "https://github.com/dotnet/cli-lab/releases/download/1.6.0/dotnet-core-uninstall-1.6.0.msi"
    $msiFilePath = "$env:TEMP\dotnet-core-uninstall.msi"

    # Download the MSI installer
    Write-Host "Downloading .NET Core Uninstall Tool MSI..."
    Invoke-WebRequest -Uri $msiUrl -OutFile $msiFilePath

    # Install the MSI
    Write-Host "Installing .NET Core Uninstall Tool..."
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$msiFilePath`" /qn /norestart" -Wait -NoNewWindow

    # Remove the MSI installer file
    Remove-Item -Path $msiFilePath

    Write-Host ".NET Core Uninstall Tool installed"
}

# Install the latest ASP.NET Core Runtime
function InstallLatestAspNetCoreRuntime {
    Write-Host "Installing latest ASP.NET Core Runtime..."
    Invoke-Expression "& { $(Invoke-RestMethod 'https://dot.net/v1/dotnet-install.ps1') } -Runtime aspnetcore"
    Write-Host "Latest ASP.NET Core Runtime installed"
}


#Install the .NET Core Uninstall Tool
InstallDotNetCoreUninstallTool

# Uninstall any ASP.NET Core Runtime versions below 
if (Get-Command dotnet-core-uninstall -ErrorAction SilentlyContinue) {
    dotnet-core-uninstall remove --aspnet-runtime --all-below 8.0.10 -y
    dotnet-core-uninstall remove --runtime --all-below 8.0.10 -y
    dotnet-core-uninstall remove --sdk --all-below 8.0.10 -y
    dotnet-core-uninstall remove --hosting-bundle --all-below 8.0.10 -y
} else {
    Write-Host "dotnet-core-uninstall tool is not installed."
}

# Clean up old .NET Core versions from the file system

$dotnetPath = Join-Path $env:ProgramFiles "dotnet\shared\Microsoft.NETCore.App"

Get-ChildItem -Path $dotnetPath -Filter $path -Directory | ForEach-Object {
    try {
        if (Test-Path $_.FullName) {
            Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction Stop
            Write-Host "Successfully removed: $($_.FullName)"
        }
    } 
    catch {
        Write-Host "Failed to remove: $($_.FullName). Error: $($_.Exception.Message)"
    }
}
    
if (Test-Path $dotnetPath) {
    Write-Host "Access to the directory '$dotnetPath' was denied." -ForegroundColor Red
}

# Install the latest ASP.NET Core Runtime
InstallLatestAspNetCoreRuntime