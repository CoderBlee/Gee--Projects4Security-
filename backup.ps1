$source = "C:\SensitiveData"
$destination = "D:\Backups"
Copy-Item -Path $source -Destination $destination -Recurse -Force
