# Скрипт для запуска туннелей
param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("cloudflare", "ngrok", "serveo", "localtunnel")]
    [string]$Type = "cloudflare",
    
    [Parameter(Mandatory=$false)]
    [int]$Port = 5173
)

Write-Host "Запуск туннеля типа: $Type на порту $Port" -ForegroundColor Green

switch ($Type) {
    "cloudflare" {
        Write-Host "Используется Cloudflare Tunnel..." -ForegroundColor Cyan
        $cloudflared = Get-Command cloudflared -ErrorAction SilentlyContinue
        if (-not $cloudflared) {
            Write-Host "cloudflared не найден. Установите через: winget install --id Cloudflare.cloudflared" -ForegroundColor Yellow
            exit 1
        }
        cloudflared tunnel --url http://localhost:$Port
    }
    
    "ngrok" {
        Write-Host "Используется ngrok..." -ForegroundColor Cyan
        $ngrok = Get-Command ngrok -ErrorAction SilentlyContinue
        if (-not $ngrok) {
            Write-Host "ngrok не найден. Установите через: winget install ngrok.ngrok" -ForegroundColor Yellow
            exit 1
        }
        ngrok http $Port
    }
    
    "serveo" {
        Write-Host "Используется serveo (SSH туннель)..." -ForegroundColor Cyan
        ssh -R 80:localhost:$Port serveo.net
    }
    
    "localtunnel" {
        Write-Host "Используется localtunnel..." -ForegroundColor Cyan
        $lt = Get-Command lt -ErrorAction SilentlyContinue
        if (-not $lt) {
            Write-Host "localtunnel не найден. Установите через: npm install -g localtunnel" -ForegroundColor Yellow
            exit 1
        }
        lt --port $Port
    }
}

