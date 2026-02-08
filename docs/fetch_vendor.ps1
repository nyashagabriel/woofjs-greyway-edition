param(
  [string]$OutDir = "vendor"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-File {
  param(
    [Parameter(Mandatory=$true)][string]$Url,
    [Parameter(Mandatory=$true)][string]$Path,
    [int]$MinBytes = 1000
  )

  Write-Host ("Downloading: {0}" -f $Url)
  try {
    Invoke-WebRequest -Uri $Url -OutFile $Path -UseBasicParsing
  } catch {
    throw ("Failed to download {0}`n{1}" -f $Url, $_.Exception.Message)
  }

  if (-not (Test-Path $Path)) {
    throw ("Download failed (no file): {0}" -f $Path)
  }

  $len = (Get-Item $Path).Length
  if ($len -lt $MinBytes) {
    throw ("Downloaded file too small ({0} bytes): {1}" -f $len, $Path)
  }

  # Basic sanity check: catch HTML error pages saved as .js/.css
  $head = Get-Content -Path $Path -TotalCount 2 -ErrorAction SilentlyContinue | Out-String
  if ($head -match "<!DOCTYPE html>|<html") {
    throw ("Downloaded HTML instead of the expected asset: {0}`nSource: {1}" -f $Path, $Url)
  }
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$deps = @(
  @{ url = "https://code.jquery.com/jquery-1.9.1.min.js";                                 file = "jquery-1.9.1.min.js";        min = 20000 },
  @{ url = "https://cdnjs.cloudflare.com/ajax/libs/vue/2.3.0/vue.min.js";                 file = "vue-2.3.0.min.js";          min = 50000 },

  # Fuse 2.5.0 is legitimately small (~7.37KB), so use jsDelivr and a lower min threshold.
  @{ url = "https://cdn.jsdelivr.net/npm/fuse.js@2.5.0/src/fuse.min.js";                  file = "fuse-2.5.0.min.js";         min = 6000  },

  @{ url = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css";       file = "bootstrap-3.3.7.min.css";   min = 50000 },
  @{ url = "https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.5.12/clipboard.min.js"; file = "clipboard-1.5.12.min.js";   min = 5000  },
  @{ url = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js";         file = "bootstrap-3.3.7.min.js";    min = 20000 }
)

foreach ($d in $deps) {
  $path = Join-Path $OutDir $d.file
  Get-File -Url $d.url -Path $path -MinBytes $d.min
}

Write-Host ""
Write-Host "OK. Vendor deps downloaded into: $OutDir"
Write-Host "Next:"
Write-Host "  1) Use index.offline.html OR update index.html to point at .\vendor\*."
Write-Host "  2) Run a local server:"
Write-Host "       py -m http.server 8000"
Write-Host "     then open:"
Write-Host "       http://localhost:8000/index.offline.html"

