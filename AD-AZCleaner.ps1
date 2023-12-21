$prefixs = "MHL-", "MSL-", "MHDK-", "MSDK-"

foreach ($machine in Get-Content .\File.txt*) {
    $count = 0
    foreach ($prefix in $prefixs) {
            if ($machine.Length -gt 8) {
                $machine = $machine.Substring(12)
            }
            try {
                $temp = $prefix + $machine
                if (Get-ADComputer -Identity $temp) {
                    if (Remove-ADComputer -Identity $temp) {
                        Write-Host $temp": AD record deleted"
                    } else {
                        Write-Host $temp": AD record deletion skipped"
                    }
                }
            } catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
                $count++
                if ($count -ge $prefixs.Length){
                    Write-Host $machine": AD record not found"
                }
            }
        }
}