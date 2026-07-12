[CmdletBinding()]
param(
    [switch]$Detached,
    [switch]$Clean
)

$ErrorActionPreference = "Stop"
$projectDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectDirectory

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker no está instalado o no se encuentra en el PATH."
}

try {
    docker info *> $null
} catch {
    throw "Docker Desktop no está iniciado. Ábrelo y vuelve a ejecutar este script."
}

if ($LASTEXITCODE -ne 0) {
    throw "Docker Desktop no está iniciado. Ábrelo y vuelve a ejecutar este script."
}

if ($Clean) {
    Write-Host "Limpiando contenedores y dependencias locales de Jekyll..." -ForegroundColor Yellow
    docker compose down --volumes --remove-orphans
    if ($LASTEXITCODE -ne 0) { throw "No se pudo limpiar el entorno local." }
}

Write-Host "Iniciando Apuntes de Java..." -ForegroundColor Cyan
Write-Host "La primera ejecución puede tardar mientras se descargan las dependencias." -ForegroundColor DarkGray
Write-Host "Cuando aparezca 'Server running', abre http://localhost:4000" -ForegroundColor Green

$arguments = @("compose", "up", "--remove-orphans")
if ($Detached) { $arguments += "--detach" }

& docker @arguments
if ($LASTEXITCODE -ne 0) { throw "Jekyll terminó con un error." }

if ($Detached) {
    Write-Host "Sitio iniciado en http://localhost:4000" -ForegroundColor Green
    Write-Host "Para detenerlo: docker compose down" -ForegroundColor DarkGray
}
