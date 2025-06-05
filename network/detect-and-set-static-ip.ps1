# Detectar el adaptador de red real y activo (excluye VPNs, VirtualBox, Bluetooth)
$adapter = Get-NetAdapter |
    Where-Object {
        $_.Status -eq 'Up' -and
        $_.InterfaceDescription -notmatch 'VirtualBox|VPN|Bluetooth|TAP|Wintun'
    } |
    Sort-Object -Property LinkSpeed -Descending |
    Select-Object -First 1

if ($null -eq $adapter) {
    Write-Error "❌ No se encontró un adaptador de red activo válido."
    exit
}

Write-Host "✅ Adaptador detectado: $($adapter.Name)"

# Configuración IP deseada
$ipAddress   = "192.168.1.150"
$subnetBits  = 24
$gateway     = "192.168.1.1"
$dnsServers  = @("1.1.1.1", "8.8.8.8")

# Aplicar configuración de red
New-NetIPAddress -InterfaceAlias $adapter.Name `
                 -IPAddress $ipAddress `
                 -PrefixLength $subnetBits `
                 -DefaultGateway $gateway -ErrorAction SilentlyContinue

Set-DnsClientServerAddress -InterfaceAlias $adapter.Name `
                           -ServerAddresses $dnsServers

Write-Host "🎉 IP estática y DNS aplicados correctamente en '$($adapter.Name)'."
