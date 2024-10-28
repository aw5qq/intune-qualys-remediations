# Author: Andrew Welch (aw5qq@virginia.edu)
# Description: This script removes old versions of .NET Core and installs the latest ASP.NET Core Runtime.
# QID: 106089

# 2024-07-01 Update: Added removal of .NET Core below 8.0.6

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



InstallDotNetCoreUninstallTool

# Uninstal any ASP.NET Core Runtime versions below 
dotnet-core-uninstall remove --aspnet-runtime --all-below 8.0.6 -y
dotnet-core-uninstall remove --runtime --all-below 8.0.6 -y
dotnet-core-uninstall remove --sdk --all-below 8.0.6 -y
dotnet-core-uninstall remove --hosting-bundle --all-below 8.0.6 -y

InstallLatestAspNetCoreRuntime

Remove-Item -Path "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\3.1.32" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\5.0.17" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.0.31" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.0.35" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\7.0.7" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\7.0.20" -Recurse -Force -ErrorAction SilentlyContinue

