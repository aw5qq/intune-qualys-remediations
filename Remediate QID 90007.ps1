# Author: Andrew Welch (aw5qq@lawschool.virginia.edu)
# This script will set the CachedLogonsCount registry key to 0. 
# This will prevent cached credentials from being stored on the system. 
# This is a remediation script for QID 90007.

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "CachedLogonsCount" -Value 0
