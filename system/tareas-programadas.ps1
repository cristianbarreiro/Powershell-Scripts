# Lista tareas programadas del usuario actual
Write-Host "📋 Tareas programadas del usuario actual:"
Get-ScheduledTask | Where-Object {$_.TaskPath -like "\*"} | Format-Table TaskName, TaskPath, State
