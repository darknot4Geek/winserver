# Importar el módulo de Active Directory
Import-Module ActiveDirectory

# Especificar la ruta del archivo Excel
$excelFilePath = "C:\Users\Administrador\Desktop\ITSENIORS.xlsx"

# Cargar el archivo Excel
$usersData = Import-Excel -Path $excelFilePath

# Establecer la contraseña predeterminada
$password = ConvertTo-SecureString "R4izraiz." -AsPlainText -Force

# Especificar la OU de destino
$targetOU = "OU=ITseniors,DC=CiberDev,DC=local"

# Iterar a través de cada fila en el archivo Excel
foreach ($user in $usersData) {
    try {
        # Construir el nombre de usuario
        $username ="it." + ($user.Izena.Substring(0, 3) + $user.Abizena.Substring(0, 4)).ToLower()

        # Generar un GUID único para el usuario
        $userGuid = [System.Guid]::NewGuid().ToString()

        # Generar el UPN con el GUID
        $uniqueUPN = "$username@ciberdev.local"

        # Generar el email
        $email = "$($user.Izena.ToLower()).$($user.Abizena.ToLower())@ciberdev.local"


        # Verificar si el UPN ya existe y ajustarlo si es necesario
        while (Get-ADUser -Filter {UserPrincipalName -eq $uniqueUPN}) {
            # Modificar el UPN para hacerlo único (agregar un número aleatorio)
            $uniqueUPN = "$username$([System.Random]::new().Next(1000, 9999))@ciberdev.local"
        }

        # Crear un usuario en Active Directory dentro de la OU especificada
        New-ADUser -SamAccountName $username -UserPrincipalName $uniqueUPN -DisplayName "$($user.Izena) $($user.Abizena)"  -GivenName $user.Izena -Surname $user.Abizena -Name "$($user.Izena) $($user.Abizena)" -EmailAddress $email -StreetAddress $user.Helbidea -City $user.Herria -Title "User" -Department "General" -OfficePhone $user.Telefonoa -Mobile $user.Telefonoa -Enabled $true -AccountPassword $password -Path $targetOU

        # Agregar el usuario a los grupos "moodle" y "zimbra"
        Add-ADGroupMember -Identity "ITseniorgroup" -Members $username
	Add-ADGroupMember -Identity "Administradores" -Members $username


    } catch {
        $givenName = $user.Izena
        $surname = $user.Abizena
        Write-Host ("Error creating user {0} {1}: {2}" -f $givenName, $surname, $_.Exception.Message)
    }
}
