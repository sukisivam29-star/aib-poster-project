# AlphaQuant AI - Lightweight Standalone Static Server
param([int]$Port = 8080)

$rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $rootDir) {
    $rootDir = Get-Location
}
Set-Location $rootDir

$listener = $null
$portsToTry = @($Port, 8081, 8082, 8085, 3000, 5000)

foreach ($p in $portsToTry) {
    try {
        $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $p)
        $listener.Start()
        $Port = $p
        break
    } catch {
        $listener = $null
    }
}

if (-not $listener) {
    Write-Host "[ERROR] Could not bind to any local port. Please check your firewall or close conflicting applications." -ForegroundColor Red
    pause
    exit 1
}

Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "   AlphaQuant AI Local Server is LIVE at: http://localhost:$Port/" -ForegroundColor Green
Write-Host "   Root Directory: $rootDir" -ForegroundColor DarkGray
Write-Host "   Leave this window open while using the platform." -ForegroundColor White
Write-Host "   Press Ctrl+C in this console to stop the server." -ForegroundColor Yellow
Write-Host "======================================================================" -ForegroundColor Cyan

# Launch default web browser directly to the successfully bound port
try {
    Start-Process "http://localhost:$Port/"
} catch {
    cmd.exe /c start "http://localhost:$Port/"
}

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".csv"  = "text/plain; charset=utf-8"
}

try {
    while ($true) {
        $client = $listener.AcceptTcpClient()
        try {
            $client.ReceiveTimeout = 4000
            $client.SendTimeout = 4000
            $stream = $client.GetStream()
            $reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::ASCII)

            $requestLine = $reader.ReadLine()
            if (-not [string]::IsNullOrWhiteSpace($requestLine)) {
                $parts = $requestLine.Split(' ')
                if ($parts.Length -ge 2 -and ($parts[0] -eq 'GET' -or $parts[0] -eq 'HEAD')) {
                    $rawPath = $parts[1].Split('?')[0].TrimStart('/')
                    if ([string]::IsNullOrWhiteSpace($rawPath)) {
                        $rawPath = "index.html"
                    }
                    $rawPath = [System.Uri]::UnescapeDataString($rawPath).Replace('/', '\')
                    $filePath = Join-Path $rootDir $rawPath

                    if (Test-Path $filePath -PathType Leaf) {
                        $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
                        $mime = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }
                        $bytes = [System.IO.File]::ReadAllBytes($filePath)
                        $header = "HTTP/1.1 200 OK`r`nContent-Type: $mime`r`nContent-Length: $($bytes.Length)`r`nAccess-Control-Allow-Origin: *`r`nConnection: close`r`n`r`n"
                        $hBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
                        $stream.Write($hBytes, 0, $hBytes.Length)
                        if ($parts[0] -eq 'GET') {
                            $stream.Write($bytes, 0, $bytes.Length)
                        }
                    } else {
                        $notFound = "HTTP/1.1 404 Not Found`r`nContent-Length: 9`r`nConnection: close`r`n`r`nNot Found"
                        $nfBytes = [System.Text.Encoding]::ASCII.GetBytes($notFound)
                        $stream.Write($nfBytes, 0, $nfBytes.Length)
                    }
                }
            }
        } catch {
            # Client disconnected early or connection timed out, ignore and continue
        } finally {
            try { $client.Close() } catch {}
        }
    }
} finally {
    if ($listener) { $listener.Stop() }
}
