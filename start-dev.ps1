# Скрипт для запуска фронтенда и бэкенда одновременно
Write-Host "=== Запуск фронтенда и бэкенда ===" -ForegroundColor Green

# Проверяем, запущен ли уже фронтенд
$frontendRunning = netstat -ano | findstr ":5173" | findstr "LISTENING"
$backendRunning = netstat -ano | findstr ":8000" | findstr "LISTENING"

if ($frontendRunning) {
    Write-Host "Фронтенд уже запущен на порту 5173" -ForegroundColor Yellow
} else {
    Write-Host "Запуск фронтенда..." -ForegroundColor Cyan
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; npm run dev"
    Start-Sleep -Seconds 2
}

if ($backendRunning) {
    Write-Host "Бэкенд уже запущен на порту 8000" -ForegroundColor Yellow
} else {
    Write-Host "Запуск бэкенда..." -ForegroundColor Cyan
    Start-Process powershell -ArgumentList "-NoExit", "-Command", ".\start-backend.ps1"
    Start-Sleep -Seconds 2
}

Write-Host "`n=== Сервисы запущены ===" -ForegroundColor Green
Write-Host "Фронтенд: http://localhost:5173" -ForegroundColor Cyan

# Получаем локальные IP адреса
$ipAddresses = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { 
    $_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*" 
} | Select-Object -ExpandProperty IPAddress

Write-Host "`nДоступно по сети:" -ForegroundColor Yellow
foreach ($ip in $ipAddresses) {
    Write-Host "  Фронтенд: http://${ip}:5173" -ForegroundColor Cyan
    Write-Host "  Бэкенд:   http://${ip}:8000" -ForegroundColor Cyan
}

