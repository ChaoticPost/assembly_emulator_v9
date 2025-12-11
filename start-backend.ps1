# Скрипт для запуска бэкенда
Write-Host "Запуск бэкенда на http://0.0.0.0:8000" -ForegroundColor Green
Write-Host "Доступен по адресам:" -ForegroundColor Cyan

# Получаем локальные IP адреса
$ipAddresses = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { 
    $_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*" 
} | Select-Object -ExpandProperty IPAddress

foreach ($ip in $ipAddresses) {
    Write-Host "  http://${ip}:8000" -ForegroundColor Yellow
}
Write-Host "  http://localhost:8000" -ForegroundColor Yellow

Write-Host "`nПереход в директорию backend..." -ForegroundColor Cyan
Set-Location backend

Write-Host "Запуск FastAPI сервера..." -ForegroundColor Green
python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

