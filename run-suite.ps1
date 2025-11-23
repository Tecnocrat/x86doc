param()
Write-Host "=== x86doc - Run Suite Script ==="

# Check prerequisites
function Check-Command {
    param([string]$Cmd, [string]$Name)
    try { 
        & $Cmd '--version' >$null 2>&1; return $true
    } catch { return $false }
}

if (-not (Check-Command 'mvn' 'Maven')) {
    Write-Warning "Maven (mvn) is not in PATH. The Java build will be skipped. Install Maven and add it to PATH if you'd like to run the Java toolset."
} else { Write-Host "Maven detected." }

if (-not (Check-Command 'java' 'Java')) {
    Write-Warning "Java (java) is not in PATH. The Java toolset will not run. Install a JDK (21+) and add java.exe to PATH."
} else { Write-Host "Java detected." }

if (-not (Check-Command 'python' 'Python')) {
    Write-Warning "Python is not in PATH. The Python extractors will not run."
} else { Write-Host "Python detected." }

Push-Location $PSScriptRoot

### Java build + run (SignatureGenerator)
if ((Check-Command 'mvn' 'Maven') -and (Check-Command 'java' 'Java')) {
    Write-Host "Building Java SignatureGenerator..."
    mvn -f .\Java\SignatureGenerator clean package

    Write-Host "Running Java converter.Main to generate signatures..."
    mvn -f .\Java\SignatureGenerator -Dexec.mainClass=converter.Main exec:java
} else {
    Write-Warning "Skipping Java build and run (missing mvn/java)."
}

### Python setup and extractors
if (Check-Command 'python' 'Python') {
    # Create and activate venv
    $venvPath = "$PSScriptRoot\.venv"
    if (-not (Test-Path $venvPath)) {
        Write-Host "Creating virtual environment at $venvPath"
        python -m venv $venvPath
    }
    Write-Host "Activating virtual environment"
    & "$venvPath\Scripts\Activate.ps1"

    Write-Host "Installing Python dependencies (pdfminer.six)..."
    pip install --upgrade pip
    pip install pdfminer.six

    # Attempt to run `extract.py` if a PDF argument is provided
    $pdfs = Get-ChildItem -Path $PSScriptRoot -Filter '*.pdf' -Recurse | Select-Object -ExpandProperty FullName
    if ($pdfs.Count -gt 0) {
        Write-Host "Found PDF(s): Running extractors on the first PDF found..."
        python .\Python\extract.py $pdfs[0]
    } else {
        Write-Warning "No PDF files found in the workspace. The extract script requires Intel x86 manual PDF(s). If you have them locally, place them in the workspace and re-run the script."
    }
} else {
    Write-Warning "Python not found, or virtual environment not created - skipping python steps."
}

Pop-Location
Write-Host "=== x86doc run-suite completed (see messages) ==="
