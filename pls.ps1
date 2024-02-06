Connect-AzureAD
$prefixes = "MHD-","MHL-","MHDK-", "MSDC-", "MSD-", "MSL-", "MSDK-"

foreach ($SN in Get-Content .\CleanerDevices.txt) {
    $count = 0
    $temp = ""
    if ($SN.Length -gt 8) {
        $SN = $SN.Substring(12)
    }

    #AD

    foreach ($prefix in $prefixes) {
        $machine = $prefix + $SN
        try {
            if (Get-ADComputer -Identity $machine) {
                if ((Read-Host "$machine delete AD record (y/n): ") -eq 'y') {
                    Remove-ADComputer -Identity $machine -Confirm:$false
                    Write-Host $machine": AD record deleted"
                } else {
                    Write-Host $machine": AD record deletion skipped"
                }
            } else {
                Write-Host $SN": No AD record found"
            }
        } catch {
            if ($count -ge $prefixes.Length - 1){
                Write-Host $SN": AD record not found"
            }
            $count++
        }
    }

    #Azure
    #EntraID
    $count = 0
    foreach ($prefix in $prefixes) {
        $machine = $prefix + $SN
        if (Get-AzureADDevice -SearchString $SN) {
            if ((Read-Host "$SN delete Azure record (y/n)") -eq 'y') {
                Get-AzureADDevice -SearchString $SN | Remove-AzureADDevice
                Write-Host $SN": Azure record deleted"
            } else {
                Write-Host $SN": AD record deletion skipped"
            }  
        } elseif (Get-AzureADDevice -SearchString $machine) {
            if ((Read-Host "$machine delete Azure record (y/n)") -eq 'y') {
                Get-AzureADDevice -SearchString $machine | Remove-AzureADDevice
                Write-Host $machine": Azure record deleted"
            } else {
                Write-Host $machine": AD record deletion skipped"
            }
        } else {
            if ($count -ge $prefixes.Length - 1){
                Write-Host $SN": Azure record not found"
            }
            $count++
        }
    }
    #InTune
    $count = 0
    foreach($device in $InTuneDevices) {
        foreach($prefix in $prefixes) {
            $machine = $prefix + $SN
            if ($device.DeviceName -eq $machine) {
                Write-Host "WARNING| DELETING $machine |WARNING" -ForegroundColor Red
                if ((Read-Host $padding"$machine (y/n)") -eq 'y') {
                    #Insert deletion statement here
                    Write-Host $padding$Machine"| InTune record deleted" -ForegroundColor Green
                    #Write-Host $device.DeviceName, $device.Id, $device.UserId
                } else {
                    Write-Host $padding$SN"| InTune record deletion skipped" -ForegroundColor Yellow
                }                  
            } else {
                #Write-Host ($Count/($prefixes.Length))
                $count++ 
                if (($Count/($prefixes.Length)) -ge $InTuneDevices.Count) {
                    Write-Host $SN"| InTune record not found" -ForegroundColor Yellow
                }
            }
        }
    }
    Write-Host ""
}