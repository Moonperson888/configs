$host.UI.RawUI.WindowTitle = "terminal"
Clear-Host

function prompt {
    $path = $PWD.Path.Replace('\', '/')
    $homePath = $HOME.Replace('\', '/')

    if ($path.StartsWith($homePath, [System.StringComparison]::OrdinalIgnoreCase)) {
        $path = '~' + $path.Substring($homePath.Length)
    }

    $esc = [char]27
    "$esc[38;2;255;255;255m$esc[38;2;150;167;163m 🗁  $path ❮$esc[0m "
}

function clock {
    $time = Get-Date -Format "hh:mm:ss tt"
    $date = Get-Date -Format "dddd, MMMM dd, yyyy"
    
    Write-Host " > Time: $time" -ForegroundColor Gray
    Write-Host " > Date: $date" -ForegroundColor Gray
}

function copy {
    if ($args.Count -eq 0) {
        Write-Host "Usage: copy <text to copy>" -ForegroundColor DarkRed
    } else {
        $textToCopy = [string]::Join(" ", $args)
        Set-Clipboard -Value $textToCopy
        Write-Host ">> Copied to clipboard!" -ForegroundColor Green
    }
}
function shutdown {
    Write-Host " [ WARNING: THIS WILL SHUT DOWN THE SYSTEM ] " -ForegroundColor DarkRed -BackgroundColor Black
    Write-Host -NoNewline " >> Are you sure you want to shut down this system? (y/n): "
    $choice = Read-Host
    if ($choice -eq "y") {
        Write-Host " >> Powering down your system..." -ForegroundColor Green
        Stop-Computer -Force
    } else {
        Write-Host " >> Shutdown cancelled" -ForegroundColor Green
    }
}
function reboot {
    Write-Host " [ WARNING: THIS WILL RESTART THE SYSTEM ] " -ForegroundColor DarkRed -BackgroundColor Black
    Write-Host -NoNewline " >> Are you sure you want to restart the system? (y/n): " -ForegroundColor Gray -BackgroundColor Black
    $choice = Read-Host
    if ($choice -eq "y") {
        Write-Host " >> Rebooting your system..." -ForegroundColor Green
        Restart-Computer -Force
    } else {
        Write-Host " >> Restart cancelled" -ForegroundColor Green
    }
}

function sudo {
    Start-Process powershell -Verb RunAs
}
Remove-Item Alias:\ls -Force

function ls { 
    eza --icons=always --git --group-directories-first $args 
}
function btop {
    btop4win $args
}
function pv { bat $args }

function clsff {
    cls
    fastfetch $args
}
