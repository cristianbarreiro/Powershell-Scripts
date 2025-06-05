<#
.SYNOPSIS
    Configura servidores DNS seguros en el adaptador de red activo.

.PARAMETER Provider
    Elige el proveedor de DNS: OpenDNS, Cloudflare, AdGuard, Quad9.

.EXAMPLE
    .\set-dns-provider.ps1 -Provider OpenDNS
#>

param (
    [ValidateSet("OpenDNS", "Cloudflare", "AdGuard", "Quad9")]
    [string]$Provider = "OpenDNS"
)

switch ($Provider) {
    "OpenDNS"    { $dns = @("208.67.222.222", "208.67.220.220") }
    "Cloudflare" { $dns = @("1.1.1.2", "1.0.0.2") }
    "AdGuard"    { $dns = @("94.140.14.14", "94.140.15.15") }
    "Quad9"      { $dns = @("9.9.9.9", "149.112.112.112") }
}

# Detectar adaptador activo válido
$adapter = Get-NetAdapter |
    Where-Object {
        $_.Status -eq 'Up' -and
        $_.InterfaceDescription -notmatch 'VPN|VirtualBox|TAP|Bluetooth'
    } |
    Select-Object -First 1

if ($null -eq $adapter) {
    Write-Error "❌ No se encontró un adaptador de red activo válido."
    exit
}

# Aplicar los DNS
Set-DnsClientServerAddress -InterfaceAlias $adapter.Name `
                           -ServerAddresses $dns

Write-Host "✅ DNS de $Provider configurados en '$($adapter.Name)':"
$dns | ForEach-Object { Write-Host "- $_" }
