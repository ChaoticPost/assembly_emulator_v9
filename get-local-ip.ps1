# Получить локальный IP адрес для доступа из локальной сети
$ipAddresses = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*" } | Select-Object -ExpandProperty IPAddress

Write-Host "`n=== Ваш локальный IP адрес ===" -ForegroundColor Green
foreach ($ip in $ipAddresses) {
    Write-Host "http://${ip}:5173" -ForegroundColor Cyan
}

Write-Host "`nДоступно из локальной сети" -ForegroundColor Yellow
Write-Host "Убедитесь, что файрвол разрешает подключения на порт 5173" -ForegroundColor Yellow

