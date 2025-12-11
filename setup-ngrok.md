# Настройка ngrok

## Шаг 1: Регистрация
1. Зайдите на https://ngrok.com/
2. Зарегистрируйтесь (бесплатно)
3. Получите токен авторизации в Dashboard

## Шаг 2: Установка
```powershell
# Через npm (уже установлен Node.js)
npm install -g ngrok

# Или через winget
winget install ngrok.ngrok
```

## Шаг 3: Авторизация
```powershell
ngrok config add-authtoken YOUR_AUTH_TOKEN
```

## Шаг 4: Запуск туннеля
```powershell
ngrok http 5173
```

После запуска вы получите два URL:
- HTTP: http://xxxx-xx-xx-xx-xx.ngrok-free.app
- HTTPS: https://xxxx-xx-xx-xx-xx.ngrok-free.app

## Преимущества ngrok:
- ✅ Более стабильное подключение
- ✅ Веб-интерфейс для мониторинга запросов
- ✅ Поддержка кастомных доменов (в платной версии)
- ✅ Лучше работает с файрволами

