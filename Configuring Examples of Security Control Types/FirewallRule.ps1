New-NetFirewallRule -DisplayName "Block Outbound HTTP" -Direction Outbound -Protocol TCP -RemotePort 80 -Action Block
