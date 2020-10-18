####### MODULO DE CIFRADO #######

Function certificados
{
    <#
    .SYNOPSIS
     Muestra certificados disponibles
    .DESCRIPTION 
      Muestra certificados disponibles
    
    .EXAMPLE 
      certificados  
  #> 

	Get-ChildItem -Path Cert:\CurrentUser\My -DocumentEncryptionCert
}


Function borrarCertificado
{
  <#
    .SYNOPSIS
     Borra un certificado disponible
    .DESCRIPTION 
      Borra un certificado disponible a traves de su ID
    
    .EXAMPLE 
      borrarCertificado $numero  
  #> 

    PARAM($numero)
	Remove-Item Cert:\CurrentUser\My\$numero
}


Function certificado
{
  <#
    .SYNOPSIS
     Crea el certificado en un fichero
    .DESCRIPTION 
      Crea el certificado en un fichero
    
    .EXAMPLE 
      certreq.exe -new DocumentEncryption.inf DocumentEncryption.cer 
    .EXAMPLE 
      certificado clave nombreFichero
  #> 

    PARAM(
      [string] $nombre,
      [string] $nombreFichero
    )

'[Version]
Signature = "$Windows NT$"
[Strings]
szOID\_ENHANCED\_KEY\_USAGE = "2.5.29.37"
szOID\_DOCUMENT\_ENCRYPTION = "1.3.6.1.4.1.311.80.1"
[NewRequest]'>>$nombreFichero
"Subject = cn=$nombre@localhost.local">>$nombreFichero
'MachineKeySet = false
KeyLength = 2048
KeySpec = AT_KEYEXCHANGE
HashAlgorithm = Sha1
Exportable = true
RequestType = Cert
KeyUsage = "CERT_KEY_ENCIPHERMENT_KEY_USAGE |  CERT_DATA_ENCIPHERMENT_KEY_USAGE"
ValidityPeriod = "Years"
ValidityPeriodUnits = "1000"
[Extensions]
%szOID\_ENHANCED\_KEY\_USAGE% = "{text}%szOID\_DOCUMENT\_ENCRYPTION%"' >> $nombreFichero




	certreq.exe -new .\$nombreFichero .\$nombreFichero.cer
	Get-ChildItem -Path Cert:\CurrentUser\My -DocumentEncryptionCert
}

# Get-ChildItem -Path Cert:\CurrentUser\My -DocumentEncryptionCert

Function cifrar
{
  <#
    .SYNOPSIS
     Cifra un texto
    .DESCRIPTION 
      Cifra un texto con un certificado y un nombre de fichero dados
    
    .EXAMPLE 
      Protect-CmsMessage -To 'cn=nombre@localhost.local'  -Content $Text  -OutFile MiTextoCifrado.txt 
    .EXAMPLE 
      cifrar nombre nombreFichero
  #> 

    PARAM(
      [string] $nombre,
      [string] $nombreFichero
    )
	Protect-CmsMessage -To "cn=$nombre@localhost.local" -OutFile $nombreFichero	
}


#Get-CmsMessage -Path .\MiTextoCifrado.txt | Unprotect-CmsMessage -To 'cn=nombre@localhost.local'

Function descifrar
{
    <#
    .SYNOPSIS
     Descifra un texto
    .DESCRIPTION 
      DesCifra un fichero con un certificado y un nombre de fichero dados, creando un fichero nuevo
    
    .EXAMPLE 
      Get-CmsMessage -Path .\MiTextoCifrado.txt | Unprotect-CmsMessage -To 'cn=nombre@localhost.local' 
    .EXAMPLE 
      descifrar nombre nombreFichero
  #> 

	    PARAM(
      [string] $nombre,
      [string] $nombreFichero
    )
	Get-CmsMessage -Path $nombreFichero | Unprotect-CmsMessage -To "cn=$nombre@localhost.local" > "$nombreFichero.descifrado.txt"
}

Function comprobarHashMultimedia
{
    <#
    .SYNOPSIS
     Comprueba cambios en una carpeta
    .DESCRIPTION 
      Descarga y descomprime un fichero del multimedia del coche y comprueba cambios en el hash
    
    .EXAMPLE 
      comprobarHash 
    .EXAMPLE 
      comprobarHash .\miPath
  #> 

  PARAM($path = "E:\personal\hashes", $time=0)
 
  $rutaActual = $pwd
  cd $path

  Remove-Item .\17TDT1EU-DA30_0016.kwi

  $client = (New-Object System.Net.WebClient).DownloadFile("http://streamtechdoc.toyota-motor-europe.com/techdoc3/audio_navigation/17TDT1EU-DA30_Latest.zip","$($path)\update.zip")

  descomprime "-y"

  .\17TDT1EU-DA30_0016.kwi.md5

  Start-Sleep -s $time
  cd $rutaActual
}

Function generatedMD5
{
    <#
    .SYNOPSIS
     Genera fichero hash
    .DESCRIPTION 
      Genera fichero hash con formato: hash ESPACIO ASTERISCOnombreFichero
    
    .EXAMPLE 
      generatedMD5 
    .EXAMPLE 
      generatedMD5 .\miPath
    #> 

  PARAM($path = "E:\personal\hashes")

  $rutaActual = $pwd
  cd $path

  $files = ls $path -exclude *.md5
  Remove-Item miMD5.md5

  ForEach ($file in $files) 
  {
        $hash= (Get-FileHash $file -Algorithm MD5).hash
        $hash + " *"+$file.Name >> miMD5.md5
  }
  

  cd $rutaActual
}

Function compareHash
{
    <#
    .SYNOPSIS
     Compara el hash de dos ficheros
    .DESCRIPTION 
     Compara el hash de dos ficheros para saber si son el mismo
    
    .EXAMPLE 
      compareHash .\miFile1 .\miFile2
    #> 

  PARAM($file1, $file2)

  $hash1= (Get-FileHash $file1 -Algorithm MD5).hash
  $hash2= (Get-FileHash $file2 -Algorithm MD5).hash

  if($hash1 -eq $hash2)
  {
    write-host -BackgroundColor DarkGreen -ForegroundColor Green ('                 IGUALES                 ')
  }else{
    Write-Host -BackgroundColor DarkRed -ForegroundColor Red ('                 DISTINTOS                 ')
  }
}

Export-ModuleMember -function certificados, borrarCertificado, certificado, cifrar, descifrar, comprobarHashMultimedia, generatedMD5, compareHash