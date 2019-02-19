# WebsiteMonitoringDashboard
Dashboard for Website Monitoring using Universal Dashboard

## Files
- WebsiteMonitor.ps1 is the main file and uses the urllist.txt to pull the list of websites to monitor
- WebsiteMonitorCore.ps1 has been adopted so it can run in powershell core (run on Linux, Mac, etc.) and uses the urllist.txt to pull the list of websites to monitor
- urllist.txt contains the list of websites to monitor (one per line).

## Initial Setup
You will most likely need to install the module via the command `Install-Module UniversalDashboard.Community`. 

## Improvement
Add email when a website goes into a status other than 200. Want to try and limit sending to every X minutes so its not sending every 15 seconds, etc.
