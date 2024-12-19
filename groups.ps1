New-ADGroup -Name "ITjuniorgroup" -GroupScope Global -GroupCategory Security -Path "CN=ITjuniors,DC=CiberDev,DC=local" -Description "Group for IT Juniors"
New-ADGroup -Name "ITseniorgroup" -GroupScope Global -GroupCategory Security -Path "CN=ITseniors,DC=CiberDev,DC=local" -Description "Group for IT Seniors"
New-ADGroup -Name "rrhhgroup" -GroupScope Global -GroupCategory Security -Path "CN=RRHH,DC=CiberDev,DC=local" 


