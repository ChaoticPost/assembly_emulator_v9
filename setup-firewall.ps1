# Setup Windows Firewall for network access
Write-Host "=== Windows Firewall Setup ===" -ForegroundColor Green

# Check if rules already exist
$viteRule = Get-NetFirewallRule -DisplayName "Vite Dev Server" -ErrorAction SilentlyContinue
$backendRule = Get-NetFirewallRule -DisplayName "FastAPI Backend" -ErrorAction SilentlyContinue

# Create rule for frontend (Vite)
if (-not $viteRule) {
    Write-Host "Creating firewall rule for Vite (port 5173)..." -ForegroundColor Cyan
    try {
        New-NetFirewallRule -DisplayName "Vite Dev Server" `
            -Direction Inbound `
            -LocalPort 5173 `
            -Protocol TCP `
            -Action Allow `
            -Profile Domain,Private,Public `
            -Description "Allow incoming connections to Vite dev server on port 5173"
        Write-Host "[OK] Vite rule created successfully" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to create Vite rule: $_" -ForegroundColor Red
    }
} else {
    Write-Host "[OK] Vite rule already exists" -ForegroundColor Yellow
    # Enable rule if it's disabled
    if (-not ($viteRule.Enabled)) {
        Enable-NetFirewallRule -DisplayName "Vite Dev Server"
        Write-Host "[OK] Vite rule enabled" -ForegroundColor Green
    }
}

# Create rule for backend (FastAPI)
if (-not $backendRule) {
    Write-Host "Creating firewall rule for FastAPI (port 8000)..." -ForegroundColor Cyan
    try {
        New-NetFirewallRule -DisplayName "FastAPI Backend" `
            -Direction Inbound `
            -LocalPort 8000 `
            -Protocol TCP `
            -Action Allow `
            -Profile Domain,Private,Public `
            -Description "Allow incoming connections to FastAPI backend on port 8000"
        Write-Host "[OK] FastAPI rule created successfully" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to create FastAPI rule: $_" -ForegroundColor Red
    }
} else {
    Write-Host "[OK] FastAPI rule already exists" -ForegroundColor Yellow
    # Enable rule if it's disabled
    if (-not ($backendRule.Enabled)) {
        Enable-NetFirewallRule -DisplayName "FastAPI Backend"
        Write-Host "[OK] FastAPI rule enabled" -ForegroundColor Green
    }
}

Write-Host "`n=== Firewall Rules Check ===" -ForegroundColor Green
Get-NetFirewallRule -DisplayName "Vite Dev Server","FastAPI Backend" | Format-Table DisplayName, Enabled, Direction, Action -AutoSize

Write-Host "`n=== Done! ===" -ForegroundColor Green
Write-Host "Ports 5173 and 8000 should now be accessible from local network." -ForegroundColor Cyan

