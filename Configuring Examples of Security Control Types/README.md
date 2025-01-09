# README: Configuring Security Control Types on Windows VM

This README provides a detailed guide for configuring examples of security control types—preventive, detective, directive, and corrective—on a Windows Virtual Machine (VM). This document will help you complete the lab with step-by-step instructions, allowing you to build practical skills for CompTIA Security+ certification.

---

## **Project Overview**
The goal of this lab is to configure and test the following security control types:

- **Preventive Controls**: To stop incidents before they occur.
- **Detective Controls**: To identify and log security events.
- **Directive Controls**: To guide users and enforce organizational policies.
- **Corrective Controls**: To respond to and mitigate the impact of security incidents.

This hands-on lab is designed to be performed in a Windows VM environment using built-in tools and PowerShell scripting.

---

## **Lab Setup**

### **Requirements**
1. **Windows Virtual Machine**:
   - Minimum configuration: 4 GB RAM, 40 GB storage
   - Recommended: Windows 10 or later
2. **PowerShell**:
   - Ensure PowerShell is enabled.
3. **Optional Tools**:
   - Sysinternals Suite (for advanced monitoring)

### **Initial Setup Steps**
1. Install and configure a Windows Virtual Machine.
2. Set the PowerShell execution policy to allow scripts:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Force
   ```
3. Create a snapshot of your VM to allow for easy resets.

---

## **Step-by-Step Guide**

### **Step 1: Preventive Controls**

#### **1.1 Configure Firewall Rules**
- **Objective**: Block unauthorized outbound HTTP traffic.
- **Steps**:
  1. Open PowerShell as an administrator.
  2. Run the following command to create a firewall rule:
     ```powershell
     New-NetFirewallRule -DisplayName "Block Outbound HTTP" -Direction Outbound -Action Block -Protocol TCP -LocalPort 80
     ```
  3. Test by attempting to access a website using HTTP (non-HTTPS).

#### **1.2 Enforce Password Policies**
- **Objective**: Strengthen authentication by enforcing password complexity.
- **Steps**:
  1. Open **Local Group Policy Editor** (`gpedit.msc`).
  2. Navigate to **Computer Configuration > Windows Settings > Security Settings > Account Policies > Password Policy**.
  3. Set:
     - Minimum password length: 10 characters
     - Password complexity: Enabled
  4. Apply changes:
     ```powershell
     gpupdate /force
     ```

#### **1.3 Disable Unused Services**
- **Objective**: Minimize the attack surface by stopping unnecessary services.
- **Steps**:
  1. Identify unused services using PowerShell:
     ```powershell
     Get-Service | Where-Object { $_.Status -eq "Running" }
     ```
  2. Stop and disable a service (e.g., Xbox Live Game Save):
     ```powershell
     Stop-Service -Name "XblGameSave"
     Set-Service -Name "XblGameSave" -StartupType Disabled
     ```

---

### **Step 2: Detective Controls**

#### **2.1 Enable Audit Logging**
- **Objective**: Track and log security events.
- **Steps**:
  1. Open **Group Policy Editor**.
  2. Navigate to **Computer Configuration > Windows Settings > Security Settings > Advanced Audit Policy Configuration > System Audit Policies**.
  3. Enable policies such as:
     - **Logon/Logoff > Audit Logon**: Success and Failure
     - **Object Access > Audit File System**: Success and Failure
  4. Apply changes:
     ```powershell
     gpupdate /force
     ```

#### **2.2 Configure File System Auditing**
- **Objective**: Monitor access to sensitive files.
- **Steps**:
  1. Right-click the folder (e.g., `C:\SensitiveData`) > **Properties > Security > Advanced > Auditing**.
  2. Add a user or group, select permissions to audit (e.g., Read, Write), and enable Success and/or Failure.
  3. Review logs in Event Viewer under **Security Logs**.

#### **2.3 Real-Time Monitoring**
- **Objective**: Identify events as they occur.
- **Steps**:
  1. Use PowerShell to filter security logs:
     ```powershell
     Get-EventLog -LogName Security | Where-Object { $_.EventID -eq 4625 } | Select-Object TimeGenerated, Message
     ```
  2. Verify failed login attempts or unauthorized access.

---

### **Step 3: Directive Controls**

#### **3.1 Display Security Warning**
- **Objective**: Inform users about acceptable use policies.
- **Steps**:
  1. Open **Group Policy Editor**.
  2. Navigate to **Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options**.
  3. Set:
     - **Interactive logon: Message text for users attempting to log on**: Add your policy message.

#### **3.2 Automate Acceptable Use Policy Reminder**
- **Objective**: Reinforce policies at every logon.
- **Steps**:
  1. Create a PowerShell script (`PolicyPrompt.ps1`) that displays a message box with the policy.
  2. Assign the script to run at user logon:
     - Navigate to **User Configuration > Windows Settings > Scripts (Logon/Logoff)**.
     - Add the script.

---

### **Step 4: Corrective Controls**

#### **4.1 Backup and Recovery**
- **Objective**: Protect data and ensure recovery from incidents.
- **Steps**:
  1. Create a script to back up files:
     ```powershell
     Copy-Item -Path "C:\SensitiveData" -Destination "D:\Backup" -Recurse
     ```
  2. Automate the script using Task Scheduler.

#### **4.2 Quarantine Suspicious Processes**
- **Objective**: Stop harmful processes immediately.
- **Steps**:
  1. Use PowerShell to terminate suspicious processes:
     ```powershell
     Stop-Process -Name "maliciousprocess"
     ```

#### **4.3 Enable System Restore**
- **Objective**: Quickly recover from misconfigurations or malware attacks.
- **Steps**:
  1. Enable System Restore via **Control Panel > Recovery > Configure System Restore**.
  2. Create a restore point manually or schedule automatic restore points.

---

## **Testing and Validation**
1. Simulate scenarios to test each control:
   - Access a blocked website to verify the firewall rule.
   - Attempt a failed login to generate audit logs.
   - Modify a monitored file to trigger file system auditing.
2. Check the Event Viewer for logs and alerts.
3. Document results in a lab report.

---

## **Conclusion**
This project demonstrates practical implementation of security controls on a Windows VM. By following these steps, you can gain valuable hands-on experience for real-world scenarios and certifications like CompTIA Security+. Repeat the lab to solidify your understanding, and don’t hesitate to test further configurations.



