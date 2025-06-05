# Limpieza básica de disco
Write-Host "🧹 Iniciando limpieza de archivos temporales..."
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Cleanmgr /sagerun:1
Write-Host "✅ Limpieza completada"
