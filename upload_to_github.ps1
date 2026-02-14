Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  GitHub Upload Script (PowerShell)" -ForegroundColor Cyan
Write-Host "  Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check if README.md exists
if (-not (Test-Path "README.md")) {
    Write-Host "ERROR: README.md not found!" -ForegroundColor Red
    Write-Host "Please put this script in the folder containing README.md" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Step 1: Initialize Git
Write-Host "Step 1: Initialize Git repository" -ForegroundColor Green
Write-Host "-----------------------------------------------" -ForegroundColor Gray
git init
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: git init failed" -ForegroundColor Red
    exit 1
}
Write-Host "Done!" -ForegroundColor Green
Write-Host ""

# Step 2: Configure user
Write-Host "Step 2: Configure Git user" -ForegroundColor Green
Write-Host "-----------------------------------------------" -ForegroundColor Gray
$username = Read-Host "Enter your GitHub username"
$email = Read-Host "Enter your GitHub email"

git config user.name $username
git config user.email $email
Write-Host "Done!" -ForegroundColor Green
Write-Host ""

# Step 3: Add remote
Write-Host "Step 3: Add remote repository" -ForegroundColor Green
Write-Host "-----------------------------------------------" -ForegroundColor Gray
$remoteUrl = "https://github.com/$username/Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide.git"
Write-Host "Remote URL: $remoteUrl" -ForegroundColor Yellow
git remote add origin $remoteUrl
Write-Host "Done!" -ForegroundColor Green
Write-Host ""

# Step 4: Add files
Write-Host "Step 4: Add files to staging" -ForegroundColor Green
Write-Host "-----------------------------------------------" -ForegroundColor Gray
git add .
Write-Host "Done!" -ForegroundColor Green
Write-Host ""

# Step 5: Commit
Write-Host "Step 5: Commit changes" -ForegroundColor Green
Write-Host "-----------------------------------------------" -ForegroundColor Gray
$commitMsg = Read-Host "Enter commit message (press Enter for default)"
if ([string]::IsNullOrEmpty($commitMsg)) {
    $commitMsg = "Initial commit - Termux OpenClaw AI Server Guide"
}
git commit -m $commitMsg
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: git commit failed" -ForegroundColor Red
    exit 1
}
Write-Host "Done!" -ForegroundColor Green
Write-Host ""

# Important notice
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "IMPORTANT: Create repository on GitHub first!" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Open browser: https://github.com/new" -ForegroundColor Cyan
Write-Host "2. Repository name: Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide" -ForegroundColor Cyan
Write-Host "3. Select 'Public'" -ForegroundColor Cyan
Write-Host "4. DO NOT add README" -ForegroundColor Cyan
Write-Host "5. Click 'Create repository'" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter after creating repository..."

# Step 6: Push
Write-Host ""
Write-Host "Step 6: Push to GitHub" -ForegroundColor Green
Write-Host "-----------------------------------------------" -ForegroundColor Gray
Write-Host "Pushing..." -ForegroundColor Yellow
Write-Host ""

git branch -M main
git push -u origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Push failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possible causes:" -ForegroundColor Yellow
    Write-Host "  1. Repository does not exist (create it first)" -ForegroundColor Gray
    Write-Host "  2. Permission denied (login to GitHub)" -ForegroundColor Gray
    Write-Host "  3. Network issue" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Solution: Create repository at https://github.com/new" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "SUCCESS! Upload completed!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Your project URL:" -ForegroundColor Cyan
Write-Host "  https://github.com/$username/Termux-Ubuntu-OpenClaw-LLM-Feishu-Guide" -ForegroundColor Yellow
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Green
Write-Host "  1. Visit the URL above to see your project" -ForegroundColor Gray
Write-Host "  2. README.md will be displayed as project description" -ForegroundColor Gray
Write-Host ""
Read-Host "Press Enter to exit"
