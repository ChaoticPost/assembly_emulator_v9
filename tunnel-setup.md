# Настройка туннелей для проброса порта 5173

## Вариант 1: Cloudflare Tunnel (Рекомендуется) ⭐

Cloudflare Tunnel - бесплатный и надежный вариант без регистрации.

### Установка:
```powershell
# Скачать cloudflared с официального сайта или через winget
winget install --id Cloudflare.cloudflared
```

### Использование:
```powershell
cloudflared tunnel --url http://localhost:5173
```

## Вариант 2: ngrok

### Установка:
```powershell
# Через winget
winget install ngrok.ngrok

# Или через npm
npm install -g ngrok
```

### Использование:
```powershell
# После регистрации на ngrok.com получите токен
ngrok config add-authtoken YOUR_TOKEN

# Запуск туннеля
ngrok http 5173
```

## Вариант 3: serveo (SSH туннель)

Не требует установки, работает через SSH:

```powershell
ssh -R 80:localhost:5173 serveo.net
```

## Вариант 4: Исправление localtunnel

Если хотите использовать localtunnel, попробуйте:

1. **Проверьте файрвол Windows:**
   - Откройте "Брандмауэр Защитника Windows"
   - Разрешите Node.js через файрвол

2. **Используйте другой поддомен:**
```powershell
lt --port 5173 --subdomain your-custom-name
```

3. **Используйте альтернативный сервер:**
```powershell
lt --port 5173 --host https://localtunnel.me
```

## Быстрый старт

Рекомендую использовать Cloudflare Tunnel - он самый простой и надежный:

```powershell
# 1. Установить cloudflared
winget install --id Cloudflare.cloudflared

# 2. Запустить туннель
cloudflared tunnel --url http://localhost:5173

# 3. Использовать предоставленный URL
```

