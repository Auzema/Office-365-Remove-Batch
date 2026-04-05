# Office 365 Remove Batch

> *"Fuck Microsuck"* Edition

A universal Windows batch script that **automatically detects and completely removes** Microsoft Office 365 / 2021 / 2019 / 2016 / 2013 from any PC.

Because Microsoft made uninstalling Office harder than installing it. So we made this.

## Features

| # | Feature | Description |
|---|---------|-------------|
| 1 | **Admin Check** | Auto-detects Administrator privileges; exits safely if not elevated |
| 2 | **Process Killer** | Force-closes all running Office apps (Word, Excel, PowerPoint, Outlook, Teams, OneNote, Access, Publisher, Visio, Project) |
| 3 | **Service Removal** | Stops and deletes Click-to-Run and related Office services |
| 4 | **Registry Path Detection** | Reads Windows Registry to find actual install locations (both 32-bit and 64-bit) |
| 5 | **Common Path Scanning** | Checks all known default Office installation directories |
| 6 | **User Data Cleanup** | Removes user-level Office data, templates, and OneDrive leftovers |
| 7 | **Scheduled Task Removal** | Deletes Office auto-update and telemetry scheduled tasks |
| 8 | **Registry Cleanup** | Purges Office-related registry keys (ClickToRun, Office 15.0/16.0, AppVISV) |
| 9 | **Cache Clearing** | Removes installer packages and patch cache |
| 10 | **Universal Compatibility** | Works on Windows 7 / 8 / 10 / 11 |
| 11 | **Multi-Version Support** | Handles Office 2013, 2016, 2019, 2021, and 365 |
| 12 | **Safety Confirmation** | Requires typing `YES` before executing to prevent accidents |


## How to use

1. **Download** `RemoveOffice.bat` from this repo.

2. **Right-click** the file → **Run as administrator**.

3. **Type `YES`** when prompted to confirm.

4. Wait for the script to finish.

5. **Restart your computer**.

6. Reinstall Office (or don't — [LibreOffice](https://www.libreoffice.org/) is free and doesn't hate you).


## What it removes
📁 Program Files\Microsoft Office 
📁 Program Files (x86)\Microsoft Office 
📁 Common Files\Microsoft Shared\ClickToRun 
📁 Common Files\Microsoft Shared\OFFICE15/16 
📁 ProgramData\Microsoft\ClickToRun 
📁 ProgramData\Microsoft\Office 
📁 AppData\Local\Microsoft\Office 
📁 AppData\Roaming\Microsoft\Office
📁 AppData\Roaming\Microsoft\Templates 
🔧 ClickToRunSvc service 
🔧 OfficeSvc service 
📋 Office Automatic Updates scheduled task 
📋 Office ClickToRun Service Monitor scheduled task 
📋 Office Telemetry Agent scheduled tasks 
🗝️ HKLM\SOFTWARE\Microsoft\Office\ClickToRun 
🗝️ HKLM\SOFTWARE\Microsoft\Office\15.0 & 16.0 
🗝️ HKCU\Software\Microsoft\Office\15.0 & 16.0 
🗝️ HKLM\SOFTWARE\Microsoft\AppVISV

## Requirements
- **Windows 7 / 8 / 10 / 11**
- **Administrator privileges** (right-click → Run as administrator)
- A healthy amount of frustration with Microsoft
---
## Disclaimer
This script is provided as-is with no warranty. Use at your own risk. It will **permanently delete** all Microsoft Office installations and related data from your system.
Back up any important Office files (documents, templates, Outlook data) before running.
---
## FAQ
**Q: Will this delete my Word/Excel documents?**
A: No. It only removes Office program files, services, and registry entries. Your `.docx`, `.xlsx`, etc. files in Documents or other folders are safe.
**Q: Can I reinstall Office after running this?**
A: Yes! That's the whole point. Restart your PC after running the script, then install Office fresh.
**Q: It says "must be run as Administrator"?**
A: Right-click the `.bat` file → **Run as administrator**.
**Q: It didn't find any Office installation?**
A: Either Office was already removed, or it's installed in a non-standard location. The script checks both registry and common paths, but exotic setups may need manual cleanup.
---
## License
MIT — Do whatever you want with it.
---
<p align="center">
  <i>"Your PC is now free from Microsuck's grip."</i><br>
  <b>— Office Terminator</b>
</p>
