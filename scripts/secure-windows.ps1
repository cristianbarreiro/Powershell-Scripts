# Activar firewall en todos los perfiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Bloquear puertos comunes inseguros
$puertosBloqueados = @(23, 21, 135, 139, 445)
foreach ($puerto in $puertosBloqueados) {
    New-NetFirewallRule -DisplayName "Bloquear puerto $puerto" -Direction Inbound -Protocol TCP -LocalPort $puerto -Action Block
}

# Permitir RDP solo desde red local
New-NetFirewallRule -DisplayName "Permitir RDP desde red local" -Direction Inbound -Protocol TCP -LocalPort 3389 -RemoteAddress 192.168.1.0/24 -Action Allow

# Desactivar uso compartido de archivos e impresoras
Set-NetFirewallRule -Group "@FirewallAPI.dll,-28502" -Enabled False

# Cambiar perfil de red a Público
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Public

# Activar UAC
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name EnableLUA -Value 1

# Mostrar extensiones de archivos conocidos
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0

# Configurar DNS seguros (Cloudflare 1.1.1.2)
Set-DnsClientServerAddress -InterfaceAlias "Wi-Fi" -ServerAddresses ("1.1.1.2","1.0.0.2")
