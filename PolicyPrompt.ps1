$policyText = @"
WARNING: Use of this system is subject to monitoring. Unauthorized access is prohibited.
"@
[System.Windows.MessageBox]::Show($policyText, "Security Policy")
