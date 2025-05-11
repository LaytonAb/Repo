$watchPath = "C:\Users\Layton\Repo"
$branch = "main"

# Create a file system watcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $watchPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# Define the action to take on changes
$action = {
    param($sender, $eventArgs)

    # Skip .git folder and temp/swap files
    if ($fullPath -match '\\\.git\\' -or $fullPath -like '*\.git*') { 
        return
    }
    Write-Host "Change detected in file: $($eventArgs.FullPath). Committing to GitHub..."
    Write-Host "Change detected. Committing to GitHub..."

    Set-Location -Path "C:\Users\Layton\Repo"

    $status = git status --porcelain
    if ($status) {
        try {
            git add .
            $timestamp = get-date -format "yyyy-mm-dd hh:mm:ss"
            git commit -m "auto-commit on $timestamp"
            git push origin main
            write-host "changes pushed."
        } catch {
            Write-Host "Error during Git operations: $_"
        }
    }
}
# Register event handlers
Register-ObjectEvent -InputObject $watcher -EventName Changed -Action $action
Register-ObjectEvent -InputObject $watcher -EventName Created -Action $action
Register-ObjectEvent -InputObject $watcher -EventName Deleted -Action $action
Register-ObjectEvent -InputObject $watcher -EventName Renamed -Action $action

Write-Host "Watching $watchPath for changes. Press Ctrl+C to exit..."

# Keep script alive with an event loop
while ($true) {
    Start-Sleep -Seconds 1
}
