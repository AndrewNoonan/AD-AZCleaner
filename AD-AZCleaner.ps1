#MUST USE ADMIN CREDENTIALS
try {
    Write-Host "Connecting to Microsoft Graph" -ForegroundColor Cyan
    Connect-MgGraph
} finally {
    Write-Host "Connecting to Microsoft AzureAD" -ForegroundColor Cyan
    Connect-AzureAD
    Write-Host "Connected to Microsoft AzureAD"
}
#MUST USE ADMIN CREDENTIALS

$padding = "     "
$prefixes = "MHD-","MHL-","MHDK-", "MSDC-", "MSD-", "MSL-", "MSDK-"

Write-Host "Gathering devices from InTune, this may take a moment" -ForegroundColor Cyan
$InTuneDevices = Get-MgDeviceManagementManagedDevice -All | Select-Object DeviceName, Id, UserId

foreach ($SN in Get-Content .\CleanerDevices.txt) {
    Write-Host $padding"--- $SN ---"$padding -ForegroundColor Cyan

    #InTune record removal
    $count = 0
    foreach($device in $InTuneDevices) {
        foreach($prefix in $prefixes) {
            $machine = $prefix + $SN
            if ($device.DeviceName -eq $machine) {
                Write-Host "InTune | DELETING $machine" -ForegroundColor Red;
                if ((Read-Host $padding"$machine (y/n)") -eq 'y') {
                    Remove-MgDeviceManagementManagedDevice -ManagedDeviceId $device.Id
                    Write-Host $padding$Machine"| InTune record deleted" -ForegroundColor Green
                    #Write-Host $SN, $machine, $device.DeviceName, $device.Id, $device.UserId -ForegroundColor Green
                } else {
                    Write-Host $padding$machine"| InTune record deletion skipped" -ForegroundColor Yellow
                }                  
            } else {
                $count++ 
                if (($Count/($prefixes.Length)) -ge $InTuneDevices.Count) {
                    Write-Host $padding$SN"| InTune record not found" -ForegroundColor Yellow
                }
            }
        }
    }

    #AD record removal 
    #This will not work if you are not logged on to an administrative machine when running this script.
    #This uses try/catch because Get-ADComputer, unlike the others, will return a fatal error if the device is not found.
    $count = 0
    foreach ($prefix in $prefixes) {
        $machine = $prefix + $SN
        try {
        if (Get-ADComputer -Identity $machine) {
            Write-Host "AD | DELETING $machine" -ForegroundColor Red
            if ((Read-Host $padding$machine" delete AD record (y/n): ") -eq 'y') {
                try {
                    Get-ADComputer -Identity $machine | Remove-ADComputer -Confirm:$false
                    Write-Host $padding$machine"| AD record deleted" -ForegroundColor Green
                } catch {
                    Write-Host $padding"Record must be deleted manually" -ForegroundColor Red
                }
            } else {
                Write-Host $padding$machine"| AD record deletion skipped" -ForegroundColor Yellow
            }
        } else {
            Write-Host "hmm" -ForegroundColor DarkRed
        }
        } catch {
            $count++
            if (($count/($prefixes.Length)) -ge $SN.Count){
            
                Write-Host $padding$SN"| AD record not found" -ForegroundColor Yellow
            }
        }
    }

    #EntraID record removal (AKA AzureAD)
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
        } else {
            $count++
            if (($count/($prefixes.Length)) -ge $SN.Count) {
                Write-Host $padding$SN"| EntraID record not found" -ForegroundColor Yellow
            }
        }
    }
}
#NOTES:
#Use ($Count/($prefixes.Length)) to calculate what prefix/device the current loop is on.