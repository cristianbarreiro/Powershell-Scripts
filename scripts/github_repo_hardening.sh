#!/bin/bash
echo "Configurando seguridad de Git local..."

# Forzar uso de SSH
git config --global url."git@github.com:".insteadOf "https://github.com/"

# Deshabilitar almacenamiento de credenciales en texto plano
git config --global credential.helper ""

# Activar firma de commits (si tenés GPG configurado)
# git config --global commit.gpgsign true

echo "✅ Seguridad Git local aplicada."
