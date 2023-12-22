#set-executionpolicy -ExecutionPolicy RemoteSigned -Scope Process
#Connect-AzureAD
$prefixes = "MHD-","MHL-","MHDK-", "MSDC-", "MSD", "MSL-", "MSDK-"

foreach ($machine in Get-Content .\Devices.txt) {
    $count = 0
    $temp = ""
    if ($machine.Length -gt 8) {
        $machine = $machine.Substring(12)
    }
    foreach ($prefix in $prefixes) {
            try {
                $temp = $prefix + $machine
                Get-ADComputer -Identity $temp
                if (Get-ADComputer -Identity $temp) {
                    if (Remove-ADComputer -Identity $temp) {
                        Write-Host $machine": AD record deleted"
                    } else {
                        Write-Host $machine": AD record deletion skipped"
                        $temp2 = $temp
                    }
                }
            } catch {
                if ($count -ge $prefixes.Length - 1){
                    Write-Host $machine": AD record not found"
                }
                $count++
            }
    }
    if ((Get-AzureADDevice -SearchString $machine) -or (Get-AzureADDevice -SearchString $temp)) {
        $input = Read-Host "Input machine name to delete azure record"
        if (($machine -contains $input) -or ($temp2 -contains $input)) {
            Get-AzureADDevice -SearchString $input | Remove-AzureADDevice
            Write-Host $machine": Azure record deleted"
        } else {
            Write-Host $machine": Azure record deletion skipped"
        }
    } else {
        Write-Host $machine": Azure record not found"
    }
    Write-Host ""
}