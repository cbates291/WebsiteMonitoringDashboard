#Improvements: Add Email Sending but limit to initial then every 5 minutes or so.
Import-Module UniversalDashboard.Community


$MyDashboard = New-UDDashboard -Title "NetJets Website Monitor" -Content {
       New-UDTable -Title "Website Monitor"-Headers @("Uri", "StatusCode", "StatusDescription") -AutoRefresh -RefreshInterval 15 -Style responsive-table -Endpoint {
            $WebResult = @()
            $URLList = Get-Content -Path "C:\Users\a-cmh-cbates\OneDrive - NetJets\Documents\WindowsPowerShell\CustomScripts\Projects\urllist.txt"
            foreach($uri in $URLList){
                try
                    {
                         $WebResult += (Invoke-WebRequest -Uri $uri | Select @{name="Uri"; expression={$uri}}, @{name="StatusCode"; expression={$_.StatusCode}}, @{name="StatusDescription"; expression={$_.StatusDescription}}) #| Out-UDGridData
                    }
                catch [Net.WebException]
                     {
                         $WebResult += $_ | Select @{name="Uri"; expression={$uri}}, @{name="StatusCode"; expression={$_.Exception.Response.StatusCode}}, @{name="StatusDescription"; expression={[string]$_.Exception.Response.StatusCode}}
                     }              
            }
            if ($WebResult.StatusCode -ne 200){
                New-UDTable -Title "Error: Needs Checked/Reviewed" -Headers @("Uri", "StatusCode", "StatusDescription") -AutoRefresh -RefreshInterval 15 -BackgroundColor red -Endpoint {
                    $WebResult | where {$_.StatusCode -ne 200} | Out-UDTableData -Property @("Uri", "StatusCode", "StatusDescription")
                }
            } 
            $WebResult | Out-UDTableData -Property @("Uri", "StatusCode", "StatusDescription")
       } 
}

$Server = Start-UDDashboard -Port 1001 -Dashboard $MyDashboard -Name Tassadar