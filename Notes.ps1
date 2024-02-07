Get-ADOrganizationalUnit -LDAPFilter '(name=*)' -SearchBase 'OU=Client Computers,DC=act-maxopco2,DC=com' -SearchScope OneLevel | Format-Table Name, DistinguishedName -A

Name                       DistinguishedName                                                       
----                       -----------------                                                       
Disabled Computers         OU=Disabled Computers,OU=Client Computers,DC=act-maxopco2,DC=com        
Imaging - limited policies OU=Imaging - limited policies,OU=Client Computers,DC=act-maxopco2,DC=com
Intune Testing             OU=Intune Testing,OU=Client Computers,DC=act-maxopco2,DC=com            
Kiosks                     OU=Kiosks,OU=Client Computers,DC=act-maxopco2,DC=com                    
Test - New GPOs            OU=Test - New GPOs,OU=Client Computers,DC=act-maxopco2,DC=com           
Virtual Workstations       OU=Virtual Workstations,OU=Client Computers,DC=act-maxopco2,DC=com  

Get-ADComputer -Identity "MSL-PW04B94Y"


DistinguishedName : CN=MSL-PW04B94Y,OU=Imaging - limited policies,OU=Client Computers,DC=act-maxopco2,DC=com
DNSHostName       : MSL-PW04B94Y.act-maxopco2.com
Enabled           : True
Name              : MSL-PW04B94Y
ObjectClass       : computer
ObjectGUID        : b005677a-a7ad-48d4-9e43-0383e02b716c
SamAccountName    : MSL-PW04B94Y$
SID               : S-1-5-21-4294613725-1444334241-828869353-23902

Get-ADOrganizationalUnit -LDAPFilter '(name=*)' -SearchBase 'OU=Imaging - limited policies,OU=Client Computers,DC=act-maxopco2,DC=com' | Format-Table Name, DistinguishedName, ObjectGUID

Name                       DistinguishedName                                                        ObjectGUID                          
----                       -----------------                                                        ----------                          
Imaging - limited policies OU=Imaging - limited policies,OU=Client Computers,DC=act-maxopco2,DC=com a19ab7fc-5135-4f22-90fb-880880db5d33

Imaging - limited policies - a19ab7fc-5135-4f22-90fb-880880db5d33
Imaging - limited policies - OU=Client Computers,DC=act-maxopco2,DC=com

Migration Staging - be65b265-3c40-4f55-b1ef-cac7b3414cab
Migration Staging - OU=Migration Staging,DC=act-maxopco2,DC=com

 Move-ADObject -Identity 'CN=MSL-PW04B94Y,OU=Client Computers,DC=act-maxopco2,DC=com' ` -TargetPath 'OU=MHS-Client Computers,OU=Migration Staging,DC=act-maxopco2,DC=com'

MHS-Client Computers - 24d559a-98ad-444c-85f4-466b93cbcdaf
MHS-Client Computers - OU=MHS-Client Computers,OU=Migration Staging,DC=act-maxopco2,DC=com

-----------------------------------------------------------------------

--- Twinkies ---     
Twinkies| InTune record not found
Twinkies| AD record not found
--- PW04B8S7 ---     
InTune| DELETING MHL-PW04B8S7
MHL-PW04B8S7 (y/n): y
MHL-PW04B8S7 af7f01be-97ae-4ad5-a516-4fe055560643 125bfcdf-b526-4f44-82e6-130aaa9cc9ed
AD| DELETING MHL-PW04B8S7
MHL-PW04B8S7 delete AD record (y/n): : y
MHL-PW04B8S7| AD record deleted
--- PW04B8QC ---     
InTune| DELETING MSL-PW04B8QC
MSL-PW04B8QC (y/n): y
MSL-PW04B8QC af7e0e1b-3e59-4500-bb3a-f256c05b4423 09d0429e-a834-4f1d-ac28-a9090378da86
AD| DELETING MSL-PW04B8QC
MSL-PW04B8QC delete AD record (y/n): : y
MSL-PW04B8QC| AD record deleted
--- PW04B8M1 ---     
InTune| DELETING MSL-PW04B8M1
MSL-PW04B8M1 (y/n): y
MSL-PW04B8M1 d60140de-8144-477e-bd88-bf30436b0079 1fce8968-578c-485b-a8ce-71e28c195449
AD| DELETING MHL-PW04B8M1
MHL-PW04B8M1 delete AD record (y/n): : y
MHL-PW04B8M1| AD record deleted
AD| DELETING MSL-PW04B8M1
MSL-PW04B8M1 delete AD record (y/n): : y
MSL-PW04B8M1| AD record deleted
--- PW04B8T1 ---     
InTune| DELETING MHL-PW04B8T1
MHL-PW04B8T1 (y/n): y
MHL-PW04B8T1 cdbe44f0-6a44-40c3-9bec-8d5ba637cdbb e2efc1f0-6323-461e-a7bb-699a3efa86c1
AD| DELETING MHL-PW04B8T1
MHL-PW04B8T1 delete AD record (y/n): : y
MHL-PW04B8T1| AD record deleted

--------------------------

--- Twinkies ---     
Twinkies| InTune record not found
Twinkies| AD record not found
--- PW04B8S7 ---     
InTune| DELETING MHL-PW04B8S7
MHL-PW04B8S7 (y/n): n
PW04B8S7| InTune record deletion skipped
AD| DELETING MHL-PW04B8S7
MHL-PW04B8S7 delete AD record (y/n): : n
MHL-PW04B8S7| AD record deletion skipped
--- PW04B8QC ---     
InTune| DELETING MSL-PW04B8QC
MSL-PW04B8QC (y/n): n
PW04B8QC| InTune record deletion skipped
AD| DELETING MSL-PW04B8QC
MSL-PW04B8QC delete AD record (y/n): : n
MSL-PW04B8QC| AD record deletion skipped
--- PW04B8M1 ---     
InTune| DELETING MSL-PW04B8M1
MSL-PW04B8M1 (y/n): n
PW04B8M1| InTune record deletion skipped
AD| DELETING MHL-PW04B8M1
MHL-PW04B8M1 delete AD record (y/n): : n
MHL-PW04B8M1| AD record deletion skipped
AD| DELETING MSL-PW04B8M1
MSL-PW04B8M1 delete AD record (y/n): : n
MSL-PW04B8M1| AD record deletion skipped
--- PW04B8T1 ---     
InTune| DELETING MHL-PW04B8T1
MHL-PW04B8T1 (y/n): n
PW04B8T1| InTune record deletion skipped
AD| DELETING MHL-PW04B8T1
MHL-PW04B8T1 delete AD record (y/n): : n
MHL-PW04B8T1| AD record deletion skipped