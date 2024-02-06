$padding = "     "
$prefixes = "","MHD-","MHL-","MHDK-", "MSDC-", "MSD-", "MSL-", "MSDK-"
$InTuneDevices = Get-MgDeviceManagementManagedDevice -All | Select-Object DeviceName, Id, UserId
Connect-MgGraph
Connect-AzureAD

foreach ($SN in Get-Content .\test.txt) {
    Write-Host $padding"--- $SN ---"$padding -ForegroundColor Cyan
    $count = 0
    foreach($device in $InTuneDevices) {
        foreach($prefix in $prefixes) {
            $machine = $prefix + $SN
            if ($device.DeviceName -eq $machine) {
                Write-Host "InTune | DELETING $machine" -ForegroundColor Red;
                if ((Read-Host $padding"$machine (y/n)") -eq 'y') {
                    #Remove-MgDeviceManagementManagedDevice -ManagedDeviceId $device.Id
                    #Write-Host $padding$Machine"| InTune record deleted" -ForegroundColor Green
                    Write-Host $SN, $machine, $device.DeviceName, $device.Id, $device.UserId -ForegroundColor Green
                } else {
                    Write-Host $padding$machine"| InTune record deletion skipped" -ForegroundColor Yellow
                }                  
            } else {
                #Write-Host ($Count/($prefixes.Length))
                $count++ 
                if (($Count/($prefixes.Length)) -ge $InTuneDevices.Count) {
                    Write-Host $padding$machine"| InTune record not found" -ForegroundColor Yellow
                }
            }
        }
    }
    $count = 0
    foreach ($prefix in $prefixes) {
        $machine = $prefix + $SN
        try {
            if (Get-ADComputer -Identity $machine) {
                Write-Host "AD | DELETING $machine" -ForegroundColor Red
                if ((Read-Host $padding$machine" delete AD record (y/n): ") -eq 'y') {
                    Remove-ADComputer -Identity $machine -Confirm:$false
                    Write-Host $padding$machine"| AD record deleted" -ForegroundColor Green
                } else {
                    Write-Host $padding$machine"| AD record deletion skipped" -ForegroundColor Yellow
                }
            }
        } catch {
            $count++
            if (($count/($prefixes.Length)) -ge $SN.Count){
                Write-Host $padding$Machine"| AD record not found" -ForegroundColor Yellow
            }
        }
    }
    $count = 0
    foreach ($prefix in $prefixes) {
        $machine = $prefix + $SN
            if (Get-AzureADDevice -SearchString $machine ) {
                Write-Host "EntraID | DELETING $machine" -ForegroundColor Red
                if ((Read-Host "$padding$machine delete EntraID record (y/n)") -eq 'y') {
                    Get-AzureADDevice -SearchString $machine | Remove-AzureADDevice
                    Write-Host $padding$machine"| EntraID record deleted" -ForegroundColor Green
                } else {
                    Write-Host $padding$machine": EntraID record deletion skipped" -ForegroundColor Yellow
                }  
            }

            $count++
            if (($count/($prefixes.Length)) -ge $SN.Count){
                Write-Host $padding$SN"| EntraID record not found" -ForegroundColor Yellow
            }
    }
}
#NOTES:
#Use ($Count/($prefixes.Length)) to calculate what device/total the current loop is on.