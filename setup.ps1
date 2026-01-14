# n8n Expert Setup Script
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   n8n Professional Auto-Configurator    " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$envFile = ".env"
$exampleFile = ".env.example"

if (-not (Test-Path $envFile)) {
    Write-Host "[+] Creating .env from template..." -ForegroundColor Green
    Copy-Item $exampleFile $envFile
} else {
    Write-Host "[!] .env already exists. Updating keys only..." -ForegroundColor Yellow
}

# Function to generate random secure strings
function Get-RandomString($length) {
    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return -join ($chars.ToCharArray() | Get-Random -Count $length)
}

Write-Host "[+] Generating secure industrial-grade keys..." -ForegroundColor Green

$encryptionKey = Get-RandomString 32
$dbPassword = Get-RandomString 24
$adminPassword = Get-RandomString 16

# Update the .env file
$content = Get-Content $envFile
$content = $content -replace "N8N_ENCRYPTION_KEY=.*", "N8N_ENCRYPTION_KEY=$encryptionKey"
$content = $content -replace "POSTGRES_PASSWORD=.*", "POSTGRES_PASSWORD=$dbPassword"
$content = $content -replace "N8N_BASIC_AUTH_PASSWORD=.*", "N8N_BASIC_AUTH_PASSWORD=$adminPassword"

$content | Set-Content $envFile

Write-Host "`n--- CONFIGURATION COMPLETE ---" -ForegroundColor Cyan
Write-Host "Generated Secrets (Saved to .env):"
Write-Host " > Encryption Key: $encryptionKey"
Write-Host " > Database Pass:  $dbPassword"
Write-Host " > Admin Pass:     $adminPassword" -ForegroundColor Yellow

Write-Host "`nNext Steps:"
Write-Host "1. Update DOMAIN_NAME in .env"
Write-Host "2. Run 'docker compose up -d' for Production"
Write-Host "3. Run 'docker compose -f docker-compose.local.yml up -d' for Local"
