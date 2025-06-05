# Función para deshabilitar un servicio
function Disable-ServiceSafe {
    param (
        [string]$ServiceName
    )
    Write-Host "Deshabilitando $ServiceName ..."
    Stop-Service -Name $ServiceName -Force -ErrorAction SilentlyContinue
    Set-Service -Name $ServiceName -StartupType Disabled
}

# Deshabilitar servicios inseguros o innecesarios
$services = @(
    "Telnet",
    "RemoteRegistry",
    "XblGameSave",
    "XboxGipSvc",
    "XboxNetApiSvc",
    "Fax",
    "Spooler"          # Desactiva impresión (opcional)
)

foreach ($svc in $services) {
    Disable-ServiceSafe -ServiceName $svc
}
