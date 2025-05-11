$Path = "C:\Users\Layton\Repo"
$Branch = "main"
$maxRetries = 40
$retries = 0

write-Host "Waiting for internet connection..."

while($retries -lt $maxRetries) {
  $Net_Check = Test-Connection -ComputerName google.com -Count 1 -Quiet

  if ($Net_Check) {
    Set-Location -Path $Path
    write-Host "`nConnection found. Pulling from $Branch...`n"
    
    try{
      git reset --hard HEAD
      git pull origin $Branch
      break
    }
    catch{
    write-Host "Git error: $_"
      break
    }
  }
  else{
    Start-Sleep -Seconds 5
    $retries++
  }
}

if(!$Net_check) {
  write-host "No connection found. Exiting script."
}
