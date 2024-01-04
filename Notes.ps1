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
