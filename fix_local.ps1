# n8n Local Setup Fixer
Write-Host "--- Fixing n8n Local Connection ---" -ForegroundColor Cyan

# 1. Stop services
Write-Host "Stopping containers..."
docker compose -f docker-compose.local.yml down

# 2. Clean Volumes (to fix encryption key mismatch)
Write-Host "Cleaning conflicting volumes..."
docker volume rm n8n-compose_n8n_data n8n-compose_postgres_data -ErrorAction SilentlyContinue

# 3. Start services
Write-Host "Starting fresh local setup..."
docker compose -f docker-compose.local.yml up -d

Write-Host "`nSuccess! Please wait 10 seconds, then open:" -ForegroundColor Green
Write-Host "http://localhost:5679" -ForegroundColor Yellow
