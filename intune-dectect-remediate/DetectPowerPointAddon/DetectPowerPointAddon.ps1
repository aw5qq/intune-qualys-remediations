# Define the name of the add-in
$addInName = "YourAddInName" # Replace with the name of your add-in

# Create a PowerPoint application object
$powerPoint = New-Object -ComObject PowerPoint.Application

# Loop through the COM add-ins to check if the specified add-in is enabled
$addInFound = $false
foreach ($addIn in $powerPoint.COMAddIns) {
    if ($addIn.Description -eq $addInName) {
        if ($addIn.Connect -eq $true) {
            Write-Output "$addInName is enabled."
            #exit 0 # Exit with code 0 to indicate success
        } else {
            Write-Output "$addInName is not enabled."
            #exit 1 # Exit with code 1 to indicate failure
        }
    }
}

if (-not $addInFound) {
    Write-Output "Add-in not found."
    exit 1 # Exit with code 1 to indicate failure
}

# Clean up
$powerPoint.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($powerPoint) | Out-Null




# Define the name of the service
$serviceName = "Panopto Remote Recorder Service"

$service = Get-Service -Name $serviceName

# Check if the service is running
if ($service.Status -eq 'Running') {
    # Stop the service
    Stop-Service -Name $serviceName -Force
    Write-Output "$serviceName has been stopped."
} else {
    Write-Output "$serviceName is not running."
}