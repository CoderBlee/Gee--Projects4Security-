Get-EventLog -LogName Security | Where-Object { $_.EventID -eq 4625 } | Select-Object TimeGenerated, Message
