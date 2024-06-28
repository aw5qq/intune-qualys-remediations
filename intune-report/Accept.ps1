
# Set the Windows 10 Home location to United States
Start-Process "ms-windows-store" -Wait


# This script will set the Windows 10 Home location to United States
Set-WinUILanguageOverride -Language "en-US"
Set-WinDefaultInputMethodOverride -InputTip "0409:00000409"
Set-WinUserLanguageList -LanguageList "en-US" -Force
Set-WinHomeLocation -GeoId 244
