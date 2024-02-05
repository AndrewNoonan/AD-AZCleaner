#Sign in with administrative account.
#Sit back, relax, and watch some youtube because this is gonna take some time. 
Connect-MgGraph

Write-Host "Searching devices..."
$InTuneDevices = Get-MgDeviceManagementManagedDevice -All | Select-Object DeviceName, Id, UserId
Write-Host "Searching users..."
$InTuneUsers = Get-MgUser -All | Select-Object -Unique Id, DisplayName, Mail
Write-Host "Exporting devices to CSV..."
$InTuneDevices | Export-Csv -Path ".\Devices.csv" -NoTypeInformation
Write-Host "Exporting users to CSV..."
$InTuneUsers | Export-Csv -Path ".\Users.csv" -NoTypeInformation