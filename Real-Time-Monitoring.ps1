Get-EventLog -LogName Security -InstanceId 4625 | Select-Object TimeGenerated, Message
