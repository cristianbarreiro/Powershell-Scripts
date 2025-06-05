# Activar firewall en todos los perfiles
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True

# Bloquear puertos comúnmente atacados (SMB, Telnet, FTP, etc.)
New-NetFirewallRule -DisplayName "Bloquear SMB (Puerto 445)" -Direction Inbound -Protocol TCP -LocalPort 445 -Action Block
New-NetFirewallRule -DisplayName "Bloquear Telnet (Puerto 23)" -Direction Inbound -Protocol TCP -LocalPort 23 -Action Block
New-NetFirewallRule -DisplayName "Bloquear FTP (Puerto 21)" -Direction Inbound -Protocol TCP -LocalPort 21 -Action Block

# Permitir Escritorio Remoto solo en la red local
New-NetFirewallRule -DisplayName "RDP solo red local" -Direction Inbound -Protocol TCP -LocalPort 3389 -RemoteAddress 192.168.1.0/24 -Action Allow

# Bloquear acceso remoto RDP desde direcciones externas
New-NetFirewallRule -DisplayName "Bloquear RDP externo" -Direction Inbound -Protocol TCP -LocalPort 3389 -RemoteAddress Any -Action Block
