
$envFile = ".env"

if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match "^\s*#") { return } # Skip comments
        if ($_ -match "^\s*$") { return } # Skip empty lines
        if ($_ -match "^\s*([^=]+)\s*=\s*(.*)\s*$") {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim()
            [System.Environment]::SetEnvironmentVariable($name, $value, "Process")
            Set-Item -Path "env:$name" -Value $value
        }
    }
    Write-Host ".env variables loaded into session."
} else {
    Write-Warning ".env file not found."
}

pip install -r requirements.txt