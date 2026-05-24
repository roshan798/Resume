# PowerShell Build Script for LaTeX Resumes - Builds ALL .tex files
# Usage: .\scripts\build.ps1 [--clean] [--view]
# Example: .\scripts\build.ps1
#          .\scripts\build.ps1 -View
#          .\scripts\build.ps1 -Clean

param(
    [switch]$Clean,
    [switch]$View
)

$SourceDir = "src"
$BuildDir = "build"
$PdfDir = "pdf"

# Ensure directories exist
if (-not (Test-Path $BuildDir)) {
    New-Item -ItemType Directory -Path $BuildDir | Out-Null
}
if (-not (Test-Path $PdfDir)) {
    New-Item -ItemType Directory -Path $PdfDir | Out-Null
}

# Clean option
if ($Clean) {
    Write-Host "Cleaning build artifacts and PDFs..." -ForegroundColor Yellow
    Remove-Item "$BuildDir\*" -Include "*.aux", "*.log", "*.out", "*.fls", "*.fdb_latexmk" -ErrorAction SilentlyContinue
    Remove-Item "$PdfDir\*.pdf" -ErrorAction SilentlyContinue
    Write-Host "Cleaned." -ForegroundColor Green
    exit 0
}

# Find all .tex files
$TexFiles = Get-ChildItem "$SourceDir\*.tex" -File
if ($TexFiles.Count -eq 0) {
    Write-Host "Error: No .tex files found in $SourceDir!" -ForegroundColor Red
    exit 1
}

# Build all .tex files
$BuildSuccess = $true
foreach ($TexFile in $TexFiles) {
    $ResumeName = $TexFile.BaseName
    $PdfFile = "$PdfDir\$ResumeName.pdf"
    
    Write-Host "Building $($TexFile.Name)..." -ForegroundColor Cyan
    
    # Use latexmk for intelligent builds
    # Run from src directory so LaTeX can find resume.cls
    # -outdir for PDFs, -auxdir for artifacts
    Push-Location $SourceDir
    latexmk -pdf `
        -pdflatex="pdflatex -interaction=nonstopmode -synctex=1" `
        -outdir="..\$PdfDir" `
        -auxdir="..\$BuildDir" `
        $TexFile.Name
    Pop-Location
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ $ResumeName.pdf built successfully" -ForegroundColor Green
        
        # View option
        if ($View) {
            Write-Host "Opening $PdfFile..." -ForegroundColor Yellow
            Start-Process $PdfFile
        }
    } else {
        Write-Host "❌ $ResumeName build failed. Check logs in $BuildDir\" -ForegroundColor Red
        $BuildSuccess = $false
    }
}

if ($BuildSuccess) {
    Write-Host "`n✅ All builds completed successfully!" -ForegroundColor Green
    Write-Host "PDFs in: $PdfDir\" -ForegroundColor Green
} else {
    Write-Host "`n❌ Some builds failed." -ForegroundColor Red
    exit 1
}
