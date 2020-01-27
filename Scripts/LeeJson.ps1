########### LEE JSON #############

<#PSScriptInfo

.VERSION 1.0
.AUTHOR Julio Martin

.TAGS
  json
.DESCRIPTION 
    lee un json y crea un fichero salida en el directorio desde el que se lanza
.EXAMPLE 
    leejson ".\eve.json" 
#> 

PARAM($nombreFichero)

# leemo del json y lo convertimos a objeto.
$SourceJson = Get-Content $nombreFichero | ConvertFrom-Json

# Seleccionamos los filtros que deseamos buscar en nuestro caso event_type app.proto y alert.signature
# obtenemos el src_ip que coincide con lo anterior y lo obtenemos obviando duplicacion de ips
# el resultado lo guardamos en out3.txt, donde quedará el listado de las ips.
$SourceJson | Where-Object -FilterScript { ($_.event_type -eq 'alert') `
                                      -and ($_.app_proto -eq 'http')   `
                                      -and ($_.alert.signature -Like '*EXE*')} | 
             Select-Object -ExpandProperty src_ip -unique|                                                             
             out-file -FilePath out3.txt -Encoding utf8 




#Para cada elemento de out3.txt ($ip) crea una regla en el FW de windows con el parámetro de $IP.            
#foreach ($ip in (get-content out3.txt)) {
#   netsh advfirewall firewall add rule name="Bloquea_IP" protocol=any dir=in action=block remoteip=$ip }
 
<#
Poniendolo todo en una línea.
(get-content .\eve.json | ConvertFrom-Json) | Where-object -FilterScript { ($_.event_type -eq 'alert') -and ($_.app_proto -eq 'http') -and ($_.alert.signature -Like '*EXE*')}|Select-Object -ExpandProperty src_ip -unique| out-file -FilePath out3.txt -Encoding utf8 ; foreach ($ip in (get-content out3.txt)) {netsh advfirewall firewall add rule name="Bloquea_IP" protocol=any dir=in action=block remoteip=$ip}
#>
