# Activar el firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Bloquear puertos peligrosos
New-NetFirewallRule -DisplayName "Bloquear SMB (445)" -Direction Inbound -Protocol TCP -LocalPort 445 -Action Block
New-NetFirewallRule -DisplayName "Bloquear Telnet (23)" -Direction Inbound -Protocol TCP -LocalPort 23 -Action Block
New-NetFirewallRule -DisplayName "Bloquear FTP (21)" -Direction Inbound -Protocol TCP -LocalPort 21 -Action Block

# Permitir RDP solo en red local
New-NetFirewallRule -DisplayName "Permitir RDP solo LAN" -Direction Inbound -Protocol TCP -LocalPort 3389 -RemoteAddress 192.168.1.0/24 -Action Allow
