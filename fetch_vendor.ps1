$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

function Get-File {
  param(
    [Parameter(Mandatory = $true)][string]$Url,
    [Parameter(Mandatory = $true)][string]$OutFile
  )
  $dir = Split-Path -Parent $OutFile
  if (!(Test-Path $dir)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }
  Invoke-WebRequest -Uri $Url -OutFile $OutFile
}

$base = Join-Path $PSScriptRoot "vendor\external"

Get-File "https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css" (Join-Path $base "animate\animate.min.css")
Get-File "https://code.jquery.com/jquery-1.12.4.min.js" (Join-Path $base "jquery\jquery-1.12.4.min.js")
Get-File "https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" (Join-Path $base "jquery-ui\jquery-ui.min.js")
Get-File "https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.min.css" (Join-Path $base "jquery-ui\jquery-ui.min.css")
Get-File "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" (Join-Path $base "bootstrap\bootstrap.min.css")
Get-File "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" (Join-Path $base "bootstrap\bootstrap.min.js")
Get-File "https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.5.12/clipboard.min.js" (Join-Path $base "clipboard\clipboard.min.js")
Get-File "https://rawcdn.githack.com/showdownjs/showdown/984942e239c9bda522b9c5544aba72647983b3f1/dist/showdown.min.js" (Join-Path $base "showdown\showdown.min.js")
Get-File "https://unpkg.com/vue@2.0.1/dist/vue.min.js" (Join-Path $base "vue\vue.min.js")
Get-File "https://unpkg.com/@babel/standalone@7.21.4/babel.min.js" (Join-Path $base "babel\babel.min.js")
Get-File "https://rawcdn.githack.com/beautify-web/js-beautify/1b52eb1f90daaefa6ff0fa7736f97fbfc58093c1/js/lib/beautify.js" (Join-Path $base "js-beautify\beautify.js")

$faBase = Join-Path $base "font-awesome"
Get-File "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" (Join-Path $faBase "css\font-awesome.min.css")
Get-File "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/fonts/fontawesome-webfont.eot?v=4.7.0" (Join-Path $faBase "fonts\fontawesome-webfont.eot")
Get-File "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/fonts/fontawesome-webfont.woff2?v=4.7.0" (Join-Path $faBase "fonts\fontawesome-webfont.woff2")
Get-File "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/fonts/fontawesome-webfont.woff?v=4.7.0" (Join-Path $faBase "fonts\fontawesome-webfont.woff")
Get-File "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/fonts/fontawesome-webfont.ttf?v=4.7.0" (Join-Path $faBase "fonts\fontawesome-webfont.ttf")
Get-File "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/fonts/fontawesome-webfont.svg?v=4.7.0" (Join-Path $faBase "fonts\fontawesome-webfont.svg")

Write-Host "Downloaded external dependencies to $base"
