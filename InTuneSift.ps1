#Sign in with administrative account.
Connect-MgGraph

Write-Host "Collecting devices..."
$InTuneDevices = Get-MgDeviceManagementManagedDevice -All | Select-Object DeviceName, Id, UserId

Write-Host "Populating InTune folder..."
$InTuneDevices.DeviceName | Out-File -Filepath ".\InTune\DeviceSNs.txt"
$InTuneDevices.Id | Out-File -Filepath ".\InTune\DeviceIDs.txt"
$InTuneDevices.UserId | Out-File -Filepath ".\InTune\DeviceUserIDs.txt"

foreach ($SN in $InTuneDeviceSNs) {
    if ($SN.DeviceName -eq "MSL-PW04B8NT") {
        Write-Host $SN.DeviceName, $SN.Id, $SN.UserId
    }
}
