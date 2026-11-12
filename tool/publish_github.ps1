<#
.SYNOPSIS
    Membuat repositori GitHub dan mengunggah project ini.

.DESCRIPTION
    Skrip ini meminta Personal Access Token (classic) dengan scope `repo` dan
    `workflow`, membuat repositori publik, lalu push branch main.

    Jalankan dari root project:

        powershell -ExecutionPolicy Bypass -File tool\publish_github.ps1

    Token hanya dipakai selama proses berjalan, tidak disimpan ke disk maupun
    ke konfigurasi git.
#>

param(
    [string]$Username = "lismaayanti19-debug",
    [string]$RepoName = "bca-mobile-redesign"
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Read-Token {
    $secure = Read-Host -AsSecureString "Tempel Personal Access Token GitHub (input disembunyikan)"
    $ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
    try {
        return [Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
    }
    finally {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)
    }
}

$token = Read-Token
if ([string]::IsNullOrWhiteSpace($token)) {
    throw "Token kosong. Dibatalkan."
}

$headers = @{
    Authorization          = "Bearer $token"
    "User-Agent"           = "bca-redesign-publisher"
    Accept                 = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}

$repoUrl = "https://github.com/$Username/$RepoName"

Write-Host "Memeriksa repositori $RepoName ..."
$exists = $false
try {
    Invoke-RestMethod -Uri "https://api.github.com/repos/$Username/$RepoName" -Headers $headers | Out-Null
    $exists = $true
    Write-Host "Repositori sudah ada: $repoUrl"
}
catch {
    $status = $_.Exception.Response.StatusCode.value__
    if ($status -ne 404) { throw }
}

if (-not $exists) {
    $body = @{
        name        = $RepoName
        description = "Redesign halaman utama BCA mobile dengan Flutter - konsep UI/UX modern minimal (data dummy, bukan aplikasi resmi)."
        private     = $false
        has_issues  = $true
        has_wiki    = $false
    } | ConvertTo-Json

    Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post `
        -Headers $headers -Body $body -ContentType "application/json" | Out-Null
    Write-Host "Repositori dibuat: $repoUrl"
}

if (-not (Test-Path ".git")) {
    git init -b main | Out-Null
}

git add -A
$pending = git status --porcelain
if ($pending) {
    git commit -m "feat: BCA Mobile home screen redesign in Flutter" | Out-Null
}

Write-Host "Mengunggah branch main ..."
git push "https://$($Username):$($token)@github.com/$Username/$RepoName.git" main:main

# Simpan remote tanpa token di dalamnya.
git remote remove origin 2>$null
git remote add origin $repoUrl
git branch --set-upstream-to=origin/main main 2>$null

Write-Host ""
Write-Host "Selesai. Repositori: $repoUrl"
Write-Host "Aktifkan demo di Settings -> Pages -> Source: GitHub Actions."
