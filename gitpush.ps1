$Path = "C:\Users\Layton\Repo"
$Branch = "main"
$maxRetries = 10
$retries = 0

write-Host "Waiting for internet connection..."

while($retries -lt $maxRetries) {
  $Net_Check = Test-Connection -ComputerName google.com -Count 1 -Quiet

  if ($Net_Check) {
    Set-Location -Path $Path
    write-Host "`nConnection found. Pushing to $Branch...`n"
    
    try{
      git add .
      $timestamp = get-date -format "yyyy-mm-dd hh:mm:ss"
      git commit -m "auto-commit on $timestamp"
      git push origin main
      write-host "changes pushed."
      break 
    }
    catch{
    write-Host "Git error: $_"
      break
    }
  }
  else{
    Start-Sleep -MilliSeconds 500
    $retries++
  }
}

if(!$Net_check) {
  write-host "No connection found. Exiting script."
}
