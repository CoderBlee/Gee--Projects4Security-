# README: Configuring Examples of Security Control Types on Windows VM

This README file (this the reverse of what we just did if you still have energy to do more)serves as a guide for configuring examples of security control types—preventive, detective, directive, and corrective—on a Windows Virtual Machine (VM). It includes step-by-step instructions for setting up, implementing, and testing the configurations, making it a valuable resource for hands-on practice and learning aligned with the CompTIA Security+ certification.

---

## **Project Overview**

The purpose of this project is to implement and understand the various types of security controls:

- **Preventive Controls**: To stop incidents before they occur.
- **Detective Controls**: To identify and log security events.
- **Directive Controls**: To guide users and enforce policies.
- **Corrective Controls**: To mitigate and respond to security incidents.

---

## **Lab Setup**

### **Requirements**

1. **Windows Virtual Machine**:
   - Minimum: 4 GB RAM, 40 GB storage
   - Software: VirtualBox, VMware, or Hyper-V
2. **PowerShell**:
   - Ensure PowerShell is enabled.
3. **Optional Tools**:
   - Sysinternals Suite

### **Setup Steps**

1. Install the Windows VM and update the system.
2. Enable PowerShell scripts by setting the execution policy:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Force
   ```
3. (Optional) Take a snapshot of the VM to allow for easy resets.

---

## **Steps to Configure Security Controls**

### **Step 1: Preventive Controls**

#### **1.1 Configure Firewall Rule**

- Block outbound HTTP traffic on port 80:
  ```powershell
  New-NetFirewallRule -DisplayName "Block Outbound HTTP" -Direction Outbound -Action Block -Protocol TCP -LocalPort 80
  ```

#### **1.2 Enforce Password Policies**

1. Open **Local Group Policy Editor** (`gpedit.msc`).
2. Navigate to **Computer Configuration > Windows Settings > Security Settings > Account Policies > Password Policy**.
3. Configure:
   - Minimum password length: 10
   - Password complexity: Enabled
4. Apply changes:
   ```powershell
   gpupdate /force
   ```

#### **1.3 Disable Unused Services**

- Stop and disable unnecessary services (e.g., Xbox Live Game Save):
  ```powershell
  Stop-Service -Name "XblGameSave"
  Set-Service -Name "XblGameSave" -StartupType Disabled
  ```

---

### **Step 2: Detective Controls**

#### **2.1 Enable Audit Logging**

1. Open **Group Policy Editor** and navigate to:
   **Computer Configuration > Windows Settings > Security Settings > Advanced Audit Policy Configuration > System Audit Policies**.
2. Enable policies such as:
   - **Logon/Logoff > Audit Logon**: Success and Failure
   - **Object Access > Audit File System**: Success and Failure
3. Apply changes:
   ```powershell
   gpupdate /force
   ```

#### **2.2 Set Up File System Auditing**

1. Right-click a folder (e.g., `C:\SensitiveData`) > **Properties > Security > Advanced > Auditing**.
2. Add a user or group, select permissions to audit (e.g., Read, Write), and enable Success and/or Failure.

#### **2.3 Monitor Logs**

- Use PowerShell for real-time log monitoring:
  ```powershell
  Get-EventLog -LogName Security | Where-Object { $_.EventID -eq 4625 } | Select-Object TimeGenerated, Message
  ```

---

### **Step 3: Directive Controls**

#### **3.1 Deploy Security Warning**

1. Open **Group Policy Editor** and navigate to:
   **Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options**.
2. Configure:
   - **Interactive logon: Message text for users attempting to log on**: Add warning text.

#### **3.2 Automate Acceptable Use Policy Reminder**

1. Create a PowerShell script (`PolicyPrompt.ps1`) that displays a message box.
2. Configure the script to run at logon through Group Policy:
   **User Configuration > Windows Settings > Scripts (Logon/Logoff)**.

---

### **Step 4: Corrective Controls**

#### **4.1 Create Backup and Recovery Script**

1. Write a script to back up files to a secure location:
   ```powershell
   Copy-Item -Path "C:\SensitiveData" -Destination "D:\Backup" -Recurse
   ```
2. Schedule the script with Task Scheduler.

#### **4.2 Quarantine Malicious Processes**

- Stop a suspicious process using PowerShell:
  ```powershell
  Stop-Process -Name "maliciousprocess"
  ```

#### **4.3 Restore System Settings**

1. Enable System Restore:
   - Open **Control Panel > Recovery > Configure System Restore**.
2. Create a restore point manually or schedule them regularly.

---

## **Testing and Validation**

1. Simulate events to test each control:
   - Attempt to access a blocked website to verify the firewall.
   - Log failed login attempts to check audit logs.
   - Access a monitored folder to validate file auditing.
2. Review logs and configurations to ensure functionality.
3. Document the outcomes and note any issues.

---

## **Reversing the Configuration**

- A detailed reverse guide is included to reset the system and practice again. Use tools like snapshots and System Restore for quick recovery.

---

## **Conclusion**

This lab provides practical experience in configuring and understanding security controls. By repeating the steps and simulating real-world scenarios, you’ll gain valuable skills for CompTIA Security+ and beyond. 



