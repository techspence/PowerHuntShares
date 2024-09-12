
#Requires -Version 5.1 
#--------------------------------------
# Function: Analyze-HuntSMBShares
#--------------------------------------
# Author: Scott Sutherland, 2024 NetSPI
# License: 3-clause BSD
# Version: v1.85
# References: This script includes custom code and code taken and modified from the open source projects PowerView, Invoke-Ping, and Invoke-Parrell. 
function Analyze-HuntSMBShares
{    
	<#
            .SYNOPSIS
            This function can be used to analyze data collected by Invoke-HuntSMBShares offline, analyze data, and generate the report.  
            It's goal in life is to expedite development.
            .PARAMETER Threads
            Number of concurrent tasks to run at once.
            .PARAMETER Output Directory
            File path report will be exported.
            .EXAMPLE
	        PS C:\> Analyze-HuntSMBShares -TargetDirectory c:\temp\SmbShareHunt-06132024085736\ -OutputDirectory c:\temp
             ---------------------------------------------------------------
             Analyze-HuntSMBShares                                       
             ---------------------------------------------------------------
              This function automates the following tasks:                  
                                                                
              o Identify shares with potentially excessive privileges      
              o Identify shares that provide read or write access           
              o Identify shares thare are high risk                         
              o Identify common share owners, names, & directory listings   
              o Generate last written & last accessed timelines             
              o Generate html summary report and detailed csv files                      
             ---------------------------------------------------------------
             |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
             ---------------------------------------------------------------
             [*][07/03/2024 11:20] IMPORT DATA
             ---------------------------------------------------------------
             [*][07/03/2024 11:20] Importing computer data...
             [*][07/03/2024 11:20] - acme.com is the target domain.
             [*][07/03/2024 11:20] - 11724 computers found.
             [*][07/03/2024 11:20] - 282 Active Directory subnets found.
             [*][07/03/2024 11:20] - 5733 computers responded to ping requests.
             [*][07/03/2024 11:20] - 5567 computers have TCP port 445 open.
             [*][07/03/2024 11:20] Importing share data...
             [*][07/03/2024 11:21] - 25949 SMB shares were found across 4886 computers.
             [*][07/03/2024 11:21] Importing acl data...
             [*][07/03/2024 11:21] - 41923 share permissions were enumerated.
             [*][07/03/2024 11:21] Importing excessive privilege data...
             [*][07/03/2024 11:21] - 4633 acls were found configured with potentially excess
            ive privileges on 1839 shares across 808 computers.
             ---------------------------------------------------------------
             SHARE DATA ANALYSIS      
             ---------------------------------------------------------------
             [*][03/01/2021 09:37] Analysis Start
             [*][03/01/2021 09:37] - 14 shares can be read across 12 systems.
             [*][03/01/2021 09:37] - 1 shares can be written to across 1 systems.
             [*][03/01/2021 09:37] - 46 shares are considered non-default across 32 systems.
             [*][03/01/2021 09:37] - 0 shares are considered high risk across 0 systems
             [*][03/01/2021 09:37] - Identified top 5 owners of excessive shares.
             [*][03/01/2021 09:37] - Identified top 5 share groups.
             [*][03/01/2021 09:37] - Identified top 5 share names.
             [*][03/01/2021 09:37] - Identified shares created in last 90 days.
             [*][03/01/2021 09:37] - Identified shares accessed in last 90 days.
             [*][03/01/2021 09:37] - Identified shares modified in last 90 days.
             [*][03/01/2021 09:37] Analysis Complete
             ---------------------------------------------------------------
             SHARE REPORT SUMMARY      
             ---------------------------------------------------------------
             [*][03/01/2021 09:37] Domain: demo.local
             [*][03/01/2021 09:37] Start time: 03/01/2021 09:35:04
             [*][03/01/2021 09:37] End time: 03/01/2021 09:37:27
             [*][03/01/2021 09:37] Run time: 00:02:23.2759086
             [*][03/01/2021 09:37] 
             [*][03/01/2021 09:37] COMPUTER SUMMARY
             [*][03/01/2021 09:37] - 245 domain computers found.
             [*][03/01/2021 09:37] - 55 (22.45%) domain computers responded to ping.
             [*][03/01/2021 09:37] - 49 (20.00%) domain computers had TCP port 445 accessible.
             [*][03/01/2021 09:37] - 32 (13.06%) domain computers had shares that were non-default.
             [*][03/01/2021 09:37] - 12 (4.90%) domain computers had shares with potentially excessive privileges.
             [*][03/01/2021 09:37] - 12 (4.90%) domain computers had shares that allowed READ access.
             [*][03/01/2021 09:37] - 1 (0.41%) domain computers had shares that allowed WRITE access.
             [*][03/01/2021 09:37] - 0 (0.00%) domain computers had shares that are HIGH RISK.
             [*][03/01/2021 09:37] 
             [*][03/01/2021 09:37] SHARE SUMMARY
             [*][03/01/2021 09:37] - 217 shares were found. We expect a minimum of 98 shares
             [*][03/01/2021 09:37]   because 49 systems had open ports and there are typically two default shares.
             [*][03/01/2021 09:37] - 46 (21.20%) shares across 32 systems were non-default.
             [*][03/01/2021 09:37] - 14 (6.45%) shares across 12 systems are configured with 33 potentially excessive ACLs.
             [*][03/01/2021 09:37] - 14 (6.45%) shares across 12 systems allowed READ access.
             [*][03/01/2021 09:37] - 1 (0.46%) shares across 1 systems allowed WRITE access.
             [*][03/01/2021 09:37] - 0 (0.00%) shares across 0 systems are considered HIGH RISK.
             [*][03/01/2021 09:37] 
             [*][03/01/2021 09:37] SHARE ACL SUMMARY
             [*][03/01/2021 09:37] - 374 ACLs were found.
             [*][03/01/2021 09:37] - 374 (100.00%) ACLs were associated with non-default shares.
             [*][03/01/2021 09:37] - 33 (8.82%) ACLs were found to be potentially excessive.
             [*][03/01/2021 09:37] - 32 (8.56%) ACLs were found that allowed READ access.
             [*][03/01/2021 09:37] - 1 (0.27%) ACLs were found that allowed WRITE access.
             [*][03/01/2021 09:37] - 0 (0.00%) ACLs were found that are associated with HIGH RISK share names.
             [*][03/01/2021 09:37] 
             [*][03/01/2021 09:37] - The 5 most common share names are:
             [*][03/01/2021 09:37] - 9 of 14 (64.29%) discovered shares are associated with the top 5 share names.
             [*][03/01/2021 09:37]   - 4 backup
             [*][03/01/2021 09:37]   - 2 ssms
             [*][03/01/2021 09:37]   - 1 test2
             [*][03/01/2021 09:37]   - 1 test1
             [*][03/01/2021 09:37]   - 1 users
             [*] -----------------------------------------------

	#>
    [CmdletBinding()]
    Param(
        
        [Parameter(Mandatory = $false,
        HelpMessage = 'Number of threads to process at once.')]
        [int]$Threads = 20,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Directory to output files to.')]
        [string]$OutputDirectory,

        [Parameter(Mandatory = $true,
        HelpMessage = 'The PowerHuntShare output folder.')]
        [string]$TargetDirectory,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Number of items to sample for summary report. Typically something like: SmbShareHunt-06132024085403')]
        [int]$SampleSum = 200,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Runspace time out.')]
        [int]$RunSpaceTimeOut = 15,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Time in days for recent share creation summary report.')]
        [int]$ShareCreationDays = 90,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Time in days for last access report.')]
        [int]$LastAccessDays = 90,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Time in days for last modified report.')]
        [int]$LastModDays = 90,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Show runspace errors if they occur.')]
        [switch] $ShowRunpaceErrors,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Import all data from files vs analyzing raw import data. Mostly used when making code changes.')]
        [switch] $ImportAll,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Supress timeline report generation.')]
        [switch] $SupressTimelineRpt,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Number of directory levels to capture file list.')]
        [int] $DirLevel = 3,
                
        [Parameter(Mandatory = $false,
        HelpMessage = 'Path to interesting files template to import file keywords to search for.')]
        [string] $FileKeywordsPath        
    )
	
    
    Begin
    {
        Write-Output " ===============================================================" 
        Write-Output " Analyze-HuntSMBShares                                "
        Write-Output " ==============================================================="         
        Write-Output "  This function automates the following tasks:                  "
        Write-Output "  o Identify shares with potentially excessive privielges       "
        Write-Output "  o Identify shares that provide read or write access           "                     
        Write-Output "  o Identify shares thare are high risk                         "
        Write-Output "  o Identify common share owners, names, & directory listings   "
        Write-Output "  o Generate last written & last accessed timelines             "
        Write-Output "  o Generate html summary report and detailed csv files         " 
        Write-Output ""         
        Write-Output "  Note: This can take hours to run in large environments.       "              
        Write-Output " ---------------------------------------------------------------"  
        Write-Output " |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
        Write-Output " ---------------------------------------------------------------"           

        # Get start time
        $StartTime = Get-Date
        $StopWatch =  [system.diagnostics.stopwatch]::StartNew()
        $Time =  Get-Date -UFormat "%m/%d/%Y %R"

        # Set target directory
        if(-not $TargetDirectory){          
           $TargetDirectory = ".\Results"
        }else{
           $TargetDirectory = "$TargetDirectory\Results" 
           $TargetDirectory = $TargetDirectory.Replace('\\','\')
        }
        Write-Output " [*] Target directory: $TargetDirectory"

        # Set output directory
        if(-not $OutputDirectory){
           $OutputDirectory = $TargetDirectory
        }
        Write-Output " [*] Output directory: $OutputDirectory"
        
        # Check for target directory
        if(Test-Path $TargetDirectory){ 
            #Write-Output " [x]The target directory exists."
        }else{
            Write-Output " [x] The $TargetDirectory did not exist."
            Write-Output " [!] Aborting operation."
            break
        }

        # Check for keyword file path 
        If($FileKeywordsPath){

            if(Test-Path $FileKeywordsPath){ 
                #Write-Output " [x]The target directory exists."
            }else{
                Write-Output " [x] The $FileKeywordsPath did not exist."
                Write-Output " [!] Aborting operation."
                break
            }
        }

        # Check for output directory
        if(Test-Path $OutputDirectory){ 
            #Write-Output " [x][$Time] The output directory exists."
        }else{
            Write-Output " [x] The $OutputDirectory did not exist."
            Write-Output " [!] Aborting operation."
            break
        }

        Write-Output " ---------------------------------------------------------------"
        Write-Output " [*][$Time] IMPORT SHARE DATA"
        Write-Output " ---------------------------------------------------------------"
        Write-Output " [*][$Time] Importing computer data..."

        $TargetDomain = "Testing"

        # Get all computers
        try{
            $DomainComputers          =  import-csv "$TargetDirectory\*-Domain-Computers.csv"
            $ComputerCount            = $DomainComputers | Measure-Object | select count -ExpandProperty count 

            # Get domain
            $DomainNamePrep = $DomainComputers | select computername -first 1 -expandproperty computername
            $TargetDomain   = Get-ADDomainFromFQDN -FQDN $DomainNamePrep 
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $TargetDomain is the target domain."
            Write-Output " [*][$Time] - $ComputerCount computers found."
        }catch{
            $DomainComputers  = ""
            $ComputerCount = 0
            Write-Output " [*][$Time] - Computers file could not be imported."                          
        }

        # Get all pingable
        try{
            $ComputersPingable        =  import-csv "$TargetDirectory\*-Domain-Computers-Pingable.csv"
            $ComputerPingableCount    = $ComputersPingable | Measure-Object | select count -ExpandProperty count 
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $ComputerPingableCount computers responded to ping requests." 
        }catch{
            $ComputersPingable = ""
            $ComputersPingableCount = 0
            Write-Output " [*][$Time] - Computers that were pingable file could not be imported."
        }         

        # Get all open ports
        try{
            $Computers445Open         =  import-csv "$TargetDirectory\*-Domain-Computers-Open445.csv"
            $Computers445OpenCount    = $Computers445Open | Measure-Object | select count -ExpandProperty count 
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $Computers445OpenCount computers have TCP port 445 open."
        }catch{
            $Computers445Open = ""
            $Computers445OpenCount = 0
            Write-Output " [*][$Time] - Computers with open port 445 file could not be imported."
        }

        # Get Subnets
        try{
            $DomainSubnets            =  import-csv "$TargetDirectory\*-Domain-Subnets.csv"
            $DomainSubnetsCount       = $DomainSubnets | measure | select count -ExpandProperty count
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $DomainSubnetsCount Active Directory subnets found."
        }catch{
            $DomainSubnets  = ""
            $DomainSubnetsCount = 0
            Write-Output " [*][$Time] - Subnets file could not be imported."
        }

        # Get all shares
        Write-Output " [*][$Time] Importing share data..." 
        try{
            $AllSMBShares             = import-csv "$TargetDirectory\*-Shares-Inventory-All.csv"
            $AllSMBSharesCount        = $AllSMBShares | Measure-Object | select count -ExpandProperty count         

            # Get all computers with shares
            $AllComputersWithShares   = $AllSMBShares | Select-Object ComputerName -Unique
            $AllComputersWithSharesCount =  $AllComputersWithShares | Measure-Object | select count -ExpandProperty count 
             $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $AllSMBSharesCount SMB shares were found across $AllComputersWithSharesCount computers."
        }catch{
            $AllSMBShares = ""
            $AllComputersWithShares = ""
            $AllSMBSharesCount = 0
            $AllComputersWithSharesCount = 0
            Write-Output " [*][$Time] - Shares file could not be imported."
        }

        # Get all acls
        Write-Output " [*][$Time] Importing acl data..." 
        try{
            $ShareACLs                =  import-csv "$TargetDirectory\*-Shares-Inventory-All-ACL.csv"
            $ShareACLsCount           = $ShareACLs | Measure-Object | select count -ExpandProperty count
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $ShareACLsCount share permissions were enumerated." 
        }catch{
            $ShareACLs = ""
            $ShareACLsCount = 0
            Write-Output " [*][$Time] - Share ACL file could not be imported."
        }

        # Get acls with excessive privileges
        Write-Output " [*][$Time] Importing excessive privilege data..." 
        try{
            $ExcessiveSharePrivs      = import-csv "$TargetDirectory\*-Shares-Inventory-Excessive-Privileges.csv"              
            $ExcessiveSharePrivsCount = $ExcessiveSharePrivs | Measure-Object | select count -ExpandProperty count 
            $ExcessiveAclCount        = $ExcessiveSharePrivs | Measure-Object | select count -ExpandProperty count #sloppy patch
        }catch{
            Write-Output " [*][$Time] - Excessive privileges file could not be imported - aborted."
        }        

        # Get shares with excessive privileges          
        $ExcessiveShares          = $ExcessiveSharePrivs | Select-Object ComputerName,ShareName -unique
        $ExcessiveSharesCount     = $ExcessiveShares     | Measure-Object | select count -ExpandProperty count

        # Get computers with excessive privileges              
        $ComputerWithExcessive    = $ExcessiveSharePrivs | Select-Object ComputerName -Unique | Measure-Object | select count -ExpandProperty count
        $Time =  Get-Date -UFormat "%m/%d/%Y %R"

        Write-Output " [*][$Time] - $ExcessiveSharePrivsCount acls were found configured with potentially excessive privileges on $ExcessiveSharesCount shares across $ComputerWithExcessive computers."                   

        Write-Output " ---------------------------------------------------------------"
        Write-Output " [*][$Time] ANALYZE SHARE DATA"
        Write-Output " ---------------------------------------------------------------"
        
        # Get non default share access
        Write-Output " [*][$Time] Identifying non-default share access..." 
        try{
            if($ImportAll){
                 Write-Output " [*][$Time] - Importing from file..."
                $SharesNonDefault = import-csv "$TargetDirectory\*-Shares-Inventory-Excessive-Privileges-NonDefault.csv"
            } else {
                Write-Output " [*][$Time] - Parsing excessive privileges..."
                $SharesNonDefault = $ShareACLs | 
                Foreach {

                    if(($_.ShareName -notlike 'admin$') -or ($_.ShareName -notlike 'c$') -or ($_.ShareName -notlike 'd$') -or ($_.ShareName -notlike 'e$') -or ($_.ShareName -notlike 'f$'))
                    {
                        $_ # out to file
                    }
                }
            }
            $AclNonDefaultCount = $SharesNonDefault | measure | select count -ExpandProperty count
            $SharesNonDefaultCount = $SharesNonDefault | Select-Object SharePath -Unique | Measure-Object | select count -ExpandProperty count
            $ComputerwithNonDefaultCount = $SharesNonDefault | Select-Object ComputerName -Unique | Measure-Object | select count -ExpandProperty count
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $SharesNonDefaultCount shares are considered non-default across $ComputerwithNonDefaultCount systems."
        }catch{
            $AclNonDefaultCount = 0
            $SharesNonDefaultCount = 0
            $ComputerwithNonDefaultCount = 0
            Write-Output " [*][$Time] - Non default shares file could not be imported."
        }

        # Get shares that provide read access
        Write-Output " [*][$Time] Identifying excessive read access..." 
        try{
            if($ImportAll){
                Write-Output " [*][$Time] - Importing from file..."
                $SharesWithread = import-csv "$TargetDirectory\*-Shares-Inventory-Excessive-Privileges-Read.csv"
            } else {
                Write-Output " [*][$Time] - Parsing excessive privileges..."
                $SharesWithread = $ExcessiveSharePrivs | 
                Foreach {

                    if(($_.FileSystemRights -like "*read*"))
                    {
                        $_ # out to file
                    }
                } 
            }              
            $AclWithReadCount = $SharesWithread | Measure-Object | select count -ExpandProperty count 
            $SharesWithReadCount = $SharesWithread | Select-Object SharePath -Unique | Measure-Object | select count -ExpandProperty count
            $ComputerWithReadCount = $SharesWithread | Select-Object ComputerName -Unique | Measure-Object | select count -ExpandProperty count
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $SharesWithReadCount shares can be read across $ComputerWithReadCount computers."
        }catch{
            $AclWithReadCount = 0
            $SharesWithReadCount = 0 
            $ComputerWithReadCount = 0
            Write-Output " [*][$Time] - Read shares file could not be imported."
        }

        # Get shares that provide write access
        Write-Output " [*][$Time] Identifying excessive write access..." 
        try{
            if($ImportAll){
                Write-Output " [*][$Time] - Importing from file..."
                $SharesWithWrite = import-csv "$TargetDirectory\*-Shares-Inventory-Excessive-Privileges-Write.csv"
            }else{
                Write-Output " [*][$Time] - Parsing excessive privileges..."
                $SharesWithWrite = $ExcessiveSharePrivs | 
                Foreach {

                    if(($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*"))
                    {
                        $_ # out to file
                    }
                }
            }
            $AclWithWriteCount = $SharesWithWrite | Measure-Object | select count -ExpandProperty count
            $SharesWithWriteCount = $SharesWithWrite | Select-Object SharePath -Unique | Measure-Object | select count -ExpandProperty count
            $ComputerWithWriteCount = $SharesWithWrite | Select-Object ComputerName -Unique | Measure-Object | select count -ExpandProperty count
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $SharesWithWriteCount shares can be written to across $ComputerWithWriteCount systems."          
        }catch{
            $AclWithWriteCount = 0
            $SharesWithWriteCount = 0
            $ComputerWithWriteCount = 0
            Write-Output " [*][$Time] - Write shares file could not be imported."
        }

        # Get high risk share access
        try{
            Write-Output " [*][$Time] Identifying high risk access..." 
            if($ImportAll){
                Write-Output " [*][$Time] - Importing from file..."
                $SharesHighRisk = import-csv "$TargetDirectory\*-Shares-Inventory-Excessive-Privileges-HighRisk.csv"
            }else{
                Write-Output " [*][$Time] - Parsing excessive privileges..."
                $SharesHighRisk = $ExcessiveSharePrivs | 
                Foreach {

                    if(($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'C') -or ($_.ShareName -like 'c_share'))
                    {
                        $_ # out to file
                    }
                }
            }
            $AclHighRiskCount = $SharesHighRisk | Measure-Object | select count -ExpandProperty count 
            $SharesHighRiskCount = $SharesHighRisk | Select-Object SharePath -Unique | Measure-Object | select count -ExpandProperty count
            $ComputerwithHighRisk = $SharesHighRisk | Select-Object ComputerName -Unique | Measure-Object | select count -ExpandProperty count
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] - $SharesHighRiskCount shares are considered high risk across $ComputerwithHighRisk systems."
        }catch{
            $AclHighRiskCount = 0
            $SharesHighRiskCount = 0
            $ComputerwithHighRisk = 0
             Write-Output " [*][$Time] - High risk shares file could not be imported."
        }
        
        Write-Output " [*][$Time] Identifying trends..." 

        # ----------------------------------------------------------------------
        # Identify common excessive share owners
        # ----------------------------------------------------------------------                

        # Get share owner list
        $CommonShareOwners = $ExcessiveSharePrivs | Select SharePath,ShareOwner -Unique |
        Select-Object ShareOwner | 
        <#
        where ShareOwner -notlike "BUILTIN\Administrators" |
        where ShareOwner -notlike "NT AUTHORITY\SYSTEM" |
        where ShareOwner -notlike "NT SERVICE\TrustedInstaller" |
        #>
        Group-Object ShareOwner |
        Sort-Object ShareOwner | 
        Select-Object count,name |
        Sort-Object Count -Descending

        # Save list
        $CommonShareOwners | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Shares-Inventory-Common-Owners.csv"
        $CommonShareOwnersCount = $CommonShareOwners | measure | select count -ExpandProperty count

        # Get top  5
        $CommonShareOwnersTop5 = $CommonShareOwners | Select-Object count,name -First $SampleSum 

        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        Write-Output " [*][$Time] - Identified top $SampleSum owners of excessive shares."

        # ----------------------------------------------------------------------
        # Identify common excessive share groups (group by file list)
        # ----------------------------------------------------------------------
        
        # Get share owner list
        $CommonShareFileGroup = $ExcessiveSharePrivs | 
        Select-Object FileListGroup | 
        Group-Object FileListGroup| 
        Select-Object count,name |
        Sort-Object Count -Descending

        # Save list
        $CommonShareFileGroup | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Shares-Inventory-Common-FileGroups.csv"
        $CommonShareFileGroupCount = $CommonShareFileGroup.count 

        # Get top  5
        $CommonShareFileGroupTop5 = $CommonShareFileGroup | Select-Object count,name,filecount -First $SampleSum 

        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        Write-Output " [*][$Time] - Identified top $SampleSum share groups."

        # ----------------------------------------------------------------------
        # Identify common share names
        # ----------------------------------------------------------------------
             
        $CommonShareNames = $ExcessiveSharePrivs | Select-Object ComputerName,ShareName -Unique | Group-Object ShareName |Sort Count -Descending | select count,name | 
        foreach{
            if( ($_.name -ne 'SYSVOL') -and ($_.name -ne 'NETLOGON'))
            {
                $_                
            }
        }        
       
        # Get percent of shared covered by top n
        # If very weighted this indicates if the shares are part of a deployment process, image, or app
        
        # Get top five share name
        $CommonShareNamesCount = $CommonShareNames.count
        $CommonShareNamesTop5 = $CommonShareNames | Select-Object count,name -First $SampleSum 
        
        # Get count of share name if in the top n
        $Top5ShareCountTotal = 0
        $CommonShareNamesTop5 |
        foreach{
            [int]$TopCount = $_.Count 
            $Top5ShareCountTotal = $Top5ShareCountTotal + $TopCount
        }
        
        # Get count of all accessible shares
        $AllAccessibleSharesCount = $ExcessiveSharePrivs | Select-Object ComputerName,ShareName -Unique | measure | select count -ExpandProperty count

        # Write output
        #Write-Output " [*] Saving results to $OutputDirectory\$TargetDomain-Shares-Inventory-Common-Names.csv" 
        $CommonShareNames | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Shares-Inventory-Common-Names.csv"

        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        Write-Output " [*][$Time] - Identified top $SampleSum share names."

        # ----------------------------------------------------------------------
        # Identify excessive share creation in last n 90 days
        # ----------------------------------------------------------------------

        # Select shares from last n names
        $StartDateAccess = (get-date).AddDays(-$ShareCreationDays);
        $EndDateAccess = Get-Date        
        $ExPrivCreationLastn = $ExcessiveSharePrivs | Where-Object {([Datetime]$_.CreationDate.trim() -ge $StartDateAccess -and [Datetime]$_.CreationDate.trim() -le $EndDateAccess)}
        $ExPrivCreationLastnShare = $ExPrivCreationLastn | select SharePath -Unique
        $ExPrivCreationLastnShareCount = $ExPrivCreationLastnShare | Measure | select count -ExpandProperty count

        # Percent of shares accessed in last n days
        $ExpPrivCreationLast = $ExPrivCreationLastnShareCount / $AllSMBSharesCount
        $ExpPrivCreationLastP = $ExpPrivCreationLast.tostring("P") -replace(" ","")

        # Get summary bar code - Need to extend for counts,%, and bar
        $ExPrivCreationLastBars = Get-ExPrivSumData -DataTable $ExPrivCreationLastn  -AllComputerCount $ComputerCount -AllShareCount $AllSMBSharesCount -AllAclCount $ShareACLsCount
        $ExPrivCreationLastComputerB = $ExPrivCreationLastBars.ComputerBar
        $ExPrivCreationLastShareB = $ExPrivCreationLastBars.ShareBar
        $ExPrivCreationLastShareAclB = $ExPrivCreationLastBars.AclBar

        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        Write-Output " [*][$Time] - Identified shares created in last $ShareCreationDays days."

        # ----------------------------------------------------------------------
        # Identify excessive share access in last n 90 days
        # ----------------------------------------------------------------------

        # Select shares from last n names
        $StartDateAccess = (get-date).AddDays(-$LastAccessDays);
        $EndDateAccess = Get-Date        
        $ExPrivAccessLastn = $ExcessiveSharePrivs | Where-Object {([Datetime]$_.LastAccessDate.trim() -ge $StartDateAccess -and [Datetime]$_.LastAccessDate.trim() -le $EndDateAccess)}
        $ExPrivAccessLastnShare = $ExPrivAccessLastn | select SharePath -Unique
        $ExPrivAccessLastnShareCount = $ExPrivAccessLastnShare | Measure | select count -ExpandProperty count

        # Percent of shares accessed in last n days
        $ExpPrivAccessLast = $ExPrivAccessLastnShareCount / $AllSMBSharesCount
        $ExpPrivAccessLastP = $ExpPrivAccessLast.tostring("P") -replace(" ","")

        # Get summary bar code - Need to extend for counts,%, and bar
        $ExPrivAccesLastBars = Get-ExPrivSumData -DataTable $ExPrivAccessLastn  -AllComputerCount $ComputerCount -AllShareCount $AllSMBSharesCount -AllAclCount $ShareACLsCount
        $ExPrivAccesLastComputerB = $ExPrivAccesLastBars.ComputerBar
        $ExPrivAccesLastShareB = $ExPrivAccesLastBars.ShareBar
        $ExPrivAccesLastShareAclB = $ExPrivAccesLastBars.AclBar

        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        Write-Output " [*][$Time] - Identified shares accessed in last $LastAccessDays days."

        # ----------------------------------------------------------------------
        # Identify excessive modification in last n 90 days
        # ----------------------------------------------------------------------

        # Select shares from last n names
        $StartDateModified = (get-date).AddDays(-$LastModDays);
        $EndDateModified = Get-Date        
        $ExPrivModifiedLastn = $ExcessiveSharePrivs | Where-Object {([Datetime]$_.LastModifiedDate.trim() -ge $StartDateModified -and [Datetime]$_.LastModifiedDate.trim() -le $EndDateModified)}
        $ExPrivModifiedLastnShare = $ExPrivModifiedLastn | select SharePath -Unique
        $ExPrivModifiedLastnShareCount = $ExPrivModifiedLastnShare | Measure | select count -ExpandProperty count

        # Percent of shares Modifieded in last n days
        $ExpPrivModifiedLast = $ExPrivModifiedLastnShareCount / $AllSMBSharesCount
        $ExpPrivModifiedLastP = $ExpPrivModifiedLast.tostring("P") -replace(" ","")

        # Get summary bar code - Need to extend for counts,%, and bar
        $ExPrivModifiedLastBars = Get-ExPrivSumData -DataTable $ExPrivModifiedLastn  -AllComputerCount $ComputerCount -AllShareCount $AllSMBSharesCount -AllAclCount $ShareACLsCount
        $ExPrivModifiedLastComputerB = $ExPrivModifiedLastBars.ComputerBar
        $ExPrivModifiedLastShareB = $ExPrivModifiedLastBars.ShareBar
        $ExPrivModifiedLastShareAclB = $ExPrivModifiedLastBars.AclBar

        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        Write-Output " [*][$Time] - Identified shares modified in last $LastModDays days."

        # ----------------------------------------------------------------------
        # Identify affected subnets
        # ----------------------------------------------------------------------        

        # Get list of Subnets
        $Subnets = $ExcessiveSharePrivs | Select IPAddress -Unique |
        Foreach{  
    
            [int]$LastOctStart = (($_.IPAddress | Select-String '\.'  -AllMatches).Matches | select -last 1 | select index -ExpandProperty index)
            $Subnet = $_.IPAddress.substring(0,$LastOctStart)
            $Subnet    
        } | select -Unique

        $SubnetsCount = $Subnets | measure | select count -ExpandProperty count

        # Get information for each subnet
        $SubnetSummary = $Subnets | 
        foreach {

            $Subnet = $_
            $Subnetdisplay = $subnet + ".0"
    
            # Acls - acl list exists
            $subnetacls = $ExcessiveSharePrivs | where ipaddress -like "$subnet*"
            $subnetaclsCount = $subnetacls | measure | select count -ExpandProperty count

            # ACLs: Read - aclread exists
            $subnetaclr = $SharesWithread | where ipaddress -like "$subnet*"
            $subnetaclrCount = $subnetaclr | measure | select count -ExpandProperty count

            # ACLs: Write - acl write exists
            $subnetaclw = $SharesWithWrite | where ipaddress -like "$subnet*"
            $subnetaclwCount = $subnetaclw | measure | select count -ExpandProperty count

            # ACLs: Highrisk - acl highrisk exists
            $subnetaclx = $SharesHighRisk | where ipaddress -like "$subnet*"
            $subnetaclxCount = $subnetaclx | measure | select count -ExpandProperty count
    
            # Shares
            $subnetshares = $subnetacls | select sharepath -Unique
            $subnetsharesCount = $subnetshares | measure | select count -ExpandProperty count

            # Computers
            $subnetcomputers = $subnetacls | select computername -Unique
            $subnetcomputersCount = $subnetcomputers | measure | select count -ExpandProperty count

            # Check for known subnet information
            if(-not $HostList){
                if($DomainSubnets -ne 0){
                    
                    $DomainSubnets |
                    foreach{
                                                
                        $SubnetFull = $_.Subnet                        

                        if((checkSubnet $SubnetFull $Subnet).condition){
                            $SubnetDesc = $_.Description
                            $SubnetCreated = $_.whencreated
                            $SubnetSite = $_.Site
                        }
                    }
                }else{
                    $SubnetDesc    = "Unknown"
                    $SubnetCreated = "Unknown"
                    $SubnetSite    = "Unknown"
                }
            }else{
                $SubnetDesc    = "Unknown"
                $SubnetCreated = "Unknown"
                $SubnetSite    = "Unknown"
            }

            # Create object
            $Object = new-object PSObject
            $Object |  Add-Member Subnet        $Subnetdisplay
            $Object |  Add-Member Desc          $SubnetDesc
            $Object |  Add-Member Created       $SubnetCreated
            $Object |  Add-Member Site          $SubnetSite
            $Object |  Add-Member ACEs          $subnetaclsCount
            $Object |  Add-Member ReadACEs      $subnetaclrCount
            $Object |  Add-Member WriteACEs     $subnetaclwCount
            $Object |  Add-Member ExploitableACEs  $subnetaclxCount
            $Object |  Add-Member Shares        $subnetsharesCount
            $Object |  Add-Member Computers     $subnetcomputersCount

            # Return object
            if($Subnetdisplay -ne ".0"){
                $Object 
            }

        } | sort Acls -Descending

        # Status User
        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        Write-Output " [*][$Time] - Identified $SubnetsCount subnets hosting shares configured with excessive privileges."
        $SubnetSummary | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Shares-Inventory-Common-Subnets.csv"               
        $SubnetFile = "$TargetDomain-Shares-Inventory-Common-Subnets.csv"  
        
        # Create HTML table for report

        # Setup HTML begin
        Write-Verbose "[+] Creating html top." 
        $HTMLSTART = @"
        <table class="table table-striped table-hover tabledrop">
"@

        # Get list of columns        
        $MyCsvColumns = ("Computers","Shares","ExploitableACEs","WriteACEs","ReadACEs","ACEs","Site","Created","Desc","Subnet")

        # Print columns creation  
        $HTMLTableHeadStart= "<thead><tr>" 
        $MyCsvColumns |
        ForEach-Object {

            # Add column
            $HTMLTableColumn = "<th>$_</th>$HTMLTableColumn"    
        }
        $HTMLTableColumn = "$HTMLTableHeadStart$HTMLTableColumn</tr></thead>" 

        # Create table rows
        Write-Verbose "[+] Creating html table rows."     
        $HTMLTableRow = $SubnetSummary |
        ForEach-Object {

            # Create a value contain row data
            $CurrentRow = $_
            $PrintRow = ""
            $MyCsvColumns | 
            ForEach-Object{
        
                try{
                    $GetValue = $CurrentRow | Select-Object $_ -ExpandProperty $_ -ErrorAction SilentlyContinue
                    $ColumnIndex = $MyCsvColumns.IndexOf($_) + 1

                    # Set background color based on shifted conditions
                    $BackgroundColor = ""

                    if ($ColumnIndex -eq 5 -and [int]$GetValue -gt 0) {          # Originally for column 4 = write
                        $BackgroundColor = ' style="background-color:#FDFFd9;"'  
                    } elseif ($ColumnIndex -eq 4 -and [int]$GetValue -gt 0) {    # Originally for column 5 = read
                        $BackgroundColor = ' style="background-color:#FFCC98;"'  
                    } elseif ($ColumnIndex -eq 3 -and [int]$GetValue -gt 0) {
                        $BackgroundColor = ' style="background-color:#FC6C84;"'  # Originally for column 3=exploitable, 2=shares,1=computers
                    }

                    # Append the value with the background color
                    if($PrintRow -eq ""){
                        $PrintRow = "<td$BackgroundColor>$GetValue</td>"               
                    }else{         
                        $PrintRow = "<td$BackgroundColor>$GetValue</td>$PrintRow"
                    }
                }catch{}            
            }

            # Return row
            $HTMLTableHeadstart = "<tr>" 
            $HTMLTableHeadend = "</tr>" 
            "$HTMLTableHeadStart$PrintRow$HTMLTableHeadend"
        }

        # Setup HTML end
        Write-Verbose "[+] Creating html bottom." 
        $HTMLEND = @"
          </tbody>
        </table>
"@

        # Return it
        $SubnetSummaryHTML = "$HTMLSTART $HTMLTableColumn $HTMLTableRow $HTMLEND"                                  

        # ----------------------------------------------------------------------
        # Calculate percentages
        # ----------------------------------------------------------------------

        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        #Write-Output " [*][$Time] Generating Report:"
        
        # Set good/bad images
        $CheckBad  = '<img style="padding-top:5px;padding-left:20px;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAGPAAABjwEeLVWuAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAkVJREFUOI2FlLtLW3EUx78akiiCLuIgKBh1NzjEIQ4SRRShxRofiLOga/8FoakVxEUnFx91Egpurg6Kf0DS1lbULb6CV40PyKfD797eXO9Ne+As53fO597zlAIEKYI0gbSNlEO6tzVn28aRIkGxQbAPSL+QIBSCeBxGRox2dRmbBNIJ0ui/QCGkL0jQ1ATLy3B5iU/yeVhagsZGB7yIVB0ENLDBQbi99YPeytUVpFIONBOUJgwNwevr/2GOvLxAf78DfV/egBOam6FQcJ1PT2F11QsolSCT8WZwc2NKJP1GisjuJqytuU5nZ9DWZr68sODC5uaMLR6H62vXf2XF+cu0kL4SjcLdnXl8foaODsfBaCYDs7NeWyrlAgsFiERA2hTSD3p7vant7UE06gWUa0MDHB56Y3p6QMoJyWJ62l/wStAgGMD4OEiWmZ+qKv9gDg9LAwN++9SUlEj47aGQJJWE9J2+Pn835+crp+w0qlySSZCyQtqmthYeHirD6uogHK4MtSyoqQFpQ/aiw8aGeczn3ZFxanZ0BLu7XmgiYSYCYH3dsY8JKYz0k1gMikXjcH4O7e3+BjiN6u525/D+HlpbsQ9KxNmWUSRIp03KYIb7+Nhfq/19d6NKJZiYcP7u3dt9XkSCyUl4fPSD3kqxCDMzDuxT0LWpRvqMBJ2dsLPj1qhcnp5gawtisb+Xpvx8+QbQvhqLkjpUXy8lk1JLiwm9uJAODiTLkqQTSR+rpG/+ofRDw0hppE2kLJJla9a2jSGFg2L/AOl+fNdFEbGxAAAAAElFTkSuQmCC" />'
        $CheckGood = '<img style="padding-top:5px;padding-left:20px;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAACXBIWXMAAAGPAAABjwEeLVWuAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAudJREFUOI2Nld1LU3EYxz/nnLVJpCMKQ6eTNESCDCy6MXoznEKglZIYddFNF91GFxF1KojyLYVuutKcFMyQ7Q8IFkWtsBDfIip68QWbwnzbi1vb08Xcam6W37tznvP9nOf3+/F9fgqZpGNE4SRCHVABFKxWJoH3gBNwohNea1XSYDc5jdACFGuKRvmOciw5ljhtcZKRnyNEJQrwBbiCzkDGpnCgodOGjuS25kqnp1Nm/bOyVl6/V9pftcv2lu2CjqDTio6aaZlt6IjNbhNf0JcGWqu5wJxUPapKQO+lL1NHavtqJRKN/BeWUDgaluO9xxPQ+vge6hiB8fzs/JLxS+OYTebMW7KOfCEfZQ/K8Pq9X4EyFYWTQMn1w9c3BFtYWeCC6wJzgTkAtmZt5dqhawA7UahTEepNmonmPc0bgtnsNrqHuqnqrUpCz+89j1EzglCnAvsOWA6Qbcz+J2w+NE+1vZo3U28AGP45TMfrDgDMJjMVeRUA+1Ugz2q2ppj9ET+2Phuuj65kZzV9Nbydepv8pmF3A7eO3ko+rzIsBgBFUVJgJx6fwP3Njfubm576Hro8XcnOErAnp59gUA3Jd5qiAcQMwPTU4lRpojA0M4Rn0gNAOBrm7MBZROSfMICJxQmAaRV455n0EIgEAKgsrMTV5CLLkAWwIdhyeJnB6UGAQRVwBn8FGfjwJ5LVJdXcPnY7xVRkLsoIA+gf7yf0KwTggodsQudTcVexBCPBlCTceXFH0JGCjoK0WkLL4WWx3rcKOl9WQwLonEJHGh2NEovFUgz2Yfu6sFgsJmf6z8Sjd5O61L7jU0OanjZJIBL4b46DkaCcGziXyPHd5GkngUd4Bmwe9Y5WOsYc5G7JpXRbKZqqpfx3JbqCY8xBQ38Dz78/B2gBruJGINOAjU+NVmBXjimHg9aDFOYUIggTCxO8/PGSpfASwGcULnMD19/2dCDED2qG+tUrYB+pV8A7wEkeLi4SWWv9DTik/yQF2VYdAAAAAElFTkSuQmCC" />'        

        # top 5 shares
        $DupDec = $Top5ShareCountTotal / $AllAccessibleSharesCount
        $DupPercent = $DupDec.tostring("P")

        # Expected share count from know defaults
        $MinExpectedShareCount = $Computers445OpenCount * 2

        # Computer ping                      
        $PercentComputerPing = [math]::Round($ComputerPingableCount/$ComputerCount,4)
        $PercentComputerPingP = $PercentComputerPing.tostring("P") -replace(" ","")
        $PercentComputerPingBarVal = ($PercentComputerPing*2).tostring("P") -replace(" %","px")

        # Computer port 445 open              
        $PercentComputerPort = [math]::Round($Computers445OpenCount/$ComputerCount,4) 
        $PercentComputerPortP = $PercentComputerPort.tostring("P") -replace(" ","")
        $PercentComputerPortBarVal = ($PercentComputerPort*2).tostring("P") -replace(" %","")

        # Computer with share        
        $PercentComputerWitShare = [math]::Round($AllComputersWithSharesCount/$ComputerCount,4)
        $PercentComputerWitShareP = $PercentComputerWitShare.tostring("P") -replace(" ","")
        $PercentComputerWitShareBarVal = ($PercentComputerWitShare*2).tostring("P") -replace(" %","px")

        # Computer with non default shares   
        $PercentComputerNonDefault = [math]::Round($ComputerwithNonDefaultCount/$ComputerCount,4)
        $PercentComputerNonDefaultP = $PercentComputerNonDefault.tostring("P") -replace(" ","")
        $PercentComputerNonDefaultBarVal = ($PercentComputerNonDefault*2).tostring("P") -replace(" %","px")

        # Computer with excessive priv shares 
        $PercentComputerExPriv = [math]::Round($ComputerWithExcessive/$ComputerCount,4)
        $PercentComputerExPrivP = $PercentComputerExPriv.tostring("P") -replace(" ","")
        $PercentComputerExPrivBarVal = ($PercentComputerExPriv*2).tostring("P") -replace(" %","px")

        # Computer read share access       
        $PercentComputerRead = [math]::Round($ComputerWithReadCount/$ComputerCount,4)
        $PercentComputerReadP = $PercentComputerRead.tostring("P") -replace(" ","")
        $PercentComputerReadBarVal = ($PercentComputerRead*2).tostring("P") -replace(" %","px")
        if($PercentComputerRead -ne 0){
            $CheckStatusComputerR = $CheckBad
        }else{
            $CheckStatusComputerR = $CheckGood
        }

        # Computer write share access         
        $PercentComputerWrite = [math]::Round($ComputerWithWriteCount/$ComputerCount,4)
        $PercentComputerWriteP = $PercentComputerWrite.tostring("P") -replace(" ","")
        $PercentComputerWriteBarVal = ($PercentComputerWrite*2).tostring("P") -replace(" %","px")
        if($PercentComputerWrite -ne 0){
            $CheckStatusComputerW = $CheckBad
        }else{
            $CheckStatusComputerW = $CheckGood
        }

        # Computer highrisk shares            
        $PercentComputerHighRisk = [math]::Round($ComputerwithHighRisk/$ComputerCount,4)
        $PercentComputerHighRiskP = $PercentComputerHighRisk.tostring("P") -replace(" ","")
        $PercentComputerHighRiskBarVal = ($PercentComputerHighRisk*2).tostring("P") -replace(" %","px")
        if($PercentComputerHighRisk -ne 0){
            $CheckStatusComputerH = $CheckBad
        }else{
            $CheckStatusComputerH = $CheckGood
        }

        # Shares with non default names      
        $PercentSharesNonDefault = [math]::Round($SharesNonDefaultCount/$AllSMBSharesCount,4)
        $PercentSharesNonDefaultP = $PercentSharesNonDefault.tostring("P") -replace(" ","")
        $PercentSharesNonDefaultBarVal = ($PercentSharesNonDefault*2).tostring("P") -replace(" %","px")

        # Shares with excessive priv shares   
        $PercentSharesExPriv = [math]::Round($ExcessiveSharesCount/$AllSMBSharesCount,4)
        $PercentSharesExPrivP = $PercentSharesExPriv.tostring("P") -replace(" ","")
        $PercentSharesExPrivBarVal = ($PercentSharesExPriv*2).tostring("P") -replace(" %","px")

        # Shares with excessive read        
        $PercentSharesRead = [math]::Round($SharesWithReadCount/$AllSMBSharesCount,4)
        $PercentSharesReadP = $PercentSharesRead.tostring("P") -replace(" ","")
        $PercentSharesReadBarVal = ($PercentSharesRead*2).tostring("P") -replace(" %","px")
        if($PercentSharesRead -ne 0){
            $CheckStatusShareR = $CheckBad
        }else{
            $CheckStatusShareR = $CheckGood
        }

        # Shares with excessive write         
        $PercentSharesWrite = [math]::Round($SharesWithWriteCount/$AllSMBSharesCount,4) 
        $PercentSharesWriteP = $PercentSharesWrite.tostring("P") -replace(" ","")
        $PercentSharesWriteBarVal = ($PercentSharesWrite*2).tostring("P") -replace(" %","px")
        if($PercentSharesWrite -ne 0){
            $CheckStatusShareW = $CheckBad
        }else{
            $CheckStatusShareW = $CheckGood
        }

        # Shares with excessive highrisk      
        $PercentSharesHighRisk = [math]::Round($SharesHighRiskCount/$AllSMBSharesCount,4)
        $PercentSharesHighRiskP = $PercentSharesHighRisk.tostring("P") -replace(" ","")
        $PercentSharesHighRiskBarVal = ($PercentSharesHighRisk*2).tostring("P") -replace(" %","px")
        if($PercentSharesHighRisk -ne 0){
            $CheckStatusShareH = $CheckBad
        }else{
            $CheckStatusShareH = $CheckGood
        }

        # ACL with non default names          
        $PercentAclNonDefault = [math]::Round($AclNonDefaultCount/$ShareACLsCount,4)
        $PercentAclNonDefaultP = $PercentAclNonDefault.tostring("P") -replace(" ","")
        $PercentAclNonDefaultBarVal = ($PercentAclNonDefault*2).tostring("P") -replace(" %","px")

        # ACL with excessive priv shares      
        $PercentAclExPriv = [math]::Round($ExcessiveSharePrivsCount/$ShareACLsCount,4)
        $PercentAclExPrivP = $PercentAclExPriv.tostring("P") -replace(" ","")
        $PercentAclExPrivBarVal = ($PercentAclExPriv*2).tostring("P") -replace(" %","px")

        # ACL with excessive read           
        $PercentAclRead = [math]::Round($AclWithReadCount/$ShareACLsCount,4)
        $PercentAclReadP = $PercentAclRead.tostring("P") -replace(" ","")
        $PercentAclReadBarVal = ($PercentAclRead *2).tostring("P") -replace(" %","px")
        if($PercentAclRead -ne 0){
            $CheckStatusAclR = $CheckBad
        }else{
            $CheckStatusAclR = $CheckGood
        }

        # ACL with excessive write             
        $PercentAclWrite = [math]::Round($AclWithWriteCount/$ShareACLsCount,4)
        $PercentAclWriteP = $PercentAclWrite.tostring("P") -replace(" ","")
        $PercentAclWriteBarVal = ($PercentAclWrite *2).tostring("P") -replace(" %","px")
        if($PercentAclWrite -ne 0){
            $CheckStatusAclW = $CheckBad
        }else{
            $CheckStatusAclW = $CheckGood
        }

        # ACL with excessive highrisk
        $PercentAclHighRisk = [math]::Round($AclHighRiskCount/$ShareACLsCount,4)
        $PercentAclHighRiskP = $PercentAclHighRisk.tostring("P") -replace(" ","")
        $PercentAclHighRiskBarVal = ($PercentAclHighRisk *2).tostring("P") -replace(" %","px")
        if($PercentAclHighRisk  -ne 0){
            $CheckStatusAclH = $CheckBad
        }else{
            $CheckStatusAclH = $CheckGood
        }
        
        # ACE User: Everyone
        $AceEveryone = Get-UserAceCounts -DataTable $ExcessiveSharePrivs -UserName "everyone"
        $AceEveryoneAclCount = $AceEveryone.UserAclsCount 
        $AceEveryoneShareCount = $AceEveryone.UserShareCount 
        $AceEveryoneComputerCount = $AceEveryone.UserComputerCount 
        $AceEveryoneAclReadCount = $AceEveryone.UserReadAclCount
        $AceEveryoneAclWriteCount = $AceEveryone.UserWriteAclCount
        $AceEveryoneAclHRCount = $AceEveryone.UserHighRiskAclCount

	    $AceEveryoneAclP = Get-PercentDisplay -TargetCount $AceEveryoneComputerCount -FullCount $ComputerCount 
        $AceEveryoneAclPS = $AceEveryoneAclP.PercentString
        $AceEveryoneAclPB = $AceEveryoneAclP.PercentBarVal

        $AceEveryoneShareCountP = Get-PercentDisplay -TargetCount $AceEveryoneShareCount -FullCount $AllSMBSharesCount 
        $AceEveryoneShareCountPS = $AceEveryoneShareCountP.PercentString
        $AceEveryoneShareCountPB = $AceEveryoneShareCountP.PercentBarVal 
    
        $AceEveryoneComputerCountP = Get-PercentDisplay -TargetCount $AceEveryoneAclCount -FullCount $ShareACLsCount
        $AceEveryoneComputerCountPS = $AceEveryoneComputerCountP.PercentString
        $AceEveryoneComputerCountPB = $AceEveryoneComputerCountP.PercentBarVal 

        # ACE User: Users
        $AceUsers = Get-UserAceCounts -DataTable $ExcessiveSharePrivs -UserName "BUILTIN\Users"
        $AceUsersAclCount = $AceUsers.UserAclsCount 
        $AceUsersShareCount = $AceUsers.UserShareCount 
        $AceUsersComputerCount = $AceUsers.UserComputerCount         
        $AceUsersAclReadCount = $AceUsers.UserReadAclCount
        $AceUsersAclWriteCount = $AceUsers.UserWriteACLCount
        $AceUsersAclHRCount = $AceUsers.UserHighRiskACLCount

        $AceUsersAclP = Get-PercentDisplay -TargetCount $AceUsersComputerCount -FullCount $ComputerCount 
        $AceUsersAclPS = $AceUsersAclP.PercentString
        $AceUsersAclPB = $AceUsersAclP.PercentBarVal

        $AceUsersShareCountP = Get-PercentDisplay -TargetCount $AceUsersShareCount -FullCount $AllSMBSharesCount 
        $AceUsersShareCountPS = $AceUsersShareCountP.PercentString
        $AceUsersShareCountPB = $AceUsersShareCountP.PercentBarVal 
    
        $AceUsersComputerCountP = Get-PercentDisplay -TargetCount $AceUsersAclCount -FullCount $ShareACLsCount
        $AceUsersComputerCountPS = $AceUsersComputerCountP.PercentString
        $AceUsersComputerCountPB = $AceUsersComputerCountP.PercentBarVal 

        # ACE User: Authenticated Users
        $AceAuthenticatedUsers = Get-UserAceCounts -DataTable $ExcessiveSharePrivs -UserName "Authenticated Users"        
        $AceAuthenticatedUsersComputerCount = $AceAuthenticatedUsers.UserComputerCount 
        $AceAuthenticatedUsersShareCount    = $AceAuthenticatedUsers.UserShareCount 
        $AceAuthenticatedUsersAclCount      = $AceAuthenticatedUsers.UserAclsCount 
        $AceAuthenticatedUsersAclReadCount  = $AceAuthenticatedUsers.UserReadAclCount
        $AceAuthenticatedUsersAclWriteCount = $AceAuthenticatedUsers.UserWriteACLCount
        $AceAuthenticatedUsersAclHRCount    = $AceAuthenticatedUsers.UserHighRiskACLCount

        $AceAuthenticatedUsersAclP = Get-PercentDisplay -TargetCount $AceAuthenticatedUsersComputerCount -FullCount $ComputerCount 
        $AceAuthenticatedUsersAclPS = $AceAuthenticatedUsersAclP.PercentString
        $AceAuthenticatedUsersAclPB = $AceAuthenticatedUsersAclP.PercentBarVal

        $AceAuthenticatedUsersShareCountP = Get-PercentDisplay -TargetCount $AceAuthenticatedUsersShareCount -FullCount $AllSMBSharesCount 
        $AceAuthenticatedUsersShareCountPS = $AceAuthenticatedUsersShareCountP.PercentString
        $AceAuthenticatedUsersShareCountPB = $AceAuthenticatedUsersShareCountP.PercentBarVal 
            
        $AceAuthenticatedUsersComputerCountP = Get-PercentDisplay -TargetCount $AceAuthenticatedUsersAclCount -FullCount $ShareACLsCount
        $AceAuthenticatedUsersComputerCountPS = $AceAuthenticatedUsersComputerCountP.PercentString
        $AceAuthenticatedUsersComputerCountPB = $AceAuthenticatedUsersComputerCountP.PercentBarVal         

        # ACE User: Domain Users
        $AceDomainUsers = Get-UserAceCounts -DataTable $ExcessiveSharePrivs -UserName "Domain Users"
        $AceDomainUsersAclCount      = $AceDomainUsers.UserAclsCount 
        $AceDomainUsersShareCount    = $AceDomainUsers.UserShareCount 
        $AceDomainUsersComputerCount = $AceDomainUsers.UserComputerCount 
        $AceDomainUsersAclReadCount  = $AceDomainUsers.UserReadAclCount
        $AceDomainUsersAclWriteCount = $AceDomainUsers.UserWriteACLCount
        $AceDomainUsersAclHRCount    = $AceDomainUsers.UserHighRiskACLCount

	    $AceDomainUsersAclP = Get-PercentDisplay -TargetCount $AceDomainUsersComputerCount -FullCount $ComputerCount 
        $AceDomainUsersAclPS = $AceDomainUsersAclP.PercentString
        $AceDomainUsersAclPB = $AceDomainUsersAclP.PercentBarVal

        $AceDomainUsersShareCountP = Get-PercentDisplay -TargetCount $AceDomainUsersShareCount -FullCount $AllSMBSharesCount 
        $AceDomainUsersShareCountPS = $AceDomainUsersShareCountP.PercentString
        $AceDomainUsersShareCountPB = $AceDomainUsersShareCountP.PercentBarVal 
    
        $AceDomainUsersComputerCountP = Get-PercentDisplay -TargetCount $AceDomainUsersAclCount -FullCount $ShareACLsCount
        $AceDomainUsersComputerCountPS = $AceDomainUsersComputerCountP.PercentString
        $AceDomainUsersComputerCountPB = $AceDomainUsersComputerCountP.PercentBarVal 

        # ACE User: Domain Computers
        $AceDomainComputers = Get-UserAceCounts -DataTable $ExcessiveSharePrivs -UserName "Domain Computers"
        $AceDomainComputersAclCount = $AceDomainComputers.UserAclsCount 
        $AceDomainComputersShareCount = $AceDomainComputers.UserShareCount 
        $AceDomainComputersComputerCount = $AceDomainComputers.UserComputerCount
        $AceDomainComputersAclReadCount = $AceDomainComputers.UserReadAclCount
        $AceDomainComputersAclWriteCount = $AceDomainComputers.UserWriteACLCount
        $AceDomainComputersAclHRCount = $AceDomainComputers.UserHighRiskACLCount
        
	    $AceDomainComputersAclP = Get-PercentDisplay -TargetCount $AceDomainComputersComputerCount -FullCount $ComputerCount 
        $AceDomainComputersAclPS = $AceDomainComputersAclP.PercentString
        $AceDomainComputersAclPB = $AceDomainComputersAclP.PercentBarVal

        $AceDomainComputersShareCountP = Get-PercentDisplay -TargetCount $AceDomainComputersShareCount -FullCount $AllSMBSharesCount 
        $AceDomainComputersShareCountPS = $AceDomainComputersShareCountP.PercentString
        $AceDomainComputersShareCountPB = $AceDomainComputersShareCountP.PercentBarVal 
    
        $AceDomainComputersComputerCountP = Get-PercentDisplay -TargetCount $AceDomainComputersAclCount -FullCount $ShareACLsCount
        $AceDomainComputersComputerCountPS = $AceDomainComputersComputerCountP.PercentString
        $AceDomainComputersComputerCountPB = $AceDomainComputersComputerCountP.PercentBarVal     
        
        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        #Write-Output " [*][$Time] - Summary report data generated."                     
        #Write-Output " [*][$Time] - $Top5ShareCountTotal of $AllAccessibleSharesCount ($DupPercent) shares are associated with the top $SampleSum share names."

        # ----------------------------------------------------------------------
        # Create Interesting Files Table
        # ---------------------------------------------------------------------- 

        Write-Output " [*][$Time] Finding interesting files..."
               
        # Define common image and other formats to filter out later
        $ImageFormats = @("*.jpg", "*.jpeg", "*.png", "*.gif", "*.bmp", "*.ico", "*.svg", "*.webp", "*.mif", "*.heic", "*.msi")

        # Create data table to hold interesting file keywords
        $FileNamePatternsAll =  New-Object system.data.datatable 
        $FileNamePatternsAll.Columns.Add("Keyword")      | Out-Null # Keyword
        $FileNamePatternsAll.Columns.Add("Description")  | Out-Null # Summary of keyword.
        $FileNamePatternsAll.Columns.Add("Instructions") | Out-Null # Used to instruct testing how to attack match.
        $FileNamePatternsAll.Columns.Add("Category")     | Out-Null # File name category: Secret (password), sensitive (data), binaries, script, backup, database
        $FileNamePatternsAll.Columns.Add("SampleRegex")  | Out-Null # Used to parse sample data from file matches.

        # Add rows to data table - Sensitive data
        $FileNamePatternsAll.Rows.Add("*credit*","Credit card number and/or PII.","None.","Sensitive","")     | Out-Null
        $FileNamePatternsAll.Rows.Add("*pci*","","None.","Sensitive","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*social*","","None.","Sensitive","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("*ssn*","","None.","Sensitive","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("human*","","None.","Sensitive","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("finance*","","None.","Sensitive","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("*medical*","","None.","Sensitive","")                                  | Out-Null
        $FileNamePatternsAll.Rows.Add("Health*","","None.","Sensitive","")                                    | Out-Null
        $FileNamePatternsAll.Rows.Add("Billing*","","None.","Sensitive","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("*payment*","","None.","Sensitive","")                                  | Out-Null
        $FileNamePatternsAll.Rows.Add("patient*","","None.","Sensitive","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("HR*","","None.","Sensitive","")                                        | Out-Null        
        $FileNamePatternsAll.Rows.Add("*nessus*","This is a vulnerability scanner.","None.","Sensitive","")   | Out-Null
        $FileNamePatternsAll.Rows.Add("*nexpose*","This is a vulnerability scanner.","None.","Sensitive","")  | Out-Null
        $FileNamePatternsAll.Rows.Add("*qualys*","This is a vulnerability scanner.","None.","Sensitive","")   | Out-Null
        $FileNamePatternsAll.Rows.Add("*tripwire*","This is a vulnerability scanner.","None.","Sensitive","") | Out-Null
       
        # Add rows to data table - Files containing passwords
        $FileNamePatternsAll.Rows.Add("Bootstrap.ini*","Used for Windows Deployment services (WDS) PXE installation and may contain credentials.","None.","Secret","")                                 | Out-Null
        $FileNamePatternsAll.Rows.Add("*.bcd","","None.","Secret","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("context.xml*","","None.","Secret","")                                 | Out-Null
        $FileNamePatternsAll.Rows.Add("db2cli.ini*","","None.","Secret","")                                  | Out-Null
        $FileNamePatternsAll.Rows.Add("ftpd.*","","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("ftpusers*","","None.","Secret","")                                    | Out-Null
        $FileNamePatternsAll.Rows.Add("httpd.conf*","","None.","Secret","")                                  | Out-Null
        $FileNamePatternsAll.Rows.Add("hudson.security.HudsonPrivateSecurityRealm.*","","None.","Secret","") | Out-Null
        $FileNamePatternsAll.Rows.Add("jboss-cli.xml*","","None.","Secret","")                               | Out-Null
        $FileNamePatternsAll.Rows.Add("jboss-logmanager.properties*","","None.","Secret","")                 | Out-Null
        $FileNamePatternsAll.Rows.Add("jenkins.model.JenkinsLocationConfiguration.*","","None.","Secret","") | Out-Null
        $FileNamePatternsAll.Rows.Add("machine.config*","","None.","Secret","")                              | Out-Null
        $FileNamePatternsAll.Rows.Add("my.*","","None.","Secret","")                                         | Out-Null
        $FileNamePatternsAll.Rows.Add("mysql.user*","","None.","Secret","")                                  | Out-Null
        $FileNamePatternsAll.Rows.Add("nginx.conf*","","None.","Secret","")                                  | Out-Null
        $FileNamePatternsAll.Rows.Add("*ntds.dit*","","None.","Secret","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("pg_hba.conf*","","None.","Secret","")                                 | Out-Null
        $FileNamePatternsAll.Rows.Add("php.ini*","","None.","Secret","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*.pfx*","Private key.","None.","Secret","")                           | Out-Null
        $FileNamePatternsAll.Rows.Add("policy.xml*","May be associated with SCCM/ConfigMgr and contain credentials to support PXE that can be recovered, base64 decoded, or decrypted using PXEThief or https://github.com/1njected/CMvarDecrypt.","None.","Secret","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add(".pol*","May contain credentials to support PXE or other things.","None.","Secret","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("putty.reg*","","None.","Secret","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("postgresql.conf*","","None.","Secret","")                             | Out-Null
        $FileNamePatternsAll.Rows.Add("SAM","","None.","Secret","")                                          | Out-Null
        $FileNamePatternsAll.Rows.Add("SAM-*","","None.","Secret","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("SAM_*","","None.","Secret","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("SYSTEM","","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("server.xml*","","None.","Secret","")                                  | Out-Null
        $FileNamePatternsAll.Rows.Add("shadow*","","None.","Secret","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("standalone.xml*","","None.","Secret","")                              | Out-Null
        $FileNamePatternsAll.Rows.Add("tnsnames.ora*","","None.","Secret","")                                | Out-Null
        $FileNamePatternsAll.Rows.Add("tomcat-users.xml*","","None.","Secret","")                            | Out-Null
        $FileNamePatternsAll.Rows.Add("sitemanager.xml*","","None.","Secret","")                             | Out-Null
        $FileNamePatternsAll.Rows.Add("users.*","","None.","Secret","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*variable*.dat*","This file is used for SCCM/ConfigMgr PXE deployments. It may contain passwords that can be recovered, base64 decoded, or decrypted using PXEThief or https://github.com/1njected/CMvarDecrypt.","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.var*","Often contain credentials. May be assocaited with SCCM/MECM","None.","Secret","")             | Out-Null
        $FileNamePatternsAll.Rows.Add("*.sav*","","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*setting.ini*","","None.","Secret","")                                | Out-Null
        $FileNamePatternsAll.Rows.Add("*.pvm*","","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.pvs*","","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.qcow*","","None.","Secret","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.qcow2*","","None.","Secret","")                                     | Out-Null     
        $FileNamePatternsAll.Rows.Add("*vcenter*","","None.","Secret","")                                    | Out-Null
        $FileNamePatternsAll.Rows.Add("*vault*","","None.","Secret","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*DefaultAppPool*","","None.","Secret","")                             | Out-Null
        $FileNamePatternsAll.Rows.Add("*WinSCP.ini*","","None.","Secret","")                                 | Out-Null
        $FileNamePatternsAll.Rows.Add("*.kdbx","","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("wp-config.php*","","None.","Secret","")                               | Out-Null
        $FileNamePatternsAll.Rows.Add("*.config","","None.","Secret","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*.dtsx*","","None.","Secret","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.rdp*","","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.aws*","","None.","Secret","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*vnc.ini*","","None.","Secret","")                                    | Out-Null
        $FileNamePatternsAll.Rows.Add("*DataSource.xml*","Group policy file that may contain passwords.","None.","Secret","")                         | Out-Null
        $FileNamePatternsAll.Rows.Add("*ScheduledTasks.xml*","Group policy file that may contain passwords.","None.","Secret","")                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*Groups.xml*","Group policy file that may contain passwords.","None.","Secret","")                             | Out-Null
        $FileNamePatternsAll.Rows.Add("*Drives.xml*","Group policy file that may contain passwords.","None.","Secret","")                             | Out-Null
        $FileNamePatternsAll.Rows.Add("*unattend*","","None.","Secret","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("*sysprep*","","None.","Secret","")                                    | Out-Null
        $FileNamePatternsAll.Rows.Add("*.key","","None.","Secret","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("*.private","","None.","Secret","")                                    | Out-Null
        $FileNamePatternsAll.Rows.Add("*.pem","","None.","Secret","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("*.p12","","None.","Secret","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("*.pfx","","None.","Secret","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("*.crt","","None.","Secret","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("*.ppk","","None.","Secret","")                                        | Out-Null

        # Add rows to data table - System/VM Images
        $FileNamePatternsAll.Rows.Add("*.img*","","None.","SystemImage","")                                                                            | Out-Null
        $FileNamePatternsAll.Rows.Add("*.iso*","This is system image.It may contain passwords in Variables.dat, unattend.xml, and policy.xml files.","None.","SystemImage","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("*.wmi*","This is system image.It may contain passwords in Variables.dat, unattend.xml, and policy.xml files.","None.","SystemImage","")                                   | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vmx*","This is a virtual machine image file.","None.","SystemImage","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vmdk*","This is a virtual machine image file.","None.","SystemImage","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.nvram*","This is a virtual machine image file.","None.","SystemImage","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vmsd*","This is a virtual machine image file.","None.","SystemImage","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vmsn*","This is a virtual machine image file.","None.","SystemImage","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vmss*","This is a virtual memory file that could be used to recover data or System Images.","None.","SystemImage","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vmem*","This is a virtual memory file that could be used to recover data or System Images.","None.","SystemImage","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vhd*","This is a virtual machine image file.","None.","SystemImage","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vhdx*","This is a virtual machine image file.","None.","SystemImage","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.avhd*","This is a virtual machine image file.","None.","SystemImage","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.avhdx*","This is a virtual machine image file.","None.","SystemImage","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vsv*","This is a virtual memory file that could be used to recover data or SystemImages.","None.","SystemImage","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vbox*","This is a virtual machine image file.","None.","SystemImage","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vbox-prev*","This is a virtual machine image file.","None.","SystemImage","")                                 | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vdi*","This is a virtual machine image file.","None.","SystemImage","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.hdd*","This is a virtual machine image file.","None.","SystemImage","")                                       | Out-Null

        # Add rows to data table - Database files  
        $FileNamePatternsAll.Rows.Add("*database*","","None.","Database","")                                 | Out-Null
        $FileNamePatternsAll.Rows.Add("*.sql*","","None.","Database","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*.sqlite*","","None.","Database","")                                  | Out-Null
        $FileNamePatternsAll.Rows.Add("*.idf*","","None.","Database","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*.mdf*","","None.","Database","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*.ora*","","None.","Database","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*oracle*","","None.","Database","")                                   | Out-Null

        # Add rows to data table - Backup files
        $FileNamePatternsAll.Rows.Add("*.bak*","","None.","Backup","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.bkf*","","None.","Backup","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*backup*","","None.","Backup","")                                     | Out-Null
        $FileNamePatternsAll.Rows.Add("*.tar*","","None.","Backup","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.zip*","","None.","Backup","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("IT*","May contain IT department files","None.","Backup","")           | Out-Null

        # Add rows to data table - Scripts
        $FileNamePatternsAll.Rows.Add("*.ps1*","","None.","Script","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.psm1*","","None.","Script","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.bat*","","None.","Script","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.sh*","","None.","Script","")                                        | Out-Null
        $FileNamePatternsAll.Rows.Add("*.vbs*","","None.","Script","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.cmd*","","None.","Script","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.wsh*","","None.","Script","")                                       | Out-Null
        $FileNamePatternsAll.Rows.Add("*.wsf*","","None.","Script","")                                       | Out-Null

        # Add rows to data table - Binaries
        $FileNamePatternsAll.Rows.Add("*.dll","","None.","Binaries","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.exe","","None.","Binaries","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.msi","","None.","Binaries","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.jar","","None.","Binaries","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*.war","","None.","Binaries","")                                      | Out-Null
        $FileNamePatternsAll.Rows.Add("*Program Files*","This is an application directory.","None.","Binaries","") | Out-Null

        # Use keyword from define file instead
        if($FileKeywordsPath){
            $FileNamePatternsAllTest = import-csv "$FileKeywordsPath"

            $CheckFieldKeyword  =  $FileNamePatternsAllTest | gm | where name -like "keyword" | select name -ExpandProperty name
            $CheckFieldCategory =  $FileNamePatternsAllTest | gm | where name -like "category" | select name -ExpandProperty name
            if($CheckFieldKeyword -and $CheckFieldCategory){
                # File found and columns exist 
                $FileNamePatternsAll.Clear()
                $FileNamePatternsAll = $FileNamePatternsAllTest
            }else{
                # File columns do not exist
                # Do nothing and fail back to hard coded list
            }
        }

        # Get unqiue categories
        $FileNamePatternCategories      = $FileNamePatternsAll | select Category -Unique
        $FileNamePatternCategoriesCount = $FileNamePatternsAll | select Category -Unique | measure | select count -ExpandProperty count          

        # Generate chart categories - Individual rows
        # for each category - "var MyScriptsCount = countStringInDisplayedRows('Scripts');" 
        $ChartCategoryCatVars = $FileNamePatternCategories |
        foreach{
            $ChartCatGenCat = $_.category
            $ChartCatGenVar = "My"+ $ChartCatGenCat + "Count"
            "var $ChartCatGenVar = countStringInDisplayedRows('$ChartCatGenCat');"
        } 
        $ChartCategoryCatVarsFlat = $ChartCategoryCatVars -join "`n"

        # Generate chart categories - Category list
        # once -  categories: ['Sensitive', 'Secrets', 'Scripts'],
        $ChartCategoryCommas = ($FileNamePatternCategories | Select-Object -ExpandProperty category | ForEach-Object { "'$_'" }) -join ", "
        $ChartCategoryCat    = "categories: [$ChartCategoryCommas],"   
        $ChartCategoryCatDash    = "[$ChartCategoryCommas]" 
               
        # Generate chart categories -
        # once -  data: [MySensitiveCount, MySecretCount, MyScriptsCount] 
        $ChartCategoryCountFormat = ($FileNamePatternCategories | Select-Object -ExpandProperty category | ForEach-Object {"My"+ $_ + "Count"}) -join ", "
        $ChartCategoryDat         = "data: [$ChartCategoryCountFormat]"
        $ChartCategoryDatDash     = "[$ChartCategoryCountFormat]"

        # Get a list of file names from each folder group for the target share name
        $InterestingFilesAllFileNames = $ExcessiveSharePrivs | select FileList -Unique | foreach {$_.FileList -split "`r`n"} | Where-Object {$_ -ne ''} | foreach {$_.ToLower()}|  select -Unique
                        
        # Identify keyword matches in filenames
        $InterestingFilesAllMatches =  New-Object system.data.datatable 
        $InterestingFilesAllMatches.Columns.Add("FileName")  | Out-Null
        $InterestingFilesAllMatches.Columns.Add("Category")  | Out-Null 
        $FileNamePatternsAll | 
        foreach {
            $TargetKeywordValue       = $_.Keyword
            $TargetKeywordCategory    = $_.Category
            $InterestingFilesAllFileNames | 
            foreach {

                    if($_ -like "$TargetKeywordValue"){

                        # check if file has already been labeled
                        $CheckForFile = $InterestingFilesAllMatches | where Filename -like "$_" 
                        if(-not $CheckForFile){ 

                            # Add file
                           $InterestingFilesAllMatches.Rows.Add("$_","$TargetKeywordCategory")| Out-Null
                        }                 
                    }
            }
        }   
        
        # Query for a list of information for each file name match
        $InterestingFilesAllObjects =  $InterestingFilesAllMatches | 
        foreach{

            # Set variables
            $TargetFileNameValue           = $_.FileName
            $TargetCategoryValue           = $_.Category

            # Filter for records with the target file
            $TargetKeywordMatches = $ExcessiveSharePrivs | where FileList -like "*$TargetFileNameValue*" | select ComputerName,ShareName,SharePath -Unique

            # Extend object to include a unc path to file
            $TargetKeywordMatches | 
            foreach {

                # Select the propertity and make new ones
                $TargetKeywordComputer  = $_.ComputerName   
                $TargetKeywordShareName = $_.ShareName 
                $TargetKeywordSharePath = $_.SharePath
                $TargetKeywordUNCPath   = "$TargetKeywordSharePath\$TargetFileNameValue"
                $TargetKeywordCategory  = $TargetCategoryValue 

                # Create updated object
                $object = New-Object psobject
                $object | add-member noteproperty ComputerName            $TargetKeywordComputer
                $object | add-member noteproperty ShareName               $TargetKeywordShareName
                $object | add-member noteproperty SharePath               $TargetKeywordSharePath   
                $object | add-member noteproperty UncPath                 $TargetKeywordUNCPath
                $object | add-member noteproperty FileName                $TargetFileNameValue
                $object | add-member noteproperty Category                $TargetKeywordCategory

                # Return object
                $object 
            }
        } | select ComputerName,ShareName,SharePath,UncPath,FileName,Category -Unique  

        # For each category get the count and store the numbers in an array
        $IFCategoryList = ($FileNamePatternCategories | select Category -ExpandProperty Category |
        foreach {
            
            $CurrentCategory = $_
            #$InterestingFilesAllObjects | where Category -eq "$CurrentCategory" | select filename -Unique | measure | select count -ExpandProperty count #unique file name count vs all files
            $InterestingFilesAllObjects | where Category -eq "$CurrentCategory" | measure | select count -ExpandProperty count

        } | select | ForEach-Object { "'$_'" }) -join ", "
        $IFCategoryListCount = "[$IFCategoryList]"

        # Outbout objects to file
        $InterestingFilesAllObjects | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Shares-Interesting-Files.csv"            
        
        # Get secrets & sensitive counts for dashboard         
        $InterestingFilesAllObjectsSecretCount = $InterestingFilesAllObjects | where category -eq 'secret' | measure | select count -ExpandProperty count
        $InterestingFilesAllObjectsSensitiveCount = $InterestingFilesAllObjects | where category -eq 'sensitive' | measure | select count -ExpandProperty count

        # Get order list of interesting file names by count
        $InterestingFilesAllFilesCount    = $InterestingFilesAllObjects | measure | select count -ExpandProperty count 
        $InterestingFilesAllFilesCountU   = $InterestingFilesAllObjects | select filename -Unique | measure | select count -ExpandProperty count 
        $InterestingFilesAllFilesGrouped  = $InterestingFilesAllObjects | group filename | select count,name | sort count -Descending

        # Generate a row for each one
        # Headers are Instance Count, FileName, Type, File Paths,Affected Computers, Affected Shares
        $InterestingFilesAllFilesRows = $InterestingFilesAllFilesGrouped | 
        foreach{
            
            # Get count
            $IfFinalCount = $_.count

            # Get File Name
            $IfFinalName = $_.name

            # Category 
            $IfFinalType = $InterestingFilesAllObjects | Where-Object { $_.FileName -like "$IfFinalName" } | select Category -First 1 -ExpandProperty Category

            # Get File Paths
            $IfFinalPaths = $InterestingFilesAllObjects | Where-Object { $_.FileName -like "$IfFinalName" } | ForEach-Object { $ASDF = $_.UncPath; "$ASDF<br>" } | Out-String

            # Get Share Count for Name
            # <td>$IfFinalShareCount</td>
            $IfFinalShareCount =  $InterestingFilesAllObjects   | Where-Object { $_.FileName -like "$IfFinalName" } | select SharePath -Unique  | measure | select count -ExpandProperty count

            # Get Computer Count for Name
            # <td>$IfFinalcomputerCount</td>
            $IfFinalcomputerCount = $InterestingFilesAllObjects | Where-Object { $_.FileName -like "$IfFinalName" } | select ComputerName -Unique   | measure | select count -ExpandProperty count
                
            # Create Row  
             
            $IfRow = @"
            <tr>
                <td>$IfFinalCount</td>
                <td>$IfFinalName</td>
                <td>$IfFinalType</td>
                <td>
                    <button class="collapsible">$IfFinalCount Files</button>
                    <div class="content">
                    $IfFinalPaths
                    </div>
                </td>
            </tr>
"@

            # Return row
            $IfRow 
        }  
        
        # ----------------------------------------------------------------------
        # Calculate risk score per acl - ACE INSIGHTS 
        # ---------------------------------------------------------------------- 
        # add interesting file flags
        # add risk score 
        # create table for later use
        # output table to file 
        
        # foreach acl update the record 
        $ExcessiveSharePrivsFinal = $ExcessiveSharePrivs  |
        foreach {

            # Get variables
            $myAccessControlType    = $_.AccessControlType
            $myAuditSettings        = $_.AuditSettings
            $myComputerName         = $_.ComputerName
            $myCreationDate         = $_.CreationDate
            $myCreationDateYear     = $_.CreationDateYear
            $myFileCount            = $_.FileCount
            $myFileList             = $_.FileList
            $myFileListGroup        = $_.FileListGroup
            $myFileSystemRights     = $_.FileSystemRights
            $myIdentityReference    = $_.IdentityReference
            $myIdentitySID          = $_.IdentitySID
            $myIpAddress            = $_.IpAddress
            $myLastAccessDate       = $_.LastAccessDate
            $myLastAccessDateYear   = $_.LastAccessDateYear
            $myLastModifiedDate     = $_.LastModifiedDate
            $myLastModifiedDateYear = $_.LastModifiedDateYear
            $myShareAccess          = $_.ShareAccess
            $myShareDescription     = $_.ShareDescription
            $myShareName            = $_.ShareName
            $myShareOwner           = $_.ShareOwner
            $mySharePath            = $_.SharePath
            $myShareType            = $_.ShareType            

            # select interesting files, get categories, compress into one line   
            # pending                      
            
            # parse data for risk score              
            $ShareNameRiskValue                        = 0
            $ShareRowHasRCE                            = ""
            $ShareRowHasHighRisk                       = ""                                                  
            $ShareRowHasWrite                          = ""              
            $ShareRowHasRead                           = ""                      
            $ShareRowHasEmpty                          = ""         
            $ShareRowHasStale                          = ""
            $ShareRowCountInterestingData              = ""           
            $ShareRowInterestingFileListDataCount      = ""          
            $ShareRowCountInterestingSecrets           = ""    
            $ShareRowInterestingFileListDataCount      = "" 
            $ShareRowNonDefault                        = ""
            
            # Check for RCE conditions            
            if((($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share')) -and (($myFileSystemRights -like "*GenericAll*") -or ($myFileSystemRights -like "*Write*") -or ($myFileSystemRights -like "*Create*")-and ($myAccessControlType  -eq "Allow")))
            {
                $ShareRowHasRCE = 1
            }else{
                $ShareRowHasRCE = 0
            }

            # Check for potential read based RCE conditions
            if(($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share'))
            {
                $ShareRowHasHighRisk = 1
            }else{
                $ShareRowHasHighRisk = 0
            }

            # Determine if write
            if(($myFileSystemRights -like "*GenericAll*") -or ($myFileSystemRights -like "*Write*") -or ($myFileSystemRights -like "*Create*") -or ($myFileSystemRights -like "*Addfile*") -or ($myFileSystemRights -like "*AppendData*") -or ($myFileSystemRights -like "*Delete*") -and ($myAccessControlType  -eq "Allow"))
            {
                $ShareRowHasWrite = 1
            }else{
                $ShareRowHasWrite = 0
            }

            # Determine if read
            if(($myFileSystemRights -like  "*read*"))
            {
                $ShareRowHasRead = 1
            }else{
                $ShareRowHasRead = 0
            }

            # Determine if empty
            if($_.FileCount -eq 0){
                $ShareRowHasEmpty = 1
            }else{
                $ShareRowHasEmpty = 0
            }

            # Determine if stale
            try{                                
                $oneYearAgo = (Get-Date).AddYears(-1)                            
                if($_.LastModifiedDate -ge $oneYearAgo){
                   $ShareRowHasStale = 1
                }else{
                   $ShareRowHasStale = 0
                }
            }catch{
                $ShareRowHasStale = 0          
            }

            # Determine if default
            if(($_.ShareName -like 'admin$') -or ($_.ShareName -like 'c$') -or ($_.ShareName -like 'd$') -or ($_.ShareName -like 'e$') -or ($_.ShareName -like 'f$')){
                $ShareRowDefault = 1
            }else{
                $ShareRowDefault = 0
            }

            # Determine number and type of interesting files - secrets
            try{
                $MySecretsCount = $InterestingFilesAllObjects | where SharePath -like "$mySharePath" | where Category -like 'Secret' | measure | select count -ExpandProperty count
                if($MySecretsCount -gt 0){
                    $ShareRowCountInterestingSecrets = 1
                }else{
                    $ShareRowCountInterestingSecrets = 0
                }
            }catch{
            }

            # Determine number and type of interesting files - sensitive
            try{
                $MySensitiveCount = $InterestingFilesAllObjects | where SharePath -like "$mySharePath" | where Category -like 'Sensitive' | measure | select count -ExpandProperty count
                if($MySensitiveCount -gt 0){
                    $ShareRowCountInterestingData = 1
                }else{
                    $ShareRowCountInterestingData = 0
                }
            }catch{
            }

            # categories = $FileNamePatternCategories | Select-Object -ExpandProperty category
            
            # Set wieghts
            $RiskWeightRCE             = 2
            $RiskWeightHR              = 9 # Potential RCE - no write access
            $RiskWeightData            = 8
            $RiskWeightDataVolume      = 1
            $RiskWeightSecrets         = 2
            $RiskWeightSecretsVolume   = 1
            $RiskWeightWrite           = 4
            $RiskWeightRead            = 3    
            $RiskWeightEmpty           = -1
            $RiskWeightStale           = -1

            # Calculate Risk Score
            $ShareNameRiskValue = 0
            if($ShareRowHasRCE                          -eq  1){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightRCE           } # RCE
            if($ShareRowHasHighRisk                     -eq  1){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightHR            } # Potential RCE
            if($ShareRowCountInterestingData            -eq  1){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightData          } # Potential Sensitive Data 
            if($MySensitiveCount                        -gt 10){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightDataVolume    } # Potential Sensitive Data Volume            
            if($ShareRowCountInterestingSecrets         -eq  1){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightSecrets       } # Potential Password Access 
            if($MySecretsCount                          -gt 10){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightSecretsVolume } # Potential Sensitive Data Volume 
            if($ShareRowHasWrite                        -eq  1){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightWrite         } # Write Access          
            if($ShareRowHasRead                         -eq  1){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightRead          } # Read Access                          
            if($ShareRowHasEmpty                        -eq  1){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightEmpty         } # Empty Folders
            if($ShareRowHasStale                        -eq  1){ $ShareNameRiskValue =  $ShareNameRiskValue + $RiskWeightStale         } # Stake Folders           

            # Check risk level - Highest wins
            If($ShareNameRiskValue  -le 4                                    ) { $RiskLevel = "Low"}  
            If($ShareNameRiskValue  -gt 4  -and $ShareNameRiskValue -lt 11   ) { $RiskLevel = "Medium"}
            If($ShareNameRiskValue  -ge 11 -and $ShareNameRiskValue -lt 20   ) { $RiskLevel = "High"}   
            If($ShareNameRiskValue  -ge 20                                   ) { $RiskLevel = "Critical"}  

            # Append new column to object
            $newObject = [PSCustomObject]@{
                ComputerName           = $myComputerName
                IpAddress              = $myIpAddress
                ShareName              = $myShareName
                SharePath              = $mySharePath
                ShareType              = $myShareType
                ShareDescription       = $myShareDescription
                ShareOwner             = $myShareOwner
                FileCount              = $myFileCount
                FileList               = $myFileList
                FileListGroup          = $myFileListGroup
                FileSystemRights       = $myFileSystemRights
                ShareAccess            = $myShareAccess
                IdentityReference      = $myIdentityReference
                IdentitySID            = $myIdentitySID                
                AccessControlType      = $myAccessControlType
                AuditSettings          = $myAuditSettings
                CreationDate           = $myCreationDate
                CreationDateYear       = $myCreationDateYear
                LastAccessDate         = $myLastAccessDate
                LastAccessDateYear     = $myLastAccessDateYear
                LastModifiedDate       = $myLastModifiedDate
                LastModifiedDateYear   = $myLastModifiedDateYear
                HasRead                = $ShareRowHasRead 
                HasWrite               = $ShareRowHasWrite
                HasHR                  = $ShareRowHasHighRisk 
                HasRCE                 = $ShareRowHasRCE
                HasIF                  = $ShareRowCountInterestingData
                HasSecrets             = $ShareRowCountInterestingSecrets
                IsEmpty                = $ShareRowHasEmpty
                IsStale                = $ShareRowHasStale
                IsDefault              = $ShareRowDefault
                RiskScore              = $ShareNameRiskValue
                RiskLevel              = $RiskLevel
                IFListColumn           = "" # this should be a list of all columns with a 0 or 1, grab category list from above
            }

            # Return object
            $newObject                                            
        }  

        # Output new table that include interesting files, risk, read, write, hr, stale, and empty tags
        $ExcessiveSharePrivsFinal | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Shares-Inventory-Excessive-Privileges-New.csv"
        
        # Get severity level counts
        $RiskLevelCountLow      = $ExcessiveSharePrivsFinal | where RiskLevel -eq 'Low'      | measure | select count -ExpandProperty count
        $RiskLevelCountMedium   = $ExcessiveSharePrivsFinal | where RiskLevel -eq 'Medium'   | measure | select count -ExpandProperty count 
        $RiskLevelCountHigh     = $ExcessiveSharePrivsFinal | where RiskLevel -eq 'High'     | measure | select count -ExpandProperty count 
        $RiskLevelCountCritical = $ExcessiveSharePrivsFinal | where RiskLevel -eq 'Critical' | measure | select count -ExpandProperty count  

        # Create table for ACEs page
        $AceTableRows = $ExcessiveSharePrivsFinal | 
        foreach {

            # Risk Level
            $AceRowRiskScore = $_.RiskScore
            $AceRowRiskLevel = $_.RiskLevel

                # Read
                $AceRowHasRead  = $_.HasRead

                # Write 
                $AceRowHasWrite = $_.HasWrite

                # HR 
                $AceRowHasHR    = $_.HasHR

                # RCE
                $AceRowHasRCE   = $_.HasRCE

                # Has sesntive secrests 
                $AceRowHasSecrets = $_.HasSecrets

                # Has sesntive data
                $AceRowHasIF = $_.HasIF

            # Computer
            $AceRowComputer   = $_.ComputerName

            # Share Name
            $AceRowShareName  = $_.ShareName

            # Share Path
            $AceRowSharePath  = $_.SharePath

            # ACE
            $AceRowACE        = $_.FileSystemRights

            # Identity
            $AceRowIdentity   = $_.IdentityReference

            # Share Owner
            $AceRowShareOwner = $_.ShareOwner          

            # Created
            $AceRowCreated    = $_. CreationDate

            # Modified 
            $AceRowModified   = $_.LastModifiedDate

            # Files 
            $AceRowFilecount     = $_.FileCount
            $AceRowFileList      = $_.FileList -split "`r`n" | ForEach-Object { $ASDF = $_; "$ASDF<br>" } | Out-String 

            $AceRow = @"
                <tr>
                    <td style="width: 100px;">$AceRowRiskScore $AceRowRiskLevel</td> <!-- Risk Level  -->
                    <td>$AceRowComputer </td> <!-- Computer    -->
                    <td>
                        <a href="$AceRowSharePath" style="text-decoration:none;">$AceRowShareName</a>
                        <div class="content" style="font-size: 10px; width:100px; overflow-wrap: break-word;">
		                $AceRowSharePath
		                </div>
                    </td> <!-- Share Name  -->
                    <td>$AceRowACE      </td> <!-- ACE         -->
                    <td>$AceRowIdentity </td> <!-- Identity    -->
                    <td>$AceRowShareOwner</td> <!-- Share Owner -->
                    <td>$AceRowCreated   </td> <!-- Created     -->
                    <td>$AceRowModified  </td> <!-- Modified    -->
                    <td><!-- Files    -->                    
                        <button class="collapsible"  style="font-size: 10px;">$AceRowFilecount  Files</button>
 		                <div class="content" style="font-size: 10px; width:100px; overflow-wrap: break-word;">
		                $AceRowFileList
		                </div>
                    </td> 
                </tr>
"@
            # Return row
            $AceRow             
        }

        #
        # Build ACE summary
        #

        # Get unique filesystemright Names
        $UniqueFileSystemRights = (($ExcessiveSharePrivsFinal | Select FileSystemRights -Unique -ExpandProperty FileSystemRights | Sort)  -split("/")) -split(",") | select -Unique | sort

        # Create structure for chart categories
        $UniqueFileSystemRightsNames = ""
        $UniqueFileSystemRightsCategories = "'" + ($UniqueFileSystemRights -join("','") ) + "'"

        # Get count for each system right
        $UniqueFileSystemRightsCounts = $UniqueFileSystemRights | 
        foreach {
            
            # Set target right
            $TargetFileSystemRight = $_

            # Get count for filesystemright
            $TargetFileSystemRightCount = $ExcessiveSharePrivsFinal | where FileSystemRights -like "*$TargetFileSystemRight*" | measure | select count -ExpandProperty count

            # Append to end of string
           $TargetFileSystemRightCount + " "
        }

        # Create structure for chart series data 
        $UniqueFileSystemRightsSeries = "[" + ($UniqueFileSystemRightsCounts -replace(" ",",")) + "]"
        $UniqueFileSystemRightsSeries = $UniqueFileSystemRightsSeries -replace(" ",",")

        # ----------------------------------------------------------------------
        # Create Identity Insight Summary Information
        # ---------------------------------------------------------------------- 

        # Get share owners 
        [array]$IdentityOwnerList      = $ExcessiveSharePrivsFinal | select ShareOwner -Unique -ExpandProperty ShareOwner
        $IdentityOwnerListCount        = $IdentityOwnerList | measure | select count -ExpandProperty count 

        # Get identity references
        [array]$IdentityReferenceList  = $ExcessiveSharePrivsFinal | select IdentityReference -Unique -ExpandProperty IdentityReference
        $IdentityReferenceListCount    = $IdentityReferenceList  | measure | select count -ExpandProperty count 

        # Combine identity lists
        [array]$IdentityCombinedList   = $IdentityOwnerList + $IdentityReferenceList | sort | select -Unique
        $IdentityCombinedListCount     = $IdentityCombinedList | measure | select count -ExpandProperty count 

        # Process each identity
        $IdentityTableRows = $IdentityCombinedList |
        foreach {           

            # Set target identity
            $TargetIdentity = $_

            # Get share owner count
            $TargetIdentityOwnerCount        = $ExcessiveSharePrivsFinal | where ShareOwner -eq "$TargetIdentity" | select SharePath | measure | select count -ExpandProperty count 

            # Get share access count
            $TargetIdentityShareAccessCount  = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | select SharePath -Unique | measure | select count -ExpandProperty count 
            $TargetIdentityShareAccess       = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | select SharePath -Unique -ExpandProperty SharePath | ForEach-Object { $ASDF = $_; "$ASDF<br>" } | Out-String  

            # Get ACE low risk
            $TargetIdentityLowRiskCount      = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | where RiskLevel -eq "Low" | select SharePath -Unique |measure | select count -ExpandProperty count     
            #$TargetIdentityLowRisk           = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | where RiskLevel -eq "Low" | select SharePath -Unique | ForEach-Object { $ASDF = $_; "$ASDF<br>" } | Out-String 

            # Get ACE medium risk
            $TargetIdentityMediumRiskrCount  = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | where RiskLevel -eq "Medium" | select SharePath -Unique | measure | select count -ExpandProperty count 
            #$TargetIdentityMediumRisk        = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | where RiskLevel -eq "Medium" | select SharePath -Unique | ForEach-Object { $ASDF = $_; "$ASDF<br>" } | Out-String 

            # Get ACE high risk
            $TargetIdentityHighRiskCount     = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | where RiskLevel -eq "High" | select SharePath -Unique | measure | select count -ExpandProperty count 
            #$TargetIdentityHighRisk          = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | where RiskLevel -eq "High" | select SharePath -Unique | ForEach-Object { $ASDF = $_; "$ASDF<br>" } | Out-String 

            # Get ACE critical risk
            $TargetIdentityCriticalRiskCount = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | where RiskLevel -eq "Critical" | select SharePath -Unique | measure | select count -ExpandProperty count 
            #$TargetIdentityCriticalRisk      = $ExcessiveSharePrivsFinal | where IdentityReference -eq "$TargetIdentity" | where RiskLevel -eq "Critical" | select SharePath -Unique | ForEach-Object { $ASDF = $_; "$ASDF<br>" } | Out-String 

            # Get interesting files count (same as share names)
            $TargetIdentityInterestingFiles  = "tbd"

            $BuildIdentityTableRows = @"
             <tr>
                <td>$TargetIdentity</td>
                <td>$TargetIdentityOwnerCount</td>
                <td>
                    <button class="collapsible" style="text-align:left;">$TargetIdentityShareAccessCount</button>
                    <div class="content" style="font-size: 10px; width:100px; overflow-wrap: break-word;">
                    $TargetIdentityShareAccess
                    </div>               
                </td>
                <td>$TargetIdentityLowRiskCount</td>
                <td>$TargetIdentityMediumRiskrCount</td>
                <td>$TargetIdentityHighRiskCount</td>
                <td>$TargetIdentityCriticalRiskCount </td>
             </tr>
"@
            $BuildIdentityTableRows
        }


        # ----------------------------------------------------------------------
        # Create Computer Insight Summary Information & Table Rows
        # ---------------------------------------------------------------------- 

        # Reset global computer risk levels
        $RiskLevelComputersCountCritical = 0
        $RiskLevelComputersCountHigh     = 0
        $RiskLevelComputersCountMedium   = 0
        $RiskLevelComputersCountLow      = 0

        # Rest row data
        $ComputerTableRows = ""
        $ComputerTableRow  = ""

        # Get computer list
        $ComputerPageComputerList = $ExcessiveSharePrivsFinal | select ComputerName -Unique

        # Get computer count
        $ComputersChartCount      = $ComputerPageComputerList | measure | select count -ExpandProperty count # Unique folder group

        # Process each computer & add data to final risk counts
        $ComputerPageComputerList |
        foreach {
             
             # Set target share name
             $TargetComputers = $_.ComputerName

             # Grab the risk level for the highest risk acl for the computer name 
             $ComputersTopACLRiskScore = $ExcessiveSharePrivsFinal | where ComputerName -eq $TargetComputers  | select RiskScore | sort RiskScore -Descending | select -First 1  | select RiskScore -ExpandProperty RiskScore

             # Check risk level - Highest wins
             If($ComputersTopACLRiskScore -le 4                                          ) { $RiskLevelComputersResult = "Low"}
             If($ComputersTopACLRiskScore -gt 4  -and $ComputersTopACLRiskScore -lt 11   ) { $RiskLevelComputersResult = "Medium"} 
             If($ComputersTopACLRiskScore -ge 11 -and $ComputersTopACLRiskScore -lt 20   ) { $RiskLevelComputersResult = "High"}     
             If($ComputersTopACLRiskScore -ge 20                                         ) { $RiskLevelComputersResult = "Critical"}   
             
             # Increment counts
             if($RiskLevelComputersResult -eq "Low"     ){$RiskLevelComputersCountLow      = $RiskLevelComputersCountLow      + 1}
             if($RiskLevelComputersResult -eq "Medium"  ){$RiskLevelComputersCountMedium   = $RiskLevelComputersCountMedium   + 1}
             if($RiskLevelComputersResult -eq "High"    ){$RiskLevelComputersCountHigh     = $RiskLevelComputersCountHigh     + 1}
             if($RiskLevelComputersResult -eq "Critical"){$RiskLevelComputersCountCritical = $RiskLevelComputersCountCritical + 1} 
             
             # Get share count         
             $ComputerPageShares     = $ExcessiveSharePrivsFinal | where ComputerName -eq $TargetComputers | select SharePath -Unique | ForEach-Object { $ASDF = $_.SharePath; "$ASDF<br>" }  | out-string 
             $ComputerPageShareCount = $ExcessiveSharePrivsFinal | where ComputerName -eq $TargetComputers | select SharePath -Unique | measure | select count -ExpandProperty count 
             $ComputerPageShareCountHTML = @"
             <button class="collapsible" style="text-align:left;">$ComputerPageShareCount</button>
             <div class="content" style="font-size: 10px; width:100px; overflow-wrap: break-word;">
             $ComputerPageShares
             </div>
"@
             # Check for interesting files 
         	 # For each file category generate count and list
	         $ComputerPageInterestingFilesInsideHTML  = ""
             $ComputerPageInterestingFilesOutsideHTML = ""
	         $FileNamePatternCategories | select Category -ExpandProperty Category | 
	         foreach{
		
		        # Get category
		        $ComputerPageCategoryName = $_

		        # Get list of that sharename and category
                $ComputerPageCategoryFilesBase = $InterestingFilesAllObjects | where ComputerName -eq $TargetComputers |  where Category -eq "$ComputerPageCategoryName" | select FileName
		        $ComputerPageCategoryFiles     = $InterestingFilesAllObjects | where ComputerName -eq $TargetComputers |  where Category -eq "$ComputerPageCategoryName" | select FileName | ForEach-Object { $ASDF = $_.FileName; "$ASDF<br>" }  | out-string

		        # Get category count
		        $ComputerPageCategoryFilesCount =  $ComputerPageCategoryFilesBase | measure | select count -expandproperty count 

		        # Generate HTML with Category
                if($ComputerPageCategoryFilesCount -ne 0){
		            $ComputerPageInterestingFilesHTMLPrep = @" 
                        <button class="collapsible" style="font-size: 10px;">$ComputerPageCategoryFilesCount $ComputerPageCategoryName</button>
 		                <div class="content" style="font-size: 10px; width:100px; overflow-wrap: break-word;">
		                $ComputerPageCategoryFiles
		                </div>
"@
		            # Add to code block
		            $ComputerPageInterestingFilesInsideHTML = $ComputerPageInterestingFilesInsideHTML + $ComputerPageInterestingFilesHTMLPrep
                }
	         }

             # Get total for interesting files for target share name
	         $ComputerPageInterestingFilesCount = $InterestingFilesAllObjects | where ComputerName -eq $TargetComputers | measure | select count -expandproperty count 
       
             # Build final interesting file html for computers page
	         $ComputerPageInterestingFilesOutsideHTML = @"
		        <button class="collapsible"  style="font-size: 10px;">$ComputerPageInterestingFilesCount Files</button>
 		        <div class="content" style="font-size: 10px; width:100px; overflow-wrap: break-word;">
		        $ComputerPageInterestingFilesInsideHTML
		        </div>
"@
             
             # Create Row
             $ComputerTableRow = @"
             <tr>
                <td>$TargetComputers</td>
                <td>$ComputersTopACLRiskScore $RiskLevelComputersResult</td>
                <td>$ComputerPageShareCountHTML</td>
                <td>$ComputerPageInterestingFilesOutsideHTML</td>
             </tr>
"@                      

            # Add row to rows    
            $ComputerTableRows = $ComputerTableRows + $ComputerTableRow  
        }

        # ----------------------------------------------------------------------
        # Create Share Summary Information
        # ---------------------------------------------------------------------- 
        
        # Get share path count
        $SharePathChartCount       = $ExcessiveSharePrivsFinal | where SharePath -ne "" | 
        foreach{
            if( ($_.sharename -ne 'SYSVOL') -and ($_.sharename -ne 'NETLOGON'))
            {
                $_                
            }
        } | select SharePath -Unique |  measure | select count -ExpandProperty count  

        # Get share path severity
        # Reivew ACLs for each share path, highest severity wins
        $RiskLevelSharePathCountCritical = 0
        $RiskLevelSharePathCountHigh     = 0
        $RiskLevelSharePathCountMedium   = 0
        $RiskLevelSharePathCountLow      = 0
        $ExcessiveSharePrivsFinal | where SharePath -ne "" |
        foreach{

            # filter out sysvol and netlogon
            if( ($_.SharePath -ne 'SYSVOL') -and ($_.SharePath -ne 'NETLOGON'))
            {
                $_                
            }
        } | select SharePath -Unique |
        foreach {
             
             # Set target share name
             $TargetRiskSharePath = $_.SharePath

             # Grab the risk level for the highest risk acl for the share name
             $SharePathTopACLRiskScore = $ExcessiveSharePrivsFinal | where SharePath -eq $TargetRiskSharePath | select RiskScore | sort RiskScore -Descending | select -First 1  | select RiskScore -ExpandProperty RiskScore

             # Check risk level - Highest wins
             If($SharePathTopACLRiskScore -le 4                                          ) { $RiskLevelSharePathResult = "Low"}
             If($SharePathTopACLRiskScore -gt 4  -and $SharePathTopACLRiskScore -lt 11   ) { $RiskLevelSharePathResult = "Medium"} 
             If($SharePathTopACLRiskScore -ge 11 -and $SharePathTopACLRiskScore -lt 20   ) { $RiskLevelSharePathResult = "High"}     
             If($SharePathTopACLRiskScore -ge 20                                         ) { $RiskLevelSharePathResult = "Critical"}   
             
             # Increment counts
             if($RiskLevelSharePathResult -eq "Low"     ){$RiskLevelSharePathCountLow      = $RiskLevelSharePathCountLow      + 1}
             if($RiskLevelSharePathResult -eq "Medium"  ){$RiskLevelSharePathCountMedium   = $RiskLevelSharePathCountMedium   + 1}
             if($RiskLevelSharePathResult -eq "High"    ){$RiskLevelSharePathCountHigh     = $RiskLevelSharePathCountHigh     + 1}
             if($RiskLevelSharePathResult -eq "Critical"){$RiskLevelSharePathCountCritical = $RiskLevelSharePathCountCritical + 1}                         
        }        

        # Counts
        <#
        $RiskLevelSharePathCountLow
        $RiskLevelSharePathCountMedium
        $RiskLevelSharePathCountHigh 
        $RiskLevelSharePathCountCritical
        #>

        # ----------------------------------------------------------------------
        # Create Share Name Summary Information
        # ----------------------------------------------------------------------  

        # Get unique share name count
        $ShareNameChartCount       = $ExcessiveSharePrivsFinal | where ShareName -ne "" | select ShareName -Unique | 
        foreach{
            if( ($_.sharename -ne 'SYSVOL') -and ($_.sharename -ne 'NETLOGON'))
            {
                $_                
            }
        } | measure | select count -ExpandProperty count  

        # Get unique share count
        $ShareNameChartCountUnique = $ExcessiveSharePrivsFinal | where ShareName -ne "" | 
        foreach{
            if( ($_.SharePath -notlike "\*SYSVOL") -and ($_.SharePath -notlike"\*NETLOGON"))
            {
                $_                
            }
        } | select SharePath -Unique | measure | select count -ExpandProperty count 

        # Get share name severity
        # Reivew ACLs for each share name, highest severity wins
        $RiskLevelShareNameCountCritical = 0
        $RiskLevelShareNameCountHigh     = 0
        $RiskLevelShareNameCountMedium   = 0
        $RiskLevelShareNameCountLow      = 0
        $ExcessiveSharePrivsFinal | where ShareName -ne "" |
        foreach{

            # filter out sysvol and netlogon
            if( ($_.sharename -ne 'SYSVOL') -and ($_.sharename -ne 'NETLOGON'))
            {
                $_                
            }
        } | select ShareName -Unique |
        foreach {
             
             # Set target share name
             $TargetRiskShareName = $_.ShareName

             # Grab the risk level for the highest risk acl for the share name
             $ShareNameTopACLRiskScore = $ExcessiveSharePrivsFinal | where ShareName -eq $TargetRiskShareName | select RiskScore | sort RiskScore -Descending | select -First 1  | select RiskScore -ExpandProperty RiskScore

             # Check risk level - Highest wins
             If($ShareNameTopACLRiskScore -le 4                                          ) { $RiskLevelShareNameResult = "Low"}
             If($ShareNameTopACLRiskScore -gt 4  -and $ShareNameTopACLRiskScore -lt 11   ) { $RiskLevelShareNameResult = "Medium"} 
             If($ShareNameTopACLRiskScore -ge 11 -and $ShareNameTopACLRiskScore -lt 20   ) { $RiskLevelShareNameResult = "High"}     
             If($ShareNameTopACLRiskScore -ge 20                                         ) { $RiskLevelShareNameResult = "Critical"}   
             
             # Increment counts
             if($RiskLevelShareNameResult -eq "Low"     ){$RiskLevelShareNameCountLow      = $RiskLevelShareNameCountLow      + 1}
             if($RiskLevelShareNameResult -eq "Medium"  ){$RiskLevelShareNameCountMedium   = $RiskLevelShareNameCountMedium   + 1}
             if($RiskLevelShareNameResult -eq "High"    ){$RiskLevelShareNameCountHigh     = $RiskLevelShareNameCountHigh     + 1}
             if($RiskLevelShareNameResult -eq "Critical"){$RiskLevelShareNameCountCritical = $RiskLevelShareNameCountCritical + 1}                         
        } 

        # ----------------------------------------------------------------------
        # Create Folder Group Summary Information
        # ---------------------------------------------------------------------- 

        $RiskLevelFolderGroupCountCritical = 0
        $RiskLevelFolderGroupCountHigh     = 0
        $RiskLevelFolderGroupCountMedium   = 0
        $RiskLevelFolderGroupCountLow      = 0
        $FolderGroupChartCount     = $ExcessiveSharePrivsFinal | select FileListGroup -Unique | measure | select count -ExpandProperty count # Unique folder group
        $ExcessiveSharePrivsFinal | select FileListGroup -Unique |
        foreach {
             
             # Set target share name
             $TargetFileListGroup = $_.FileListGroup

             # Grab the risk level for the highest risk acl for the share name
             $FileListGroupTopACLRiskScore = $ExcessiveSharePrivsFinal | where FileListGroup -eq $TargetFileListGroup | select RiskScore | sort RiskScore -Descending | select -First 1  | select RiskScore -ExpandProperty RiskScore

             # Check risk level - Highest wins
             If($FileListGroupTopACLRiskScore -le 4                                              ) { $RiskLevelFileListGroupResult = "Low"}
             If($FileListGroupTopACLRiskScore -gt 4  -and $FileListGroupTopACLRiskScore -lt 11   ) { $RiskLevelFileListGroupResult = "Medium"} 
             If($FileListGroupTopACLRiskScore -ge 11 -and $FileListGroupTopACLRiskScore -lt 20   ) { $RiskLevelFileListGroupResult = "High"}     
             If($FileListGroupTopACLRiskScore -ge 20                                             ) { $RiskLevelFileListGroupResult = "Critical"}   
             
             # Increment counts
             if($RiskLevelFileListGroupResult -eq "Low"     ){$RiskLevelFolderGroupCountLow      = $RiskLevelFolderGroupCountLow      + 1}
             if($RiskLevelFileListGroupResult -eq "Medium"  ){$RiskLevelFolderGroupCountMedium   = $RiskLevelFolderGroupCountMedium   + 1}
             if($RiskLevelFileListGroupResult -eq "High"    ){$RiskLevelFolderGroupCountHigh     = $RiskLevelFolderGroupCountHigh     + 1}
             if($RiskLevelFileListGroupResult -eq "Critical"){$RiskLevelFolderGroupCountCritical = $RiskLevelFolderGroupCountCritical + 1}                         
        } 


        # ----------------------------------------------------------------------
        # Calculate Peer Comparison Data - INSIGHTS 
        # ---------------------------------------------------------------------- 
        # % of computers, shares, aces with excessive privs enumerated from single active directory domain

        # Set averages from a sample of 50 representative (size and industry) environments
        $PeerCompareAverageP = "[18, 9, 15]"  

        # Get actual computer %
        if($ComputerPingableCount -gt 0){
            $PeerComparisonComputerCount = $ComputerPingableCount # use ping count
        }else{
            $PeerComparisonComputerCount = $Computers445OpenCount # use open445 count
            $ComputerPingableCount       = 0 #hacky patch
        }
        $PeerComparActualComputers   = [math]::Round($ComputerWithExcessive/$PeerComparisonComputerCount,2) * 100 
        $PeerComparActualComputersr  = [math]::Round($ComputerWithReadCount/$PeerComparisonComputerCount,2) * 100
        $PeerComparActualComputersW  = [math]::Round($ComputerWithWriteCount/$PeerComparisonComputerCount,2) * 100
        $PeerComparActualComputershr = [math]::Round($ComputerwithHighRisk/$PeerComparisonComputerCount,2) * 100             

        # Get actual shares %
        $PeerComparActualShares = [math]::Round($ExcessiveSharesCount/$AllSMBSharesCount,2) * 100      

        # Get actual aces %
        $PeerComparActualAces = [math]::Round($ExcessiveSharePrivsCount/$ShareACLsCount ,2) * 100     

        # Set actual
        $PeerCompareActuaP   = "[$PeerComparActualComputers, $PeerComparActualShares, $PeerComparActualAces]"

        # ----------------------------------------------------------------------
        # Calculate Remediation Prioritization and Charts - INSIGHTS 
        # ----------------------------------------------------------------------
        $RemediationBase = "[$ExcessiveSharePrivsCount,$ExcessiveSharePrivsCount,$ExcessiveSharePrivsCount]"
        $RemediationSave = "[$ExcessiveSharePrivsCount,$FolderGroupChartCount,$ShareNameChartCount]"
        $RemediationSaveFgP = 100 - ([math]::Round($FolderGroupChartCount/$ExcessiveSharePrivsCount,2) * 100)
        $RemediationSaveSnP = 100 - ([math]::Round($ShareNameChartCount/$ExcessiveSharePrivsCount,2) * 100)

        if($RemediationSaveFgP -gt $RemediationSaveSnP){
            $RemediationSavings = $RemediationSaveFgP
        }else{
            $RemediationSavings = $RemediationSaveSnP
        }
   
        # ----------------------------------------------------------------------
        # Create ShareGraph Nodes and Edges
        # ---------------------------------------------------------------------- 
        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        Write-Output " [*][$Time] Creating ShareGraph nodes and edges..."  

        # Create hashsets to track added nodes and edges
        $addedNodes = @{}
        $addedEdges = @{}

        # Iterate through each row in the CSV
        foreach ($row in $ExcessiveSharePrivsFinal) {

            # Replace single backslashes with double backslashes for SharePath, ShareName, ShareOwner, and IdentityReference
            $escapedSharePath = $row.SharePath -replace '\\', '\\'
            $escapedShareName = $row.ShareName -replace '\\', '\\'
            $escapedShareOwner = $row.ShareOwner -replace '\\', '\\'
            $escapedIdentityReference = $row.IdentityReference -replace '\\', '\\'

            # Create and add nodes if they don't exist
            $ownerNode = "{ data: { id: '$escapedShareOwner', label: '$escapedShareOwner', type: 'owner', IdentitySID: '$($row.IdentitySID)' } },"
            if (-not $addedNodes.ContainsKey($escapedShareOwner)) {
                $ShareGraphNodes += $ownerNode
                $addedNodes[$escapedShareOwner] = $true
            }

            $userNode = "{ data: { id: '$escapedIdentityReference', label: '$escapedIdentityReference', type: 'user', IdentitySID: '$($row.IdentitySID)' } },"
            if (-not $addedNodes.ContainsKey($escapedIdentityReference)) {
                $ShareGraphNodes += $userNode
                $addedNodes[$escapedIdentityReference] = $true
            }

            $computerNode = "{ data: { id: '$($row.ComputerName)', label: '$($row.ComputerName)', type: 'computer', ipaddress: '$($row.IpAddress)' } },"
            if (-not $addedNodes.ContainsKey($row.ComputerName)) {
                $ShareGraphNodes += $computerNode
                $addedNodes[$row.ComputerName] = $true
            }

            $folderGroupNode = "{ data: { id: '$($row.FileListGroup)', label: '$($row.FileListGroup)', type: 'Folder Group' } },"
            if (-not $addedNodes.ContainsKey($row.FileListGroup)) {
                $ShareGraphNodes += $folderGroupNode
                $addedNodes[$row.FileListGroup] = $true
            }

            # Check if the ShareName node already exists
            if (-not $addedNodes.ContainsKey($escapedShareName)) {
                $shareNameNode = "{ data: { id: '$escapedShareName', label: '$escapedShareName', type: 'sharename' } },"
                $ShareGraphNodes += $shareNameNode
                $addedNodes[$escapedShareName] = $true
            }

            # Check if SharePath node already exists
            if (-not $addedNodes.ContainsKey($escapedSharePath)) {
                $sharePathNode = "{ data: { id: '$escapedSharePath', label: '$escapedSharePath', type: 'sharepath', RiskLevel: '$($row.RiskLevel)', RiskScore: '$($row.RiskScore)', creationDate: '$($row.CreationDate)', lastModifiedDate: '$($row.LastModifiedDate)', fileCount: $($row.FileCount), owner: '$escapedShareOwner', IsDefault: '$($row.IsDefault)', IsEmpty: '$($row.IsEmpty)', IsStale: '$($row.IsStale)', IsHR: '$($row.HasHR)', HasWrite: '$($row.HasWrite)', HasRead: '$($row.HasRead)', HasRCE: '$($row.HasRCE)', InterestingFiles: '$($row.HasIF)', ShareName: '$escapedShareName', ShareDescription: '$($row.ShareDescription)' } },"
                $ShareGraphNodes += $sharePathNode
                $addedNodes[$escapedSharePath] = $true
            }

            # Ensure the edge between ShareName and SharePath exists
            $shareNameEdge = "{ data: { source: '$escapedShareName', target: '$escapedSharePath', label: 'child_of' } },"
            if (-not $addedEdges.ContainsKey("child_of_$escapedShareName_$escapedSharePath")) {
                $ShareGraphEdges += $shareNameEdge
                $addedEdges["child_of_$escapedShareName_$escapedSharePath"] = $true
            }

            # Create and add other edges if they don't exist
            $ownerEdge = "{ data: { source: '$escapedShareOwner', target: '$escapedSharePath', label: 'owner_of' } },"
            if (-not $addedEdges.ContainsKey("owner_of_$escapedShareOwner_$escapedSharePath")) {
                $ShareGraphEdges += $ownerEdge
                $addedEdges["owner_of_$escapedShareOwner_$escapedSharePath"] = $true
            }

            $privilegeEdge = "{ data: { source: '$escapedIdentityReference', target: '$escapedSharePath', label: 'has_privilege_on', filesystemrights: '$($row.FileSystemRights)' } },"
            if (-not $addedEdges.ContainsKey("has_privilege_on_$escapedIdentityReference_$escapedSharePath")) {
                $ShareGraphEdges += $privilegeEdge
                $addedEdges["has_privilege_on_$escapedIdentityReference_$escapedSharePath"] = $true
            }

            $folderGroupEdge = "{ data: { source: '$($row.FileListGroup)', target: '$escapedSharePath', label: 'hosted_on' } },"
            if (-not $addedEdges.ContainsKey("hosted_on_$($row.FileListGroup)_$escapedSharePath")) {
                $ShareGraphEdges += $folderGroupEdge
                $addedEdges["hosted_on_$($row.FileListGroup)_$escapedSharePath"] = $true
            }

            $computerEdge = "{ data: { source: '$escapedSharePath', target: '$($row.ComputerName)', label: 'hosted_on' } },"
            if (-not $addedEdges.ContainsKey("hosted_on_$escapedSharePath_$($row.ComputerName)")) {
                $ShareGraphEdges += $computerEdge
                $addedEdges["hosted_on_$escapedSharePath_$($row.ComputerName)"] = $true
            }
        }

        # Reference $ShareGraphNodesFinal and $ShareGraphEdgesFinal in Cytoscape JavaScript   
        $ShareGraphNodesFinal = $ShareGraphNodes | select -Unique
        $ShareGraphEdgesFinal = $ShareGraphEdges | select -Unique

        # ----------------------------------------------------------------------
        # Create Timeline Reports
        # ----------------------------------------------------------------------     
        
        # Generate last modified card 
        If($SupressTimelineRpt){
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] Creation timeline reports have been disabled."            
            $CardLastModifiedTimeLine = "Share creation Timeline reports have been disabled."            
        }else{
            $CardCreationTimeLine = Get-CardCreationTime -MyDataTable $ExcessiveSharePrivs -OutFilePath "$OutputDirectory\$TargetDomain-Shares-Timeline-Creation-Summary.csv"            
        }     
        
        # Generate last modified card 
        If($SupressTimelineRpt){
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] Last modified timeline reports have been disabled."            
            $CardLastModifiedTimeLine = "Last modified timeline reports have been disabled."            
        }else{
            $CardLastModifiedTimeLine = Get-CardLastModified -MyDataTable $ExcessiveSharePrivs -OutFilePath "$OutputDirectory\$TargetDomain-Shares-Timeline-Last-Modified-Summary.csv"            
        }        

        # Generate last access card
        If($SupressTimelineRpt){
            $Time =  Get-Date -UFormat "%m/%d/%Y %R"
            Write-Output " [*][$Time] Last access timeline reports have been disabled."
            $CardLastAccessTimeLine = "Last access timeline reports have been disabled."            
        }else{
            $CardLastAccessTimeLine = Get-CardLastAccess -MyDataTable $ExcessiveSharePrivs -OutFilePath "$OutputDirectory\$TargetDomain-Shares-Timeline-Last-Accessed-Summary.csv"            
        }  

        Write-Output " [*][$Time] Analysis Complete"

        # ----------------------------------------------------------------------
        # Display final summary
        # ----------------------------------------------------------------------
        
        Write-Output " ---------------------------------------------------------------"
        Write-Output " SHARE REPORT SUMMARY      "
        Write-Output " ---------------------------------------------------------------"
        
        $Time =  Get-Date -UFormat "%m/%d/%Y %R"
        #Write-Output " [*][$Time] Results written to $OutputDirectory"
        #Write-Output " [*][$Time] "

        $EndTime = Get-Date
        $StopWatch.Stop()
        $RunTime = $StopWatch | Select-Object Elapsed -ExpandProperty Elapsed

        if($NoPing){
            $NoPingMsg = "(No Ping)"
        }else{
            $NoPingMsg = ""
        }

        #Write-Output " [*][$Time] -----------------------------------------------"
        #Write-Output " [*][$Time] Get-ShareInventory Summary Report"
        #Write-Output " [*][$Time] -----------------------------------------------"
        Write-Output " [*][$Time] Domain: $TargetDomain"
        Write-Output " [*][$Time] Start time: $StartTime"
        Write-Output " [*][$Time] End time: $EndTime"
        Write-Output " [*][$Time] Run time: $RunTime"
        Write-Output " [*][$Time] "
        Write-Output " [*][$Time] COMPUTER SUMMARY"
        Write-Output " [*][$Time] - $ComputerCount domain computers found."
        Write-Output " [*][$Time] - $ComputerPingableCount ($PercentComputerPingP) domain computers responded to ping. $NoPingMsg"
        Write-Output " [*][$Time] - $Computers445OpenCount ($PercentComputerPortP) domain computers had TCP port 445 accessible."
        Write-Output " [*][$Time] - $ComputerwithNonDefaultCount ($PercentComputerNonDefaultP) domain computers had shares that were non-default."  
        Write-Output " [*][$Time] - $ComputerWithExcessive ($PercentComputerExPrivP) domain computers had shares with potentially excessive privileges."      
        Write-Output " [*][$Time] - $ComputerWithReadCount ($PercentComputerReadP) domain computers had shares that allowed READ access."  
        Write-Output " [*][$Time] - $ComputerWithWriteCount ($PercentComputerWriteP) domain computers had shares that allowed WRITE access."  
        Write-Output " [*][$Time] - $ComputerwithHighRisk ($PercentComputerHighRiskP) domain computers had shares that are HIGH RISK."  
        Write-Output " [*][$Time] "
        Write-Output " [*][$Time] SHARE SUMMARY"      
        Write-Output " [*][$Time] - $AllSMBSharesCount shares were found. We expected a minimum of $MinExpectedShareCount shares"
        Write-Output " [*][$Time]   because $Computers445OpenCount systems had open ports and there are typically two default shares."
        Write-Output " [*][$Time] - $SharesNonDefaultCount ($PercentSharesNonDefaultP) shares across $ComputerwithNonDefaultCount systems were non-default."
        Write-Output " [*][$Time] - $ExcessiveSharesCount ($PercentSharesExPrivP) shares across $ComputerWithExcessive systems are configured with $ExcessiveSharePrivsCount potentially excessive ACLs."
        Write-Output " [*][$Time] - $SharesWithReadCount ($PercentSharesReadP) shares across $ComputerWithReadCount systems allowed READ access."
        Write-Output " [*][$Time] - $SharesWithWriteCount ($PercentSharesWriteP) shares across $ComputerWithWriteCount systems allowed WRITE access."
        Write-Output " [*][$Time] - $SharesHighRiskCount ($PercentSharesHighRiskP) shares across $ComputerwithHighRisk systems are considered HIGH RISK."
        Write-Output " [*][$Time] "
        Write-Output " [*][$Time] SHARE ACL SUMMARY"
        Write-Output " [*][$Time] - $ShareACLsCount ACLs were found."
        Write-Output " [*][$Time] - $AclNonDefaultCount ($PercentAclNonDefaultP) ACLs were associated with non-default shares." 
        Write-Output " [*][$Time] - $ExcessiveSharePrivsCount ($PercentAclExPrivP) ACLs were found to be potentially excessive."               
        Write-Output " [*][$Time] - $AclWithReadCount ($PercentAclReadP) ACLs were found that allowed READ access."  
        Write-Output " [*][$Time] - $AclWithWriteCount ($PercentAclWriteP) ACLs were found that allowed WRITE access."                               
        Write-Output " [*][$Time] - $AclHighRiskCount ($PercentAclHighRiskP) ACLs were found that are associated with HIGH RISK share names."
        Write-Output " [*][$Time] "
        Write-Output " [*][$Time] - The $SampleSum most common share names are:"
        Write-Output " [*][$Time] - $Top5ShareCountTotal of $AllAccessibleSharesCount ($DupPercent) discovered shares are associated with the top $SampleSum share names."
        $CommonShareNamesTop5 |
        foreach {
            $ShareCount = $_.count
            $ShareName  = $_.name
            Write-Output " [*][$Time]   - $ShareCount $ShareName"   
        }

        # Estimate report generation time
        $ReportGenTimeEstimate = "Unknown"
        If($AllSMBSharesCount -le 500   ) {$ReportGenTimeEstimate = "1 minute or less"   }
        If($AllSMBSharesCount -gt 500   ) {$ReportGenTimeEstimate = "5 minutes or less"  }
        If($AllSMBSharesCount -ge 1000  ) {$ReportGenTimeEstimate = "10 minutes or less" }
        If($AllSMBSharesCount -ge 2000  ) {$ReportGenTimeEstimate = "15 minutes or less" }
        If($AllSMBSharesCount -ge 10000 ) {$ReportGenTimeEstimate = "20 minutes or less" }
        If($AllSMBSharesCount -ge 15000 ) {$ReportGenTimeEstimate = "25 minutes or less" }
        If($AllSMBSharesCount -ge 30000 ) {$ReportGenTimeEstimate = "30 minutes or less" }


        Write-Output " [*] -----------------------------------------------"
        Write-Output " [*][$Time]   - Generating HTML Report"
        Write-Output " [*][$Time]   - Estimated generation time: $ReportGenTimeEstimate"  
        
        # ----------------------------------------------------------------------
        # Display final summary - NEW HTML REPORT
        # ----------------------------------------------------------------------
		if($username -like ""){$username = whoami}
		$SourceIps = (Get-NetIPAddress | where AddressState -like "*Pref*" | where AddressFamily -like "ipv4" | where ipaddress -notlike "127.0.0.1" | select IpAddress).ipaddress -join ("<br>")
		$SourceHost = (hostname) 

        # Get file group string list
        $CommonShareFileGroupTopString = $CommonShareFileGroupTop5 |
        foreach {
            $FileGroupName = $_.name                          
            $ThisFileBars = Get-GroupFileBar -DataTable $ExcessiveSharePrivs -Name $FileGroupName -AllComputerCount $ComputerCount -AllShareCount $AllSMBSharesCount -AllAclCount $ShareACLsCount
            $ComputerBarF = $ThisFileBars.ComputerBar
            $ShareBarF = $ThisFileBars.ShareBar
            $AclBarF = $ThisFileBars.AclBar            
            $ThisFileListPrep = $ThisFileBars.FileList 
            $ThisFileList = $ThisFileListPrep -replace "`n", "<br>"          
            $ThisFileCount = $ThisFileBars.FileCount
            $ThisFileShareCount = $ThisFileBars.Sharecount
            $ThisFileShareNameList = $ExcessiveSharePrivs | where FileListGroup -eq $FileGroupName | select ShareName -unique -expandproperty sharename | foreach { "$_ <br>"}
            $ThisFileShareNameListUniqueCount = $ThisFileShareNameList | measure | select count -ExpandProperty count
            $ShareFileShareUnc = $ExcessiveSharePrivs | where FileListGroup -eq $FileGroupName | select SharePath -unique -expandproperty SharePath | foreach { "$_ <br>"}
            
            # Grab the risk level for the highest risk acl for the foldergroup
            $FolderGroupsTopACLRiskScoreRow = $ExcessiveSharePrivsFinal | where FileListGroup -eq $FileGroupName | select RiskScore | sort RiskScore -Descending | select -First 1  | select RiskScore -ExpandProperty RiskScore

            # Check risk level - Highest wins
            If($FolderGroupsTopACLRiskScoreRow -le 4                                                ) { $RiskLevelFolderGroupResultRow = "Low"}
            If($FolderGroupsTopACLRiskScoreRow -gt 4  -and $FolderGroupsTopACLRiskScoreRow -lt 11   ) { $RiskLevelFolderGroupResultRow = "Medium"} 
            If($FolderGroupsTopACLRiskScoreRow -ge 11 -and $FolderGroupsTopACLRiskScoreRow -lt 20   ) { $RiskLevelFolderGroupResultRow = "High"}     
            If($FolderGroupsTopACLRiskScoreRow -ge 20                                               ) { $RiskLevelFolderGroupResultRow = "Critical"} 
            
            # Set risk level for row
            $FileGroupNameRiskLevelRow = "$FolderGroupsTopACLRiskScoreRow $RiskLevelFolderGroupResultRow"

            $ThisRow = @" 
	          <tr>
	          <td>
                <!-- Unique Share Count -->
                <button class="collapsible">$ThisFileShareNameListUniqueCount</button>
                <div class="content" style="font-size:11px;width:100px;">
                    $ThisFileShareNameList
                </div>
	          </td>	
	          <td>
                <!-- Total Share Count -->    
                <button class="collapsible">$ThisFileShareCount</button>
                <div class="content" style="font-size:11px;width:100px;">
                $ShareFileShareUnc
                </div>
	          </td>
	          <td> <!-- File Count -->               
                  <button class="collapsible"><span style="color:#CE112D;"></span>$ThisFileCount Files</button>
                  <div class="content" style="font-size:11px;width:100px;">
                  $ThisFileList
                  </div>
	          </td>	
	          <td> <!-- Risk Level -->  
	          $FileGroupNameRiskLevelRow
	          </td>
	          <td> <!-- Folder Group Name -->  
              $FileGroupName
	          </td>		           	  
	          </tr>
"@              
            $ThisRow
        }

        # Get share name string list
        $CommonShareNamesTopString = $CommonShareNamesTop5 |
        foreach {
            $ShareCount = $_.count
            $ShareName = $_.name            
            Write-Output "$ShareCount $ShareName <br>"   
        }  

        # Get share name string list table
        $CommonShareNamesTopStringT = $CommonShareNamesTop5 |
        foreach {
            $ShareCount = $_.count
            $ShareName = $_.name
            $ShareFolderGroupCount = $ExcessiveSharePrivs | where sharename -like "$ShareName" | select filelistgroup -Unique | measure | select count -ExpandProperty count 
            $ShareNameBars = Get-GroupNameNoBar -DataTable $ExcessiveSharePrivs -Name $ShareName -AllComputerCount $ComputerCount -AllShareCount $AllSMBSharesCount -AllAclCount $ShareACLsCount
            $ComputerBar = $ShareNameBars.ComputerBar
            $ShareBar    = $ShareNameBars.ShareBar
            $AclBar      = $ShareNameBars.AclBar            
            
            # Share Description
            $ShareDescriptionSample = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | where ShareDescription  -NE "" | select ShareDescription -first 1 -expandproperty ShareDescription | foreach {"<strong>Sample Description</strong><br> $_ <br><br> "}

            # First created
            # $ShareFirstCreated = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select creationdate | foreach{[datetime]$_.creationdate } | Sort-Object | select -First 1 | foreach {$_.tostring("MM/dd/yyyy HH:mm:ss")}
            $ShareFirstCreated = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select creationdate | foreach{[datetime]$_.creationdate } | Sort-Object | select -First 1 | foreach {$_.tostring("MM/dd/yyyy")}

            # Last created
            # $ShareLastCreated  = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select creationdate | foreach{[datetime]$_.creationdate } | Sort-Object -Descending | select -First 1 | foreach {$_.tostring("MM/dd/yyyy HH:mm:ss")}
            $ShareLastCreated  = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select creationdate | foreach{[datetime]$_.creationdate } | Sort-Object -Descending | select -First 1 | foreach {$_.tostring("MM/dd/yyyy")}

            # Last modified
            # $ShareLastModified = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select LastModifiedDate | foreach{[datetime]$_.LastModifiedDate } | Sort-Object -Descending | select -First 1 | foreach {$_.tostring("MM/dd/yyyy HH:mm:ss")}            
            $ShareLastModified = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select LastModifiedDate | foreach{[datetime]$_.LastModifiedDate } | Sort-Object -Descending | select -First 1 | foreach {$_.tostring("MM/dd/yyyy")}  

            # Share owner list
            $ShareOwnerList = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | Sort-Object | select ShareOwner -Unique -ExpandProperty ShareOwner
            $ShareOwnerListHTML = $ShareOwnerList | foreach{ "$_ <br>"}
            
            # Share owner list count
            $ShareOwnerListCount = $ShareOwnerList | select -Unique | measure-object | select count -expandproperty count               

            # Share folder group list
            $ShareFolderGroupList  = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select SharePath,FileListGroup -Unique | Group-Object FileListGroup   | sort count -Descending | select count, name | 
            foreach { 

                $fdcount = $_.count; 
                $fdname = $_.name;

                If($fdname){
                
                    # Get file count
                    $FdFileCount = $ExcessiveSharePrivs | where FileListGroup -eq  $fdname | select FileCount -First 1 -ExpandProperty FileCount -ErrorAction SilentlyContinue

                    # Get file list
                    $MyFdList = $ExcessiveSharePrivs | where FileListGroup -eq  $fdname | select FileList -First 1 -ExpandProperty FileList -ErrorAction SilentlyContinue
                    $MyFdListBr = $MyFdList -replace "`n", "<br>"

                    $ThisFileDirList = @"
                       
                        <button class="collapsible" style="font-size: 10px;">$fdcount of $ShareCount shares ($FdFileCount Files)</button>
                        <div class="content" style="font-size: 10px;background-color: white;padding-left:2px;top: 2px;">
                        <!-- $fdname<br><br> -->
                        $MyFdListBr
                        </div>                
"@
                    $ThisFileDirList
                }
            }

            #region SimilarityScore
            # ----------------------------------------------------------------------
            # Calculate Similarity Score - START  
            # ----------------------------------------------------------------------
            
            ## ---
            ## Folder Group Coverage Weighted Calculations 
            ## ---------------------------------------------

            ##
            ## Determine if the percentage of shares that exists in each folder group for the target share name meet the defined thresholds.
            
            # Start all values at 0
            $SimularityFolderGroupCoverageScore = 0
            $SimularityFolderGroupCoverage10    = 0
            $SimularityFolderGroupCoverage20    = 0
            $SimularityFolderGroupCoverage30    = 0
            $SimularityFolderGroupCoverage40    = 0
            $SimularityFolderGroupCoverage50    = 0
            $SimularityFolderGroupCoverage60    = 0
            $SimularityFolderGroupCoverage70    = 0
            $SimularityFolderGroupCoverage80    = 0
            $SimularityFolderGroupCoverage90    = 0            
            $SimularityFolderGroupCoverage100   = 0            

            # Get the share count for each folder group
            $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select SharePath,FileListGroup -Unique | Group-Object FileListGroup | sort count -Descending | select count, name |
            foreach{
                
                # Determine if thesholds where met and update tracker variables

                # Get % of shares the folder group includes
                $PercentOfSharesInFg = [math]::Round($_.count/$ShareCount,4)

                # Check if 10% of shares share the same file group
                if($PercentOfSharesInFg -ge .10){
                    $SimularityFolderGroupCoverage10  = 1
                }

                # Check if 20% of shares share the same file group
                if($PercentOfSharesInFg -ge .20){
                    $SimularityFolderGroupCoverage20  = 1
                }

                # Check if 30% of shares share the same file group
                if($PercentOfSharesInFg -ge .30){
                    $SimularityFolderGroupCoverage30  = 1
                }

                # Check if 40% of shares share the same file group
                if($PercentOfSharesInFg -ge .40){
                    $SimularityFolderGroupCoverage40  = 1
                }

                # Check if 51% of shares share the same file group
                if($PercentOfSharesInFg -ge .51){
                    $SimularityFolderGroupCoverage50  = 1
                }

                # Check if 60% of shares share the same file group
                if($PercentOfSharesInFg -ge .60){
                    $SimularityFolderGroupCoverage60  = 1
                }
                # Check if 70% of shares share the same file group
                if($PercentOfSharesInFg -ge .70){
                    $SimularityFolderGroupCoverage70  = 1
                }

                # Check if 80% of shares share the same file group
                if($PercentOfSharesInFg -ge .80){
                    $SimularityFolderGroupCoverage80  = 1
                }

                # Check if 90% of shares share the same file group
                if($PercentOfSharesInFg -ge .90){
                    $SimularityFolderGroupCoverage90  = 1
                }

                # Check if 100% of shares share the same file group
                if($PercentOfSharesInFg -ge 1){
                    $SimularityFolderGroupCoverage100 = 1
                }
            }

            # Set the weighted values
            $SimularityFolderGroupCoverage10w     =  $SimularityFolderGroupCoverage10   * 10
            $SimularityFolderGroupCoverage20w     =  $SimularityFolderGroupCoverage20   * 10
            $SimularityFolderGroupCoverage30w     =  $SimularityFolderGroupCoverage30   * 10
            $SimularityFolderGroupCoverage40w     =  $SimularityFolderGroupCoverage40   * 10
            $SimularityFolderGroupCoverage50w     =  $SimularityFolderGroupCoverage50   * 10
            $SimularityFolderGroupCoverage60w     =  $SimularityFolderGroupCoverage60   * 10
            $SimularityFolderGroupCoverage70w     =  $SimularityFolderGroupCoverage70   * 10
            $SimularityFolderGroupCoverage80w     =  $SimularityFolderGroupCoverage80   * 10
            $SimularityFolderGroupCoverage90w     =  $SimularityFolderGroupCoverage90   * 10
            $SimularityFolderGroupCoverage100w    =  $SimularityFolderGroupCoverage100  * 10

            # Set max value
            $SimularityFolderGroupCoverageMax     =  100

            # Set actual value
            $SimularityFolderGroupCoverageValue   =  $SimularityFolderGroupCoverage10w  + 
                                                     $SimularityFolderGroupCoverage20w  + 
                                                     $SimularityFolderGroupCoverage30w  + 
                                                     $SimularityFolderGroupCoverage40w  + 
                                                     $SimularityFolderGroupCoverage50w  + 
                                                     $SimularityFolderGroupCoverage60w  + 
                                                     $SimularityFolderGroupCoverage70w  + 
                                                     $SimularityFolderGroupCoverage80w  + 
                                                     $SimularityFolderGroupCoverage90w  + 
                                                     $SimularityFolderGroupCoverage100w  


            # Calculate Weighted Score
            $SimularityFolderGroupCoverageScore   =  $SimularityFolderGroupCoverageValue / $SimularityFolderGroupCoverageMax 
            $SimularityFolderGroupCoverageScoreP1 =  [math]::round(($SimularityFolderGroupCoverageScore.tostring("P") -replace('%','')))
            $SimularityFolderGroupCoverageScoreP  =  "$SimularityFolderGroupCoverageScoreP1%"
            

            ## --- 
            ## File Name Coverage Weighted Calculations  
            ## ---------------------------------------------       

            ##
            ## Determine if at least one file is the same across the target percentages of file groups for the target share.

            # Start all values at 0
            $SimularityFileCoverageScore  = 0
            $SimularityFileCoverage10     = 0
            $SimularityFileCoverage20     = 0
            $SimularityFileCoverage30     = 0
            $SimularityFileCoverage40     = 0
            $SimularityFileCoverage50     = 0
            $SimularityFileCoverage60     = 0
            $SimularityFileCoverage70     = 0
            $SimularityFileCoverage80     = 0
            $SimularityFileCoverage90     = 0
            $SimularityFileCoverage100    = 0
            $SimularityFileCommonList     = ""
            $SimularityFileCommonList     = New-Object System.Data.DataTable 
            $SimularityFileCommonList.Columns.Add("Count") | Out-Null
            $SimularityFileCommonList.Columns.Add("FileName") | Out-Null
            $SimularityFileCommonList.Columns.Add("Coverage") | Out-Null

            # Get a list of file names from each folder group for the target share name
            $FullFileListSim = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select FileListGroup,FileList -Unique | Select FileList | foreach {$_.FileList -split "`r`n"} | Where-Object {$_ -ne ''}                              
            
            # Count how many file groups (file name instances) each file is seen in
            $FullFileListSimCounts = $FullFileListSim | Group-Object | sort count -Descending | select count,name | Where-Object {$_.name -ne ''}

            # Determine if at least one file meets each coverage threshold
            $FullFileListSimCounts | 
            Foreach{
                [string]$SameFileNameCount    = $_.count
                [string]$SameFileName         = $_.name
                $SameFileNameCoverage         = [math]::Round($SameFileNameCount/$ShareFolderGroupCount,4)            

                # Check for 10% coverage
                if($SameFileNameCoverage -ge .10){ 
                   $SimularityFileCoverage10  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 20% coverage
                if($SameFileNameCoverage -ge .20){ 
                   $SimularityFileCoverage20  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 30% coverage
                if($SameFileNameCoverage -ge .30){ 
                   $SimularityFileCoverage30  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 40% coverage
                if($SameFileNameCoverage -ge .40){ 
                   $SimularityFileCoverage40  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 50% coverage
                if($SameFileNameCoverage -ge .51){ 
                   $SimularityFileCoverage50  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 60% coverage
                if($SameFileNameCoverage -ge .60){ 
                   $SimularityFileCoverage60  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 70% coverage
                if($SameFileNameCoverage -ge .70){ 
                   $SimularityFileCoverage70  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 80% coverage
                if($SameFileNameCoverage -ge .80){ 
                   $SimularityFileCoverage80  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 90% coverage
                if($SameFileNameCoverage -ge .90){ 
                   $SimularityFileCoverage90  = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                }

                # Check for 100% coverage
                if($SameFileNameCoverage -ge 1){ 
                   $SimularityFileCoverage100 = 1
                   $SimularityFileCommonList.rows.Add($SameFileNameCount,"$SameFileName",$SameFileNameCoverage) | Out-Null
                } 
            }

            # Set common file constraints
            If($ShareCount -eq 1){
                $CommonFileConstraint = 0
            }else{
                $CommonFileConstraint = 1
            }

            # Select a list of all files found in 10% or more of folder groups
            $SimularityFileCommonListTop = $SimularityFileCommonList | where Coverage -ge .10 | where Count -gt $CommonFileConstraint |
            foreach {
                $SimularityFileTopName          = $_.FileName
                $SimularityFileTopCount         = $_.Count
                $SimularityFileTopCountCalc     = [math]::Round($SimularityFileTopCount/$ShareFolderGroupCount,4)                  
                $SimularityFileTopCPercentage   = ($SimularityFileTopCountCalc * 100).ToString() + '%'
                "<tr id='ignore'><td>$SimularityFileTopName</td><td>&nbsp;$SimularityFileTopCPercentage ($SimularityFileTopCount)</td></tr>"
            } | select -Unique
            
            # This supports situations when the a file exist in more than one group, but the total folder group count is less than 10
            # we need this should we only show common files with more than one instance
            If($ShareFolderGroupCount -lt 10 -and $ShareFolderGroupCount -gt 1 -and $ShareCount -gt 2) {
                $SimularityFileCommonListTop = $SimularityFileCommonList | where Count -gt 1 |
                foreach {
                    $SimularityFileTopName          = $_.FileName
                    $SimularityFileTopCount         = $_.Count
                    $SimularityFileTopCountCalc     = [math]::Round($SimularityFileTopCount/$ShareFolderGroupCount,4)                  
                    $SimularityFileTopCPercentage   = ($SimularityFileTopCountCalc * 100).ToString() + '%'
                    "<tr id='ignore'><td>$SimularityFileTopName</td><td>&nbsp;$SimularityFileTopCPercentage ($SimularityFileTopCount)</td></tr>"
                } | select -Unique
            }  
            
            # This supports situations when the a file exist in more than one group, but there is only one group
            If($ShareFolderGroupCount -eq 1 -and $ShareCount -gt 1) {
                $SimularityFileCommonListTop = $SimularityFileCommonList | 
                foreach {
                    $SimularityFileTopName          = $_.FileName
                    $SimularityFileTopCount         = $_.Count
                    $SimularityFileTopCountCalc     = [math]::Round($SimularityFileTopCount/$ShareFolderGroupCount,4)                  
                    $SimularityFileTopCPercentage   = ($SimularityFileTopCountCalc * 100).ToString() + '%'
                    "<tr id='ignore'><td>$SimularityFileTopName</td><td>&nbsp;$SimularityFileTopCPercentage ($SimularityFileTopCount)</td></tr>"
                } | select -Unique
            }                      
            
            # Set count for display
            $SimularityFileCommonListTopNum = $SimularityFileCommonListTop | measure | select count -ExpandProperty count         

            # Format list for display
            $SimularityFileCommonListTxt = $SimularityFileCommonListTop -join "`n"

            # Set the weighted values
            $SimularityFileCoverage10w            =  $SimularityFileCoverage10   * 10
            $SimularityFileCoverage20w            =  $SimularityFileCoverage20   * 10
            $SimularityFileCoverage30w            =  $SimularityFileCoverage30   * 10
            $SimularityFileCoverage40w            =  $SimularityFileCoverage40   * 10
            $SimularityFileCoverage50w            =  $SimularityFileCoverage50   * 10
            $SimularityFileCoverage60w            =  $SimularityFileCoverage60   * 10
            $SimularityFileCoverage70w            =  $SimularityFileCoverage70   * 10
            $SimularityFileCoverage80w            =  $SimularityFileCoverage80   * 10
            $SimularityFileCoverage90w            =  $SimularityFileCoverage90   * 10
            $SimularityFileCoverage100w           =  $SimularityFileCoverage100  * 10            

            # Set max value
            $SimularityFileCoverageMax            =  100

            # Set actual value
            $SimularityFileCoverageValue          =  $SimularityFileCoverage10w   +
                                                     $SimularityFileCoverage20w   +
                                                     $SimularityFileCoverage30w   +
                                                     $SimularityFileCoverage40w   +
                                                     $SimularityFileCoverage50w   +
                                                     $SimularityFileCoverage60w   +
                                                     $SimularityFileCoverage70w   +
                                                     $SimularityFileCoverage80w   +
                                                     $SimularityFileCoverage90w   +
                                                     $SimularityFileCoverage100w 


            # Calculate Weighted Score
            $SimularityFileCoverageScore          =  $SimularityFileCoverageValue  / $SimularityFileCoverageMax
            $SimularityFileCoverageScoreP1        =  [math]::round(($SimularityFileCoverageScore.tostring("P") -replace('%','')))
            $SimularityFileCoverageScoreP         =  "$SimularityFileCoverageScoreP1%"    
            
            ## --- 
            ## Share Properties Weight Group Calculations  
            ## ---------------------------------------------  

            ##
            ## Calculate share name ratio
            ## Output Value: 0 or 1 
            $SimularitySharePropShareName = 1         

            ##
            ## Calculate creation date ratio
            ## Output Value: 0 to 1
            $ShareCreateCount                    = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select creationdate -Unique | Measure-Object | Select-Object count -ExpandProperty count            
            $SimularityCalcCreateDate1           = [math]::Round($ShareCount/$ShareCreateCount,4) 
            $SimularitySharePropCreateDateRatio  = $SimularityCalcCreateDate1 / $ShareCount
            $SimularitySharePropCreateDateRatioT  = $SimularitySharePropCreateDateRatio.ToString("F2")
           
            ##
            ## Calculate modification date ratio
            ## Output Value: 0 to 1
            $ShareModifiedCount                   = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select LastModifiedDate -Unique | Measure-Object | Select-Object count -ExpandProperty count            
            $SimularityCalcLastModDate1           = [math]::Round($ShareCount/$ShareModifiedCount,4) 
            $SimularitySharePropModDateRatio      = $SimularityCalcLastModDate1 / $ShareCount
            $SimularitySharePropModDateRatioT     = $SimularitySharePropModDateRatio.ToString("F2") 
                        
            ##
            ## Calculate file group owner ratio average 
            ## Output Value: 0 to 1

            # Reset avg score
            $SimularitySharePropFGOwnerAvg = 0
                      
            # Foreach folder group calculate owner to folder group ratio
            $FGtoOwnerFGList = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | select FileListGroup -Unique  | 
            foreach{

                # Get folder group name
                $FGtoOwnerFG = $_.FileListGroup              

                # Get number of shares in folder group          
                $FGtoOwnerShareCount = $ExcessiveSharePrivs | where ShareName -EQ "$ShareName" | where FileListGroup -eq "$FGtoOwnerFG" | select SharePath -Unique | Measure-Object | select count -ExpandProperty count
                               
                # Get number of owners associated with folder group
                $FGtoOwnerOwnerCount = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | where FileListGroup -EQ "$FGtoOwnerFG" | select ShareOwner -Unique | Measure-Object | select count -ExpandProperty count                

                # Calculate fg to owner ratio               
                $FGtoOwnerThings = $FGtoOwnerOwnerCount/$FGtoOwnerShareCount
                $FGtoOwnerThings              
            } 

            # Calculate file group owner ratio average 
            $FGtoOwnerMax   = $FGtoOwnerFGList | measure | select count -ExpandProperty count
            $FGtoOwnerValue = ($FGtoOwnerFGList | measure -sum).sum            
            $SimularitySharePropFGOwnerAvg = [math]::Round($FGtoOwnerValue/$FGtoOwnerMax,4)
            $SimularitySharePropFGOwnerAvgT = $SimularitySharePropFGOwnerAvg.ToString("F2")

            ##
            ## Calculate group score

            # Set the weighted values
            $SimularitySharePropShareNameW             =  $SimularitySharePropShareName        * 90
            $SimularitySharePropFGOwnerAvgW            =  $SimularitySharePropFGOwnerAvg       * 5
            $SimularitySharePropCreateDateRatioW       =  $SimularitySharePropCreateDateRatio  * 3
            $SimularitySharePropModDateRatioW          =  $SimularitySharePropModDateRatio     * 2

            # Set max value
            $SimularitySharePropCoverageMax            =  100

            # Set actual value
            $SimularitySharePropCoverageValue          =  $SimularitySharePropShareNameW       +
                                                          $SimularitySharePropFGOwnerAvgW      +
                                                          $SimularitySharePropCreateDateRatioW +
                                                          $SimularitySharePropModDateRatioW
            # Calculate Weighted Score
            $SimularitySharePropCoverageScore          =  $SimularitySharePropCoverageValue  / $SimularitySharePropCoverageMax
            $SimularitySharePropCoverageScoreP1        =  [math]::round(($SimularitySharePropCoverageScore.tostring("P") -replace('%','')))
            $SimularitySharePropCoverageScoreP         =  "$SimularityFolderGroupCoverageScoreP1%"       

            ## ---
            ## General metrics (Not included in similarity score, but displayed in details)  
            ## ---------------------------------------------                                
                                              
            # Calculate the share to owner ratio
            # Output value: 0 to 1     
            $SimularityCalcShareOwner1 = [math]::Round($ShareCount/$ShareOwnerListCount,4) 
            $SimularityCalcShareOwner  = $SimularityCalcShareOwner1 / $ShareCount
            $SimularityCalcShareOwner  = $SimularityCalcShareOwner.ToString("F2")

            ## Calculate share to folder group ratio
            # Output value: 0 to 1                                       
            $SimularityCalcShareFg1 = [math]::Round($ShareCount/$ShareFolderGroupCount,4) # Original value
            $SimularityCalcShareFg  = $SimularityCalcShareFg1 / $ShareCount 
            $SimularityCalcShareFg  = $SimularityCalcShareFg.ToString("F2")

            ##
            ## Calculate if all descriptions for the target share name are the same.
            ## Output Value: 0 or 1
            $ShareDescriptionCount    = $ExcessiveSharePrivs | where sharename -EQ "$ShareName" | where ShareDescription -NE ""| select ShareDescription -Unique | measure | select count -ExpandProperty count        
            If($ShareDescriptionCount -ge 1){
                $SimularityCalcShareDesc = 1
            }else{
                $SimularityCalcShareDesc = 0
            }            

            ## ---
            ## Final Similarity Weighting V1
            ## ---------------------------------------------  
                      
            # Normalize Weight Groups
            # - File Name Coverage Weight Group
            # - File Group Coverage Wieght Group
            # - Share Properties Weight Group
            
            # Set final max
            $FinalSimilarityMax                     = 3.85

            # Set weighted values
            if($SimularityFileCoverageScore -eq 0){

                # 0 matches patch; means all folders are empty, so we want to weight up.
                $SimularityFileCoverageScoreW       = 2.25
            }else{

                # Default setting
                $SimularityFileCoverageScoreW       = $SimularityFileCoverageScore         * 2.25
            }
            $SimularityFolderGroupCoverageScoreW    = $SimularityFolderGroupCoverageScore  * 1          
            $SimularitySharePropCoverageScoreW      = $SimularitySharePropCoverageScore    * .6

            # Set final value
            $FinalSimilarityValue                   = $SimularityFolderGroupCoverageScoreW + 
                                                      $SimularityFileCoverageScoreW        +
                                                      $SimularitySharePropCoverageScoreW 

            # Set cumulative score
            $FinalSimilarityScore   = $FinalSimilarityValue / $FinalSimilarityMax
            $FinalSimilarityScoreP1 = [math]::round(($FinalSimilarityScore.tostring("P") -replace('%','')))
            $FinalSimilarityScoreP  = "$FinalSimilarityScoreP1%"           

            #
            # Set similarity classification
            #
            If($FinalSimilarityScore -ge .80){ $SimLevel = "$FinalSimilarityScoreP High"}
            If($FinalSimilarityScore -ge .95){ $SimLevel = "$FinalSimilarityScoreP Very High"}
            If($FinalSimilarityScore -lt .80){ $SimLevel = "$FinalSimilarityScoreP Medium"}
            If($FinalSimilarityScore -lt .50){ $SimLevel = "$FinalSimilarityScoreP Low"}                             

            # ----------------------------------------------------------------------
            # Calculate Similarity Score - END   
            # ---------------------------------------------------------------------- 
            #endregion SimilarityScore
            
            #region PeakDateRange
            # ----------------------------------------------------------------------
            # Calculate peak event date range - START
            # ----------------------------------------------------------------------
            # Assumptions: a) if only two unique dates exist, then both will be included in the observation window. 

            # Count total number of events
            $ShareEventCountTotal = $ExcessiveSharePrivs | where sharename -eq "$ShareName" | select SharePath, CreationDate -unique | measure | select count -expandproperty count

            # Identify the first event date
            $ShareEventFirst = $ExcessiveSharePrivs | where sharename -eq "$ShareName" | select SharePath, CreationDate -unique | foreach {[datetime]$_.CreationDate} | sort | select -first 1

            # Identify the last event date
            $ShareEventLast = $ExcessiveSharePrivs | where sharename -eq "$ShareName" | select SharePath, CreationDate -unique | foreach {[datetime]$_.CreationDate} | sort -desc | select -first 1

            # Determine total time between start and end of all events
            [timespan]$ShareEventTotalTime = $ShareEventLast -  $ShareEventFirst

            # Calculate the observation window date range based on the largest interval between events
            $ShareEventsSorted = $ExcessiveSharePrivs | where sharename -eq "$ShareName" | select SharePath, CreationDate -unique | foreach {[datetime]$_.CreationDate} | sort 
            [timespan]$ObservationWindow = "00:00:00"
            $ShareEventsSorted |
            foreach {                
                 [timespan]$Diff = ($_ - $ShareEventFirst )               
                 if($ObservationWindow -lt $Diff){
                    [timespan]$ObservationWindow = $Diff
                 }                 
            }          

            # Set initial observation window start and end dates
            $ObservationWindowStartDate = $ShareEventFirst
            $ObservationWindowsEndDate  = $ShareEventFirst + $ObservationWindow
            [datetime]$ObvWinnerFirst = '00:00:00'
            [datetime]$ObvWinnerLast = '00:00:00'
            $ObservationWindowRangecountWinner = 0
            $ObservationWindowsBiggest = 0
            $ObservationWindowsBiggestObject = ""
            if($ShareEventTotalTime.TotalMinutes -eq 0 -and $ObservationWindow.TotalMinutes -eq 0){
                $ObservationWindowInstanceCount = 0
            }else{
                $ObservationWindowInstanceCount = $ShareEventTotalTime.TotalMinutes / $ObservationWindow.TotalMinutes
            }

            # Iterate through the observeration windows to identify the one with the greatest number of events
            1..$ObservationWindowInstanceCount |
            Foreach{                                      

                    # Select range and get count
                    $ObservationWindowRangecount = $ShareEventsSorted | Where-Object { $_ -ge $ObservationWindowStartDate -and $_ -le $ObservationWindowsEndDate} | measure | select count -expandproperty count                                                   

                    # Check if count is bigger than last, if so set tracker
                    if($ObservationWindowsBiggest -le $ObservationWindowRangecount){

                        # Get window first date
                        [datetime]$ObvWinnerFirst = $ShareEventsSorted | Where-Object { $_ -ge $ObservationWindowStartDate -and $_ -le $ObservationWindowsEndDate} | select -first 1                        

                        # Get window last date
                        [datetime]$ObvWinnerLast = $ShareEventsSorted | Where-Object { $_ -ge $ObservationWindowStartDate -and $_ -le $ObservationWindowsEndDate} | sort -desc | select -first 1

                        $ObservationWindowRangecountWinner = $ObservationWindowRangecount                         

                        # Create object
                        # $ObservationWindowsBiggestObject = [PSCustomObject]@{ TotalCount = $ShareEventCountTotal; WindowCount = $ObservationWindowRangecount; WindowFirstDate = [datetime]$ObvWinnerFirst; WindowLastDate = [datetime]$ObvWinnerLast}
                    }

                    # Set $ObservationWindowStartDate to $ObservationWindowsEndDate
                    $ObservationWindowStartDate = $ObservationWindowsEndDate 

                    # Set $ObservationWindowsEndDate to $ObservationWindowsEndDate + $ObservationWindow
                    $ObservationWindowsEndDate  = $ObservationWindowsEndDate + $ObservationWindow
             }

            # ----------------------------------------------------------------------
            # Calculate peak event date range - END
            # ----------------------------------------------------------------------
            #endregion PeakDateRange

            #region Access Checks
            # ----------------------------------------------------------------------
            # Check share access types for name - START  
            # ----------------------------------------------------------------------

            # Check if high risk     
            try{                                
                $ShareRowHighRisk = $ExcessiveSharePrivs | Where ShareName -like "$ShareName" | 
                Foreach {
                    if(($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share'))
                    {
                        $_ # out to file
                    }
                }
                
                $ShareRowCountHRAcls         = $ShareRowHighRisk  | Measure-Object | select count -ExpandProperty count 
                $ShareRowCountHRShares       = $ShareRowHighRisk  | Select-Object SharePath    -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountHRComputers    = $ShareRowHighRisk  | Select-Object ComputerName -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountHRSharesCacl   = $ShareRowCountHRShares / $ShareCount
                $ShareRowCountHRSharesCaclP1 = [math]::round(($ShareRowCountHRSharesCacl.tostring("P") -replace('%','')))
                $ShareRowCountHRSharesCaclP  = "$ShareRowCountHRSharesCaclP1% ($ShareRowCountHRShares)"  

                if($ShareRowCountHRAcls -gt 0){
                   $ShareRowHasHighRisk    = "Yes"
                }else{
                   $ShareRowHasHighRisk    = "No"
                }
            }catch{
                $ShareRowCountHRAcls       = "Unknown"   
                $ShareRowCountHRShares     = "Unknown"   
                $ShareRowCountHRComputers  = "Unknown"   
                $ShareRowHasHighRisk       = "Unknown"              
            }

            # Check if write
            try{                                
                $ShareRowWrite = $ExcessiveSharePrivs | Where ShareName -like "$ShareName" | 
                Foreach {
                    if(($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*"))
                    {
                        $_ # out to file
                    }
                }
                
                $ShareRowCountWriteAcls         = $ShareRowWrite    | Measure-Object | select count -ExpandProperty count 
                $ShareRowCountWriteShares       = $ShareRowWrite    | Select-Object SharePath    -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountWriteComputers    = $ShareRowWrite    | Select-Object ComputerName -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountwriteSharesCacl   = $ShareRowCountwriteShares / $ShareCount
                $ShareRowCountwriteSharesCaclP1 = [math]::round(($ShareRowCountwriteSharesCacl.tostring("P") -replace('%','')))
                $ShareRowCountwriteSharesCaclP  = "$ShareRowCountwriteSharesCaclP1% ($ShareRowCountwriteShares)"  

                if($ShareRowCountWriteAcls -gt 0){
                   $ShareRowHasWrite          = "Yes"
                }else{
                   $ShareRowHasWrite          = "No" 
                }
            }catch{
                $ShareRowCountWriteAcls       = "Unknown"   
                $ShareRowCountWriteShares     = "Unknown"   
                $ShareRowCountWriteComputers  = "Unknown"   
                $ShareRowHasWrite             = "Unknown"              
            }

            # Check if read
            try{                                
                $ShareRowRead = $ExcessiveSharePrivs | Where ShareName -like "$ShareName" | 
                Foreach {
                    if(($_.FileSystemRights -like "*read*"))
                    {
                        $_ # out to file
                    }
                }
                
                $ShareRowCountReadAcls         = $ShareRowRead   | Measure-Object | select count -ExpandProperty count 
                $ShareRowCountReadShares       = $ShareRowRead   | Select-Object SharePath    -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountReadComputers    = $ShareRowRead   | Select-Object ComputerName -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountReadSharesCacl   = $ShareRowCountReadShares / $ShareCount
                $ShareRowCountReadSharesCaclP1 = [math]::round(($ShareRowCountReadSharesCacl.tostring("P") -replace('%','')))
                $ShareRowCountReadSharesCaclP  = "$ShareRowCountReadSharesCaclP1% ($ShareRowCountReadShares)"  

                if($ShareRowCountReadAcls -gt 0){
                   $ShareRowHasRead         = "Yes"
                }else{
                   $ShareRowHasRead         = "No" 
                }
            }catch{
                $ShareRowCountReadAcls      = "Unknown"   
                $ShareRowCountReadShares    = "Unknown"   
                $ShareRowCountReadComputers = "Unknown"   
                $ShareRowHasRead            = "Unknown"              
            }

            # Check if non defaults
            try{                                
                $ShareRowNonDefault = $ExcessiveSharePrivs | Where ShareName -like "$ShareName" | 
                Foreach {
                    if(($_.ShareName -like 'admin$') -or ($_.ShareName -like 'c$') -or ($_.ShareName -like 'd$') -or ($_.ShareName -like 'e$') -or ($_.ShareName -like 'f$'))
                    {
                        $_ # out to file
                    }
                }
                
                $ShareRowCountNonDefaultAcls      = $ShareRowNonDefault | Measure-Object | select count -ExpandProperty count                 
                if($ShareRowCountNonDefaultAcls -gt 0){
                   $ShareRowHasDefault         = "Yes"
                }else{
                   $ShareRowHasDefault         = "No"  
                }
            }catch{  
                $ShareRowHasDefault            = "Unknown"              
            }

            # Check if empty
            try{                                
                $ShareRowEmpty = $ExcessiveSharePrivs | Where ShareName -like "$ShareName" | where FileCount -eq 0
                
                $ShareRowCountEmptyAcls      = $ShareRowEmpty  | Measure-Object | select count -ExpandProperty count 
                $ShareRowCountEmptyShares    = $ShareRowEmpty  | Select-Object SharePath    -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountEmptyComputers = $ShareRowEmpty  | Select-Object ComputerName -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountEmptySharesCacl   = $ShareRowCountEmptyShares / $ShareCount
                $ShareRowCountEmptySharesCaclP1 = [math]::round(($ShareRowCountEmptySharesCacl.tostring("P") -replace('%','')))
                $ShareRowCountEmptySharesCaclP  = "$ShareRowCountEmptySharesCaclP1% ($ShareRowCountEmptyShares)"    

                if($ShareRowCountEmptyAcls -gt 0){
                   $ShareRowHasEmpty         = "Yes"
                }else{
                   $ShareRowHasEmpty         = "No" 
                }
            }catch{
                $ShareRowCountEmptyAcls      = "Unknown"   
                $ShareRowCountEmptyShares    = "Unknown"   
                $ShareRowCountEmptyComputers = "Unknown"   
                $ShareRowHasEmpty            = "Unknown"              
            }

            # Check if stale
            try{                                
                $oneYearAgo = (Get-Date).AddYears(-1)
                $ShareRowStale = $ExcessiveSharePrivs | Where ShareName -like "$ShareName" | where { $_.LastModifiedDate-ge $oneYearAgo }
                
                $ShareRowCountStaleAcls      = $ShareRowStale  | Measure-Object | select count -ExpandProperty count 
                $ShareRowCountStaleShares    = $ShareRowStale  | Select-Object SharePath    -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountStaleComputers = $ShareRowStale  | Select-Object ComputerName -Unique   | Measure-Object | select count -ExpandProperty count
                $ShareRowCountStaleSharesCacl   = $ShareRowCountStaleShares / $ShareCount
                $ShareRowCountStaleSharesCaclP1 = [math]::round(($ShareRowCountStaleSharesCacl.tostring("P") -replace('%','')))
                $ShareRowCountStaleSharesCaclP  = "$ShareRowCountStaleSharesCaclP1% ($ShareRowCountStaleShares)"           

                if($ShareRowCountStaleAcls -gt 0){
                   $ShareRowHasStale         = "Yes"
                }else{
                   $ShareRowHasStale         = "No" 
                }
            }catch{
                $ShareRowCountStaleAcls      = "Unknown"   
                $ShareRowCountStaleShares    = "Unknown"   
                $ShareRowCountStaleComputers = "Unknown"   
                $ShareRowHasStale            = "Unknown"           
            }

            # Set default
            $ShareRowCountInteresting                = "No"

            # Check if interesting files 
         	# For each category generate count and list
	        $ShareNameInterestingFilesInsideHTML  = ""
            $ShareNameInterestingFilesOutsideHTML = ""
	        $FileNamePatternCategories | select Category -ExpandProperty Category | 
	        foreach{
		
		        # Get category
		        $ShareNameCategoryName = $_

		        # Get list of that sharename and category
                $ShareNameCategoryFilesBase = $InterestingFilesAllObjects | Where ShareName -eq "$ShareName" |  where Category -eq "$ShareNameCategoryName" | select FileName
		        $ShareNameCategoryFiles = $InterestingFilesAllObjects | Where ShareName -eq "$ShareName" |  where Category -eq "$ShareNameCategoryName" | select FileName | ForEach-Object { $ASDF = $_.FileName; "$ASDF<br>" }  | out-string

		        # Get category count
		        $ShareNameCategoryFilesCount =  $ShareNameCategoryFilesBase | measure | select count -expandproperty count 

		        # Generate HTML with Category
                if($ShareNameCategoryFilesCount -ne 0){
		            $ShareNameInterestingFilesHTMLPrep = @" 
                        <button class="collapsible" style="font-size: 10px;">$ShareNameCategoryFilesCount $ShareNameCategoryName</button>
 		                <div class="content" style="font-size: 10px; width:100px; overflow-wrap: break-word;">
		                $ShareNameCategoryFiles
		                </div>
"@
		            # Add to code block
		            $ShareNameInterestingFilesInsideHTML = $ShareNameInterestingFilesInsideHTML + $ShareNameInterestingFilesHTMLPrep
                }
	        }

            # Get total for interesting files for target share name
	        $ShareNameInterestingFilesCount = $InterestingFilesAllObjects | Where ShareName -eq "$ShareName" | measure | select count -expandproperty count 
            if($ShareNameInterestingFilesCount -gt 0){
                $ShareRowCountInteresting = "Yes"
            }else{
                 $ShareRowCountInteresting = "No"
            }

            # Get secrets count
            $ShareRowInterestingFileListSecretsCount = $InterestingFilesAllObjects | Where ShareName -eq "$ShareName" |  Where Category -eq "Secret" | measure | select count -expandproperty count 

            # Get sensitive count
            $ShareRowInterestingFileListDataCount    = $InterestingFilesAllObjects | Where ShareName -eq "$ShareName" |   Where Category -eq "Sensitive" | measure | select count -expandproperty count 
       
            # Build final interesting file html for share names page
	        $ShareNameInterestingFilesOutsideHTML = @"
		        <button class="collapsible"  style="font-size: 10px;">$ShareNameInterestingFilesCount Files</button>
 		        <div class="content" style="font-size: 10px; width:100px; overflow-wrap: break-word;">
		        $ShareNameInterestingFilesInsideHTML
		        </div>
"@
            
            # Build coverage icon set
            $CoverageIcons = ""
            if($ShareRowHasHighRisk        -eq "Yes"){ $CoverageIcons = $CoverageIcons + "<div class=`"tooltip`"><div class=`"circle`">H</div><span class=`"tooltiptext`">Highly Exploitable</span></div>&nbsp;" }
            if($ShareRowHasWrite           -eq "Yes"){ $CoverageIcons = $CoverageIcons + "<div class=`"tooltip`"><div class=`"circle`">W</div><span class=`"tooltiptext`">Write Access</span></div>&nbsp;" }
            if($ShareRowHasRead            -eq "Yes"){ $CoverageIcons = $CoverageIcons + "<div class=`"tooltip`"><div class=`"circle`">R</div><span class=`"tooltiptext`">Read Access</span></div>&nbsp;" }
            if($ShareRowCountInteresting   -eq "Yes"){ $CoverageIcons = $CoverageIcons + "<div class=`"tooltip`"><div class=`"circle`">I</div><span class=`"tooltiptext`">Interesting Files<br>such as secrets<br>and sensitive data.</span></div>&nbsp;" }
            if($ShareRowHasEmpty           -eq "Yes"){ $CoverageIcons = $CoverageIcons + "<div class=`"tooltip`"><div class=`"circle`">E</div><span class=`"tooltiptext`">Empty. <br>At least one folder<br>group is empty.</span></div>&nbsp;" }
            if($ShareRowHasStale           -eq "Yes"){ $CoverageIcons = $CoverageIcons + "<div class=`"tooltip`"><div class=`"circle`">S</div><span class=`"tooltiptext`">Stale. <br>No modifications in <br>a year or more.</span></div>&nbsp;" }

            # ----------------------------------------------------------------------
            # Check share access types for name - END 
            # ----------------------------------------------------------------------
            #endregion Check Access


            # ----------------------------------------------------------------------
            # Calculate Risk Level
            # ----------------------------------------------------------------------

            # Grab the risk level for the highest risk acl for the share name
            $ShareNameTopACLRiskScore = $ExcessiveSharePrivsFinal | where ShareName -eq $ShareName | select RiskScore | sort RiskScore -Descending | select -First 1  | select RiskScore -ExpandProperty RiskScore

            # Check risk level - Highest wins
            If($ShareNameTopACLRiskScore -le 4                                          ) { $RiskLevelShareNameResult = "Low"}
            If($ShareNameTopACLRiskScore -gt 4  -and $ShareNameTopACLRiskScore -lt 11   ) { $RiskLevelShareNameResult = "Medium"} 
            If($ShareNameTopACLRiskScore -ge 11 -and $ShareNameTopACLRiskScore -lt 20   ) { $RiskLevelShareNameResult = "High"}     
            If($ShareNameTopACLRiskScore -ge 20                                         ) { $RiskLevelShareNameResult = "Critical"}   
             
            # Set final risk level
            if($RiskLevelShareNameResult -eq "Low"     ){$RiskLevel = "$ShareNameTopACLRiskScore Low"}
            if($RiskLevelShareNameResult -eq "Medium"  ){$RiskLevel = "$ShareNameTopACLRiskScore Medium"}
            if($RiskLevelShareNameResult -eq "High"    ){$RiskLevel = "$ShareNameTopACLRiskScore High"}
            if($RiskLevelShareNameResult -eq "Critical"){$RiskLevel = "$ShareNameTopACLRiskScore Critical"}

            # ----------------------------------------------------------------------
            # Build UNC Path Lists
            # ----------------------------------------------------------------------
            $GetRowUncPathsRaw   = $ExcessiveSharePrivs | where ShareName -EQ "$ShareName" | Select SharePath -Unique
            $GetRowUncPathsCount = $GetRowUncPathsRaw | measure | select count -ExpandProperty count
            $GetRowUncPaths      = $GetRowUncPathsRaw | ForEach-Object { $ASDF = $_.SharePath; "$ASDF<br>" } | Out-String
                                      
            # ----------------------------------------------------------------------
            # Build Share Name Summary Page Rows
            # ----------------------------------------------------------------------
            # Build Rows
            $ThisRow = @" 
	          <tr h="$ShareRowHasHighRisk" w="$ShareRowHasWrite" r="$ShareRowHasRead" i="$ShareRowCountInteresting" e="$ShareRowHasEmpty" s="$ShareRowHasStale" n="$ShareRowHasDefault" >
              <td style="text-align:Center;">
                    <button class="collapsible">
		            $GetRowUncPathsCount
                     </button>
                    <div class="content" style="width:80px;overflow-wrap: break-word;text-align:left;font-size: 10px;">
                  	    $GetRowUncPaths                                                   
                    </div>  
	          </td>	 
	          <td style="vertical-align: top;text-align:left">
                  <button class="collapsible" style="text-align:left">
                  $ShareName<br>
                  $CoverageIcons
                  </button>
                  <div class="content">
                  <div class="filelistparent" style="font-size: 10px;"> 
                      $ShareDescriptionSample                                                                
                      <strong>Affected Assets</strong><br>
                      <table class="subtable">
                       <tr id="ignore">
                        <td>Computers:</td><td>&nbsp;$ComputerBar</td>
                       </tr>
                       <tr id="ignore">
                        <td>Shares:</td><td>&nbsp;$ShareBar</td>
                       </tr>
                       <tr id="ignore">
                        <td>ACLs:</td><td>&nbsp;$AclBar</td>
                       </tr>
                      </table>      
                      <br><br>

                      <strong>Timeline Context</strong><br>
                      <table class="subtable">
                       <tr id="ignore">
                        <td>First Created:</td>                          
                        <td>&nbsp;$ShareFirstCreated</td> 
                       </tr>
                       <tr id="ignore">
                        <td>Last Created:</td> 
                        <td>&nbsp;$ShareLastCreated</td> 
                       </tr>
                       <tr id="ignore">
                        <td>Last Mod:</td> 
                        <td>&nbsp;$ShareLastModified</td> 
                       </tr>
                       </table>  
                       <br><br>

                      <strong>Owners ($ShareOwnerListCount)</strong> 
                      <br>                  
                      $ShareOwnerListHTML                                                        
                  </div>
                  </div>                            
	          </td>	
              <td>
		        <button class="collapsible" style="text-align:left; font-size: 10px;">
               <strong>$RiskLevel</strong>
                </button>
                <div class="content">
                    <div class="filelistparent" style="font-size: 10px;width:90px;"> 
                      <strong>Risk Summary</strong><br>
                      <table class="subtable">
                       <tr id="ignore">
                        <td>HE:</td><td>&nbsp;$ShareRowCountHRSharesCaclP</td>
                       </tr>
                       <tr id="ignore">
                        <td>Write:</td><td>&nbsp;$ShareRowCountwriteSharesCaclP</td>
                       </tr>
                       <tr id="ignore">
                        <td>Read:</td><td>&nbsp;$ShareRowCountReadSharesCaclP</td>
                       </tr>
                       <tr id="ignore">
                        <td>Stale:</td><td>&nbsp;$ShareRowCountStaleSharesCaclP</td>
                       </tr>
                       <tr id="ignore">
                        <td>Empty:</td><td>&nbsp;$ShareRowCountEmptySharesCaclP</td>
                       </tr>
                       <tr id="ignore">
                        <td>Default:</td><td>&nbsp;$ShareRowHasDefault</td>
                       </tr>
                       <tr id="ignore">
                        <td>Sensitive:</td><td>&nbsp;$ShareRowInterestingFileListDataCount</td>
                       </tr>
                       <tr id="ignore">
                        <td>Secrets:</td><td>&nbsp;$ShareRowInterestingFileListSecretsCount</td>
                       </tr>
                      </table>      
                    </div>
                </div>  
              </td>		 
	          <td>
                <button class="collapsible" style="font-size: 10px;"><strong>$SimLevel</strong></button>
                    <div class="content">
                        <div class="filelistparent" style="font-size: 10px;width:120px;">          
                            <table class="subtable">
                                <tr id="ignore">
                                    <td><strong>Final Score: </strong>:</td><td>&nbsp;<strong>$FinalSimilarityScoreP</strong></td>
                                </tr> 
                                <tr id="ignore">
                                    <td>File Name Coverage:</td><td>&nbsp;$SimularityFileCoverageScoreP</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>Folder Group Coverage:</td><td>&nbsp;$SimularityFolderGroupCoverageScoreP</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>Share Property Coverage:</td><td>&nbsp;$SimularitySharePropCoverageScoreP</td>
                                </tr> 
                            </table>
                            <br> --- <br>  
                             
                            <strong>File Name Metrics</strong><Br>
                            <table class="subtable">
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;10%:</td><td>&nbsp;$SimularityFileCoverage10</td>
                                </tr>
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;20%:</td><td>&nbsp;$SimularityFileCoverage20</td>
                                </tr>
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;30%:</td><td>&nbsp;$SimularityFileCoverage30</td>
                                </tr>
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;40%:</td><td>&nbsp;$SimularityFileCoverage40</td>
                                </tr>
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;51%:</td><td>&nbsp;$SimularityFileCoverage50</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;60%:</td><td>&nbsp;$SimularityFileCoverage60</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;70%:</td><td>&nbsp;$SimularityFileCoverage70</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;80%:</td><td>&nbsp;$SimularityFileCoverage80</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>FG Coverage  &nbsp;90%:</td><td>&nbsp;$SimularityFileCoverage90</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>FG Coverage 100%:</td><td>&nbsp;$SimularityFileCoverage100</td>
                                </tr>                                  
                            </table>

                            <Br><Br><strong>Folder Group Metrics</strong><Br>
                            <table class="subtable">
                                <tr id="ignore">
                                    <td>1 FG &nbsp;10%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage10</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG &nbsp;20%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage20</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG &nbsp;30%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage30</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG &nbsp;40%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage40</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG &nbsp;51%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage50</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG &nbsp;60%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage60</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG &nbsp;70%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage70</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG &nbsp;80%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage80</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG &nbsp;90%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage90</td>
                                </tr> 
                                <tr id="ignore">
                                    <td>1 FG 100%/shares:</td><td>&nbsp;$SimularityFolderGroupCoverage100</td>
                                </tr>

                            </table>
                            <Br><Br><strong>Share Property Metrics</strong><Br>
                            <table class="subtable">
                                <tr id="ignore">
                                    <td>Same Share Name:</td><td>&nbsp;1</td>
                                </tr>
                                <tr id="ignore">
                                    <td>folder Group/Owner Ratio Average:</td><td>&nbsp;$SimularitySharePropFGOwnerAvgT</td>
                                </tr>
                                <tr id="ignore">
                                    <td>Creation Date/Share Ratio:</td><td>&nbsp;$SimularitySharePropCreateDateRatioT</td>
                                </tr>
                                <tr id="ignore">
                                    <td>Last Modification Date/Share Ratio:</td><td>&nbsp;$SimularitySharePropModDateRatioT</td>
                                </tr>
                            </table>
                            <Br><Br><strong>Experimental Metrics</strong><Br>
                            <table class="subtable">
                                <tr id="ignore">
                                    <td>Share Owner Ratio:</td><td>&nbsp;$SimularityCalcShareOwner</td>
                                </tr>
                                <tr id="ignore">
                                    <td>File Group/Name Ratio:</td><td>&nbsp;$SimularityCalcShareFg</td>
                                </tr>
                                <tr id="ignore">
                                    <td>All Descriptions Match:</td><td>&nbsp;$SimularityCalcShareDesc</td>
                                </tr>
                            </table>
                        </div>
                    </div>	              	 
	          </td>	
              <td>                  
                  <button class="collapsible" style="font-size: 10px;text-align:left;"><strong>$ShareFolderGroupCount</strong></button>
                  <div class="content" style="width:100px;">
                  $ShareFolderGroupList
                  </div> 
              </td>   
	          <td style="font-size: 10px;">
              <button class="collapsible" style="font-size: 10px;"><strong>$SimularityFileCommonListTopNum Files</strong></button>
              <div class="content" style="width:100px;overflow-wrap: break-word;">                                         
                  <table class="subtable" style="width:80%;"`>
                  $SimularityFileCommonListTop
                  </table>
              </div>
	          </td> 
	          <td style="font-size: 10px;">
                $ShareNameInterestingFilesOutsideHTML          
	          </td>          	  
	          </tr>
"@              
            $ThisRow  
        } 

        # Get share name string list for card
        $CommonShareNamesRollingCount = 0
        $CommonShareNamesTopStringTCard = $CommonShareNamesTop5 |
        foreach {
            $ShareCount = $_.count
            $CommonShareNamesRollingCount = $CommonShareNamesRollingCount + $ShareCount
            $ShareName = $_.name
            $ShareNameBars = Get-GroupNameBar -DataTable $ExcessiveSharePrivs -Name $ShareName -AllComputerCount $ComputerCount -AllShareCount $AllSMBSharesCount -AllAclCount $ShareACLsCount
            $ComputerBar = $ShareNameBars.ComputerBar
            $ShareBar = $ShareNameBars.ShareBar
            $AclBar = $ShareNameBars.AclBar
            $ShareFolderGroupList = $ExcessiveSharePrivs|where sharename -like "$ShareName" | select filelistgroup -Unique | select filelistgroup -ExpandProperty filelistgroup
            $ThisRow = @" 
	          <tr>
	          <td>
              $ShareName
	          </td>	
	          <td>
              $ShareCount
	          </td>		          	  
	          </tr>
"@              
            $ThisRow  
        } 
        $CommonShareNamesTotalC = [math]::Round($CommonShareNamesRollingCount/$AllSMBSharesCount,4)
        $CommonShareNamesTotalP = $CommonShareNamesTotalC.tostring("P") -replace(" ","")

        # Get owner string list 
        $CommonShareOwnersTop5String = $CommonShareOwnersTop5 |
        foreach {
            $ShareCount = $_.count
            $ShareOwner = $_.name
            Write-Output "$ShareCount $ShareOwner<br>"   
        } 

        # Get owner string list table
        $CommonShareOwnersTop5StringT = $CommonShareOwnersTop5 |
        foreach {
            $ShareCount = $_.count
            $ShareOwner = $_.name
            $ShareOwnerBars = Get-GroupOwnerBar -DataTable $ExcessiveSharePrivs -Name $ShareOwner -AllComputerCount $ComputerCount -AllShareCount $AllSMBSharesCount -AllAclCount $ShareACLsCount
            $ComputerBarO = $ShareOwnerBars.ComputerBar
            $ShareBarO = $ShareOwnerBars.ShareBar
            $AclBarO = $ShareOwnerBars.AclBar
            $ThisRow = @" 
	          <tr>
	          <td>
              $ShareCount
	          </td>	
	          <td>
              $ShareOwner
	          </td>		  
	          <td>
	          $ComputerBarO
	          </td>		  
	          <td>
	          $ShareBarO
	          </td>  
	          <td>
	          $AclBarO
	          </td>          	  
	          </tr>
"@              
            $ThisRow    
        } 
       
$NewHtmlReport = @" 
<html>
<head>
  <link rel="shortcut icon" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTM4IDc5LjE1OTgyNCwgMjAxNi8wOS8xNC0wMTowOTowMSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTcgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6QTQxQkNBNzA2OEI1MTFFNzlENkRCMzJFODY4RjgwNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6QTQxQkNBNzE2OEI1MTFFNzlENkRCMzJFODY4RjgwNDMiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpBNDFCQ0E2RTY4QjUxMUU3OUQ2REIzMkU4NjhGODA0MyIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpBNDFCQ0E2RjY4QjUxMUU3OUQ2REIzMkU4NjhGODA0MyIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Ptdv5vcAAAB9SURBVHjaYmTAAS4IajsCqeVQbqTB+6v7saljxKHZCUhtAWJOqNB3IPYBGrKPoAFYNDPgM4SRSM04DWEkQTNWQxhJ1IxhCCM0tLeSoBnZEG+QAS+ADHEG8sBLJgYKAciASKhzGMjwQiTlgUiVaKRKQqJKUqZKZiI1OwMEGAA7FE70gYsL4wAAAABJRU5ErkJggg==" >
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/cytoscape/3.21.0/cytoscape.min.js"></script>
  <script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- Font Awesome -->
  <script src="https://unpkg.com/dagre/dist/dagre.min.js"></script>
  <script src="https://unpkg.com/cytoscape-dagre/cytoscape-dagre.js"></script>
  <script src="https://unpkg.com/cytoscape-euler/cytoscape-euler.js"></script>
  <script src="https://unpkg.com/klayjs/klay.js"></script>
  <script src="https://unpkg.com/cytoscape-klay/cytoscape-klay.js"></script>  
  <title>Report</title>
  <style>    
     .modern-input {
            width: 150px;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            background-color: #f9f9f9;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.2s ease;
        }

        .modern-input:focus {
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            border-color: #25648C;
            outline: none;
        }

        .modern-button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            color: #fff;
            background-color: #17405A;
            cursor: pointer;
            transition: background-color 0.2s ease;
            margin: 4px 2px;
        }

        .modern-button:hover {
            background-color: #25648C;
        }

        .modern-dropdown {
            width: 158px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            background-color: #f9f9f9;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .modern-dropdown-item {
            display: block;
            padding: 8px;
            color: #333;
            text-decoration: none;
            transition: background-color 0.2s ease;
        }

        .modern-dropdown-item:hover {
            background-color: #f0f0f0;
        }

        .modern-slider {
            -webkit-appearance: none;
            width: 100px;
            height: 6px;
            background: #ddd;
            border-radius: 5px;
            outline: none;
            transition: background 0.3s ease;
        }

        .modern-slider::-webkit-slider-thumb {
            -webkit-appearance: none;
            width: 16px;
            height: 16px;
            background: #07142A;
            border-radius: 50%;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .modern-slider::-webkit-slider-thumb:hover {
            background: #0056b3;
        }

        .modern-popup {
            display: none;
            position: absolute;
            top: 0;
            right: 0;
            width: 40%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.9);
            border-left: 2px solid #ccc;
            box-shadow: -5px 0 15px rgba(0, 0, 0, 0.3);
            padding: 20px;
            overflow-y: auto;
            z-index: 9999;
            border-radius: 4px;
        }

        .modern-resizer {
            width: 5px;
            height: 100%;
            background-color: #ddd;
            position: absolute;
            left: 0;
            top: 0;
            cursor: ew-resize;
        }
  
     #cy {
            width: 100%;
            height: 100%;
            display: block;
            background-color: #f0f3f5;
        }

        /* The container <div> - needed to position the dropdown content */
        .dropdown {
            position: relative;
            display: inline-block;
            align-items: center;
            text-align: left;
        }

        /* Dropdown Content (Hidden by Default) */
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f1f1f1;
            min-width: 120px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            right: 0px;
            left: 0px;
            top: 32px;
        }

        /* Links inside the dropdown */
        .dropdown-content a {
            color: black;
            padding: 5px 5px;
            text-decoration: none;
            display: block;
        }

        .ToolBarButton {
            --border-radius: 8px;
            --color: #7F7F7F;
            --padding-top: 0px;
            --padding-bottom: 0px;
            --padding-right: 11px;
            --padding-left: 10px;
            --padding-top: 12px;
            --padding-bottom: 0px;
            --margin-top: 2px;
            --margin-bottom: 2px;
            padding-top: 15px;
            padding-bottom: 3px;
            padding-right: 5px;
            padding-left: 5px;
        }

        #nodemenu a:hover {
            background-color: gray;
            color: white; /* Optional: changes the text color to white for better contrast */
        }

        .slider-container {
            text-align: center;
        }

        .slider {
            width: 300px;
            margin: 20px 0;
        }

        .slider-value {
            font-size: 24px;
            color: #333;
        }

        .side-menu {			
			box-shadow: 0 2px 4px 0;
			width: 180px;
			height: 100%;
			background-color:#07142A;
			position: fixed; /* Stay in place */
			top: 0; 
			left: 0;
			float:left;
			line-height:1.15;
			-webkit-text-size-adjust:100%;
			-ms-text-size-adjust:100%;
			z-index: 1;		
			--transition: width 0.3s; /* Smooth transition when expanding/collapsing */		
			background: linear-gradient(to bottom, #07142A 80%, rgba(0, 0, 0, 1) 98%, black 100%);			
        }
		
		.side-menu.collapsed div,
		.side-menu.collapsed h2,
		.side-menu.collapsed ul,
		.side-menu.collapsed ul li {
			opacity: 0; /* Hide text and child divs when collapsed */
			height: 0; /* Collapse height to prevent content from being visible */
			overflow: hidden; /* Ensure that any overflow content is hidden */
			transition: opacity 0.3s, height 0.3s; /* Smooth transition for hiding content */
		}

		.side-menu a {
				width:auto;
				cursor:initial;
				border-bottom:2px solid transparent;
				-webkit-box-ordinal-group:2;
				-ms-flex-order:1;
				order:1;
		}		

        .side-menu.collapsed {
            width: 50px; /* Width when collapsed */
        }		

        .side-menu h2 {
            text-align: center;
            margin: 50px 0; /* Add margin for better spacing */
        }

        .side-menu ul {
            list-style-type: none;
            padding: 0;
            transition: opacity 0.3s; /* Fade effect */
        }

        .side-menu ul li {
            padding: 10px 0;
            text-align: center;
        }

        .menu-button {
            margin: 0;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            background-color: transparent;
            border: none;
            color: white;
            position: absolute;
            right: 10px; /* Align to right when expanded */
            top: 10px;   /* Align to top when expanded */
            --transition: all 0.3s; /* Smooth transition for position */
        }

        .menu-button .icon {
            font-size: 24px;
        }

        .side-menu.collapsed h2,
        .side-menu.collapsed ul li {
            opacity: 0; /* Hide text when collapsed */
        }

        .side-menu.collapsed .menu-button {
            right: 18px; /* Keep the icon aligned to the right */
            top: 10px;   /* Keep the icon aligned to the top */
        } 
  
        .toggle-content {
            display: block; /* Set to block to be expanded by default */	
        }

        .toggle-button {
            cursor: pointer;
			border: none;
            outline: none;
            background-color: transparent;	
			color: white;
        } 	

	.hidden { display: none; }

        button.pagination-button {
            border: none;
            outline: none;
            background-color: transparent;
            cursor: pointer;
            padding: 5px 10px;
            margin: 2px;	
			border-radius:0.20rem 0.20rem 0.20rem 0.20rem;	
			color: #07142A;			
        }
        button.pagination-button:hover{
            background-color: #F56A00 ;
            color: #07142A;		
		}
		
        button.pagination-button.active {
            background-color: #07142A;
            color: white;
        }

    .1collapsible:after {
	  content: '\0208A';
	  font-size: 30;
	  color: gray;
	  padding: 5px;
	  font-weight: bold;
	}

	.1active:after {
	  content: "\0078"; 
	  font-size: 30;
	  color: gray;
	  padding: 5px;
	  --font-weight: bold;	  
	}
  
	.collapsible {
		font-family:"Open Sans", sans-serif;
		font-size:15;
		font-weight:600;
		color: #333;	
		padding-left:0px;
		background-color: inherit;
		cursor: pointer;
		border: none;
		outline: none;		
	}

	.active, .collapsible:hover {
	  --background-color: #555;
	  color:#CE112D;
	  --font-weight:bold;
	}

	.content {
	  max-height: 0;
      --max-width: 0;
	  overflow: hidden;
	  transition: max-height 0.2s ease-out;
      transition: max-width 0.2s ease-out;
	}

	.tabs{
		margin-top: 10px;
		display:-webkit-box;
		display:-ms-flexbox;
		display:flex;
		-ms-flex-wrap:wrap;
		flex-wrap:wrap;
		width:100%
	}
	
	.tabInput{
		position:fixed;
		top:0;
		left:0;
		opacity:0
	}
	
	.tabLabel{
		width:auto;
		color:#C4C4C8;
		--font-weight:bold;
		--cursor:pointer;
		padding-left: 15px;
		--border-bottom:2px solid transparent;
		-webkit-box-ordinal-group:2;
		-ms-flex-order:1;
		order:1;
		--border-radius:0.80rem 0.80rem 0.80rem 0.80rem
	}
	
	.tabLabel:focus{
		outline:0	
		background-color:red;
	}
	
	.tabInput:target+
	.tabLabel,
	.tabInput:checked+
	.tabLabel{
		--background:white;
		--border-bottom-color:#9B3722;
		--border-bottom:2px solid;
		--color:#9B3722; red
		font-weight: bold;
	}

	.stuff {
		color:#C4C4C8;
		font-weight: bold;
		font-weight: normal;	
		width:auto;		
		text-decoration: none;
		padding-top:5px;
		padding-bottom:5px;
		padding-left:15px;
		order:1;
		border-radius: 0px;
		margin-left:5px;
	}

		.stuff:hover{
			font-weight: normal;
			background-color:#17405A;
			text-decoration: none;
			padding-top:5px;
			padding-bottom:5px;
			margin-right:5px;
			margin-left:5px;
			color: white;
			border-radius: 5px;
			--box-shadow: inset 0 0 0 0.25px white;
			--outline: 1px solid #F56A00; /* Adjust thickness and color */
			outline: 1px ridge #cfcfd4; /* Adjust thickness and color */
			transition: color 0.3s ease;
			transition: background-color 0.3s ease;
			--background: linear-gradient(to bottom, #17405A, #FFFFFF);
		}

		.stuff:active {
			font-weight: normal;		 
			background-color:#25648C;		
			width:auto;		
			padding-left: 15px;	
			color: white;
			transition: background-color 0.2s ease;
		}			

	.tabLabel:hover{
		background-color:#555555;		
		color:#ccc;
		--border-color:#eceeef #eceeef #ddd			
	}
		
	.tabPanel{
		display:none;width:100%;
		-webkit-box-ordinal-group:100;
		-ms-flex-order:99;order:99
	}
	
	.tabInput:target+
	.tabLabel+.tabPanel,
	.tabInput:checked+
	.tabLabel+
	.tabPanel{
		display:block
	}
	
	.tabPanel.nojs{
		opacity:0
	}
  
	{box-sizing:border-box}
	body,html{
		font-family:"Open Sans", 
		sans-serif;font-weight:400;
		min-height:100%;
		color:#3d3935;
		margin:0px;
		line-height:1.5;
		overflow-x:hidden
		font-family:"Proxima Nova","Open Sans",-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif;
		font-size:14px;
		font-weight:normal;
		line-height:1.3;
		background-color:#f0f3f5;
		--color:#333;
		--background-color:#DEDFE1
	}
		
	table{
		width:100%;
		max-width:100%;
		--margin-bottom:1rem;
		border-collapse:collapse;	
		border:.5px solid lightgray;	
	}
		
	.tabledrop {
		box-shadow: 0 2px 4px 0 lightgray;
		margin: 10px;
		width: 90%;
	}
	
	.tabledrop:hover {
		box-shadow: 0 6px 12px 0 lightgray;
	}	
	
	table thead th{
		vertical-align:bottom;
		background-color: white;
		color:#4A4A4A;
		border:.5px solid lightgray;
		--border-top-right-radius: 10px;	
	}
	
	table tbody tr{
		background-color:white;	
	}	

	table thead th:nth-child(1){	 
		--border-top-left-radius: 10px;	
	}	
	
	table thead th:nth-child(last){	 
		--border-top-right-radius: 10px;	
	}	
	
	table tbody tr:nth-of-type(odd){
		--background-color:#F0E8E8;
		background-color:#f9f9f9;		
	}
	
	table tbody tr:hover{
		background-color:#ECF1F1;	
		--font-weight: bold;		
	}
	
	table td,table th{
		padding:.75rem;
		line-height:1.5;
		text-align:left;
		font-size:1rem;
		vertical-align:top;
		border-top:1px solid #eceeef
	}

    .NamesTh {
        cursor: pointer;
    }

	.subtable{
		all: unset;
        margin: 0;
        padding: 0;
        border: none;
        background: none;
        color: initial;
        text-align: left;
		font-family:"Proxima Nova","Open Sans",-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif;
		font-size:10px;	
        border-collapse: unset;
	}

	.subtable td {
		background: none;	
        font-size:10px;	
        text-align: left;
        margin: 0;
        padding: 0;
        border: none;
        border-collapse: unset;
	}

	.subtable tr {
		background: none;	
        font-size:10px;	
        text-align: left;
        margin: 0;
        padding: 0;
        border: none;
        border-collapse: unset;
	}

	.subtable tbody td:nth-child(1) {
		background: none;	
        font-size:10px;	
        text-align: left;
        margin: 0;
        padding: 0;
        border: none;
        border-collapse: unset;
	}

	.subtable  tbody tr:nth-of-type(odd) {
		background: none;	
        font-size:10px;
        text-align: left;
        margin: 0;
        padding: 0;
        border: none;
        border-collapse: unset;
	}

	.subtable  tbody tr:hover {
		background: none;	
        font-size:10px;	
        text-align: left;
        margin: 0;
        padding: 0;
        border: none;
        border-collapse: unset;
	}
	
	h2{
		font-size:2rem
	}
		
	h3{
		font-size:1.75rem
	}
	
	h4{
		font-size:1.5rem
	}
	
	h1,h2,h3,h4,h5,h6{
		margin-bottom:.5rem;
		margin-top:0px;
		font-family:inherit;
		font-weight:500;
		line-height:1.1;
		color:inherit
	}
	
	label{
		display:inline-block;
		padding-top:.5rem;
		padding-bottom:.25rem;
		--margin-bottom:.5rem
	}
	
	code{
		padding:.2rem .4rem;
		font-size:1rem;
		color:#bd4147;
		background-color:#f7f7f9;
		--border-radius:.25rem
	}
	
	p{
		margin-top:0;
		margin-bottom:1rem
	}
	
	a,a:visited{
		text-decoration:none;
		font-size: 14;
		color: gray;
		font-weight: bold;
	}
	
	a:hover{
		--color:#9B3722;
		text-decoration:underline
	}
	
	.preload *{
		-webkit-transition:none !important;
		-moz-transition:none !important;
		-ms-transition:none !important;
		-o-transition:none !important
	}
	
	.header{
		text-align:center
	}

    .noscroll{
        overflow:hidden
    }
	
	.link:hover{
		text-decoration:underline
	}
	
	li{
		list-style-type:none
	}
	
	.mobile{
		display:none;
		height:0;
		width:0
	}
	
	@media (max-width: 700px){
		.mobile{display:block !important}
	}
	
	code{
		color:black;
		font-family:monospace
	}
	
	ul.noindent{
		padding-left:20px
	}

    .pageDescription {
        margin: 10px;
		width:90%;
    }
	
	.pagetitle {
		font-size: 20;
		font-weight:bold;
		--color:#9B3722;
		--color:#CE112D;
		color:#07142A;
	}
	
	.pagetitlesub {
		font-size: 20;
		font-weight:bold;
		--color:#9B3722;
		color:#07142A;
		--color:#222222;
	}	
	
	.topone{background:#999999}
  
	.divbarDomain{
		background:#d9d7d7;
		width:200px;
		--border: 1px solid #999999;
		height: 15px;
		text-align:center;
	}
  
	.divbarDomainInside{
		--background:#9B3722;
		--background:#CE0E2D;	
        background:#F56A00;
		text-align:center;
		height: 15px;
		vertical-align:middle;
	}
	
	.piechartComputers {    		
        display: block;
        width: 130px;
        height: 130px;
        background: radial-gradient(white 60%, transparent 41%), 
		conic-gradient(#CE112D 0% $PercentComputerExPrivP, 
					   #d9d7d7 $PercentComputerExPrivP 100%);
		border-radius: 50%;
		text-align: center;
		margin-top: 5px;
		margin-bottom: 10px;
    }

	.piechartShares {    
        display: block;
        width: 130px;
        height: 130px;
        background: radial-gradient(white 60%, transparent 41%), 
		conic-gradient(#CE112D 0% $PercentSharesExPrivP, 
					   #d9d7d7 $PercentSharesExPrivP 100%);
		border-radius: 50%;
		text-align: center;
		margin-top: 5px;
		margin-bottom: 10px;
    }
	
	.piechartAcls {         
		display: block;
        width: 130px;
        height: 130px;
        background: radial-gradient(white 60%, transparent 41%), 
		conic-gradient(#CE112D 0% $PercentAclExPrivP, 
					   #d9d7d7 $PercentAclExPrivP 100%);
		border-radius: 50%;
		text-align: center;
		margin-top: 5px;
		margin-bottom: 10px;
    }

	.piechartLastAccess {         
		display: block;
        width: 130px;
        height: 130px;
        background: radial-gradient(white 60%, transparent 41%), 
		conic-gradient(#CE112D 0% $ExpPrivAccessLastP , 
					   #d9d7d7 $ExpPrivAccessLastP  100%);
		border-radius: 50%;
		text-align: center;
		margin-top: 5px;
		margin-bottom: 10px;
    }

	.piechartLastMod {         
		display: block;
        width: 130px;
        height: 130px;
        background: radial-gradient(white 60%, transparent 41%), 
		conic-gradient(#CE112D 0% $ExpPrivModLastP, 
					   #d9d7d7 $ExpPrivModLastP 100%);
		border-radius: 50%;
		text-align: center;
		margin-top: 5px;
		margin-bottom: 10px;
    }

	.percentagetextBuff {
		--height: 25%;
	}	
	
	.percentagetext {
		text-align: center;
		font-size: 2.25em;
		font-weight: 700;
		font-family:"Open Sans", sans-serif;
		--color:#9B3722;
		color:#F56A00;
	}
	
	.percentagetext2 {
		font-size: 10;
		font-family:"Open Sans", sans-serif;
		color:#666;			
		text-align: center;
	}	

	.dashboardsub {
		text-align: center;
		font-size: 12;
		font-family:"Open Sans", sans-serif;
		color:#666;
		font-weight: bold;
	}
	
	.dashboardsub2 {
		font-size: 10;
		font-family:"Open Sans", sans-serif;
		color:#666;		
		text-align: right;
	}	

	.landingheader	{
		font-size: 16;
		font-family:"Open Sans", sans-serif;
		color: #CE112D;
		font-weight: bold;	
		padding-left:0px;
	}

	.landingheader2	{
		font-size: 16;	
		--font-weight: bold;		
		color:White;
		--color:9B3722;
		--background-color: #ccc;		
		border-bottom: 2px solid #999;		
		padding-left:15px;
	}	
	
	.landingheader2a	{
        background-color: #07142A;
		--background-color: #999;		
		padding-left:120px;;
		padding-right: 5px;
	}	

	.landingheader2b	{
        background-color: #07142A;
		--background-color: #999;		
		padding-left: 5px;
		padding-right: 5px;
		margin-top: 10px;
		margin-left: 10px;
		font-size: 16;
		color:White;	
	}		
	
	.landingtext {
		font-size: 14;
		font-family:"Open Sans", sans-serif;
		color:#666;
		background-color:white;
		--border-radius: 10px;
		padding: 20px;
		margin-top: 10px;
		margin-right: 10px;
		margin-bottom: 15px;
		width: 90%		
	}
	
	.landingtext2 {
		font-size: 14;
		font-family:"Open Sans", sans-serif;
		color:#666;
		padding-top: 5px;
		padding-bottom: 20px;
		padding-left:15px;
	}

	.subexpandnocolor {
		font-size: 14;
		font-family:"Open Sans", sans-serif;
		color:#666;
		background-color:none;
		--border-radius: 0px;
		padding: 5px;
		margin-top: 5px;
		margin-right: 5px;
		margin-bottom: 5px;
		width: 90%		
	}	

	.filelist {
		font-size: 14;
		font-family:"Open Sans", sans-serif;
		color:#666;
		background-color:white;
		--border-radius: 0px;
		padding: 5px;
		margin-top: 5px;
		margin-right: 5px;
		margin-bottom: 5px;
		--width: 90%		
	}

	.filelistparent {
		font-size: 14;
		font-family:"Open Sans", sans-serif;
		color:#666;
		--background-color:white;
		--border-radius: 0px;
		padding: 5px;
		margin-top: 5px;
		margin-right: 5px;
		margin-bottom: 5px;
		--width: 90%		
	}

	.tablecolinfo {
		font-size: 14;
		font-family:"Open Sans", sans-serif;
		color:#666;		
	}

	.card {
		padding:10px;
		text-align: right;
		box-shadow: 0 2px 4px 0 #DEDFE1;	
		transition:0.3s;
		background-color: white;
		font-family:"Open Sans", sans-serif;
		font-size: 12;
		font-weight: 2;
		font-color: black;
		float: left;
		--overflow:auto;
		display:block;
		margin:10px;
		margin-bottom:20px;
		border:.5px solid lightgray;		
       		 border-radius: 3px;
	}

	.card:hover{	
		box-shadow: 0 6px 12px 0 lightgray;
		--box-shadow: 0 8px 16px 0 #DEDFE1;
		
	}

    .cardtitle{		
		font-size: 18;
		text-align: left;
	}

	.cardsubtitle {
		font-size: 12;
		font-family:"Open Sans", sans-serif;
		color:#222222;	
		text-align: left;
		font-weight: bold;
	}	

	.cardsubtitle2 {
		font-size: 12;
		font-family:"Open Sans", sans-serif;
		color:#eee;	
		text-align: left;
		font-weight: bold;
	}		

	.cardbartext {
		font-size: 10;
		font-family:"Open Sans", sans-serif;
		color:#666;			
		text-align: right;		
		font-weight:bold;
	}

	.cardbartext2 {
		font-size: 10;
		font-family:"Open Sans", sans-serif;
		color:#666;			
		text-align: right;
		margin-left: 10px;
	}
	
	.cardtitlescan{	
		padding:5px;	
		padding-left: 10px;
		font-size:15;
		color: white;
		font-weight:bold;
		font-family:"Open Sans", sans-serif;
		--border-bottom:1.5px solid transparent;
		--border-bottom-color:#222222;
		background-color: #07142A;
	}

	.cardtitlescansub {
		font-size: 10;
		font-family:"Open Sans", sans-serif;
		color: #eee;			
		text-align: center;
	}

	.cardcontainer {
		background-color:white;
		padding: 8px;
		: center;
		--padding-left: 10px;
		border-right:1px solid #ccc;
		border-left:1px solid #ccc;
		border-bottom:1px solid #ccc;	
		--border-bottom-right-radius: 10px;
		--border-bottom-left-radius: 10px;
		border-bottom-left-radius: 3px; 
		border-bottom-right-radius: 3px; 
	}	

	.cardbarouter{
		background:#d9d7d7;
		width:102px;
		--border: 1px solid #999999;
		height: 15px;
		text-align:center;
	}
	  
	.cardbarinside{
		--background:#9B3722;
		--background:#CE112D;
        background:#F56A00;
		text-align:center;
		height: 15px;
		vertical-align:middle;
        width: 0px;
	}	

	.AclEntryWrapper {
		--width: 300px;
		overflow: hidden; 
	}

	.AclEntryLeft {
		width: 75px;
		float:left;
		font-size: 12;
		font-family:"Open Sans", sans-serif;
		color:#666;	
        --font-weight:bold;		
	}
	.AclEntryRight{
		float: left; 
		font-size: 12;
		font-family:"Open Sans", sans-serif;
		color:#666;			
	}

	.sidenavcred{
		font-size: 12;
		font-family:"Open Sans", sans-serif;
		color: white;			
		text-align: left;
		padding-left:15px;
	}
	
.sidenav {
    box-shadow: 0 2px 4px 0;
	width: 180px;
	height: 100%;
	background-color:#07142A;
	position: fixed; /* Stay in place */
	top: 0; 
	left: 0;
	float:left;
	line-height:1.15;
	-webkit-text-size-adjust:100%;
	-ms-text-size-adjust:100%;
    z-index: 1;
}

.sidenav a {
		width:auto;
		cursor:initial;
		border-bottom:2px solid transparent;
		-webkit-box-ordinal-group:2;
		-ms-flex-order:1;
		order:1;
}

#main {
	margin-left: 190px;
	margin-right: 10px;
	--padding-left: 20px;
}

.Minicard {
		width: 115px;
		box-shadow: 0 2px 4px 0 #DEDFE1;	
		transition:0.3s;
		background-color: #BDBDBD;
		font-family:"Open Sans", sans-serif;
		font-size: 12;
		font-weight: 2;
		font-color: black;
		float: left;
		--overflow:auto;
		display:block;
		margin:0px;
		margin-bottom:20px;
        --border-radius: 10px;
	}

	.Minicard:hover{	
		--box-shadow: 0 8px 16px 0;
		box-shadow: 0 8px 16px 0 #CDCECF;		
	}	

	.Minicardtitle{	
		padding:5px;	
		--padding-left: 20px;
		font-size: 13;
		color: #07142A;
		font-weight:bold;
		font-family:"Open Sans", sans-serif;
		border-bottom:1.5px solid transparent;
		border-bottom-color:#07142A;
	}
	
	.Minicardcontainer {
		background-color:white;
		padding: 8px;
		: center;
		--padding-left: 10px;
		border-right:1px solid #ccc;
		border-left:1px solid #ccc;
		border-bottom:1px solid #ccc;	
		--border-bottom-right-radius: 10px;
		--border-bottom-left-radius: 10px;
	}		

	.MinicardconnectLine {    		
        display: block;
		float:left;
		border-bottom: 1px solid red;	         	
		height:10px;
		width:20px;
		margin-top:58px;	
    }
.TimelineChart{
  display: grid;
  --grid-template-columns: 1px repeat($ExcessivePrivsYearsCount, 204px) 1px;
  grid-template-rows: minmax(0px, 1fr);
  overflow-x: scroll;
  overflow-y: hidden;
  scroll-snap-type: x proximity;
  margin:5px;
  border:1px solid #ccc;
  background-color: #F2F3F4;
}

.TimelineChart:before,
.TimelineChart:after {
  content: '';
}

.TimelineChart> li,
.YearItem {
  display: flex;
  scroll-snap-align: left;
  padding:0;
  margin: 0;
  display: block;
  flex-direction: row;
  justify-content: left;
  align-items: left;
  background: #F0F2F4;
}

.TimelineBarOutside {
	position: relative;
	height: 153px;
	width: 15px;
	float: left;
	display: block;
	bottom: 0;
	left: 0;
}
	
.TimelineBarOutside:hover{
	background-color: white;

}

.TimelineBarOutside:hover > div{
	opacity: 1;
}	

.TimelineBarInside:hover > .TimelinePopup{
	visibility:visible;
}

.PopWrapper{
}

.PopWrapper:hover > .TimelinePopup {
    visibility:visible;
    z-index: 6;

}

.TimelineBarInside {
	width: 100%;
	display: block;
    background-color: #07142A;	
    opacity: .5;	
    margin-left:1px;
    position: absolute;
    top: 100%;
    -ms-transform: translateY(-100%);
    transform: translateY(-100%);	  
}

.TimelineDot {
	width: 100%;
	height:15px;
	display: block;
	background-color: blue;	
	position: absolute;
	bottom: 0;
	left: 0;		  
	opacity: .5;
    border-top: 1px solid #F2F3F4;
    border-bottom: 1px solid #F2F3F4;
}	

.TimelinePopup {

	visibility:hidden;
}	

.TimelineMinicard {
	width: 115px;
	box-shadow: 0 2px 4px 0 #DEDFE1;	
	background-color: #BDBDBD;
	font-family:"Open Sans", sans-serif;
	font-size: 10;
	font-weight: 2;
	font-color: black;
	float: left;
	display:block;
	margin:0px;
    margin-left: 20px;
    margin-top: 10px;
	-margin-bottom:20px;
    --border-radius: 10px;
}

.TimelineMinicard:hover{	
	box-shadow: 0 8px 16px 0 #CDCECF;		
}	

.TimelineMinicardtitle{	
	padding:5px;	
	font-size: 10;
	color: #07142A;
	font-weight:bold;
	font-family:"Open Sans", sans-serif;
	border-bottom:1.5px solid transparent;
	border-bottom-color:#757575;
}
	
.TimelineMinicardcontainer {
	background-color:white;
	padding: 8px;
	border-right:1px solid #ccc;
	border-left:1px solid #ccc;
	border-bottom:1px solid #ccc;	
	--border-bottom-right-radius: 10px;
	--border-bottom-left-radius: 10px;
}		

.TimelineMinicardconnectLine {    		
	display: block;
	float:left;
	border-bottom: 1px solid red;	         	
	height:10px;
	width:20px;
	margin-top:58px;	
}

.LargeCard {                              
	padding: 10px;
	background-color: white;
	transition:0.3s;
	font-family:"Open Sans", sans-serif;
	float: left;
	display:block;
	margin:10px;
	margin-bottom:20px;
	border:.5px solid lightgray;
	border-radius: 3px;   
	box-shadow: 0 2px 4px 0 #DEDFE1;
}

.LargeCard:hover{	
	box-shadow: 0 6px 12px lightgray;	
}

.LargeCardtitle{	
		font-size: 18;
		text-align: left;  
}

.LargeCardSubtitle2 {
	font-size: 12;
	font-family:"Open Sans", sans-serif;
	color:#eee;	
	text-align: left;
	font-weight: bold;
}		
	
.LargeCardContainer {
	background-color:white;
	padding: 8px;
	border-right:1px solid #ccc;
	border-left:1px solid #ccc;
	border-bottom:1px solid #ccc;	
	border-radius: 3px; 
}

.tooltip {
    position: relative;
    display: inline-block;
    cursor: pointer;
}

.tooltip .tooltiptext {
    visibility: hidden;
    width: 130px;
    font-size: 12;
    font-weight: normal;
    background-color: #555;
    color: #fff;
    text-align: center;
    vertical-align: middle;
    border-radius: 5px;
    padding: 6px 0;
    margin: 10px;
    left: -50px;
    position: absolute;
    z-index: 1;
    bottom: 125%; /* Position the tooltip above the text */
    opacity: 0;
    transition: opacity 0.3s
}

.tooltip:hover .tooltiptext {
    visibility: visible;
    opacity: 1;
}

input[type="checkbox"] {
    width: 20px;
    height: 20px;
    font-size: 16px;
    border-radius: 3px;    
    text-align: center;
    vertical-align: middle;  
    -webkit-appearance: none;
    border: 1px solid #BDBDBD;
    background-color: white;
}

input[type="checkbox"]:checked {
    background-color: #07142A; /* Change this to your desired color */
    --border-color: #07142A;	
    border: 1px solid #07142A;
}

input[type="checkbox"]:checked::before {
    content: '✔';
    color: #F56A00;
    display: block;
    text-align: center;
    line-height: 20px;
    font-size: 16px;
}

.searchbar {
	box-shadow: 0 2px 4px 0 #DEDFE1;
	margin-left:10px;
	background-color: #ccc;
	border-radius: 2px; 
	width:95%; 
	height: 40px;
	outline:1px solid #BDBDBD;
}

.circle {
    width: 14px;
    height: 14px;
    background-color: #f2f4f7;
	color: #07142A;
    border: 1.5px solid #07142A; /* 1px border */
    border-radius: 60%; /* Makes the div a circle */
    --display: flex;
    display: inline-block;
    align-items: center;
    justify-content: center;
    font-size: 10px; /* Adjust font size to fit the circle */
    text-align: center;
    vertical-align: middle;    
	opacity:.25; 
	font-weight: bold;	
    z-index: 2;
}

.circle:hover {
	opacity:.5;
}
  </style>
</head>
<body onload="radiobtn = document.getElementById('dashboard');radiobtn.checked = true;updateLabelColors('tabs', 'btnsummary');">

<!--  
|||||||||| SIDE MENU
-->
<div class="side-menu" id="sideMenu">	
	
	<button onclick="toggleMenu()" class="menu-button" style="margin-top: -15px; margin-right: -10px;">
            <span class="icon" style="font-size: 16px; color:#F56A00; transition: color 0.3s ease;" onmouseover="this.style.color='white'" onmouseout="this.style.color='#F56A00'"><i class="fas fa-times"></i></span>
    </button>
	
    <div  style="font-weight:bolder;color:white;margin-bottom:5px; margin-top:17px; margin-left: 14px;" align="left">
	<a href="https://github.com/NetSPI/PowerHuntShares" style="text-decoration: none; color:#F56A00;cursor: pointer;">
	<br><SPAN style="font-size: 15;">POWERHUNT</SPAN><SPAN style="color:white;font-size: 15;">SHARES</span></a>
    <br>
    <div style="font-size: 11;font-weight:normal;margin-top:3px;margin-left: 1px;">$TargetDomain</div>
	</div>

	<div id="tabs" class="tabs" data-tabs-ignore-url="false">	
		<label id="noactionmenubar1" href="#" class="stuff" style="background-color: transparent;text-align: center; border-bottom: 0.25px dashed gray; width:85%; margin-bottom: 4px; margin-top: -9px; border-radius: 0px;outline:none;"></label>	
		<label id="noactionmenuheader1"class="tabLabel" style="background-color: transparent; width:100%;color:#F56A00;padding-top:5px;padding-bottom:5px;margin-top:1px;margin-bottom:2px;font-weight:bolder;"><Strong>Results</Strong></label>
		<label id="btnsummary" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('dashboard');radiobtn.checked = true;updateLabelColors('tabs', 'btnsummary');">Summary Report</label>
		<label id="btnscaninfo" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('home');radiobtn.checked = true;updateLabelColors('tabs', 'btnscaninfo');">Scan Information</label>		
		<label id="noactionmenuheader2"class="tabLabel" style="background-color: transparent;width:100%;color:#F56A00;padding-top:5px;padding-bottom:5px;margin-top:1px;margin-bottom:2px;font-weight:bolder;"><Strong>Explore Data</Strong></label>
        <label id="btnnetworks" href="#" class="stuff" style="width:100%;" onclick="radiobtn = document.getElementById('SubNets');radiobtn.checked = true;updateLabelColors('tabs', 'btnnetworks');">Networks</label>	
        <label id="btncomputers" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('ComputerInsights');radiobtn.checked = true;updateLabelColors('tabs', 'btncomputers');">Computers</label>	  	  			
		<label id="btnshares" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('ShareName');radiobtn.checked = true;updateLabelColors('tabs', 'btnshares');">Share Names</label>					
		<label id="btnfgs" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('ShareFolders');radiobtn.checked = true;updateLabelColors('tabs', 'btnfgs');">Folder Groups</label>
        <label id="btnaces" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('AceInsights');radiobtn.checked = true;updateLabelColors('tabs', 'btnaces');">Insecure ACEs</label>
        <label id="btnidentities" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('IdentityInsights');radiobtn.checked = true;updateLabelColors('tabs', 'btnidentities');">Identities</label>
		<label id="noactionmenubar2" href="#" class="stuff" style="background-color: transparent;border-bottom: 0.25px dashed gray; opacity: 0.25; width:85%; margin-bottom: 6px; margin-top:-1px;border-radius: 0px;outline: none;"></label>			
        <label id="btnif" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('InterestingFiles');radiobtn.checked = true;applyFiltersAndSort('InterestingFileTable', 'filterInputIF', 'filterCounterIF', 'paginationIF');updateLabelColors('tabs', 'btnif');">Interesting Files</label>			   
        <label id="btnShareGraph" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('ShareGraph');radiobtn.checked = true;updateLabelColors('tabs', 'btnShareGraph');">ShareGraph</label>			        			     			
		<label id="noactionmenuheader3"class="tabLabel" style="background-color: transparent;width:100%;color:#F56A00;padding-top:5px;padding-bottom:5px;margin-top:1px;margin-bottom:2px;font-weight:bolder;"><strong>Recommendations</strong></label>
		<label id="btnexploit" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('Attacks');radiobtn.checked = true;updateLabelColors('tabs', 'btnexploit');">Exploiting Access</label>		
		<label id="btndetect" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('Detections');radiobtn.checked = true;updateLabelColors('tabs', 'btndetect');">Detecting Attacks</label>
		<label id="btnprioritize" href="#" class="stuff" style="width:100%;" onClick="radiobtn = document.getElementById('Remediation');radiobtn.checked = true;updateLabelColors('tabs', 'btnprioritize');">Prioritization</label>	        		
	</div>
</div>
<div id="main">

<!--  
|||||||||| PAGE: Interesting Files 
-->
		<input class="tabInput"  name="tabs" type="radio" id="InterestingFiles"/>
		<label class="tabLabel" onClick="updateTab('InterestingFiles',false)" for="InterestingFiles"></label>
		<div id="tabPanel" class="tabPanel">
		<h2 style="margin-top: 13.5px;margin-left:10px;margin-bottom: 17px;">Interesting Files</h2>
		<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>			
            <div style="margin-top:3px">					
				<div style="width:100%;">
                    <div style="margin-left:10px; width:95%;">                   
                    This section provides a list of files that may contain passwords or sensitive data, or may be abused for remote code execution.
                    </div>

			        <!-- /////////////// Interesting Files - Total -->					

                    <div class="card" style="width: 20%">	
	                    <div class="cardtitle" style="color:gray;font-size: 16px; font-weight: bold;">
		                   Interesting Files Found
	                    </div>		
                                    <br><br>
				                    <span class="percentagetext" style = "color:#f08c41;">                    
					                    $InterestingFilesAllFilesCount&nbsp;                     
				                    </span>	
			                    <Br>
                                <div style="padding-right: 10px;">
                                ($InterestingFilesAllFilesCountU unique file names)	
                                </div>
                    </div>


					<!-- /////////////// Interesting Files - Chart -->
					<div class="LargeCard" style="width:69.25%">	
	
									<div class="chart-container">
									<div id="chart"></div>
										<div class="chart-controls"></div>
									</div>								  							
					</div>	
									

					<!-- /////////////// Table  -->
                    <div style="height: 125px;text-align: left;"></div>

                    <div class="searchbar" style="text-align:left; display: flex;" >
							<input type="text" id="filterInputIF" placeholder=" Search..." style="margin-top: 8px; height: 25px; font-size: 14px; padding-left:3px;margin-left: 10px;border-radius: 3px;border: 1px solid #BDBDBD;outline: none;color:#07142A;">
							<div style="font-size:12;text-align: left;cursor: pointer;color:gray; margin-top: 13px; margin-left: 5px;" onmouseover="this.style.color='white';" onmouseout="this.style.textDecoration='';this.style.fontWeight='normal';this.style.color='gray';"onclick="document.getElementById('filterInputIF').value = '';applyFiltersAndSort('InterestingFileTable', 'filterInputIF', 'filterCounterIF', 'paginationIF');">Clear</div>
					 </div>
					<div style="display: flex; margin-left:10px; font-size:11; text-align:left;" >	
						<div id="filterCounterIF" style="margin-top:5px;">Loading...</div>
                        <a style="font-size:11; margin-top: 5px; margin-left: 5px;" href="#" onclick="extractAndDownloadCSV('InterestingFileTable', 3)">Export</a>						      
                    </div>
                    <table id="InterestingFileTable" class="table table-striped table-hover tabledrop" style="width: 95%;">
                      <thead>
                        <tr>

                        <th class="NamesTh"  onclick="sortTable('InterestingFileTable',0,'number')" style="vertical-align: middle;text-align: left;">File Count</th>       
                        <th class="NamesTh"  onclick="sortTable('InterestingFileTable',1,'alpha')" style="vertical-align: middle;text-align: left;">File Name</th>
                        <th class="NamesTh"  onclick="sortTable('InterestingFileTable',2,'alpha')" style="vertical-align: middle;text-align: left;">Category</th>
                        <th class="NamesTh"  onclick="sortTable('InterestingFileTable',3,'alpha')" style="vertical-align: middle;text-align: left;">File Paths</th>	 	 	  
                        </tr>
                        </thead>

                        <tbody>
                        $InterestingFilesAllFilesRows   
                        </tbody>
                    </table>
                    <div id="paginationIF" style="margin:10px;"></div>
                </div>
            </div>                    	
		</div>	

<!--  
|||||||||| PAGE: Dashboard
-->
		<input class="tabInput"  name="tabs" type="radio" id="dashboard"/>
		<label class="tabLabel" onClick="updateTab('dashboard',false)" for="dashboard"></label>
		<div id="tabPanel" class="tabPanel">
		<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Summary Report</h2>	
		<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
		<div style="min-height: 450px;">	
												
<!--  
|||||||||| CARD: RISK AND INTERESTING FILE SUMMARY
-->
                     <div style="margin-left: 10px; width: 90%;">
	                    <h4 style="color:#4A4A4A;">Risk & Data Exposure</h4>
	                    In total, $RiskLevelCountCritical critical, $RiskLevelCountHigh high, $RiskLevelCountMedium medium, and  $RiskLevelCountLow low risk <a style="font-weight: normal;" href="https://en.wikipedia.org/wiki/Security_descriptor">ACE (Access Control Entry)</a> configurations were discovered across $ExcessiveSharesCount shares, hosted by $ComputerWithExcessive computers in the $TargetDomain Active Directory domain. The affected shares were found hosting $InterestingFilesAllObjectsSecretCount files that may contain passwords and $InterestingFilesAllObjectsSensitiveCount files that may contain sensitive data. Overall, $InterestingFilesAllFilesCount interesting files were found that could potentially lead to unauthorized data access or remote code execution. 
                        <Br>
                     </div>

		            <div class="LargeCard" style="width:43.75%;">	
							<a href="#" id="DashLink" onClick="radiobtn = document.getElementById('AceInsights');radiobtn.checked = true;updateLabelColors('tabs', 'btnaces');" style="text-decoration:none;">
							</a>
																	
									<div class="chart-container">
									<div id="ChartDashboardRisk"></div>
										<div class="chart-controls"></div>
									</div>								  							
							
					</div>									
				
					<div class="LargeCard" style="width: 43.75%;">	
							<a href="#" id="DashLink" onClick="radiobtn = document.getElementById('InterestingFiles');radiobtn.checked = true;updateLabelColors('tabs', 'btnif');" style="text-decoration:none;">
							</a>
																	
									<div class="chart-container">
									<div id="ChartDashboardIF"></div>
										<div class="chart-controls"></div>
									</div>								  							
							
					</div>

<!--  
|||||||||| CARD: Remediation Recommendations
-->
                     <div style="margin-left: 10px; width: 90%; margin-bottom: 10px;">
	                    <span style="color:#4A4A4A;"> <strong>Remediation Prioritization</strong><br></span>
	                    Consider remediating share ACEs by risk level, starting with critical and high risks. Next, prioritize remediating groups of shares to speed up the process. Prioritize by folder group (shares containing exactly the same files) or by share names that have a high similarity score. 
						<i>Prioritizing those groups may help reduce remediation actions by as much as <strong>$RemediationSavings percent</strong> for this environment</i>. Below is a summary of the potential task reduction for each approach.
                     </div>

		            <div class="LargeCard" style="width:90%;">	
							<a href="#" id="DashLink" style="text-decoration:none;">
							</a>
																	
									<div class="chart-container">
									<div id="ChartDashboardRemediate"></div>
										<div class="chart-controls"></div>
									</div>								  							
							
					</div>

<!--  
|||||||||| Section: Affected Asset Exposure
-->	
		<div style="margin-left:10px;margin-top:16px;">			
			<div style="width:90%;">	
				<h4 style="color:#4A4A4A;">Affected Asset Exposure</h4>
				<div>
				Below is a summary of the computers, shares, and ACEs associated with shares configured with excessive privileges.
	            $ExcessiveSharePrivsCount ACL entries, on $ExcessiveSharesCount shares, hosted by $ComputerWithExcessive computers were found configured with excessive privileges on the $TargetDomain domain. Overall, $IdentityReferenceListCount identities were assigned excessive privileges. Click the "Exposure Summary" or the titles on the cards below to explore the details.<Br><Br>
				</div>
			</div>
		</div>

<!-- mini card wrapper -->
<div style="margin-top: -10px;">

<!--  
|||||||||| CARD: COMPUTER SUMMARY
-->
 <div class="card" style="width: 20%">	
	<div class="cardtitle">
		<a href="#" id="DashLink" style="text-decoration:none;" onClick="radiobtn = document.getElementById('ComputerInsights');radiobtn.checked = true;updateLabelColors('tabs', 'btncomputers');">COMPUTERS</a>
	</div>		
				<span class="percentagetext" style = "color:#f08c41;">                    
					$ComputerWithExcessive&nbsp;                     
				</span>	
			<Br>
			<button class="collapsible" style="text-align:left;font-size:10px;">Exposure Summary</button>
			<div class="content">
			<div class="filelistparent" style="font-size: 10px;">		  
			<div>
                <span style="color:#9B3722;font-size:12;">$ComputerWithExcessive</span> of $PeerComparisonComputerCount ($PeerComparActualComputers%)<br><br>
	            <table>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align: top; width:78px;">
                        Read
                        </td>
			            <td align="right">				
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width: $PercentComputerReadP;"></div>
				            </div>	
				            <span class="cardbartext">$ComputerWithReadCount of $PeerComparisonComputerCount ($PeerComparActualComputersr%)</span>				
			            </td>
		             </tr>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align:top">
                        Write
                        </td>
			            <td align="right">				
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width: $PercentComputerWriteP;"></div>
				            </div>
				            <span class="cardbartext">$ComputerWithWriteCount of $PeerComparisonComputerCount ($PeerComparActualComputersW%)</span>
			            </td>
		             </tr>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align:top">
                        Exploitable
                        </td>
			            <td align="right">
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width: $PercentComputerHighRiskP;"></div>
				            </div>
				            <span class="cardbartext">$ComputerwithHighRisk of $PeerComparisonComputerCount ($PeerComparActualComputershr%)</span>				
			            </td>
		             </tr>		 
		            </table> 
                </div>	   
			</div>
			</div> 			  
 </div>

<!--  
|||||||||| CARD: SHARE SUMMARY
-->

<div class="card" style="width: 20%">	
	<div class="cardtitle">
		<a href="#" id="DashLink" style="text-decoration:none;" onClick="radiobtn = document.getElementById('ShareName');radiobtn.checked = true;updateLabelColors('tabs', 'btnshares');">SHARES</a>
	</div>	
				<span class="percentagetext" style = "color:#f08c41;">                    
					$ExcessiveSharesCount&nbsp;                      
				</span>	
			<Br>
			<button class="collapsible" style="text-align:left;font-size:10px;">Exposure Summary</button>
			<div class="content">
			<div class="filelistparent" style="font-size: 10px;">		  
			<div>
                <span style="color:#9B3722;font-size:12;">$ExcessiveSharesCount</span> of $AllSMBSharesCount ($PercentSharesExPrivP)<br><br>
	            <table>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align: top; width:78px;">
                        Read
                        </td>
			            <td align="right">				
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width: $PercentSharesReadP;"></div>
				            </div>	
				            <span class="cardbartext">$SharesWithReadCount of $AllSMBSharesCount ($PercentSharesReadP;)</span>				
			            </td>
		             </tr>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align:top">
                        Write
                        </td>
			            <td align="right">				
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width: $PercentSharesWriteP;"></div>
				            </div>
				            <span class="cardbartext">$SharesWithWriteCount of $AllSMBSharesCount ($PercentSharesWriteP)</span>
			            </td>
		             </tr>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align:top">
                        Exploitable
                        </td>
			            <td align="right">
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width: $PercentSharesHighRiskP;"></div>
				            </div>
				            <span class="cardbartext">$SharesHighRiskCount of $AllSMBSharesCount ($PercentSharesHighRiskP)</span>				
			            </td>
		             </tr>		 
		            </table> 
                </div>	   
			</div>
			</div> 			  
 </div>

<!--  
|||||||||| CARD: ACL SUMMARY
-->

<div class="card" style="width: 20%">	
	<div class="cardtitle">
		<a href="#" id="DashLink" style="text-decoration:none;" onClick="radiobtn = document.getElementById('AceInsights');radiobtn.checked = true;updateLabelColors('tabs', 'btnaces');">ACES</a>
	</div>	
				<span class="percentagetext" style = "color:#f08c41;">                    
					$ExcessiveSharePrivsCount&nbsp;                   
				</span>	
			<Br>
			<button class="collapsible" style="text-align:left;font-size:10px;">Exposure Summary</button>
			<div class="content">
			<div class="filelistparent" style="font-size: 10px;">		  
			<div>
                <span style="color:#9B3722;font-size:12;">$ExcessiveSharePrivsCount</span> of $ShareACLsCount ($PercentAclExPrivP)<br><br>
	            <table>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align: top; width:78px;">
                        Read
                        </td>
			            <td align="right">				
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width: $PercentAclReadP;"></div>
				            </div>	
				            <span class="cardbartext">$AclWithReadCount of $ShareACLsCount ($PercentAclReadP)</span>				
			            </td>
		             </tr>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align:top">
                        Write
                        </td>
			            <td align="right">				
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width: $PercentAclWriteP;"></div>
				            </div>
				            <span class="cardbartext">$AclWithWriteCount of $ShareACLsCount ($PercentAclWriteP)</span>
			            </td>
		             </tr>
		             <tr>
			            <td class="cardsubtitle" style="vertical-align:top">
                        Exploitable
                        </td>
			            <td align="right">
				            <div class="cardbarouter">
					            <div class="cardbarinside" style="width:  $PercentAclHighRiskP;"></div>
				            </div>
				            <span class="cardbartext">$AclHighRiskCount of $ShareACLsCount ($PercentAclHighRiskP)</span>				
			            </td>
		             </tr>		 
		            </table> 
                </div>	   
			</div>
			</div> 			  
 </div>

 <!--  
|||||||||| CARD: IDENTITY SUMMARY
-->

<div class="card" style="width: 20%">	
	<div class="cardtitle">
		<a href="#" id="DashLink" style="text-decoration:none;" onClick="radiobtn = document.getElementById('IdentityInsights');radiobtn.checked = true;updateLabelColors('tabs', 'btnidentities');">IDENTITIES</a>
	</div>	
				<span class="percentagetext" style = "color:#f08c41;">                    
					$IdentityReferenceListCount&nbsp;                      
				</span>	
			<Br>
			<button class="collapsible" style="text-align:left;font-size:10px;">Exposure Summary</button>
			<div class="content">
			    <div class="filelistparent" style="font-size: 10px;">		  
			        <div>
	                Coming soon.
                    </div>   
			    </div>
			</div> 			  
 </div>

 <!-- mini card  wrapper end  -->	
</div>

 <!--  
|||||||||| CARD: Identities Place Holder
-->

<div style="height:.5px;width:100%;position:relative;float:left;"></div>

<!--  
|||||||||| CARD: Peer Comparison
-->
                     <div style="margin-left: 10px; width: 90%; margin-bottom: 10px;">
	                    <span style="color:#4A4A4A;"> <strong>Peer Comparison</strong><br></span>
	                    Below is a comaprison between the percent of affected assets in this environment and the average percent of affected assets observed in other environments. 
                        The percentage is calculated based on the total number of assets discovered for each asset type. 
                     </div>

		            <div class="LargeCard" style="width:90%;">	
							<a href="#" id="DashLink" style="text-decoration:none;">
							</a>
																	
									<div class="chart-container">
									<div id="ChartDashboardPeerCompare"></div>
										<div class="chart-controls"></div>
									</div>								  							
							
					</div>		

<!--  
|||||||||| CARD: Share Creation Timeline
-->
 <div style="height:.5px;width:100%;position:relative;float:left;"></div>
 <div style="height:130px;"></div>
	<div style="margin-left: 10px; width: 95%">
	<h4 style="color:#4A4A4A;">Timelines</h4>
	Below are charts to help illustrate the share creation and last write timelines.<Br><Br>
 </div>
$CardCreationTimeLine
<div style="height:.5px;width:100%;position:relative;float:left;"></div>
 

<!--  
|||||||||| CARD: LastAccessDate Timeline
$CardLastAccessTimeLine
<div style="height:.5px;width:100%;position:relative;float:left;"></div>
-->

<!--  
|||||||||| CARD: LastModifiedDate Timeline
-->
$CardLastModifiedTimeLine
</div>
</div>

<!--  
|||||||||| PAGE: COMPUTER INSIGHTS
-->

<input class="tabInput"  name="tabs" type="radio" id="ComputerInsights"/> 
<label class="tabLabel" onClick="updateTab('ComputerInsights',false)" for="ComputerInsights"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Computers</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px; margin-bottom: 3px;width:95%">
$ComputerCount computers were found in the $TargetDomain Active Directory domain, $ComputerPingableCount responded to ping requests, $Computers445OpenCount had port 445 open, and $ComputerWithExcessive were found hosting shares configured with excessive privileges. Below is a list of the computers hosting shares configured with excessive privileges. 
</div>		

		    

                    <div class="card" style="width: 20%">	
	                    <div class="cardtitle" style="color:gray;font-size: 16px; font-weight: bold;">
		                    Live Computers Found
	                    </div>		
                                    <br><br>
				                    <span class="percentagetext" style = "color:#f08c41;">                    
					                    $PeerComparisonComputerCount&nbsp;                     
				                    </span>	
			                    <Br>
                                <div style="padding-right: 10px;">
                                ($ComputerWithExcessive host shares with excessive privileges)
                                </div>
                    </div>

					<div class="LargeCard" style="width:32.75%;">	
																	
									<div class="chart-container">
									<div id="ChartComputersRisk"></div>
										<div class="chart-controls"></div>
									</div>								  							
							
					</div>	
            
					<div class="LargeCard" style="width:32.75%;">	
																	
									<div class="chart-container">
									<div id="ChartComputersDisco"></div>
										<div class="chart-controls"></div>
									</div>								  							
						
					</div>					
				
<div class="searchbar" style="margin-top:270px; text-align:left; display: flex;" >
        <input type="text" id="computerfilterInput" placeholder=" Search..." style="margin-top: 8px; height: 25px; margin-left: 10px;font-size: 14px;padding-left:3px;border-radius: 3px;border: 1px solid #BDBDBD;outline: none;color:#07142A;">
        <div style="font-size:12;text-align: left;cursor: pointer;color:gray; margin-top: 13px; margin-left: 5px;" onmouseover="this.style.color='white';" onmouseout="this.style.textDecoration='';this.style.fontWeight='normal';this.style.color='gray';"onclick="document.getElementById('computerfilterInput').value = '';applyFiltersAndSort('ComputersTable', 'computerfilterInput', 'computerfilterCounter', 'computerpagination');">Clear</div>
        <!-- <div style="margin-top: 10px; margin-left: 5px; margin-right: 5px;"><strong>Quick Filters</strong></div>
        <label><input type="checkbox" class="filter-checkbox" name="h"> Exploitable</label>
        <label><input type="checkbox" class="filter-checkbox" name="w"> Write</label>
        <label><input type="checkbox" class="filter-checkbox" name="r"> Read</label>
        <label><input type="checkbox" class="filter-checkbox" name="i"> Interesting</label>
        <label><input type="checkbox" class="filter-checkbox" name="e"> Empty</label>
        <label><input type="checkbox" class="filter-checkbox" name="s"> Stale</label>
        <label><input type="checkbox" class="filter-checkbox" name="n"> Default</label>
        -->
</div>		
<div style="display: flex; margin-left:10px; font-size:11; text-align:left;" >		
        <div id="computerfilterCounter" style="margin-top:5px;">Loading...</div>      
        <a style="font-size:11; margin-top: 5px; margin-left: 5px;" href="#" onclick="extractAndDownloadCSV('ComputersTable', 2)">Export</a>
</div>
<table id="ComputersTable" class="table table-striped table-hover tabledrop" style="width: 95%;">
  <thead>
    <tr>
    
    <th class="NamesTh" onclick="sortTable('ComputersTable',0,'alpha')" style="vertical-align: middle;text-align: left;">Computer<br>Name&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Computer Name</strong><br>is the name of the computer.</span></div></th>        
                          
    <th class="NamesTh" onclick="sortTable('ComputersTable',1,'number')" style="vertical-align: middle;text-align: left;">Risk<br>Level&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Risk Level</strong><br>relfects the exposure of credentials and sensitive data.</span></div></th>
                          
    <th class="NamesTh"  onclick="sortTable('ComputersTable',2,'number')" style="vertical-align: middle;text-align: left;">Share<br>Count&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Share Count</strong><br>is the number of shares<br>hosted on the same computer.</span></div></th>
      
    <th class="NamesTh"  onclick="sortTable('ComputersTable',3,'number')" style="vertical-align: middle;text-align: left;">Interesting<br>Files&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Interesting Files</strong><br>are filenames that<br>may be sensitive.</span></div> </th>	 	        

    </tr>
    </thead>

    <tbody>
    $ComputerTableRows
    </tbody>
</table>
<div id="computerpagination" style="margin:10px;"></div>
</div>

<!--  
|||||||||| PAGE: IDENTITY INSIGHTS
-->

<input class="tabInput"  name="tabs" type="radio" id="IdentityInsights"/> 
<label class="tabLabel" onClick="updateTab('IdentityInsights',false)" for="IdentityInsights"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Identities</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px; margin-bottom: 3px;width:95%">
$IdentityCombinedListCount identities were discovered across shares in the $TargetDomain Active Directory domain. $IdentityOwnerListCount were owners and $IdentityReferenceListCount were assigned privileges. 
</div>		     


                    <div class="card" style="width: 28%">	
	                    <div class="cardtitle" style="color:gray;font-size: 16px; font-weight: bold;">
		                   Identities Found
	                    </div>		
                                    <br><br>
				                    <span class="percentagetext" style = "color:#f08c41;">                    
					                    $IdentityCombinedListCount&nbsp;                     
				                    </span>	
			                    <Br>
                    </div>

                    <div class="card" style="width: 28%">	
	                    <div class="cardtitle" style="color:gray;font-size: 16px; font-weight: bold;">
		                   Identities Assigned Ownership
	                    </div>		
                                    <br><br>
				                    <span class="percentagetext" style = "color:#f08c41;">                    
					                    $IdentityOwnerListCount&nbsp;                     
				                    </span>	
			                    <Br>
                    </div>
                    
                    <div class="card" style="width: 28%">	
	                    <div class="cardtitle" style="color:gray;font-size: 16px; font-weight: bold;">
		                   Identities Assigned Privileges
	                    </div>		
                                    <br><br>
				                    <span class="percentagetext" style = "color:#f08c41;">                    
					                    $IdentityReferenceListCount&nbsp;                     
				                    </span>	
			                    <Br>
                    </div>                     
<br> 					
<div style="margin-top: 125px; margin-left: 10px; width="80%">
Note: Within the context of this report, all read and write access the "Everyone", "Authenticated Users", "BUILTIN\Users", "Domain Users", or "Domain Computers" groups are considered excessive privileges, because all provide domain users access to the affected shares due to privilege inheritance. 				
</div>
<div class="searchbar" style="margin-top:12px; text-align:left; display: flex;" >
        <input type="text" id="IdentityfilterInput" placeholder=" Search..." style="margin-top: 8px; height: 25px; margin-left: 10px;font-size: 14px;padding-left:3px;border-radius: 3px;border: 1px solid #BDBDBD;outline: none;color:#07142A;">
        <div style="font-size:12;text-align: left;cursor: pointer;color:gray; margin-top: 13px; margin-left: 5px;" onmouseover="this.style.color='white';" onmouseout="this.style.textDecoration='';this.style.fontWeight='normal';this.style.color='gray';"onclick="document.getElementById('IdentityfilterInput').value = '';applyFiltersAndSort('IdentityTable', 'IdentityfilterInput', 'IdentityfilterCounter', 'Identitypagination');">Clear</div>
        <!-- <div style="margin-top: 10px; margin-left: 5px; margin-right: 5px;"><strong>Quick Filters</strong></div>
        <label><input type="checkbox" class="filter-checkbox" name="h"> Exploitable</label>
        <label><input type="checkbox" class="filter-checkbox" name="w"> Write</label>
        <label><input type="checkbox" class="filter-checkbox" name="r"> Read</label>
        <label><input type="checkbox" class="filter-checkbox" name="i"> Interesting</label>
        <label><input type="checkbox" class="filter-checkbox" name="e"> Empty</label>
        <label><input type="checkbox" class="filter-checkbox" name="s"> Stale</label>
        <label><input type="checkbox" class="filter-checkbox" name="n"> Default</label>
        -->
</div>		
<div style="display: flex; margin-left:20px; font-size:11; text-align:left;" >		
        <div id="IdentityfilterCounter" style="margin-top:5px; margin-left: -10px;">Loading...</div>      
        <a style="font-size:11; margin-top: 5px; margin-left: 5px;" href="#" onclick="extractAndDownloadCSV('IdentityTable', 2)">Export</a>
</div>
<table id="IdentityTable" class="table table-striped table-hover tabledrop" style="width: 95%;">
  <thead>
    <tr>
    
    <th class="NamesTh" onclick="sortTable('IdentityTable',0,'alpha')" style="vertical-align: middle;text-align: left;">Identity</th>
    <th class="NamesTh" onclick="sortTable('IdentityTable',0,'alpha')" style="vertical-align: middle;text-align: left;">Owned Shares</th> 
    <th class="NamesTh" onclick="sortTable('IdentityTable',0,'alpha')" style="vertical-align: middle;text-align: left;">Accessible Shares</th> 
    <th class="NamesTh" onclick="sortTable('IdentityTable',0,'alpha')" style="vertical-align: middle;text-align: left;">Low Risk Shares</th> 
    <th class="NamesTh" onclick="sortTable('IdentityTable',0,'alpha')" style="vertical-align: middle;text-align: left;">Medium Risk Shares</th> 
    <th class="NamesTh" onclick="sortTable('IdentityTable',0,'alpha')" style="vertical-align: middle;text-align: left;">High Risk Shares</th> 
    <th class="NamesTh" onclick="sortTable('IdentityTable',0,'alpha')" style="vertical-align: middle;text-align: left;">Critical Risk Shares</th>         
                          
    </tr>
    </thead>

    <tbody>
    $IdentityTableRows
    </tbody>
</table>
<div id="Identitypagination" style="margin:10px;"></div>
</div>

<!--  
|||||||||| PAGE: ACE INSIGHTS
-->

<input class="tabInput"  name="tabs" type="radio" id="AceInsights"/> 
<label class="tabLabel" onClick="updateTab('AceInsights',false)" for="AceInsights"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Insecure ACEs</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px; margin-bottom: 3px;width:95%">
Below is a list of the ACE (access control entries) configured with excessive privileges found in the $TargetDomain Active Directory domain. 
</div>		

                    <div class="card" style="width: 20%">	
	                    <div class="cardtitle" style="color:gray;font-size: 16px; font-weight: bold;">
		                   Inescure ACEs Found
	                    </div>		
                                    <br><br>
				                    <span class="percentagetext" style = "color:#f08c41;">                    
					                    $ExcessiveSharePrivsCount &nbsp;                     
				                    </span>	
                    </div>


					<div class="LargeCard" style="width:23%;">	
										
									<div class="chart-container">
									<div id="ChartAceRisk"></div>
										<div class="chart-controls"></div>
									</div>								  							
					</div>
            
					<div class="LargeCard" style="width:18%;">									
									<div class="chart-container">
									<div id="ChartAceType"></div>
										<div class="chart-controls"></div>
									</div>								  							
					</div>	

					<div class="LargeCard" style="width:20.5%;">												
									<div class="chart-container">
									<div id="ChartAcesIF"></div>
										<div class="chart-controls"></div>
									</div>								  							
					</div>					
				
<div class="searchbar" style="margin-top:270px; text-align:left; display: flex;" >
        <input type="text" id="acefilterInput" placeholder=" Search..." style="margin-top: 8px; height: 25px; margin-left: 10px;font-size: 14px;padding-left:3px;border-radius: 3px;border: 1px solid #BDBDBD;outline: none;color:#07142A;">
        <div style="font-size:12;text-align: left;cursor: pointer;color:gray; margin-top: 13px; margin-left: 5px;" onmouseover="this.style.color='white';" onmouseout="this.style.textDecoration='';this.style.fontWeight='normal';this.style.color='gray';"onclick="document.getElementById('acefilterInput').value = '';applyFiltersAndSort('aceTable', 'acefilterInput', 'acefilterCounter', 'acepagination');">Clear</div>
        <!-- <div style="margin-top: 10px; margin-left: 5px; margin-right: 5px;"><strong>Quick Filters</strong></div>
        <label><input type="checkbox" class="filter-checkbox" name="h"> Exploitable</label>
        <label><input type="checkbox" class="filter-checkbox" name="w"> Write</label>
        <label><input type="checkbox" class="filter-checkbox" name="r"> Read</label>
        <label><input type="checkbox" class="filter-checkbox" name="i"> Interesting</label>
        <label><input type="checkbox" class="filter-checkbox" name="e"> Empty</label>
        <label><input type="checkbox" class="filter-checkbox" name="s"> Stale</label>
        <label><input type="checkbox" class="filter-checkbox" name="n"> Default</label>
        -->
</div>		
<div style="display: flex; margin-left:10px; font-size:11; text-align:left;" >		
        <div id="acefilterCounter" style="margin-top:5px;">Loading...</div>      
        <a style="font-size:11; margin-top: 5px; margin-left: 5px;" href="#" onclick="extractAndDownloadCSV('aceTable', 2)">Export</a>
</div>
<table id="aceTable" class="table table-striped table-hover tabledrop" style="width: 95%;">
  <thead>
    <tr>
    
    <th class="NamesTh" onclick="sortTable('aceTable',0,'number')" style="vertical-align: middle;text-align: left;">Risk Level</th>
    <th class="NamesTh" onclick="sortTable('aceTable',1,'alpha')" style="vertical-align: middle;text-align: left;">Computer</th>        
    <th class="NamesTh" onclick="sortTable('aceTable',2,'alpha')" style="vertical-align: middle;text-align: left;">Share Name</th>                
    <th class="NamesTh" onclick="sortTable('aceTable',3,'alpha')" style="vertical-align: middle;text-align: left;">FileSystemRight</th>        
    <th class="NamesTh" onclick="sortTable('aceTable',4,'alpha')" style="vertical-align: middle;text-align: left;">Identity</th>        
    <th class="NamesTh" onclick="sortTable('aceTable',5,'alpha')" style="vertical-align: middle;text-align: left;">Share Owner</th>        
    <th class="NamesTh" onclick="sortTable('aceTable',6,'number')" style="vertical-align: middle;text-align: left;">Creation Date</th>        
    <th class="NamesTh" onclick="sortTable('aceTable',7,'number')" style="vertical-align: middle;text-align: left;">Last Modified</th>        
    <th class="NamesTh" onclick="sortTable('aceTable',8,'number')" style="vertical-align: middle;text-align: left;">Files</th>                
                          
    </tr>
    </thead>
    
    <tbody>
    $AceTableRows
    </tbody>
</table>
<div id="acepagination" style="margin:10px;"></div>
</div>

<!--  
|||||||||| PAGE: COMPUTER SUMMARY
-->

<input class="tabInput"  name="tabs" type="radio" id="computersummary"/>
<label class="tabLabel" onClick="updateTab('computersummary',false)" for="computersummary"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Computer Summary</h2>		
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px">
Below is a summary of the domain computers that were targeted, connectivity to them, and the number that are hosting potentially insecure SMB shares.
</div>
	
<table class="table table-striped table-hover tabledrop">
  <thead>
    <tr>
      <th>Description</th>
      <th align="left">Percent Chart</th>	  
	  <th align="left">Percent</th>
	  <th align="left">Computers</th>
	  <th align="left">Details</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>DISCOVERED</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: 100%;"></div></div></td>
	  <td>100.00%</td>
	  <td>$ComputerCount</td>
      <td><a href="$SubDir/$DomainComputersFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$DomainComputersFileH"><span class="cardsubtitle">HTML</span></a></td>	  
    </tr>
    <tr>
      <td>PING RESPONSE</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentComputerPingP;"></div></div></td>
      <td>$PercentComputerPingP</td>	
	  <td>$ComputerPingableCount</td>  
      <td><a href="$SubDir/$ComputersPingableFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ComputersPingableFileH"><span class="cardsubtitle">HTML</span></a></td>		  
    </tr>
    <tr>
      <td>PORT 445 OPEN</td>
      <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentComputerPortP;"></div></div></td>
	  <td>$PercentComputerPortP</td>
	  <td>$Computers445OpenCount</td>
      <td><a href="$SubDir/$Computers445OpenFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$Computers445OpenFileH"><span class="cardsubtitle">HTML</span></a></td>  
    </tr>
    <tr>
      <td>HOST SHARE</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentComputerWitShareP;"></div></div></td>
      <td>$PercentComputerWitShareP</td>	
	  <td>$AllComputersWithSharesCount</td>  
      <td><a href="$SubDir/$ShareACLsFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsFileH"><span class="cardsubtitle">HTML</span></a></td> 
    </tr>
    <tr>
      <td>HOST NON-DEFAULT SHARE</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentComputerNonDefaultP;"></div></div></td>
      <td>$PercentComputerNonDefaultP</td>	
	  <td>$ComputerwithNonDefaultCount</td>  
      <td><a href="$SubDir/$ShareACLsNonDefaultFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsNonDefaultFileH"><span class="cardsubtitle">HTML</span></a></td>  
    </tr>	
    <tr>
      <td>HOST POTENTIALLY INSECURE SHARE</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width:$PercentComputerExPrivP;"></div></div></td>
      <td>$PercentComputerExPrivP</td>	
	  <td>$ComputerWithExcessive</td>  
      <td><a href="$SubDir/$ShareACLsExFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsExFileH"><span class="cardsubtitle">HTML</span></a></td>  
    </tr>	
    <tr>
      <td>HOST READABLE SHARE</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentComputerReadP;"></div></div></td>
      <td>$PercentComputerReadP</td>	  
	  <td>$ComputerWithReadCount</td>	  
      <td><a href="results/$ShareACLsReadFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsReadFileH"><span class="cardsubtitle">HTML</span></a></td>  
    </tr>
	<tr>
      <td>HOST WRITEABLE SHARE</td>
      <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentComputerWriteP;"></div></div></td>
	  <td>$PercentComputerWriteP</td>
	  <td>$ComputerWithWriteCount</td>	  	  
	  <td><a href="$SubDir/$ShareACLsWriteFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsWriteFileH"><span class="cardsubtitle">HTML</span></a></td> 
    </tr>
	<tr>
      <td>HOST HIGH RISK SHARE</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentComputerHighRiskP;"></div></div></td>     
	  <td>$PercentComputerHighRiskP</td>
	  <td>$ComputerwithHighRisk</td>	  	 
	  <td><a href="$SubDir/$ShareACLsHRFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsHRFileH"><span class="cardsubtitle">HTML</span></a></td> 
    </tr>	
  </tbody>
</table>
</div>

<!--  
|||||||||| PAGE: SHARE SUMMARY
-->

<input class="tabInput"  name="tabs" type="radio" id="sharesum"/>
<label class="tabLabel" onClick="updateTab('sharesum,false)" for="sharesum"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Share Summary</h2>		
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px">
Below is a summary of the SMB shares discovered on domain computers that may provide excessive privileges to standard domain users.
</div>

<table class="table table-striped table-hover tabledrop">
  <thead>
    <tr>
      <th>Description</th>
      <th align="left">Percent Chart</th>	  
	  <th align="left">Percent</th>
	  <th align="left">Shares</th>
	  <th align="left">Details</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>DISCOVERED</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: 100%;"></div></div></td>
	  <td>100.00%</td>
	  <td>$AllSMBSharesCount</td>
      <td><a href="$SubDir/$AllSMBSharesFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$AllSMBSharesFileH"><span class="cardsubtitle">HTML</span></a></td>   
    </tr>
    <tr>
      <td>NON-DEFAULT</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentSharesNonDefaultP;"></div></div></td>
      <td>$PercentSharesNonDefaultP</td>	
	  <td>$SharesNonDefaultCount</td>  
      <td><a href="$SubDir/$ShareACLsNonDefaultFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsNonDefaultFileH"><span class="cardsubtitle">HTML</span></a></td>  	  
    </tr>	
    <tr>
      <td>POTENTIALLY EXCESSIVE</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentSharesExPrivP;"></div></div></td>
      <td>$PercentSharesExPrivP</td>	
	  <td>$ExcessiveSharesCount</td>  
      <td><a href="$SubDir/$ShareACLsExFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsExFileH"><span class="cardsubtitle">HTML</span></a></td>    
    </tr>
    <tr>
      <td>READ ACCESS</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentSharesReadP;"></div></div></td>
      <td>$PercentSharesReadP</td>	  
	  <td>$SharesWithReadCount</td>	  
      <td><a href="$SubDir/$ShareACLsReadFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsReadFileH"><span class="cardsubtitle">HTML</span></a></td>   
    </tr>
	<tr>
      <td>WRITE ACCESS</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentSharesWriteP;"></div></div></td>     
	  <td>$PercentSharesWriteP</td>
	  <td>$SharesWithWriteCount</td>	  	 
	  <td><a href="$SubDir/$ShareACLsWriteFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsWriteFileH"><span class="cardsubtitle">HTML</span></a></td> 	  
    </tr>
	<tr>
      <td>HIGH RISK</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentSharesHighRiskP;"></div></div></td>     
	  <td>$PercentSharesHighRiskP</td>
	  <td>$SharesHighRiskCount</td>	  	 
	  <td><a href="$SubDir/$ShareACLsHRFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsHRFileH"><span class="cardsubtitle">HTML</span></a></td> 
    </tr>	
  </tbody>
</table>
    <div class="pageDescription">
    Note: All Windows systems have a c$ and admin$ share configured by default.  A a result, the number of visible shares should be (at a minimum) double the number of the computers found with port 445 open. In this case, $Computers445OpenCount computers were found with port 445 open, so we would expect to discover approximetly $MinExpectedShareCount or more shares.
    </div>
</div>

<!--  
|||||||||| PAGE: ACL SUMMARY
-->

<input class="tabInput"  name="tabs" type="radio" id="ACLsum"/>
<label class="tabLabel" onClick="updateTab('ACLsum',false)" for="ACLsum"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Share ACL Entry Summary</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px">
Below is a summary of the SMB share ACL entries discovered on domain computers that may provide excessive privileges to standard domain users.
</div> 	

<table class="table table-striped table-hover tabledrop">
  <thead>
    <tr>
      <th>Description</th>
      <th align="left">Percent Chart</th>	  
	  <th align="left">Percent</th>
	  <th align="left">ACLs</th>
	  <th align="left">Details</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>DISCOVERED</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: 100%;"></div></div></td>
	  <td>100.00%</td>
	  <td>$ShareACLsCount</td>
      <td><a href="$SubDir/$ShareACLsFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsFileH"><span class="cardsubtitle">HTML</span></a></td> 	  
    </tr>	
    <tr>
      <td>NON-DEFAULT</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentAclNonDefaultP;"></div></div></td>
      <td>$PercentAclNonDefaultP</td>	
	  <td>$AclNonDefaultCount</td>  
      <td><a href="$SubDir/$ShareACLsNonDefaultFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsNonDefaultFileH"><span class="cardsubtitle">HTML</span></a></td>   
    </tr>		
    <tr>
      <td>POTENTIALLY EXCESSIVE</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentAclExPrivP;"></div></div></td>
      <td>$PercentAclExPrivP</td>	
	  <td>$ExcessiveSharePrivsCount</td>  
      <td><a href="$SubDir/$ShareACLsExFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsExFileH"><span class="cardsubtitle">HTML</span></a></td>  
    </tr>
    <tr>
      <td>READ ACCESS</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentAclReadP;"></div></div></td>
      <td>$PercentAclReadP</td>	  
	  <td>$AclWithReadCount</td>	  
      <td><a href="$SubDir/$ShareACLsReadFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsReadFileH"><span class="cardsubtitle">HTML</span></a></td>  	  
    </tr>
	<tr>
      <td>WRITE ACCESS</td>
      <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentAclWriteP;"></div></div></td>
	  <td>$PercentAclWriteP</td>
	  <td>$AclWithWriteCount</td>	  	  
	  <td><a href="$SubDir/$ShareACLsWriteFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsWriteFileH"><span class="cardsubtitle">HTML</span></a></td> 
    </tr>
	<tr>
      <td>HIGH RISK</td>
	  <td><div class="divbarDomain"><div class="divbarDomainInside" style="width: $PercentAclHighRiskP;"></div></div></td>     
	  <td>$PercentAclHighRiskP</td>
	  <td>$AclHighRiskCount</td>	  	 
	  <td><a href="$SubDir/$ShareACLsHRFile"><span class="cardsubtitle">CSV</a> | </span><a href="$SubDir/$ShareACLsHRFileH"><span class="cardsubtitle">HTML</span></a></td> 
    </tr>	
  </tbody>
</table>
</div>

<!--  
|||||||||| PAGE: GROUP STATS
-->

<input class="tabInput"  name="tabs" type="radio" id="accounts"/> 
<label class="tabLabel" onClick="updateTab('accounts',false)" for="accounts"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Group ACL Summary</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px;width:90%">
In the context of this report, excessive read and write share permissions have been defined as any network share ACL containing an explicit entry for the "Everyone", "Authenticated Users", "BUILTIN\Users", "Domain Users", or "Domain Computers" groups. All provide domain users access to the affected shares due to privilege inheritance.
Below is a summary of the exposure associated with each of those groups. 
</div>

<table class="table table-striped table-hover tabledrop">
  <thead>
    <tr>
      <th align="left">Name</th>
      <th align="left">Excessive ACL Entries</th>
      <th align="left">Affected Computers</th>
	  <th align="left">Affected Shares</th>
	  <th align="left">Affected ACLs</th>	 	 
    </tr>
  </thead>
  <tbody>
	<tr>
	  <td>Everyone</td>	
      <td>
 	  <span class="tablecolinfo">
		  <div class="AclEntryWrapper">
			<div class="AclEntryLeft">
			Read<br> 
			Write<br> 
			High Risk<br> 
			</div>
			<div class="AclEntryRight">
			 : $AceEveryoneAclReadCount <br> 
			 : $AceEveryoneAclWriteCount <br>
			 : $AceEveryoneAclHRCount 
			</div>
		  </div>
	  </span>
      </td>		  
	  <td>
		  <span class="dashboardsub2">$AceEveryoneComputerCountPS ($AceEveryoneComputerCount of $ComputerCount)</span>
		  <br>
		  <div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceEveryoneComputerCountPS;"></div>
		  </div>
      </td>     	 	  
	  <td>
		<span class="dashboardsub2">$AceEveryoneShareCountPS ($AceEveryoneShareCount of $AllSMBSharesCount)</span>
		<br>
		<div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceEveryoneShareCountPS;"></div>
		</div>
      </td>  	  
	  <td>
	  <span class="dashboardsub2">$AceEveryoneAclPS ($AceEveryoneAclCount of $ShareACLsCount)</span>
      <br>
      <div class="divbarDomain"><div class="divbarDomainInside" style="width: $AceEveryoneAclPS;"></div></div>
      </td>    	  
    </tr>	
	<tr>
	  <td>BUILTIN\Users</td>		
      <td>
 	  <span class="tablecolinfo">
		  <div class="AclEntryWrapper">
			<div class="AclEntryLeft">
			Read<br> 
			Write<br> 
			High Risk<br> 
			</div>
			<div class="AclEntryRight">
			 : $AceUsersAclReadCount <br> 
			 : $AceUsersAclWriteCount <br>
			 : $AceUsersAclHRCount 
			</div>
		  </div>
	  </span>
      </td>  
	  <td>
		  <span class="dashboardsub2">$AceUsersComputerCountPS ($AceUsersComputerCount of $ComputerCount)</span>
		  <br>
		  <div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceUsersComputerCountPS;"></div>
		  </div>
      </td>     	 	  
	  <td>
		<span class="dashboardsub2">$AceUsersShareCountPS ($AceUsersShareCount of $AllSMBSharesCount)</span>
		<br>
		<div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceUsersShareCountPS;"></div>
		</div>
      </td>  	  
	  <td>
	  <span class="dashboardsub2">$AceUsersAclPS ($AceUsersAclCount of $ShareACLsCount)</span>
      <br>
      <div class="divbarDomain"><div class="divbarDomainInside" style="width: $AceUsersAclPS;"></div></div>
      </td>    	  
    </tr>	
	<tr>
	  <td>Authenticated Users</td>
      <td>
 	  <span class="tablecolinfo">
		  <div class="AclEntryWrapper">
			<div class="AclEntryLeft">
			Read<br> 
			Write<br> 
			High Risk<br> 
			</div>
			<div class="AclEntryRight">
			 : $AceAuthenticatedUsersAclReadCount <br> 
			 : $AceAuthenticatedUsersAclWriteCount <br>
			 : $AceAuthenticatedUsersAclHRCount 
			</div>
		  </div>
	  </span>
      </td>		  
	  <td>
		  <span class="dashboardsub2">$AceAuthenticatedUsersComputerCountPS ($AceAuthenticatedUsersComputerCount of $ComputerCount)</span>
		  <br>
		  <div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceAuthenticatedUsersComputerCountPS;"></div>
		  </div>
      </td>     	 	  
	  <td>
		<span class="dashboardsub2">$AceAuthenticatedUsersShareCountPS ($AceAuthenticatedUsersShareCount of $AllSMBSharesCount)</span>
		<br>
		<div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceAuthenticatedUsersShareCountPS;"></div>
		</div>
      </td>  	  
	  <td>
	  <span class="dashboardsub2">$AceAuthenticatedUsersAclPS ($AceAuthenticatedUsersAclCount of $ShareACLsCount)</span>
      <br>
      <div class="divbarDomain"><div class="divbarDomainInside" style="width: $AceAuthenticatedUsersAclPS;"></div></div>
      </td>    	  
    </tr>	
	<tr>
	  <td>Domain Users</td>	
      <td>
 	  <span class="tablecolinfo">
		  <div class="AclEntryWrapper">
			<div class="AclEntryLeft">
			Read<br> 
			Write<br> 
			High Risk<br> 
			</div>
			<div class="AclEntryRight">
			 : $AceDomainUsersAclReadCount <br> 
			 : $AceDomainUsersAclWriteCount <br>
			 : $AceDomainUsersAclHRCount 
			</div>
		  </div>
	  </span>
      </td>	  
	  <td>
		  <span class="dashboardsub2">$AceDomainUsersComputerCountPS ($AceDomainUsersComputerCount of $ComputerCount)</span>
		  <br>
		  <div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceDomainUsersComputerCountPS;"></div>
		  </div>
      </td>     	 	  
	  <td>
		<span class="dashboardsub2">$AceDomainUsersShareCountPS ($AceDomainUsersShareCount of $AllSMBSharesCount)</span>
		<br>
		<div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceDomainUsersShareCountPS;"></div>
		</div>
      </td>  	  
	  <td>
	  <span class="dashboardsub2">$AceDomainUsersAclPS ($AceDomainUsersAclCount of $ShareACLsCount)</span>
      <br>
      <div class="divbarDomain"><div class="divbarDomainInside" style="width: $AceDomainUsersAclPS;"></div></div>
      </td>    	  
    </tr>
	<tr>
	  <td>Domain Computers</td>	
      <td>
 	  <span class="tablecolinfo">
		  <div class="AclEntryWrapper">
			<div class="AclEntryLeft">
			Read<br> 
			Write<br> 
			High Risk<br> 
			</div>
			<div class="AclEntryRight">
			 : $AceDomainComputersAclReadCount <br> 
			 : $AceDomainComputersAclWriteCount <br>
			 : $AceDomainComputersAclHRCount 
			</div>
		  </div>
	  </span>
      </td>	  
	  <td>
		  <span class="dashboardsub2">$AceDomainComputersComputerCountPS ($AceDomainComputersComputerCount of $ComputerCount)</span>
		  <br>
		  <div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceDomainComputersComputerCountPS;"></div>
		  </div>
      </td>     	 	  
	  <td>
		<span class="dashboardsub2">$AceDomainComputersShareCountPS ($AceDomainComputersShareCount of $AllSMBSharesCount)</span>
		<br>
		<div class="divbarDomain">
			<div class="divbarDomainInside" style="width: $AceDomainComputersShareCountPS;"></div>
		</div>
      </td>  	  
	  <td>
	  <span class="dashboardsub2">$AceDomainComputersAclPS ($AceDomainComputersAclCount of $ShareACLsCount)</span>
      <br>
      <div class="divbarDomain"><div class="divbarDomainInside" style="width: $AceDomainComputersAclPS;"></div></div>
      </td>    	  
    </tr>
  </tbody>
</table>
</div>

<!--  
|||||||||| PAGE: SHARE NAMES
-->

<input class="tabInput"  name="tabs" type="radio" id="ShareName"/> 
<label class="tabLabel" onClick="updateTab('ShareName',false)" for="ShareName"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Share Names</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px; margin-bottom: 3px;width:95%">
$AllSMBSharesCount shares were discovered across $ComputerPingableCount live computers in the $TargetDomain Active Directory domain. $ExcessiveSharesCount of those shares were found configured with excessive privileges across $ComputerWithExcessive computers. Below is a summary of the affected shares grouped by name.
</div>	

                    <div class="card" style="width: 20%">	
	                    <div class="cardtitle" style="color:gray;font-size: 16px; font-weight: bold;">
		                   Shares Found
	                    </div>		
                                    <br><br>
				                    <span class="percentagetext" style = "color:#f08c41;">                    
					                    $ExcessiveSharesCount  &nbsp;                     
				                    </span>	
			                    <Br>
                                <div style="padding-right: 10px;">
                                ($ShareNameChartCount unique names)	
                                </div>
                    </div>
					
		            <div class="LargeCard" style="width:32.5%;">																
									<div class="chart-container">
									<div id="ChartShareNameRiska"></div>
										<div class="chart-controls"></div>
									</div>								  							
					</div>
					
								
					<div class="LargeCard" style="width:32.5%;">										
									<div class="chart-container">
									<div id="ChartSharePageIF"></div>
										<div class="chart-controls"></div>
									</div>								  							
					</div>
				
<div class="searchbar" style="margin-top:270px; text-align:left; display: flex;" >
        <input type="text" id="filterInput" placeholder=" Search..." style="margin-top: 8px; height: 25px; margin-left: 10px;font-size: 14px;padding-left:3px;border-radius: 3px;border: 1px solid #BDBDBD;outline: none;color:#07142A;">
        <div style="margin-top: 10px; margin-left: 5px; margin-right: 5px;"><strong>Quick Filters</strong></div>
        <label><input type="checkbox" class="filter-checkbox" name="h"> Exploitable</label>
        <label><input type="checkbox" class="filter-checkbox" name="w"> Write</label>
        <label><input type="checkbox" class="filter-checkbox" name="r"> Read</label>
        <label><input type="checkbox" class="filter-checkbox" name="i"> Interesting</label>
        <label><input type="checkbox" class="filter-checkbox" name="e"> Empty</label>
        <label><input type="checkbox" class="filter-checkbox" name="s"> Stale</label>
        <label><input type="checkbox" class="filter-checkbox" name="n"> Default</label>
</div>		
<div style="display: flex; margin-left:10px; font-size:11; text-align:left;" >		
        <div id="filterCounter" style="margin-top:5px;">Loading...</div>      
        <a style="font-size:11; margin-top: 5px; margin-left: 5px;" href="#" onclick="extractAndDownloadCSV('sharenametable', 0)">Export</a>
</div>
<table id="sharenametable" class="table table-striped table-hover tabledrop" style="width: 95%;">
  <thead>
    <tr>
    <th class="NamesTh"  onclick="sortTable('sharenametable',0,'number')" style="vertical-align: middle;text-align: left;">Share<br>Count&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Share Count</strong><br>is the number of unique shares with<br>the same name.</span></div></th>
                          
    <th class="NamesTh" onclick="sortTable('sharenametable',1,'alpha')" style="vertical-align: middle;text-align: left;">Share<br>Name&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Share Name</strong><br>is the name of a<br>collection of share<br>with the same name.</span></div></th>
          
    <th class="NamesTh" onclick="sortTable('sharenametable',2,'number')" style="vertical-align: middle;text-align: left;">Risk<br>Level&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Risk Level</strong><br>relfects the exposure of credentials and sensitive data.</span></div></th>
                      
    <th class="NamesTh" onclick="sortTable('sharenametable',3,'number')" style="vertical-align: middle;text-align: left;">Share<br>Similarity&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Share Similarity</strong><br>scores reflect how likely it is that the shares are related to each other.</span></div></th>
         
    <th class="NamesTh"  onclick="sortTable('sharenametable',4,'number')" style="vertical-align: middle;text-align: left;">Folder<br>Groups&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Folder Groups</strong><br>are groups of shares<br>that have the same<br>name and file listing.</span></div></th>            
	  
    <th class="NamesTh"  onclick="sortTable('sharenametable',5,'number')" style="vertical-align: middle;text-align: left;">Common<br>Files&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Common Files</strong><br>are file names that<br>exist in 10% or more<br>of the file groups.</span></div> </th>	 	 
	  
    <th class="NamesTh"  onclick="sortTable('sharenametable',6,'number')" style="vertical-align: middle;text-align: left;">Interesting<br>Files&nbsp;&nbsp;<div class="tooltip"><img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpSJVBzuIOGSoBcEuKuJYqlgEC6Wt0KqDyaVf0KQhSXFxFFwLDn4sVh1cnHV1cBUEwQ8QZwcnRRcp8X9JoUWMB8f9eHfvcfcOEJpVpp
    o9MUDVLCOdiIu5/KoYeEUAQQxiAhGJmXoys5iF5/i6h4+vd1Ge5X3uzzGgFEwG+ETiGNMNi3iDeHbT0jnvE4dYWVKIz4knDbog8SPXZZffOJccFnhmyMim54lDxGKpi+UuZmVDJZ4hDiuqRvlCzmWF8xZntVpn7XvyFwYL2kqG6zTHkMASkkhBhIw6KqjCQpRWjRQTadqPe/hHHX+KXDK5KmDkWEANK
    iTHD/4Hv7s1i9NTblIwDvS+2PbHOBDYBVoN2/4+tu3WCeB/Bq60jr/WBOY+SW90tPARMLQNXFx3NHkPuNwBRp50yZAcyU9TKBaB9zP6pjwwfAv0r7m9tfdx+gBkqavlG+DgEIiUKHvd49193b39e6bd3w/VdnLO67/jCAAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0
    SU1FB+gHDA40BpbiKy8AAAEjSURBVBjTXZAxS4JhFIWfe5XqA6NIBSvK1pak2tqjvb8Q/oUImgPnqL/R7tbYVPCtUb46iKYoSUGK3tvQK0hnu889HO49Uq1eyOXVtRby+Q1VrSBSBpaBMRDMLG2GMLi/uzV5fXvPFIvFHRE5A0qAAVMgCyjQNbN6v99vyfBzVFTVc2ArprWAHrAJbANLQNts9qCqWom
    JAB/u9uzuPXd/AjqRl1T1QIEyIBGuiuiJiJwCGeArcgHZy8Zn5loHcsBL5IWF3bLGOxf1DUxEZP+feazgAfAF+OOOAGuxDQB396BmloJ3F8w5EXbjOXN1zCzVZggDM68D7dhxEttJ/mZvu1u92QyDzGw25fDoeJQkK0FExiAKTIAhkJrZY2g0urXajf0CiVl4icFa+XEAAAAASUVORK5CYII=" /><span class="tooltiptext"><strong>Interesting Files</strong><br>are filenames that<br>may be sensitive.</span></div> </th>	 	        

    </tr>
    </thead>

    <tbody>
    $CommonShareNamesTopStringT    
    </tbody>
</table>
<div id="pagination" style="margin:10px;"></div>
</div>

<!--  
|||||||||| PAGE: Affected Networks
-->

<input class="tabInput" name="tabs" type="radio" id="SubNets"> 
<label class="tabLabel" onclick="updateTab(&#39;SubNets#39;,false)" for="SubNets"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Networks</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px">
$SubnetsCount networks/subnets were found associated with computers that host shares that are configured with excessive privileges. 
</div>

$SubnetSummaryHTML
</div>

<!--  
|||||||||| PAGE: SHARE OWNERS
-->
<input class="tabInput"  name="tabs" type="radio" id="ShareOwner"/> 
<label class="tabLabel" onClick="updateTab('ShareOwner',false)" for="ShareOwner"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Share Owners</h2>	
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px">
This section lists the most common share owners. 
</div>

<table class="table table-striped table-hover tabledrop">
  <thead>
    <tr>
      <th align="left">Share Count</th> 
      <th align="left">Owner</th>
      <th align="left">Affected Computers</th>
	  <th align="left">Affected Shares</th>
	  <th align="left">Affected ACLs</th>	 	 
    </tr>
  </thead>
  <tbody>
  $CommonShareOwnersTop5StringT	
  </tbody>
  </table>
</div>

<!--  
|||||||||| PAGE: FOLDER GROUPS
-->

<input class="tabInput"  name="tabs" type="radio" id="ShareFolders"/> 
<label class="tabLabel" onClick="updateTab('ShareFolders',false)" for="ShareFolders"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Folder Groups</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px;width:95%;">
Folder groups are SMB shares that contain the exact same file listing. Each folder group has been hashed so they can be quickly correlated. In some cases, shares with the exact same file listing may be related to a single application or process.  This information can help identify the root cause associated with the excessive privileges and expedite remediation.
</div>

                    <div class="card" style="width: 20%">	
	                    <div class="cardtitle" style="color:gray;font-size: 16px; font-weight: bold;">
		                   Folder Groups Found
	                    </div>		
                                    <br><br>
				                    <span class="percentagetext" style = "color:#f08c41;">                    
					                    $FolderGroupChartCount &nbsp;                     
				                    </span>	
			                    <Br>
                    </div>
					
		            <div class="LargeCard" style="width:32.5%;">																		
									<div class="chart-container">
									<div id="ChartFGRiska"></div>
										<div class="chart-controls"></div>
									</div>								  							
					</div>
					
				
				
					<div class="LargeCard" style="width:32.5%;">											
									<div class="chart-container">
									<div id="ChartFGPageIF"></div>
										<div class="chart-controls"></div>
									</div>								  							
					</div>
					
<div class="searchbar" style="margin-top:270px; text-align:left; display: flex;" >
        <input type="text" id="filterInputTwo" placeholder=" Search..." style="margin-top: 8px; height: 25px; font-size: 14px; padding-left:3px;margin-left: 10px;border-radius: 3px;border: 1px solid #BDBDBD;outline: none;color:#07142A;">
        <div style="font-size:12;text-align: left;cursor: pointer;color:gray; margin-top: 13px; margin-left: 5px;" onmouseover="this.style.color='white';" onmouseout="this.style.textDecoration='';this.style.fontWeight='normal';this.style.color='gray';" onclick="document.getElementById('filterInputTwo').value = '';applyFiltersAndSort('foldergrouptable', 'filterInputTwo', 'filterCounterTwo', 'paginationfg');">Clear</div>
        <!--
		<strong>&nbsp;&nbsp;Quick Filters</strong>
        <label><input type="checkbox" class="filter-checkbox" name="h"> Highly Exploitable</label>
        <label><input type="checkbox" class="filter-checkbox" name="w"> Write</label>
        <label><input type="checkbox" class="filter-checkbox" name="r"> Read</label>
        <label><input type="checkbox" class="filter-checkbox" name="i"> Interesting</label>
        <label><input type="checkbox" class="filter-checkbox" name="e"> Empty</label>
        <label><input type="checkbox" class="filter-checkbox" name="s"> Stale</label>
        <label><input type="checkbox" class="filter-checkbox" name="n"> Default</label>
		-->
		<br><br>
</div>		
<div style="display: flex; margin-left:10px; font-size:11; text-align:left;" >	
        <div id="filterCounterTwo" style="margin-top:5px;">Loading...</div>        
        <a style="font-size:11; margin-top: 5px; margin-left: 5px;" href="#" onclick="extractAndDownloadCSV('foldergrouptable', 1)">Export</a>
</div>	
<table class="table table-striped table-hover tabledrop" id="foldergrouptable" style="width:95%;">
  <thead>
    <tr>  
      <th onclick="sortTable('foldergrouptable',0,'number')" align="left" style="cursor: pointer;">Unique Share Names</th>
      <th onclick="sortTable('foldergrouptable',1,'number')" align="left" style="cursor: pointer;">Share Count</th> 
      <th onclick="sortTable('foldergrouptable',2,'number')" align="left" style="cursor: pointer;">File Count</th>
      <th onclick="sortTable('foldergrouptable',3,'number')" align="left" style="cursor: pointer;">Risk Level</th>            
      <th onclick="sortTable('foldergrouptable',4,'alpha')"  align="left" style="cursor: pointer;">Folder Group</th>      	 	 
    </tr>
  </thead>
  <tbody>
  $CommonShareFileGroupTopString	
  </tbody>
</table>
<div id="paginationfg" style="margin:10px;"></div>
</div>

<!--  
|||||||||| PAGE: ShareGraph
-->

<input class="tabInput" name="tabs" type="radio" id="ShareGraph"/> 
<label class="tabLabel" onClick="updateTab('ShareGraph',false)" for="ShareGraph"></label>
<div id="tabPanel" class="tabPanel">
    <h2 style="margin-top: 6px; margin-left: 10px; margin-bottom: 17px;">ShareGraph</h2>
    <div style="border-bottom: 1px solid #DEDFE1; margin-left: -200px; background-color: #f0f3f5; height: 5px; width: 120%; margin-bottom: 10px;"></div>
    <div style="margin-left: 10px; margin-top: 7px;">
		
		<!-- Header Text, Selected Node -->
		<div  style="width: 100%; display: flex; align-items: left; margin-left: -1px;">
			<div style="flex: 1;">
			This provides an interactive graph that can be used to explore the computer, share, and other relationships. Experimental.
			</div>
			<div style="text-align: right; margin-right: 10px;color:gray;">
			&nbsp;Selected Node:&nbsp;<span id="selected-node" style="color:gray;">None</span><br>
				<div id="buttonsright" style="text-align: right;">						
					<span id="node-count">Nodes: 0</span>&nbsp;&nbsp;
					<span id="edge-count">Edges: 0</span>  					
				</div>
			</div>
		</div>
		
		<!-- SHAREGRAPH CONTAINER START -->
		<div  style="width: 100%; display: flex;">
		
			<!-- SHAREGRAPH TOOLBAR -->
			<div style="width: 179px; border: .5px solid lightgray; border-radius: 6px; padding: 10px; background-color: lightgray; margin-top: -10px;">
				
				<!-- Search and shortest path -->
				<input type="text" id="search-input" placeholder="Search nodes..." class="modern-input" style="width: 180px;">
				<input type="text" id="src-node" placeholder="src-node..." class="modern-input" style="width: 180px;">
				<input type="text" id="dst-node" placeholder="dst-node..." class="modern-input" style="width: 180px;">
				<button id="find-path" class="modern-button" style="width: 176px;">Find Path</button>			
				<br>

				<!-- Configuration Options -->
				<select id="layout-select" class="modern-dropdown" style="width: 180px;">
					<option value="breadthfirst">Layout</option>
					<option value="grid">Grid</option>
					<option value="random">Random</option>
					<option value="circle">Circle</option>
					<option value="concentric">Concentric</option>
					<option value="breadthfirst">Breadthfirst</option>
					<option value="cose">Cose</option>
					<option value="dagre">Dagre</option>
					<option value="euler">Euler</option>
					<option value="klay">Klay</option>
					<option value="hierarchical">Hierarchical</option>
					<option value="organic">Organic</option>
					<option value="BlastZone">BlastRadius</option>
				</select>
				<select id="curve-style-select" class="modern-dropdown" style="width: 180px;">
					<option value="bezier">Line Style</option>
					<option value="bezier">Bezier</option>
					<option value="unbundled-bezier">Unbundled Bezier</option>
					<option value="haystack">Haystack</option>
					<option value="segments">Segments</option>
					<option value="straight">Straight</option>
					<option value="taxi">Taxi</option>
					<option value="straight-triangle">Straight-Triangle</option>
				</select>
				<label><input type="checkbox" id="toggle-edge-labels" checked> Show Edge Labels</label>
				<label><input type="checkbox" id="toggle-node-labels" checked> Show Node Labels</label>
				<label><input type="checkbox" id="toggle-visibility"> Hide Unselected</label>

				<br><div style="margin-bottom: 3px;margin-top: 3px;">Blast Radius</div>
				<input type="range" min="0" max="5" value="0" class="modern-slider" id="mySlider" style="width:160px;">&nbsp;<span id="sliderValue">0</span>
				<br><br>					 
	
				<!-- Save, Reset, Show All, Zoom Buttons -->
				<div id="buttonsleft" style="margin-left:2">
						<button id="save-button" class="modern-button" style="width: 170px;" style="font-size: 11px;">Save as Image</button><br>
						<button id="clear-selection" class="modern-button" onclick="ResetGraph();" style="font-size: 11px">&nbsp;&nbsp;&nbsp;Reset&nbsp;&nbsp;&nbsp;</button>
						<button id="removeFadedClassButton" class="modern-button" style="font-size: 11px">&nbsp;Show All&nbsp;&nbsp;</button><br>
						<button id="zoom-in" class="modern-button" style="font-size: 11px">&nbsp;Zoom In&nbsp;</button>
						<button id="zoom-out" class="modern-button" style="font-size: 11px">Zoom Out&nbsp;</button>						
				</div>						
			</div>
			
			<!-- Cytoscape Canvas -->
			<div id="cy" style="flex: 3; height: 600px; margin-top: 10px;">
			</div>		
		</div>		
		
			<!-- Hidden Menu - right-click -->
				<label href="#" class="dropbtn" id="tbrearrange" onClick="">
					<div id="nodemenu" class="dropdown-content">
						<a href="#" id="select-node" class="" style="text-decoration:none; font-weight: normal;">Select</a>
						<a href="#" class="" style="text-decoration:none; font-weight: normal;">Center</a>
						<a href="#" class="" style="text-decoration:none; font-weight: normal;">Expand</a>
						<a href="#" id="Show" class="" style="text-decoration:none; font-weight: normal;">Show</a>
						<a href="#" class="" style="text-decoration:none; font-weight: normal;">Hide</a>
						<a href="#" class="" style="text-decoration:none; font-weight: normal;">View</a>
						<a href="#" id="setspsrc" class="" style="text-decoration:none; font-weight: normal;">Set Src</a>
						<a href="#" id="setspdst" class="" style="text-decoration:none; font-weight: normal;">Set Dest</a>
					</div>
				</label>	
						
				<!-- Hidden Menu - node data  -->
				<div id="popup" class="modern-popup">
					<div id="resizer" class="modern-resizer"></div>
					<h2 id="popup-title">Node Details</h2>
					<p id="popup-content">Content goes here...</p>
					<button id="close-popup" class="modern-button">Close</button>
				</div>
							
				<!-- Hidden Menu - edge data -->
				<div id="popup2" class="modern-popup">
					<div id="resizer2" class="modern-resizer"></div>
					<h2 id="popup-title">Edge Details</h2>
					<p id="popup-content">Content goes here...</p>
					<button id="close-popup" class="modern-button">Close</button>
				</div>			
	</div>
	   <script>
	   	   
        // Custom Organic Layout
        (function() {
            'use strict';

            function OrganicLayout(options) {
                this.options = options;
            }

            OrganicLayout.prototype.run = function() {
                var cy = this.options.cy;
                var nodes = cy.nodes();
                var edges = cy.edges();
                var iterations = this.options.iterations || 1000;
                var coolingFactor = this.options.coolingFactor || 0.95;
                var area = cy.width() * cy.height();
                var maxDisplacement = Math.sqrt(area) / 20;  // Decrease displacement to bring nodes closer

                nodes.positions(function() {
                    return {
                        x: Math.random() * cy.width(),
                        y: Math.random() * cy.height()
                    };
                });

                for (var iteration = 0; iteration < iterations; iteration++) {
                    var displacements = {};

                    nodes.forEach(function(node) {
                        displacements[node.id()] = { x: 0, y: 0 };
                    });

                    // Apply repulsive forces
                    nodes.forEach(function(nodeA) {
                        nodes.forEach(function(nodeB) {
                            if (nodeA.id() === nodeB.id()) return;

                            var deltaX = nodeA.position('x') - nodeB.position('x');
                            var deltaY = nodeA.position('y') - nodeB.position('y');
                            var distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY) + 0.1;
                            var repulsiveForce = area / (distance * distance);

                            displacements[nodeA.id()].x += (deltaX / distance) * repulsiveForce;
                            displacements[nodeA.id()].y += (deltaY / distance) * repulsiveForce;
                        });
                    });

                    // Apply attractive forces
                    edges.forEach(function(edge) {
                        var source = edge.source();
                        var target = edge.target();

                        var deltaX = source.position('x') - target.position('x');
                        var deltaY = source.position('y') - target.position('y');
                        var distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY) + 0.1;
                        var attractiveForce = (distance * distance) / area;

                        displacements[source.id()].x -= (deltaX / distance) * attractiveForce;
                        displacements[source.id()].y -= (deltaY / distance) * attractiveForce;

                        displacements[target.id()].x += (deltaX / distance) * attractiveForce;
                        displacements[target.id()].y += (deltaY / distance) * attractiveForce;
                    });

                    // Limit displacement and update positions
                    nodes.forEach(function(node) {
                        var displacement = displacements[node.id()];
                        var distance = Math.sqrt(displacement.x * displacement.x + displacement.y * displacement.y);

                        if (distance > 0) {
                            var limitedDisplacement = Math.min(maxDisplacement, distance);

                            node.position({
                                x: node.position('x') + (displacement.x / distance) * limitedDisplacement,
                                y: node.position('y') + (displacement.y / distance) * limitedDisplacement
                            });
                        }
                    });

                    maxDisplacement *= coolingFactor;
                }

                cy.fit();
                cy.emit('layoutready');
                cy.emit('layoutstop');
            };

            cytoscape('layout', 'organic', OrganicLayout);
        })();

        // Custom Hierarchical Layout
        (function() {
            'use strict';

            function HierarchicalLayout(options) {
                this.options = options;
            }

            HierarchicalLayout.prototype.run = function() {
                var cy = this.options.cy;
                var nodes = cy.nodes();
                var edges = cy.edges();

                // Initialize node levels and positions
                var levels = [];
                var nodeLevels = {};

                nodes.forEach(function(node) {
                    var level = calculateNodeLevel(node, edges);
                    nodeLevels[node.id()] = level;

                    if (!levels[level]) {
                        levels[level] = [];
                    }
                    levels[level].push(node);
                });

                // Calculate positions for nodes within each level
                var maxLevel = levels.length;
                var levelHeight = cy.height() / maxLevel;
                var nodeWidth = cy.width() / nodes.length;

                levels.forEach(function(nodesAtLevel, levelIndex) {
                    var y = (levelIndex + 0.5) * levelHeight;
                    var currentX = 0;

                    nodesAtLevel.forEach(function(node, nodeIndex) {
                        // Consider node dimensions for spacing
                        var width = node.width();
                        currentX += width / 2;
                        node.position({ x: currentX, y: y });
                        currentX += width / 2 + 20; // Add extra spacing between nodes
                    });
                });

                cy.fit();
                cy.emit('layoutready');
                cy.emit('layoutstop');
            };

            function calculateNodeLevel(node, edges) {
                var incomingEdges = edges.filter(function(edge) {
                    return edge.target().id() === node.id();
                });

                if (incomingEdges.length === 0) {
                    return 0; // Root node level
                } else {
                    var parentLevels = incomingEdges.map(function(edge) {
                        return calculateNodeLevel(edge.source(), edges);
                    });

                    return Math.max.apply(Math, parentLevels) + 1;
                }
            }

            cytoscape('layout', 'hierarchical', HierarchicalLayout);
        })();

        // Custom BlastZone Layout
        (function() {
            'use strict';

            function BlastZoneLayout(options) {
                this.options = options;
            }

            BlastZoneLayout.prototype.run = function() {
                var cy = this.options.cy;
                var nodes = cy.nodes();
                var selectedNode = cy.getElementById(this.options.centerNode);

                if (!selectedNode || selectedNode.empty()) {
                    console.error("Center node not found or not provided.");
                    return;
                }

                var BlastZones = {};

                nodes.forEach(function(node) {
                    var dijkstra = cy.elements().dijkstra(selectedNode, function(edge) {
                        return 1;
                    });
                    var distance = dijkstra.distanceTo(node);
                    BlastZones[node.id()] = distance;
                });

                var maxDistance = Math.max(...Object.values(BlastZones));

                var centerX = cy.width() / 2;
                var centerY = cy.height() / 2;

                var animatePositions = [];

                selectedNode.position({ x: centerX, y: centerY });

                for (var i = 1; i <= maxDistance; i++) {
                    var nodesAtDistance = nodes.filter(function(node) {
                        return BlastZones[node.id()] === i;
                    });

                    var angleStep = (2 * Math.PI) / nodesAtDistance.length;
                    var radius = i * this.options.radiusStep;

                    nodesAtDistance.forEach(function(node, index) {
                        var angle = index * angleStep;
                        var x = centerX + radius * Math.cos(angle);
                        var y = centerY + radius * Math.sin(angle);

                        animatePositions.push({
                            node: node,
                            position: { x: x, y: y }
                        });
                    });
                }

                cy.batch(function() {
                    animatePositions.forEach(function(anim) {
                        anim.node.animate({
                            position: anim.position
                        }, {
                            duration: this.options.animationDuration || 500,
                            easing: this.options.easing || 'ease-out'
                        });
                    }.bind(this));
                }.bind(this));

                cy.fit();
                cy.emit('layoutready');
                cy.emit('layoutstop');
            };

            cytoscape('layout', 'BlastZone', BlastZoneLayout);

        })();

        // Declare cy as a global variable
        var cy;

        // cy creation function 
        function initializeCytoscape(containerId) {
            var cy = cytoscape({
                container: document.getElementById(containerId),

                elements: [

                // Nodes

                $ShareGraphNodesFinal
				
                // Edges

				$ShareGraphEdgesFinal
				
                ],

                style: [
                    {
                        selector: 'node[type="file"]',
                        style: {
                            'shape': 'round-rectangle',
                            'background-opacity': '0.35',
                            'background-color': '#8C5725',
                            'border-color': '#ababab',
                            'border-width': 4,
                            'background-image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAuUlEQVR4nO3WsQ3CABBDUa+ARMH+89DQsM6noYgsSu5MkC2d0ubrFYnUnWsM3lPS7R9C2Ixh8B6H5/XMIRdJ9y0ZBk+bMQyHrMWwELISw1LIeAyLIaMx2yFjMYmQkZhUyNdjkiF6f/GPfwA/GTIV/3HpF6chtrQAFbGlBaiILS1ARWxpASpiSwtQEVtagIrY0gJUxJYWoCK2tAAVsaUFqIgtLUBFbGkBKmJLC1ARW1qAitjSAlSkU3Yv1GHq3C0e2MQAAAAASUVORK5CYII=', // File icon
                            'background-fit': 'none',
                            'label': 'data(labelWithDegree)',
                            'color': '#000',
                            'text-valign': 'bottom',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'text-margin-y': '10px' // Move label down by 10px
                        }
                    },
                    {
                        selector: 'node[type="Folder Group"]',
                        style: {
                            'shape': 'round-rectangle',
                            'background-opacity': '0.35',
                            'background-color': '#8C2F25', // Distinct blue color for Folder Group
                            'border-color': '#ababab',
                            'border-width': 4,
                            'background-image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAAA4klEQVR4nO2XMQqDQBBFX58cISmDpV1yTq8h4qnSCtEq3QbBNAkIsxnd1fwHvxR5zAx+QQghtswZaIABCAtnfEcLFEtIdCsIfGZ858lTpEkg8U7tKTIkFOk9RULiSEQTQauFbsRC7Mo8gQq4AQcyIETkDpRkRoiYRJljRwvGVLl2tGDMNdeOFow55trRgjGxz3nnC4mgiaDV4h9uZNiLSLsXkcJYNbIVYeou9fTF3LRIDBJBE0GrNYduBN0IupE5Uv7qPnDE2tE803iKWDuaVzrggjOWjvZr+mkS7hJCCMFqvAAc6in79kAVQAAAAABJRU5ErkJggg==',
                            'background-fit': 'none',
                            'label': 'data(labelWithDegree)',
                            'color': '#000',
                            'text-valign': 'bottom',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'text-margin-y': '10px' // Move label down by 10px
                        }
                    },
                    {
                        selector: 'node[type="sharename"]',
                        style: {
                            'shape': 'round-rectangle',
                            'background-opacity': '0.35',
                            'background-color': '#8C2F25', // Distinct blue color for Folder Group
                            'border-color': '#ababab',
                            'border-width': 4,
                            'background-image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAAB7klEQVR4nO2ZzStEURjGH1+TKGWpJgtWGmUnSf6ASZKdr62ErJGNjSG2UmRPNpYKO6WQnSIbm9GkbERmYby69d7pzLjijTHPTPepX+fcmc3z636ee4EwYcJ8lwiAFQD3AMTAHYB+EGXZKODyCqADJEn+QsTjCkAtCCJ/wDrKRET+kaSeDpFSFxElUS4i9+UiIj8ROQYwAKAFQDVKJJKHdyJVoAQjDqcAKlVkVu/eGYJDSH5yBXP/GFW5SYKSYr2CuT80q8glQTkx7pnsxqNK1AF4IygnBlKuyJGKdBEUEyMHrsiaikwQFBMj3jIkuzGmIhsExcTIsCvSriKnBMXESMwXSQOoAVAF4JmgmBhI+08f3sa57o02gmJi5MK9s2/pfIigmBjZdkWm/2D9XixmXJEenR8QFBMjvb7IO4AGnacIiokBr3ujL3KrYxNBMTHiPZ1ns6djnKCYGNl3RRZ0nCcoJkYWXZE+HXcJiomRQVckquMNQTEx0oq81JMvaSWAJ12W56SboJiVEwRkiqCYlcD3zZsExayMB4mcERSz0pkv4a1BXgiKWcjoBSonMYJiVq6DDqsRgmJWdoJEVgmKWZkLEjkkKGYlHiTyQFDMSrQQX3WL/qXKT4KgnIUlfJGIyrDvmaT2/PQ1N0wYFC4f9KbkCFRHU0gAAAAASUVORK5CYII=',
                            'background-fit': 'none',
                            'label': 'data(labelWithDegree)',
                            'color': '#000',
                            'text-valign': 'bottom',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'text-margin-y': '10px' // Move label down by 10px
                        }
                    },
                    {
                        selector: 'node[type="sharepath"]',
                        style: {
                            'shape': 'round-rectangle',
                            'background-opacity': '0.35',
                            'background-color': '#2C73D2',
                            'border-color': '#ababab',
                            'border-width': 4,
                            'background-image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAyElEQVR4nO2ZsQ0CQQwEJ3qJbiiFroAKKAhRAykB9zWQLUK6APEE/4Cw77Qjbe7dtSODMWYuA7AHRkAzdAE2JGQ308CzbsCaZJQPjDx0BlYkQl/oQCdG9GeVegpD60ZUte3FyNiLEXVtxGTjlGBNtFDHd0a6uRE1qgnRA9mIGyF+neQbIT55uRHi05YbIT5huZFKdLJu5JXoZN2IGyGXJkQPZCNuhPh1km+E+OTlRmi0kZJgKC3U9Vfv6ZSvt6GaKa0/Q40xTLgDAd+imkMA/j4AAAAASUVORK5CYII=',
                            'background-fit': 'none',
                            'label': 'data(labelWithDegree)',
                            'color': '#000',
                            'text-valign': 'bottom',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'text-margin-y': '10px' // Move label down by 10px
                        }
                    },
                    {
                        selector: 'node[type="sharepath"][RiskLevel="High"]',
                        style: {
                            'shape': 'round-rectangle',
                            'background-opacity': '.60',
                            'background-color': 'red',
                            'border-color': '#ababab',
                            'border-width': 4,
                            'background-image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAyElEQVR4nO2ZsQ0CQQwEJ3qJbiiFroAKKAhRAykB9zWQLUK6APEE/4Cw77Qjbe7dtSODMWYuA7AHRkAzdAE2JGQ308CzbsCaZJQPjDx0BlYkQl/oQCdG9GeVegpD60ZUte3FyNiLEXVtxGTjlGBNtFDHd0a6uRE1qgnRA9mIGyF+neQbIT55uRHi05YbIT5huZFKdLJu5JXoZN2IGyGXJkQPZCNuhPh1km+E+OTlRmi0kZJgKC3U9Vfv6ZSvt6GaKa0/Q40xTLgDAd+imkMA/j4AAAAASUVORK5CYII=',
                            'background-fit': 'none',
                            'label': 'data(labelWithDegree)',
                            'color': '#000',
                            'text-valign': 'bottom',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'text-margin-y': '10px' // Move label down by 10px
                        }
                    },
                    {
                        selector: 'node[type="computer"]',
                        style: {
                            'shape': 'round-rectangle',
                            'border-radius': '50%',
                            'background-opacity': '0.35',
                            'background-color': '#8C8325',
                            'border-color': '#ababab',
                            'border-width': 4,
                            'background-image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAz0lEQVR4nO2YTQrCMBhE3z2sFxHdK15X6t7Si7TeY6TQhQqS+BOS1Hkwy8I3/V4KDRhj3qUHVHi6mCKqJEFyDygXeWLRG9mQj+0vi+RGLoI3kgRZLaxWEmS1sFpJkNXCaiVBVgurlQRZLR7fwvSXloudb1FY8OWDCkyQsYAhFcgQrgGHwssMwD6miCmNI3AtQCG9yDjrH2Qxh12VJEjuAU/ACmiANkWRb4kt0tw9s3YR8qvVzluZtnGu+YwoMi6i2jbSFTCkArl88tk05p+5AaKM/C7vSn5eAAAAAElFTkSuQmCC',
                            'background-fit': 'none',  // Ensures the image fits within the node's bounds
                            'background-position': 'center center', // Centers the image both horizontally and vertically
                            'label': 'data(labelWithDegree)',
                            'color': '#000',
                            'text-valign': 'bottom',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'text-margin-y': '10px' // Move label down by 10px
                        }
                    },
                    {
                        selector: 'node[type="owner"]',
                        style: {
                            'shape': 'round-rectangle',
                            'background-opacity': '0.35',
                            'background-color': '#258C71',
                            'border-color': '#ababab',
                            'border-width': 4,
                            'background-image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAAC8UlEQVR4nO2ZPWgUURDHf4kXLGKCWpy1goUaBLGwUAtRoygYkGilFgG7YIwWFqIggVioiBAbBRtP7axE7Y0fp0IETSIxYEQQVBT8KMwpXhiYhWW5zb3dfeuNcD8Y2N3bt7v/2zfzZmahSZMmjWI5cBAYAi4Dl4CTwEaghf+A7cBjoDqPjQJLMcxZ4G8dEYG9A64AazFGv6OAqFWAPoywBPiWUojYb2ANBjiQQURgVzHADQ9CXmOAsgchf4CFjRYy5UGIWEejhUx7EtLeaCGPPIiQqNdwbnsQMoYBzngQMoIBdnsQsg8DrPMgZD0GuO9ByD0M8MqDkJcY4KYHIdcxwNYEdUgtk7FbMMKODEK6McZ0ChFvMMi5FELOY5AVwGzCynAlRhlKIETeoFlagHHHLsoCjFN2ECLFmHmeOgh5W2NcG9ALlIBJ4CfwQ7dL+pucYypleR8Z0+NYMk/publTAD45PNAtPb9VO5TBcfkTjmqfq11NtgdDvieZwLCOzY1TDiJmgMV6fiBCwnZ/nQAgvx3R7mRVxeTSbbzmmHMd0jE9er6I2JawUV7RsXt8CVgGnAY+Oq4dMzr92kI+IW8iKQMhn8kUADZpJPmVMCW5qON7Qz6RZj0pABN6DblW4sVur3Y8qiltp16rpPvi2Ek+Ho0BD3T/WJpaZgPwIoOAwCQfQ3u9sr/a8f6bgc865oke60raNz6sCV7VYzfxe4026SjwDChG7t8XSkbvAJ16vEOPybXqsj9j9Re1znmEPA/5TVF950Ik5Q/7k7MQ+c731aMIsVWRqRX+wFPUJkQg5q5uz8Z81XKeWic8ixDbFXF2WbGJEVPVLEH8oxbHXZ39YQ5CRiLhd7xG+C2qr5Q1UsWF30nX8PslByEfNEcKL4iSdiRl0NeC6IMgRalo2uFKdx4pSlaG9Z+VBxvQKRNHQd9ErkljWlr1gYIQP64rtkSkRWpd6tgT/zKNT4tMEdfCysx0iiNa6kqZKyZvQkJsbKk7BzC/6XzIHQYsAAAAAElFTkSuQmCC', // User icon
                            'background-position': 'center center',
                            'background-repeat': 'no-repeat',
                            'background-fit': 'none',
                            'label': 'data(labelWithDegree)',
                            'color': '#000',
                            'text-valign': 'bottom',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'text-margin-y': '10px' // Move label down by 10px
                        }
                    },
                    {
                        selector: 'node[type="user"]',
                        style: {
                            'shape': 'round-rectangle',
                            'background-opacity': '0.35',
                            'background-color': '#8C2564',
                            'border-color': '#ababab',
                            'border-width': 4,
                            'background-image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAABtklEQVR4nO2ZPShFYRjHf5dEsriSrAwWGViUkiQMRh8Li7JZZVDko5QySBYGCzIZZRZyDcrHjUSxiluyuK7u0VvnLqeLc895OM/N+dV/fHuf3zmn932f80JISEhQ1ABDwBywAiwBE0ALECEP6ASOAeubHABRFDMPpH+QyOQBWAUaUMaoSwFn3oFhlFAOvHgUMUkB9Shg0IdEJmsoYFNA5BoFxAREPoDioEVuBERMyoIWuRUSKQ1a5EhAwqx6gbMjIHKKAqYFRJZRQI+ASC8KaBQQaUIBewIiuyjgUkDkAgVsCYhsoICOHPqQbDFj21FCtw+RLpRx50HCHG/UsehBxIxRRy2QzLEzrEMps/n+NjJEXO4r90Ahyom5EImTB5y4ELkiD4i7/EGnmiLg0YXIK1CCYqZyWLUWUEgUWPdw5jL/xCpRQBUw6fJz+ipPwAxQHYRAq/0033wIOJMEtoG2375DKbB76zPB4r/KOdBvzylK8x8JWFmEzNwijNgHPCugpOwafDHgs/uTShro83OB86xAwrKTACq8iIwrKN5yZMyLyKGCwi1H9r2IJBQUbmXZPENCQv4rn6Ej5y2yxDtPAAAAAElFTkSuQmCC', // User icon
                            'background-position': 'center center',
                            'background-repeat': 'no-repeat',
                            'background-fit': 'none',
                            'label': 'data(labelWithDegree)',
                            'color': '#000',
                            'text-valign': 'bottom',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'text-margin-y': '10px' // Move label down by 10px
                        }
                    },
                    {
                        selector: 'node:selected',
                        style: {
                            //'border-color': '#F56A00', // color on node selection
                            'border-color': '#F56A00', // color on node selection
                            'border-width': 4,
                        }
                    },
                    {
                        selector: 'edge',
                        style: {
                            'width': 2,
                            'line-color': 'lightgray',
                            'curve-style': 'bezier',
                            'label': 'data(label)',  // Ensure this is present
                            'text-opacity': 1,
                            'font-size': 12,
                            'text-margin-y': -10,  // Adjust as needed to position the label correctly
                        }
                    }
                ],

                layout: {
                    name: 'breadthfirst',
                    directed: true,
                    padding: 10,
                    spacingFactor: 1.5,
                    fit: true,
                    animate: true,
                }
            });

            return cy;
        };

        // #################################
        // START CYTOSCAPE
        // #################################

        cy = initializeCytoscape('cy');
		
        // #################################
        // RESET CYTOSCAPE
        // #################################

        // Function to reset the graph
        function ResetGraph() {
            // Destroy the current Cytoscape instance
            cy.destroy();

            // Reinitialize the Cytoscape instance and reassign it to the global variable
            cy = initializeCytoscape('cy');

            // Reinitialize event listeners
            StartCytoListener();

            // Set the 'Show Edge Labels' checkbox to checked
            document.getElementById('toggle-edge-labels').checked = true;

            // Set the 'Show Node Labels' checkbox to checked
            document.getElementById('toggle-node-labels').checked = true;

            // Set the 'Hide Unselected' checkbox to unchecked
            document.getElementById('toggle-visibility').checked = false;

            // Set the search input value to an empty string
            document.getElementById('search-input').value = '';

            // Set the src input value to an empty string
            document.getElementById('src-node').value = '';

            // Set the dst input value to an empty string
            document.getElementById('dst-node').value = '';

            // Set the 'Curve Style' dropdown to the default option
            document.getElementById('curve-style-select').selectedIndex = 0;

            // Set the 'Layout' dropdown to the default option
            document.getElementById('layout-select').selectedIndex = 0;

            // Set Selected to ""
            document.getElementById('selected-node').innerText = '';
        }

        // #################################
        // START CYTOSCAPE EVENT LISTENERS
        // #################################

        function StartCytoListener() {

            // Calculate and set degree for each node, and update label with degree count
            cy.nodes().forEach(function (node) {
                var degree = node.degree();
                var labelWithDegree = node.data('label') + ' (' + degree + ')';
                node.data('degree', degree);
                node.data('labelWithDegree', labelWithDegree);
            });

            // Right-click to show the node menu
            let selectedNode = null;
            let lastSelectedNode = null;

            cy.on('cxttap', 'node', function (evt) {
                selectedNode = evt.target;

                // Show the dropdown menu for node selection
                let x = evt.originalEvent.clientX;
                let y = evt.originalEvent.clientY;

                let menu = document.getElementById('nodemenu');
                menu.style.display = 'inline-block';
                menu.style.position = 'absolute';
                menu.style.left = (x + 10) + 'px';
                menu.style.top = (y + 10) + 'px';
                menu.style.width = '100px';
                menu.style.margin = '2px';
                menu.style.backgroundColor = '#f9f9f9';
                menu.style.border = '1px solid #ccc';
                menu.style.boxShadow = '0px 4px 8px rgba(0, 0, 0, 0.2)';
            });

            // Define a set of gradient colors for different distances
            var gradientColors = [
                '#2A6D79', // Distance 0 (center) - Medium-dark blue
                '#368B81', // Distance 1 - Teal
                '#45A789', // Distance 2 - Light teal
                '#54C491', // Distance 3 - Soft greenish blue
                '#63E199', // Distance 4 - Pale green
                '#72FFB1', // Distance 5 - Very light greenish blue

                // Add more colors if needed for greater distances
            ];

		// Function to update edge colors and manage label visibility based on distance and slider value
		function updateEdgeColors(selectedNode, sliderValue) {

			// Check the state of the checkboxes
			var shouldHide = document.getElementById('toggle-visibility').checked;
			var showEdgeLabels = document.getElementById('toggle-edge-labels').checked;
			var showNodeLabels = document.getElementById('toggle-node-labels').checked;

			// Reset all edges and nodes to their original styles
			cy.edges().forEach(function (edge) {
				edge.removeClass('highlighted-edge'); // Remove any highlighted-edge class
				edge.style('line-color', 'lightgray'); // Reset the edge color to the default color
				edge.source().style('border-color', '#ababab'); // Reset source node border color
				edge.target().style('border-color', '#ababab'); // Reset target node border color
			});

			// Reset all nodes and edges to default faded and invisible state
			if (shouldHide) {
				cy.nodes().removeClass('faded blueedge').addClass('invisible');
				cy.edges().removeClass('faded blueedge').addClass('invisible').removeClass('highlighted-edge');
			} else {
				cy.nodes().removeClass('invisible blueedge').addClass('faded');
				cy.edges().removeClass('invisible blueedge').addClass('faded').removeClass('highlighted-edge');
			}

			// Get the connected nodes and edges for the selected node
			var connectedEdges = selectedNode.connectedEdges();
			var connectedNodes = connectedEdges.connectedNodes();

			// Handle visibility when slider value is 0
			if (sliderValue === 0) {
				// Make only the selected node, its connected nodes, and edges visible
				selectedNode.removeClass('faded invisible');
				connectedNodes.removeClass('faded invisible');
				connectedEdges.removeClass('faded invisible');

				// Highlight connected edges and update their styles
				connectedEdges.forEach(function (edge) {
					edge.addClass('highlighted-edge');
					edge.style('line-color', 'blue'); // Example color, change as needed

					// Manage edge label visibility based on the checkbox
					edge.style('label', showEdgeLabels ? edge.data('label') : '');
				});

				// Manage node labels for connected nodes based on the checkbox
				connectedNodes.forEach(function (node) {
					node.style('label', showNodeLabels ? node.data('labelWithDegree') : '');
				});

				// Skip the rest of the function since we're only showing connected nodes/edges
				updateLabelsVisibility();
				updateCounts();
				return;
			}

			// Get the Dijkstra distance from the selected node for non-zero slider values
			var dijkstra = cy.elements().dijkstra('#' + selectedNode.id(), function (edge) {
				return 1; // Weight of 1 for each edge
			});

			// Update edge colors and manage node/edge visibility based on the shortest distance from the selected node
			cy.edges().forEach(function (edge) {
				var sourceDistance = dijkstra.distanceTo(edge.source());
				var targetDistance = dijkstra.distanceTo(edge.target());

				var minDistance = Math.min(sourceDistance, targetDistance);

				if (minDistance <= sliderValue) {
					// Remove the faded or invisible classes from nodes and edges that should be highlighted
					if (shouldHide) {
						edge.removeClass('invisible');
						edge.source().removeClass('invisible');
						edge.target().removeClass('invisible');
					} else {
						edge.removeClass('faded');
						edge.source().removeClass('faded');
						edge.target().removeClass('faded');
					}

					// Apply the highlighted-edge class and set the color based on the distance
					edge.addClass('highlighted-edge');
					var color = gradientColors[minDistance] || gradientColors[gradientColors.length - 1]; // Use last color if distance exceeds predefined colors
					edge.style('line-color', color);

					// Manage edge label visibility based on the checkbox
					edge.style('label', showEdgeLabels ? edge.data('label') : '');
				}

				// Ensure labels are correctly updated
				updateLabelsVisibility();
			});

			// Update node labels based on the checkbox state
			cy.nodes().forEach(function (node) {
				var distance = dijkstra.distanceTo(node);
				if (distance <= sliderValue) {
					// Manage node visibility
					if (shouldHide) {
						node.removeClass('invisible');
					} else {
						node.removeClass('faded');
					}

					// Manage node label visibility based on the checkbox
					node.style('label', showNodeLabels ? node.data('labelWithDegree') : '');
				}

				// Ensure labels are correctly updated
				updateLabelsVisibility();
			});

			// Update count 
			updateCounts();
		}

            // ##############################
			// Select node using the "Select" option from the nodemenu	
			// ##############################			
			document.getElementById('select-node').addEventListener('click', function () {
				// Hide the dropdown menu
				document.getElementById('nodemenu').style.display = 'none';

				if (selectedNode) {
					// Ensure that the node is correctly selected by its ID
					var selectedNodeId = selectedNode.id();
					var cyNode = cy.getElementById(selectedNodeId);

					if (cyNode && cyNode.same(selectedNode)) {  // Ensure we have the correct node
						// Remove the 'highlighted' style from the previously highlighted path
						cy.elements().removeClass('highlighted highlighted-edge');

						// Remove the 'highlighted-edge' style and reset formatting for the previously selected node
						if (lastSelectedNode && lastSelectedNode.id() !== selectedNodeId) {
							var lastConnectedEdges = lastSelectedNode.connectedEdges();
							lastConnectedEdges.removeClass('highlighted-edge').style('line-color', 'lightgray');
							lastConnectedEdges.connectedNodes().removeClass('highlighted');

							// Reset the last selected node's size and border to its original style
							lastSelectedNode.style({
								'border-color': '#ababab', // Reset to the original border color
								'width': '60px',           // Reset to the original width
								'height': '60px'           // Reset to the original height
							});
						}

						// Update selected node's style
						selectedNode.style({
							'border-color': '#25648C',
							'width': '80px',
							'height': '80px'
						}).addClass('highlighted'); // Add the 'highlighted' class to the selected node

						// Get connected edges of the selected node
						var connectedEdges = selectedNode.connectedEdges();

						// Add the 'highlighted-edge' style to the connected edges of the selected node
						connectedEdges.addClass('highlighted-edge').style('line-color', '#25648C');

						// Also add the 'highlighted' class to the connected nodes
						connectedEdges.connectedNodes().addClass('highlighted');

						// Handle visibility/fading for unselected nodes and edges based on checkboxes
						var shouldHide = document.getElementById('toggle-visibility').checked;

						// Reset all nodes and edges
						cy.elements().removeClass('faded invisible');

						if (shouldHide) {
							// Hide all nodes and edges
							cy.elements().addClass('invisible');
						} else {
							// Fade all nodes and edges
							cy.elements().addClass('faded');
						}

						// Remove the "faded" or "invisible" class from the selected node and its connected nodes/edges
						cyNode.removeClass('faded invisible');
						connectedEdges.removeClass('faded invisible');
						connectedEdges.connectedNodes().removeClass('faded invisible');

						// Update the last selected node
						lastSelectedNode = selectedNode;

						// Update label
						document.getElementById('selected-node').innerText = selectedNodeId;

						// Ensure label visibility (full, faded, invisible) is correctly updated
						updateLabelsVisibility();

						// Update counts
						updateCounts();
					} else {
						console.error("Failed to correctly identify the selected node.");
					}
				}
			});

            // Update edges when the slider is moved
            document.getElementById('mySlider').addEventListener('input', function () {
                var sliderValue = this.value;
                document.getElementById('sliderValue').textContent = sliderValue;

                // Check if the "selected-node" element's innerText is not empty
                if (document.getElementById('selected-node').innerText !== '') {
                    // Apply the color changes to the edges connected to the currently selected node, if any
                    if (selectedNode) {
                        updateEdgeColors(selectedNode, sliderValue);
                    }
                }
            });

            // Add a class to fade elements
            cy.style()
                .selector('.faded')
                .style({
                    'opacity': 0.1,
                    'pointer-events': 'none',
                    'text-opacity': 0,  // Hide labels when faded
                    'color-opacity': 0,  // Hide label colors when faded
                    // 'transition-property': 'opacity, text-opacity, color-opacity'
                    //'transition-duration': '0.2s'
                })
                .update();

            // Add a class to highlight shortest path edges
            cy.style()
                .selector('.highlighted')
                .style({
                    'line-color': 'red',
                    'target-arrow-color': 'red',
                    'transition-property': 'line-color, target-arrow-color',
                    'transition-duration': '0.5s'
                })
                .update();

            // Add a class to non visible elements
            cy.style()
                .selector('.invisible')
                .style({
                    //'opacity': 0.1,
                    //'pointer-events': 'none',
                    //'text-opacity': 0,  // Hide labels when faded
                    //'color-opacity': 0,  // Hide label colors when faded
                    'visibility': 'hidden'  // Hide the nodes and edges completely
                    //'transition-property': 'visibility',
                    //'transition-duration': '0.2s'
                })
                .update();

            // Add selectionNode styles - nodemenu-select
            cy.style()
                .selector('.selected-node')
                .style({
                    'border-color': '#25648C',
                    'border-width': '4px'
                })
                .selector('.previously-selected-node')
                .style({
                    'border-color': '#ababab',
                    'border-width': '2px'
                })
                .selector('.highlighted-edge')
                .style({
                    'line-color': '#25648C',
                    'width': '4px'
                })
                .update();

            // Add source node style select style for shortest path
            cy.style()
                .selector('.sourcenode-dot')
                .style({
                    'background-color': 'green',  // Make the main node background transparent
                    'overlay-opacity': 0,  // Ensure no overlay on the node itself
                    'underlay-color': 'transparent',  // Make sure no underlay color is applied
                    //'content': '',  // Remove any content from the node
                    'background-clip': 'none',  // Prevent background clipping
                    'width': '80px',  // Set the size of the outer node (if needed)
                    'height': '80px',  // Set the size of the outer node (if needed)
                    'z-index': 10,  // Ensure this node is above others
                    //'shape': 'ellipse',  // Round shape for the dot
                })
                .update();

            cy.style()
                .selector('.sourcenode-dot:parent')
                .style({
                    'background-color': 'green',  // Make sure the main node background is transparent
                    'overlay-opacity': 0,  // Ensure no overlay on the main node
                    'underlay-color': 'transparent',  // Ensure no underlay color on the main node
                    //'label': '',  // Remove the label from the parent node
                    //'content': '',  // Remove any content
                    //'shape': 'ellipse',  // Round shape for the dot
                    'background-color': 'blue',  // Blue color for the dot
                    'width': '50px',  // Size of the blue dot (smaller than the main node)
                    'height': '50px',  // Size of the blue dot
                    'position': 'relative',  // Ensure it's relative to the parent node
                    'z-index': 20,  // Ensure the dot is above the parent node
                    'padding': '5px'  // Optional: add padding to the dot
                })
                .update();

            // Add dest node style select style for shortest path
            cy.style()
                .selector('.dstnode-dot')
                .style({
                    'background-color': 'red',  // Make the main node background transparent
                    'overlay-opacity': 0,  // Ensure no overlay on the node itself
                    'underlay-color': 'transparent',  // Make sure no underlay color is applied
                    //'content': '',  // Remove any content from the node
                    'background-clip': 'none',  // Prevent background clipping
                    'width': '80px',  // Set the size of the outer node (if needed)
                    'height': '80px',  // Set the size of the outer node (if needed)
                    'z-index': 10,  // Ensure this node is above others
                    //'shape': 'ellipse',  // Round shape for the dot
                })
                .update();

            cy.style()
                .selector('.dstnode-dot:parent')
                .style({
                    'background-color': 'green',  // Make sure the main node background is transparent
                    'overlay-opacity': 0,  // Ensure no overlay on the main node
                    'underlay-color': 'transparent',  // Ensure no underlay color on the main node
                    //'label': '',  // Remove the label from the parent node
                    //'content': '',  // Remove any content
                    //'shape': 'ellipse',  // Round shape for the dot
                    'background-color': 'blue',  // Blue color for the dot
                    'width': '50px',  // Size of the blue dot (smaller than the main node)
                    'height': '50px',  // Size of the blue dot
                    'position': 'relative',  // Ensure it's relative to the parent node
                    'z-index': 20,  // Ensure the dot is above the parent node
                    'padding': '5px'  // Optional: add padding to the dot
                })
                .update();

            // Search input event to filter nodes
            document.getElementById('search-input').addEventListener('input', function () {
                var searchTerm = this.value.toLowerCase();

                if (searchTerm === '') {
                    cy.elements().removeClass('faded');
                    document.getElementById('selected-node').textContent = 'None';
                    return;
                }

                cy.elements().addClass('faded');

                cy.nodes().filter(function (node) {
                    return node.data('label').toLowerCase().includes(searchTerm);
                }).removeClass('faded');
            });


            // Expand node using the "Expand" option from the menu
            document.querySelector('#nodemenu a:nth-child(3)').addEventListener('click', function () {
                if (selectedNode) {
                    var connectedNodes = selectedNode.connectedEdges().connectedNodes();

                    // Show connected nodes and edges - faded
                    connectedNodes.removeClass('faded');
                    selectedNode.connectedEdges().removeClass('faded');

                    // Show connected nodes and edges - invisible
                    connectedNodes.removeClass('invisible');
                    selectedNode.connectedEdges().removeClass('invisible');

                    // Set edge color to lightgray for expanded node
                    // selectedNode.connectedEdges().style('line-color', '#17405A');

                    // Hide the dropdown menu
                    document.getElementById('nodemenu').style.display = 'none';
                }

                // Ensure labels are correctly updated
                updateLabelsVisibility();

				// Update counts
				updateCounts();				
            });
			
			// Show node using the "Show" option from the menu
			document.getElementById('Show').addEventListener('click', function() {
				if (selectedNode) {
				
					// Hide the dropdown menu
					document.getElementById('nodemenu').style.display = 'none'
					
					// Remove 'faded' class from the selected node
					selectedNode.removeClass('faded');;
					
					// Get all nodes connected to the selected node
					var connectedNodes = selectedNode.connectedNodes();

					// Filter nodes to get those that do not have the 'faded' class
					var nonFadedNodes = connectedNodes.filter(function(node) {
						return !node.hasClass('faded');
					});		
					
					// Find edges connected to non-faded nodes
					var edgesToUpdate = cy.edges().filter(function(edge) {
						return nonFadedNodeIds.includes(edge.source().id()) || nonFadedNodeIds.includes(edge.target().id());
					});

					// Remove 'faded' class from these edges
					edgesToUpdate.removeClass('faded');		
					edgesToUpdate.removeClass('invisible');		

					// Update counts
					updateCounts();
				}
			});
	

            // Hide the menu when clicking elsewhere
            document.addEventListener('click', function (event) {
                if (!event.target.closest('#nodemenu') && !event.target.closest('node')) {
                    document.getElementById('nodemenu').style.display = 'none';
                }
            });

			// View node details using the "View" option from the nodemenu
			document.querySelector('#nodemenu a:nth-child(6)').addEventListener('click', function () {
				if (selectedNode) {
					// Get the background image URL from the node's style
					let backgroundImage = selectedNode.style('background-image');

					// Remove 'url("') and '")' from the string
					backgroundImage = backgroundImage.replace(/^url\(["']?/, '').replace(/["']?\)$/, '');

					// Check if the image is a valid URL
					if (!backgroundImage || backgroundImage === 'none') {
						backgroundImage = ''; // Set to empty if no valid image URL is found
					}

					// Populate the popup with the selected node's data
					const popupTitle = document.getElementById('popup-title');
					const popupContent = document.getElementById('popup-content');

					popupTitle.textContent = 'Node Details: ' + selectedNode.data('label');

					// Initialize the content string
					let content = '';

					// Add an image element with the background image at the very beginning, only if a valid image URL is found
					if (backgroundImage) {
						content += '<img src="' + backgroundImage + '" alt="Node Image" style="float:left; width: 50px; height: 50px; margin-right: 10px;"><br><br><br>';
					}

					// Iterate through all the properties of the selected node
					Object.keys(selectedNode.data()).forEach(function (key) {
						content += '<div><strong>' + key.charAt(0).toUpperCase() + key.slice(1) + ':</strong> ' + selectedNode.data(key) + '</div>';
					});

					// Set the content of the popup
					popupContent.innerHTML = content;

					// Show the popup
					document.getElementById('popup').style.display = 'block';

					// Hide the dropdown menu
					document.getElementById('nodemenu').style.display = 'none';
				}
			});

            // Hide using the "Hide" option from the nodemenu
            document.querySelector('#nodemenu a:nth-child(5)').addEventListener('click', function () {
                if (selectedNode) {

                    var connectedNodes = selectedNode.connectedEdges().connectedNodes();

                    // check toggle-visibility
                    var shouldHide = document.getElementById('toggle-visibility').checked;

                    // Show connected nodes and edges
                    // connectedNodes.addClass('faded');
                    if (shouldHide) {
                        selectedNode.addClass('invisible');
                        selectedNode.connectedEdges().addClass('invisible');
                    } else {
                        selectedNode.addClass('faded');
                        selectedNode.connectedEdges().addClass('faded');
                    }

                    // Set edge color to lightgray for expanded node
					selectedNode.connectedEdges().addClass('faded');

                    // Hide the dropdown menu
                    document.getElementById('nodemenu').style.display = 'none';
                }

                // Ensure labels are correctly updated
                updateLabelsVisibility();
				
				// Update counts
				updateCounts();				
            });

            // Set using the "set src" option from the nodemenu
            document.querySelector('#nodemenu a:nth-child(7)').addEventListener('click', function () {
                if (selectedNode) {
                    document.getElementById('src-node').value = selectedNode.id();

                    // Remove the sourcenode-dot class from all nodes
                    cy.nodes().removeClass('sourcenode-dot');

                    // Add the sourcenode-dot class to the selected node
                    selectedNode.addClass('sourcenode-dot');

                    // Hide the dropdown menu
                    document.getElementById('nodemenu').style.display = 'none';
                }
            });

            // Set using the "set dst" option from the node menu
            document.querySelector('#nodemenu a:nth-child(8)').addEventListener('click', function () {
                if (selectedNode) {

                    document.getElementById('dst-node').value = selectedNode.id();

                    // Show connected nodes and edges
                    // connectedNodes.addClass('faded');
                    //selectedNode.addClass('border-color':'yellow');

                    // Remove the sourcenode-dot class from all nodes
                    cy.nodes().removeClass('dstnode-dot');

                    // Add the sourcenode-dot class to the selected node
                    selectedNode.addClass('dstnode-dot');

                    // Hide the dropdown menu
                    document.getElementById('nodemenu').style.display = 'none';
                }
            });

            // Close the popup when the close button is clicked
            document.getElementById('close-popup').addEventListener('click', function () {
                document.getElementById('popup').style.display = 'none';
            });

            // Ensure the popup closes when clicking outside of it
            document.addEventListener('click', function (event) {
                if (!event.target.closest('#popup') && !event.target.closest('#nodemenu')) {
                    document.getElementById('popup').style.display = 'none';
                }
            });

            // Resizing functionality
            var isResizing = false;
            var lastDownX = 0;

            var popup = document.getElementById('popup');
            var resizer = document.getElementById('resizer');

            resizer.addEventListener('mousedown', function (e) {
                isResizing = true;
                lastDownX = e.clientX;

                // Prevent text selection while resizing
                document.body.style.userSelect = 'none';
            });

            document.addEventListener('mousemove', function (e) {
                if (!isResizing) return;

                var offsetRight = document.body.clientWidth - (e.clientX - document.body.offsetLeft);
                var newWidth = offsetRight + 'px';

                // Set a minimum and maximum width for the popup
                if (offsetRight > 100 && offsetRight < document.body.clientWidth * 0.8) {
                    popup.style.width = newWidth;
                }
            });

            document.addEventListener('mouseup', function (e) {
                isResizing = false;

                // Re-enable text selection after resizing
                document.body.style.userSelect = 'auto';
            });

            // Toggle edge labels visibility
            document.getElementById('toggle-edge-labels').addEventListener('change', function () {
                updateLabelsVisibility();
            });

            // Toggle node labels visibility
            document.getElementById('toggle-node-labels').addEventListener('change', function () {
                updateLabelsVisibility();
            });

            // Helper function for visiblity of labels
            function updateLabelsVisibility() {
                var showEdgeLabels = document.getElementById('toggle-edge-labels').checked;
                var showNodeLabels = document.getElementById('toggle-node-labels').checked;

                cy.edges().forEach(function (edge) {
                    if (edge.hasClass('faded') || edge.hasClass('invisible')) {
                        edge.style('text-opacity', 0);  // Hide label if faded or invisible
                    } else {
                        edge.style('text-opacity', showEdgeLabels ? 1 : 0);  // Show or hide based on the checkbox
                    }
                });

                cy.nodes().forEach(function (node) {
                    if (node.hasClass('faded') || node.hasClass('invisible')) {
                        node.style('text-opacity', 0);  // Hide label if faded or invisible
                    } else {
                        node.style('text-opacity', showNodeLabels ? 1 : 0);  // Show or hide based on the checkbox
                    }
                });
            }


            // Toggle faded visibility
            document.getElementById('toggle-visibility').addEventListener('change', function () {
                var shouldHide = this.checked;

                if (shouldHide) {
                    cy.elements('.faded').addClass('invisible').removeClass('faded');
                } else {
                    cy.elements('.invisible').addClass('faded').removeClass('invisible');
                }
            });

            // Add hover event listeners to edges
            cy.edges().on('mouseover', function (event) {
                var edge = event.target;
                if (!edge.hasClass('faded') && !edge.hasClass('invisible')) {
                    edge.style('text-opacity', 1);  // Show label when hovering over the edge
                }
            });

            cy.edges().on('mouseout', function (event) {
                var edge = event.target;
                if (edge.hasClass('faded') || edge.hasClass('invisible') || !document.getElementById('toggle-edge-labels').checked) {
                    edge.style('text-opacity', 0);  // Hide label when not hovering if labels are toggled off or faded class is applied
                }
            });

            // Add hover event listeners to nodes
            cy.nodes().on('mouseover', function (event) {
                var node = event.target;
                if (!node.hasClass('faded') && !node.hasClass('invisible')) {
                    node.style('text-opacity', 1);  // Show label when hovering over the node
                }
            });

            cy.nodes().on('mouseout', function (event) {
                var node = event.target;
                if (node.hasClass('faded') || node.hasClass('invisible') || !document.getElementById('toggle-node-labels').checked) {
                    node.style('text-opacity', 0);  // Hide label when not hovering if labels are toggled off or faded class is applied
                }
            });

            // Add a right-click context menu for edges
            cy.on('cxttap', 'edge', function (evt) {
                var selectedEdge = evt.target;

                // Show the dropdown menu for edge selection
                let x = evt.originalEvent.clientX;
                let y = evt.originalEvent.clientY;

                let edgeMenu = document.getElementById('edgemenu');
                if (!edgeMenu) {
                    edgeMenu = document.createElement('div');
                    edgeMenu.id = 'edgemenu';
                    edgeMenu.className = 'dropdown-content';
                    edgeMenu.innerHTML = '<a href="#" id="view-edge">View</a>';
                    document.body.appendChild(edgeMenu);
                }

                // Remove any existing event listener to avoid multiple triggers
                document.getElementById('view-edge').removeEventListener('click', handleViewEdge);

                // Add click event for "View" option
                document.getElementById('view-edge').addEventListener('click', handleViewEdge);

                function handleViewEdge() {
                    if (selectedEdge) {
                        let content = '';

                        // Conditionally add each property if it exists
                        Object.keys(selectedEdge.data()).forEach(function (key) {
                            content += '<strong>' + key.charAt(0).toUpperCase() + key.slice(1) + ':</strong> ' + selectedEdge.data(key) + '<br>';
                        });

                        // Populate the popup with the selected edge's data
                        document.getElementById('popup2').querySelector('#popup-title').textContent = 'Edge Details';
                        document.getElementById('popup2').querySelector('#popup-content').innerHTML = content;

                        // Show the popup
                        document.getElementById('popup2').style.display = 'block';

                        // Hide the dropdown menu
                        edgeMenu.style.display = 'none';
                    }
                }

                edgeMenu.style.display = 'inline-block';
                edgeMenu.style.position = 'absolute';
                edgeMenu.style.left = (x + 10) + 'px';
                edgeMenu.style.top = (y + 10) + 'px';
                edgeMenu.style.width = '100px';
                edgeMenu.style.margin = '2px';
                edgeMenu.style.backgroundColor = '#f9f9f9';
                edgeMenu.style.border = '1px solid #ccc';
                edgeMenu.style.boxShadow = '0px 4px 8px rgba(0, 0, 0, 0.2)';
            });


            // Hide the menu when clicking elsewhere
            document.addEventListener('click', function (event) {
                let edgeMenu = document.getElementById('edgemenu');
                if (edgeMenu && !event.target.closest('#edgemenu') && !event.target.closest('edge')) {
                    edgeMenu.style.display = 'none';
                }
            });

            // Close the popup2 when the close button is clicked
            document.querySelector('#popup2 #close-popup').addEventListener('click', function () {
                document.getElementById('popup2').style.display = 'none';
            });

            // Ensure the popup2 closes when clicking outside of it
            document.addEventListener('click', function (event) {
                if (!event.target.closest('#popup2') && !event.target.closest('#edgemenu')) {
                    document.getElementById('popup2').style.display = 'none';
                }
            });

            // Resizing functionality for popup2
            var isResizing2 = false;
            var lastDownX2 = 0;

            var popup2 = document.getElementById('popup2');
            var resizer2 = document.getElementById('resizer2');

            resizer2.addEventListener('mousedown', function (e) {
                isResizing2 = true;
                lastDownX2 = e.clientX;

                // Prevent text selection while resizing
                document.body.style.userSelect = 'none';
            });

            document.addEventListener('mousemove', function (e) {
                if (!isResizing2) return;

                var offsetRight2 = document.body.clientWidth - (e.clientX - document.body.offsetLeft);
                var newWidth2 = offsetRight2 + 'px';

                // Set a minimum and maximum width for the popup2
                if (offsetRight2 > 100 && offsetRight2 < document.body.clientWidth * 0.8) {
                    popup2.style.width = newWidth2;
                }
            });

            document.addEventListener('mouseup', function (e) {
                isResizing2 = false;

                // Re-enable text selection after resizing
                document.body.style.userSelect = 'auto';
            });

            // Function to calculate and return the node with the highest degree centrality
            function getHighestCentralityNode(cy) {
                let maxCentralityNode = null;
                let maxCentrality = -1;

                cy.nodes().forEach(function (node) {
                    let centrality = node.degree(); // Calculate degree centrality (number of connected edges)

                    if (centrality > maxCentrality) {
                        maxCentrality = centrality;
                        maxCentralityNode = node;
                    }
                });

                return maxCentralityNode;
            }

            // Event listener for layout dropdown
            document.getElementById('layout-select').addEventListener('change', function () {
                var selectedNodes = cy.nodes().not('.faded');
                var selectedEdges = selectedNodes.connectedEdges().filter(function (edge) {
                    return edge.target().same(selectedNodes) || edge.source().same(selectedNodes);
                });

                // Get the selected layout from the dropdown
                var selectedLayout = document.getElementById('layout-select').value;

                // Check if the selected layout is 'BlastZone'
                if (selectedLayout === 'BlastZone') {
                    // If selectedNode is not set, choose the node with the highest centrality as the centerNode
                    var centerNode = selectedNode ? selectedNode : getHighestCentralityNode(cy);

                    // Ensure the centrality selection has returned a valid node
                    if (!centerNode || centerNode.empty()) {
                        console.error("No valid nodes available to select as the center node.");
                        return;
                    }

                    cy.layout({
                        name: 'BlastZone',
                        centerNode: centerNode.id(), // Use the selectedNode or highest centrality node as the centerNode
                        radiusStep: 200,
                        nodes: selectedNodes,
                        fit: false,
                        animate: true
                    }).run();
                } else {
                    // Apply the selected layout to the selected nodes and their connected edges
                    cy.layout({
                        name: selectedLayout, // Use the selected layout
                        nodes: selectedNodes,
                        fit: false,
                        animate: true
                    }).run();
                }

                // Ensure selected edges are also shown
                selectedEdges.removeClass('faded');
            });

// Event listener for the "Center" option from the nodemenu
// Event listener for the "Center" option from the nodemenu
document.querySelector('#nodemenu a:nth-child(2)').addEventListener('click', function () {
    // Determine the centroid node
    var centroidNode;

    // If a node is selected, use it as the centroid
    if (selectedNode && !selectedNode.empty()) {
        centroidNode = selectedNode;
    } else {
        // If no node is selected, choose the node with the most connections (highest degree)
        centroidNode = getHighestCentralityNode(cy);
    }

    if (!centroidNode || centroidNode.empty()) {
        console.error("No valid node available to center.");
        return;
    }

    cy.batch(function () {
        // Ensure the centroid node and its connected elements are visible before layout
        centroidNode.removeClass('faded invisible');
        var connectedEdges = centroidNode.connectedEdges();
        var connectedNodes = connectedEdges.connectedNodes();
        connectedEdges.removeClass('faded invisible');
        connectedNodes.removeClass('faded invisible');

        // Apply the BlastZone layout with the centroid node as the center
        var layout = cy.layout({
            name: 'BlastZone',
            centerNode: centroidNode.id(),
            radiusStep: 200,
            fit: false,  // Do not fit automatically within the layout
            animate: true
        });

        layout.run();

        // Ensure the centroid node and its connected elements remain visible after layout
        centroidNode.removeClass('faded invisible');
        connectedEdges.removeClass('faded invisible');
        connectedNodes.removeClass('faded invisible');

        // Fit the view to show the centroid node and its immediate connections without zooming in too much
        var elementsToFit = centroidNode.union(connectedNodes).union(connectedEdges);
        cy.fit(elementsToFit, 100); // Adjust the padding (100) as needed

        // Apply the same selection formatting as the "Select" functionality
        // Remove the 'highlighted' style from the previously highlighted path
        cy.elements().removeClass('highlighted highlighted-edge');

        // Remove the 'highlighted-edge' style and reset formatting for the previously selected node
        if (lastSelectedNode && lastSelectedNode.id() !== centroidNode.id()) {
            var lastConnectedEdges = lastSelectedNode.connectedEdges();
            lastConnectedEdges.removeClass('highlighted-edge').style('line-color', 'lightgray');
            lastConnectedEdges.connectedNodes().removeClass('highlighted');

            // Reset the last selected node's size and border to its original style
            lastSelectedNode.style({
                'border-color': '#ababab', // Reset to the original border color
                'width': '60px',           // Reset to the original width
                'height': '60px'           // Reset to the original height
            });
        }

        // Update the centroid node's style
        centroidNode.style({
            'border-color': '#25648C',
            'width': '80px',
            'height': '80px'
        }).addClass('highlighted'); // Add the 'highlighted' class to the centroid node

        // Add the 'highlighted-edge' style to the connected edges of the centroid node
        connectedEdges.addClass('highlighted-edge').style('line-color', '#25648C');

        // Also add the 'highlighted' class to the connected nodes
        connectedEdges.connectedNodes().addClass('highlighted');

        // Handle visibility/fading for unselected nodes and edges based on checkboxes
        var shouldHide = document.getElementById('toggle-visibility').checked;

        // Reset all nodes and edges
        cy.elements().removeClass('faded invisible');

        if (shouldHide) {
            // Hide all nodes and edges
            cy.elements().addClass('invisible');
        } else {
            // Fade all nodes and edges
            cy.elements().addClass('faded');
        }

        // Remove the "faded" or "invisible" class from the centroid node and its connected nodes/edges
        centroidNode.removeClass('faded invisible');
        connectedEdges.removeClass('faded invisible');
        connectedNodes.removeClass('faded invisible');

        // Update the last selected node
        lastSelectedNode = centroidNode;

        // Update the label to show the centroid node's ID
        document.getElementById('selected-node').innerText = centroidNode.id();

        // Hide the dropdown menu
        document.getElementById('nodemenu').style.display = 'none';

        // Ensure labels are correctly updated
        updateLabelsVisibility();

        // Update counts
        updateCounts();
    });
});







            // Set curve style
            document.getElementById('curve-style-select').addEventListener('change', function () {
                var selectedStyle = this.value;
                var edgeStyle = {
                    'curve-style': selectedStyle
                };

                cy.edges().style(edgeStyle);
            });

            // save as image
            document.getElementById('save-button').addEventListener('click', function () {
                var pngData = cy.png({
                    bg: '#f0f0f0' // Same background color as the canvas
                });
                var link = document.createElement('a');
                link.href = pngData;
                link.download = 'cytoscape-graph.png';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });

            // Add drop shadow to nodes on hover
            cy.nodes().on('mouseover', function (event) {
                var node = event.target;
                node.addClass('hovered');
            });

            cy.nodes().on('mouseout', function (event) {
                var node = event.target;
                node.removeClass('hovered');
            });

            cy.style()
                .selector('.hovered')
                .style({
                    'overlay-color': 'rgba(255, 255, 255, 0.3)', // Simulate shadow with overlay
                    'overlay-padding': '2px',             // Increase size of the overlay
                    'overlay-opacity': 0.3,                // Adjust opacity for shadow effect
                    'background-color': 'white',           // Set to your node color
                    'z-compound-depth': 'below'
                })
                .update();
            
			// ###########################
			// Shortest Path Finder
			// ###########################
			document.getElementById('find-path').addEventListener('click', function () {
				// Clear previous highlights and visibility/fading
				cy.elements().removeClass('highlighted faded invisible');

				// Reset all edges and nodes to their original styles
				cy.edges().forEach(function (edge) {
					edge.removeClass('highlighted-edge'); // Remove any highlighted-edge class
					edge.style('line-color', 'lightgray'); // Reset the edge color to the default color
				});

				// Remove blue formatting from the last selected node
				cy.nodes().forEach(function (node) {
					node.style('border-color', '#ababab'); // Reset to default border color
				});

				// Get source and destination nodes
				var srcNodeId = document.getElementById('src-node').value;
				var dstNodeId = document.getElementById('dst-node').value;

				// Validate that the source and destination nodes exist in the graph
				var srcNode = cy.getElementById(srcNodeId);
				var dstNode = cy.getElementById(dstNodeId);

				if (srcNode.empty() || dstNode.empty()) {
					console.error('Source or Destination node not found.');
					return;
				}

				// Run Dijkstra's algorithm
				var dijkstra = cy.elements().dijkstra(srcNode, function (edge) {
					return 1; // Weight of 1 for each edge
				});

				var path = dijkstra.pathTo(dstNode);

				// Highlight the path
				path.addClass('highlighted');

				// Get toggle visibility status
				var toggleVisibility = document.getElementById('toggle-visibility').checked;

				// Apply 'faded' or 'invisible' class to elements not on the path
				cy.elements().not(path).forEach(function (ele) {
					if (toggleVisibility) {
						ele.addClass('invisible');
					} else {
						ele.addClass('faded');
					}
				});

				// Remove the sourcenode-dot and dstnode-dot classes from all nodes
				cy.nodes().removeClass('dstnode-dot sourcenode-dot');

				// Set selected node to dstnode and apply selection styles
				selectedNode = dstNode;
				selectedNode.style({
					'border-color': '#25648C',
					'width': '80px',
					'height': '80px'
				});

				// Display the ID of the selected node in the 'selected-node' element
				document.getElementById('selected-node').innerText = selectedNode.id();

				// Ensure labels are correctly updated
				updateLabelsVisibility();

				// Update count 
				updateCounts();
			});


            // Set an initial zoom step
            var zoomStep = 10;

            // Function to zoom in
            function zoomIn() {
                var currentZoom = cy.zoom();
                var newZoom = currentZoom + (zoomStep / cy.container().clientHeight); // Calculate the new zoom level
                cy.zoom({
                    level: newZoom,
                    renderedPosition: { x: cy.width() / 2, y: cy.height() / 2 } // Keep zoom centered
                });
                cy.center();
            }

            // Function to zoom out
            function zoomOut() {
                var currentZoom = cy.zoom();
                var newZoom = currentZoom - (zoomStep / cy.container().clientHeight); // Calculate the new zoom level
                cy.zoom({
                    level: newZoom,
                    renderedPosition: { x: cy.width() / 2, y: cy.height() / 2 } // Keep zoom centered
                });
                cy.center();
            }

            // Attach event listeners to buttons
            document.getElementById('zoom-in').addEventListener('click', zoomIn);
            document.getElementById('zoom-out').addEventListener('click', zoomOut);

            const slider = document.getElementById('mySlider');
            const sliderValue = document.getElementById('sliderValue');

            // Update the slider value dynamically
            slider.addEventListener('input', function () {
                sliderValue.textContent = slider.value;
            });
			
			document.getElementById('removeFadedClassButton').addEventListener('click', function() {
			// Access the Cytoscape instance (assumed to be stored in a variable 'cy')
			if (typeof cy !== 'undefined') {
					cy.nodes().removeClass('faded'); // Remove 'faded' class from all nodes
					cy.edges().removeClass('faded');  // Remove 'faded' class from all edges
					cy.nodes().removeClass('invisible'); // Remove 'faded' class from all nodes
					cy.edges().removeClass('invisible');  // Remove 'faded' class from all edges
                    updateCounts();					
				} else {
					console.error('Cytoscape instance is not available.');
				}
			});
			
			function debounce(func, wait) {
				let timeout;
				return function(...args) {
					const context = this;
					clearTimeout(timeout);
					timeout = setTimeout(() => func.apply(context, args), wait);
				};
			}

			// Apply debounce to the slider input event
			document.getElementById('mySlider').addEventListener('input', debounce(function() {
				var sliderValue = this.value;
				document.getElementById('sliderValue').textContent = sliderValue;

				if (document.getElementById('selected-node').innerText !== '') {
					if (selectedNode) {
						updateEdgeColors(selectedNode, sliderValue);
					}
				}
			}, 100)); // Adjust debounce delay as needed	

			function updateCounts() {
				const visibleNodes = cy.nodes().filter(node => !node.hasClass('faded') && !node.hasClass('invisible'));
				const visibleEdges = cy.edges().filter(edge => !edge.hasClass('faded') && !edge.hasClass('invisible'));

				document.getElementById('node-count').textContent = visibleNodes.length + ' Nodes';
                document.getElementById('edge-count').textContent = visibleEdges.length + ' Edges';
			}

			// Update counts
			updateCounts();
			
			function escapeCyId(id) {
				return id.replace(/([#;&,.+*~':"!^$[\]()=>|/@])/g, "\\$1");
			}
        } // end cytoscape event listeners function

        // #################################
        // START CYTOSCAPE EVENT LISTENERS
        // #################################
        StartCytoListener();
		
        // #################################
        // START CYTOSCAPE INITIAL LAYOUT
        // #################################		
        // Flag to track if the layout has been applied
        let layoutApplied = false;

        // Set layout on sharegraph menu selection
        document.getElementById('btnShareGraph').addEventListener('click', function () {

            // Select nodes and edges
            var selectedNodes = cy.nodes().not('.faded');
            var selectedEdges = selectedNodes.connectedEdges().filter(function (edge) {
                return edge.target().same(selectedNodes) || edge.source().same(selectedNodes);
            });

            // Only apply the layout if it's the first time the button is clicked
            if (!layoutApplied) {
                // Get the selected layout from the dropdown (you can update this as needed)
                var selectedLayout = 'breadthfirst';

                // Apply the selected layout to the selected nodes and edges
                cy.elements().layout({
                    name: selectedLayout,
                    fit: false,
                    animate: true,
                    eles: selectedNodes.union(selectedEdges), // Apply the layout to selected nodes and edges
                    ready: function() {
                        // This function is called when the layout is ready but not yet applied
                    },
                    stop: function() {
                        // This function is called after the layout has been completely applied
                
                        // Set the initial zoom level to 0.4 (40% of the original size)
                        cy.zoom(0.4);

                        // Re-center the graph after zooming
                        cy.center(selectedNodes);

                        // Optional: Ensure that the centered graph fits well within the viewport
                        cy.fit(selectedNodes, 50);

                        // Mark that the layout has been applied
                        layoutApplied = true;
                    }
                }).run();
		
                // If the layout has already been applied, just re-center and zoom the graph
                cy.zoom(0.4);
                cy.center(selectedNodes);
                cy.fit(selectedNodes, 50);		
            } else {
            }
    
            // Zoom-in functionality
            document.getElementById('zoom-in').addEventListener('click', function() {
                const zoomLevel = cy.zoom();
                cy.zoom(zoomLevel * 1.2); // Increase the zoom level by 20%
                cy.center(selectedNodes); // Re-center after zooming in
            });
        });
    </script>
</div>

<!--  
|||||||||| PAGE: Exploit Shares
-->

<input class="tabInput"  name="tabs" type="radio" id="Attacks"/> 
<label class="tabLabel" onClick="updateTab('Attacks',false)" for="Attacks"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Exploiting Access</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:7px">
Below are some tips for getting started on exploiting share access.	
</div>

<table class="table table-striped table-hover tabledrop">
  <thead>
    <tr>	  
	  <th align="left">Share</th>
	  <th align="left">Access</th>	  
	  <th align="left">Instructions</th>	
    </tr>
  </thead>
  <tbody>  			
    <tr>	
	  <td>C$, admin$</td>
	  <td>READ</td>
	  <td>
	  Read OS and Application password files and log in.<br>
	  Identify non-public information disclosure.
	  </td>  
    </tr>	
    <tr>	
	  <td>C$, admin$</td>
	  <td>WRITE</td>
	  <td>Read OS and Application password files and log in.<br>
	  Identify non-public information disclosure.<br>
	  Execute arbitrary code by writing files to autorun locations:<br>
	  DLL Hijacking<br>
	  All Users folders<br>
	  Other file based autoruns<br>
	  EXE Replacement<br>
	  </td>  
    </tr>	
   <tr>
	  <td>wwwroot,inetpub,webroot</td>
	  <td>READ</td>
	  <td>Read connection strings and escalation through database. <br>
	  <span class="code">Code - search for file types</span><br>
	  <span class="code">Code - search for file contents</span><br>
     </td>    
   </tr>
   <tr>
	  <td>wwwroot,inetpub,webroot</td>
	  <td>Write</td>
	  <td>
	  Read connection strings and escalation through database.<br>
	  Upload webshell to execute as web server service account.
	  </td> 	  
    </tr>				
  </tbody>
</table>
</div>

<!--  
|||||||||| PAGE: Detect Share Scans
-->

<input class="tabInput"  name="tabs" type="radio" id="Detections"/> 
<label class="tabLabel" onClick="updateTab('Detections',false)" for="Detections"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Recommendations</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>
<div style="margin-left:10px;margin-top:3px">
Below are some tips for getting started on building detections for potentially malicious share scanning events.
</div>

<table class="table table-striped table-hover tabledrop">
  <thead>
    <tr>	  
	  <th align="left">Action</th>
	  <th align="left">Detection Guidance</th>	  
    </tr>
  </thead>
  <tbody>  	    
   <tr>
	  <td>Detect Share Scanning</td>
	  <td>
<strong>Data Sources</strong><br>
Ensure that group policy audit settings are configured so that authentication successes and failures are logged so that real-time analysis and offline analysis can be used to identify common indicators of compromise.  Specifically, ensure the following events IDs are logged and forward to a SIEM solutions.
<br><br>
Logon Success<br>
- Windows Server 2003: 540<br>
- Windows Server 2008-2012: 4624<br>
<br>
Logon Failure<br>
- Windows Server 2003: 680<br>
- Windows Server 2008-2012: 4625<br>
<br>
Network Share Object was Accessed
- All versions: 5140

<br><br>
<strong>Detection Thresholds and Indicators</strong>
<br>
Below is a list of common Indicators of Compromise (IoCs) that can be used to identify potentially SMB scanning.  Please note that not all IoCs will work in every environment due false positives generated by legitimate applications and processes.  However, in some environments it may be possible to modify IoC thresholds or signatures to reduce the number of false positives to an acceptable level.
<br><br>
Consider creating correlation rules based on Active Directory and Local Windows authentication logs for:
<br>
A single system authenticates to many systems via SMB (port 445) in short period of time, and accesses Windows shares. For example, ten or more systems in under a minute. Use the events above to build detections.
<br><br>
Consider implementing a honey pot or canary system that supports SMB shares that can be used to generate alerts when accessed.
<br><br>
<strong>Prevention</strong><br>
If network shares are not required, disable them or block access using host-based firewalls.
Ensure that sensitive information is not available on these shares. To restrict access under Windows, open Explorer, right-click on each of the shares, go to the 'Sharing' tab, and click on 'Permissions'. From here, add or remove permissions for various users and groups.
Guest access to the system should also be revoked and ensure that adequate access controls are in place for each shared resource. NULL sessions should be disabled.

	  </td>  	  
    </tr>
   <tr>
	  <td>Detect Canaries</td>
	  <td>Build detections for authenticated share access read/write access.
	  </td>  	  
    </tr>				
  </tbody>
</table>
</div>

<!--  
|||||||||| PAGE: Prioritize Remediation
-->

<input class="tabInput"  name="tabs" type="radio" id="Remediation"/> 
<label class="tabLabel" onClick="updateTab('Remediation',false)" for="Remediation"></label>
<div id="tabPanel" class="tabPanel">
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Prioritizing Remediation</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>	
<div style="margin-left:10px;margin-top:3px">
Below are some tips for getting started on prioritizing the remediation of shares configured with excessive privileges.
</div>

<table class="table table-striped table-hover tabledrop">
  <thead>
    <tr>	  
	  <th align="left">Share Access</th>
	  <th align="left">Impact</th>	  
	  <th align="left">Description</th>
    </tr>
  </thead>
  <tbody>  	
    <tr>
	  <td>High Risk Shares</td>
	  <td>Confidentiality, Integrity, Availability, Code Execution<br>
	   High likelihood.
	  </td>
	  <td>Remediate high risk shares. In the context of this report, high risk shares have been defined as shares that provide unauthorized remote access to systems or applications. By default, that includes wwwroot, inetpub, c$, and admin$ shares. However, additional exposures may exist that are not called out beyond that.</td>  
    </tr>	
    <tr>
	  <td>Write Access Shares</td>
	  <td>Confidentiality, Integrity, Availability, Code Execution</td>
	  <td>Remediate shares with write access. Write access to shares may allow an attacker to modify data, insert their own users into configuration files to access applications, or leverage write access to execute code on remote systems.  Folders that provide write access could also fall victem to ransomware attacks.</td>  
    </tr>		
    <tr>
	  <td>Read Access Shares</td>
	  <td>Confidentiality,Code Execution</td>
	  <td>Remediate shares with read access. Read access may provide an attacker with unauthorized access to sensitive data and stored secrets such as passwords and private keys that could be used to gain unauthorized access to systems, applications, and databases.</td>  
    </tr>
    <tr>
	  <td>Top Share Names</td>
	  <td>NA</td>
	  <td>Sub prioritize remediation based on top groups of share names(most common share names). When a large number of systems are configured with the same share, they often represent weak configurations associated with applications and processes.</td>  	  
    </tr>
   <tr>
	  <td>Top Share Groups</td>
	  <td>NA</td>
	  <td>Sub prioritize remediation based on top share groups that have the same list of files in their directory.  This is another way to identify systems that are configured with the same share are associated with the same insecure application deployment or process.
	  </td>  	  
    </tr>		
      <tr>	
	  <td>Sub Prioritzation Tips</td>
	  <td>NA</td>
	  <td>
	  Use the detailed .csv files to:<br><br>
	  1. Identify share owners with the ShareOwner field. Filter out "BUILTIN\Administrators", "NT AUTHORITY\SYSTEM", and "NT SERVICE\TrustedInstaller" to identify potential asset owners.<br><br> 
	  2. Filter out shares with a FileCount of 0.<br><br> 
	  3. Sort shares by LastModifiedDate.<br><br> 
	  4. Filter for keywords in the FileList.<br><br>
	  For example, simple keywords like sql, database, backup, password, etc can help identify additional high risk exposures quickly. <br>
	  </td>  				
  </tbody>
</table>
</div>

<!--  
|||||||||| PAGE: Home
-->

<input class="tabInput"  name="tabs" type="radio" id="home"/> 
<label class="tabLabel" onClick="updateTab('home',false)" for="home"></label>
<div id="tabPanel" class="tabPanel">	
<h2 style="margin-top: 6px;margin-left:10px;margin-bottom: 17px;">Scan Information</h2>
<div style="border-bottom: 1px solid #DEDFE1 ;margin-left:-200px;background-color:#f0f3f5; height:5px; width:120%; margin-bottom:10px;"></div>	
<div style="min-height: 670px">	 
	  <div style="margin-left:10px;margin-top:3px">	  
	  The <a href="https://github.com/netspi/powerhuntshares">PowerHuntShares</a> audit script was run against the $TargetDomain Active Directory domain to collect SMB Share data, generate this HTML summary report, and generate the associated csv files that detail potentially excessive share configurations. Below is a the scan summary and an overview of how to use this report.
	  </div>	

<!--  
|||||||||| CARD: SCAN SUMMARY
-->

 <a href="#" id="DashLink" onClick="radiobtn = document.getElementById('dashboard');radiobtn.checked = true;">
 <div class="card" style="position:absolute;margin-top:20px;width:270px;">	
	<div class="cardtitle" align="left">
		<div style="margin-left: 5px; margin-top: 15px; color:#4A4A4A; font-size: 18px; font-weight: bold;">SCAN SUMMARY</div>
		<img style="vertical-align:top;float: right;clear:both;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAwj3pUWHRSYXcgcHJvZmlsZSB0eXBlIGV4aWYAAHjapZxZkly3km3/MYo7BLQOYDhozd4Mavi1NiJISRRl11RPFDOTkRGnAdx343Acd/7n/133n//8JwQfosulNutmnv9yzz0Ofmj+8994X4PP7+v7z/L3d+GvrztL319EXtLP3383+77/x+vh5wE+3wY/lT8dqK3vL+Zff9G/Z47tlwN9T5R0RZEf9vdA/XugFD+/CN8DjPG9ld7qn29hns/37+c/w8Bfpy93xa7Xyvz87td/58ro7cJ5UownheT5GlP7XEDS3+jS4IfA15hq1E/+/fx5pX2vhAH53Tj9/I/TuqtLzb99019m5edPv8zW/TFGv85Wjt+3pF8G2X5+/+3rLpTfz8ob+j+dObfvT/Gvr8/yGU/nfxn9N/h3t/vumbsY2Rhq+97Uj1t8P/E+piPr1M1xaeYrfwuHqO9P508jqhehsP3ykz8r9BCZiRty2GGEG877vsLiEnM8LjJXMcbFROnFxtz1uN5MZv0JN9bU006NWVxMe+LV+PNawjtt98u9szXOvANvjYGDBcXFv/3j/u0H7lUqkPDtTX34zG+MGuwoHOBe+MrbmJFwv4Na3gD/+PPrf5rXxAwWjbJSpDOw83OIWcIfSJDeRCfeWPj+ycFQ9/cADBGnLlxMSMwAsxZSCRZ8jbGGwEA2Jmhw6THlOJmBUErcXGTMKRlz06JOzUdqeG+NJfKy43XAjJkoyVJlbnoaTFbOhfipuRFDo6SSSylWammll2HJshUzqyZQHDXV7GqpVmtttdfRUsutNGu1tdbb6LEnQLN067W33vsYnHNw5MGnB28YY8aZZp7FTZt1ttnnWITPyqssW3W11dfYcacNfmzbdbfd9zjhEEonn3Ls1NNOP+MSaje5m2+5duttt9/xc9a+0/q3P/9i1sJ31uKbKb2x/pw1Xq31xyGC4KRozpgwWCQw41VTQEBHzZlvIeeomdOc+R7JihK5yKI520EzxgzmE2K54cfcufiZUc3c/9e8uZr/Mm/x/zpzTlP3L2fu7/P2u1nboqH1ZuyThRpUn8i+a3HeefOcrRdLxRismW7yp6Z13dxmjObYe7ez9lx7Zwuz1mE2F5+zG3q5i3u/12YfDFFaM3H7J+Z1akz97HNdOaOa5XxrsHEbNzYAV90F97Zrt2iB0dq5z1sn9xjOPeKyW6zdyMAwyDMXF1ARuwYAuoTS9J4bkvV9yPNUdPsnx3y5NV0G8TGPrbmAZWOqU2WiCa7tXan93NYSBLpHWadVIsoa0TqKzdGT7RvN+tiQ65gMSdz9dq6vcVcjnFn6OmM5xoOsS373ekSwVvOBZasxPGnbmIxO4VN829dOvmcpTe3OyH0nXp0jGrOWKlNZCeLLCId26zo2W2WIuaCSziQ2BlNb52Q4Zm3MQDv1wma2SZAZk51k1+nzJewzucjQt9VIpLW6I4kYQ+P7Ka0RbTeeWW85rWT+uSZvOiflUWddK1d3G6Nf+l6J6dew1OtbIbvGWj0tC/ecbiWK9cJinCKRHaE6Zm+MSqaenGcmReri50jE3FA167eENvZIPe5ZiWGNpA+bf9y5mL6aFY09c5yqM/d3ZnNMB2HUETd3jc+pOW9fRs7ymVTHOXkLjA+ReA0msHbm0OulzTNX19BkF49xaHK7j0M+9y4KhgNSiExf2jMyc5to89Z6zGO1uUckv2oa3ibDPAiAyIF4xdvZjRCIxXOaOKqArY7EMBTFz74clfsHVUsOgyHNNeZqXAn07nNew7vcD/NjdlZuezbjw7q208YokWgKLV+/iZACYHVgdObbgczaGcoIinBhB3hFRFwhHZN2wujkdrfdyz6ewxJ7i9nJgXQ44Mq+KNMwW7tzpNTWZrZJGa4cPAI3uq/kNVDT+F7v2ofp6/DlJVpP3xMsIIXOBSbI9D54nRjgk1zezjfZsOLAA6EgQBW2lbsVjMRnyDeM0zkdI4oQqovgII9FFD2d7duYnZjg1ldSrDH9p3N5jN/O0VoCt+YWPK1RZjlnXcQd+pDwjSQ0WAheeXJO0XauJ6cyo+PdaeAiIRLKKRcrchtTSMYrqDapBHTPjowhiPxizo7n2CeG7UmXCzZPRDivupNmjH2F2U+4pexQy553HSFQTKcxNUArL5/YQY5a+tx1AnfA1bVFMN80i08ukCEcxyduay5GGvQMBwlXSe4JIXGH0ovGvJYR4iljAtUeDgB/UfKwARk1uDVGMZGfcXUUDmkOQwKAnqEMINiMXuQOW7RxmGwuGzOR9wQehx2NCkJ1TEdoxrwXMXr42IBROzppLE3yhZHuNNtCmpAIEHBtlu01DbnWfAECyWKCyiVQbBM8cS6guABik5P43owJKry/7eWNXIS5WyBdyRqiQrC34AZiqHgQ47hcQcTa+QTIASnbCYAWUG/AD/jG8deIqYBEeYNjzPc5IOYloePKh5NAqnM5YcU9VgdxCLGgB0QrkRSFVjL/e34sBxD2FT2QkdwQBOfDdQGzhD8gX8d1W5A8ieixbyZsYJe6JtognxMIH3SJAQZQeD1TUkBItcciuEAtWHqU6kkgVxk8FMeMa4BvscwKNjNLDd1aIX8m73bIEswYDRgpaIoJJ4RYAYi7JuNIDA93FwhC9pJ3PRFx00j2XmUIiFlEweHYDANabGp0giKDcAnKIw0ISH+JAwfFg1WgL/TK1TOo9RIKOixqA6w4Htzlfpnq260NxA1KqYP+pImHqXT6Ye7MDKFM1AGziNdGuXDqSKKM0vyb7YsegssaKV8RXGRQgEov4xAbXimDvKgRRodI5IpIr7QqJnpAjgw9egvGsr3g4N7fqC2gbaKBLvQTBHzET2Dodu/boSqEHBitIlGzUIXoIO5om0LwbEIJBjjIlD46HDAZ7F3a8mAAKgbG0cQ1t0xmst8yieg+MlcNMfOVxFxA/CQ1wDCkGVBwxHXEZeGWZXw0TYswZtBdqAgiSCtKF+Cb+Bm7QkgRxMHICvgfXmjARXyRdBohyRgFghgYhk/FGsXV5lMScwRY09ImOkylAjEEWrnpfURaLZA3UI+uDF11BM4AZI5MYCRQP7mDZFicBA+Z0EX6vAoif/1+Ni60XH/SPchxMLww0gzjBVaIGhS7QzXBHKhIooOYJy8uUKwRvqV3pHbpGPVDZhNNiABuZ5sGM1+T0l19FsRjdx7ihAmBS5QjycMMlJqkOjsDjS7BGhOYFxh8YEP4T65tZuQAWj4xSERw4taSeCm1sZD2fL4DFbAcTASsgV+kN8KdHNAXgEGqn78TMZmx5rXFDZPn6aJUa+eKMnmPCEpDaV7Wsgbro6mhGhvEZESMkdNQ2UQQGULrnAnzIl8MRHbGITs4AaYQCDeFbr7XDNQyq2hEJPCcXnonfRWPiJ1wIBomJLNHg63QkCVFyb5DVF9ItcBd/TC7kPHuoCBXCLMyxjhXQOvOqeG6oyMEB5fdCScYNzimIthueOAFxPiMfFVuCGO3Sckhvv2EeJllJp3I5TQomoa2gBUmUcgRYVpxZ5dshfENHEB9JtKlo14HZEdOe2Qycw33QvsX4QYnhDiAYWAChbiaqM/Bh/NhPBBuMaKIsU6IWdixSlTUzHu5WRAsCyX74A7uLlwSQcSt71VIB8OvgTWI6bgrIYvwY7zjCLljB/2smkUCibkeA7nRfddpwRxvCHJSMSAozF/vhtehClaLSwV6hIsQHOchZvFLj0mYESieeEYioMYXocL0NgNwpkQKktxNAWnUBSrauLZpXGhBTeJVmdb6fBcZg9BkgHCJcBX5Sdy3A31sRipwqS7q2gti6GBGL+KXj5XnKrEeAL1cHIGXll84sX2FTgQql4beXqliWeKNpSIi0AZKSswIaMQQJpI7YWnrihtJNICGhSdHiSEFiB8iBMhDHDG5HtmDpgNdXOQ4ZzHgBERe0sEY5cGwh6RYBM6yPAlkvDiEB284IaMQJmqWDJfe7kCWY8wJf+jKPG5NVdHM/K3pL1m6PW8DvhcyEqKWzo4v5hiJ07FUTCfsiDVA1eIq54BEScfCyXCTZOfiQjx6R2qR5Mt8hZdwQwuHQEJHjDcBhbmPiGtM+cb4Na68gjUAciPrO6IMFQVpCOOZP6YbqUugL3IE8AXtCXW5l5jwdyQdOegdsbAAtJ0OeIarR8ijVxG/gNUEa8m/FK3fgDPCoMBDlpuOjWpGzSAssR2pB4dwHThB+By7ESXRMIWHiAuLgDVUQ0DWolhTVwwyvhj1mzK6t4HfmZTeKkm4zTEiX1CMARkHYIsVZHujGAEVC6RzGkRcRwYjQauIpDCZPQ9ptcZfNKQlbD5kaeBxwAtBkYwhUn7JXhF/DM/WHJHYKDeFP6OAgoA0wBO4buH6T3MVY51ENIQ/mBySl//GroOTk+GW574FmMYeoHSZouwhIbLyHh8JafwIVnC4EFCpGF9GcYCemARSbwKxHh/QMzJ84OuYfD5N/HFEfAn+HIwnAQfz1YMqwk61wSw7UM9t1xRuI2LC5GD8RveJGwYONvQuCOyAEMwIEjey5aLad1aYORIINcWAMhLAB9lIYqmuS+r0UEeTE8ClIPLs+oVbj6Wh17CDqlkySxgdjKlD+GeEOE4H+BgbTYNvQ8S18jArHrIEzdexT4Q/4gAfU4MnXDETZx5j/o0BdFBxhiWwBOQ+SRRqA7iwCQFu5tzHo2sQn0BVaakYA0rUwKVBBSQgDeqSRHAICoOkrtZmCE4MSe1eLIgGwSVzV4G0JwQwy4cohyjiIpkZ92Gb4JZqwPsAbN0LRkG5m5WWnDSLH20sAjviBPh8jjIHZAlys1SkhqF4mYKJFtr4nLScqaAGOOBPAa13wxPYNswxOgR3e0W9p3FR6NBB2hXOiYAPHoG2Okq8quDoGHyuZoru7+XtBTwH4TeqgkkNKKkj83ssgieYfNCsgjPbQ7w+gQYeDuRHR9qFjNklqpl3BmdrGJvB9PjGpiIlQhiK2IgS6Sq4AAO0GGrID1FInOoMDoZuEMHo4lfErmaGjwM4XBxQgt9HjkDPhD1z+miJfzFu83LfYDtTenYhaTFJulmPJPJroxZmHEXgPUkGYJDpTNIGWP4G4mP76vNlmBCQkcy/cG1w9TP1WJQE3asAB0S0WOzZY5TCI0gAskKP72ctnX2+8/IgxkjSRRyRFrkRwKAZsZdFS0LPt6QIE1S5aagrYNU8HFXQUxtyVK0FrLcFB8ICya2Z0COSvV7TDd0n8oFbKHIUepu+5l1I5ouAVEoz9he8AS+CdbE0gsRF9HEMYvqROQBQBo/BIfjM9SAkQFhRFkAWLeVINkHkNWQcKo4AVcdfbg0fZy/K+AAyNWA1DcWL9gSM7+KTF5HU0BdDCt3vwIhuYk6aGQ8ADWB2znLtqJyAumoKeQnH5zKY1iAdrTNyGCSx3I0KoxGVItt8pQBUlNweyxodqA758F96y4OxL61sAZvzw0oR+UyScSqGIMoLWlD5DX4nWuDxpYVDDTY5ZEmJhvVkvIHh7OcinBtpj5dCqsDe67lyAAyWIcxI4pJM9W2igiirRPZuRAH8UNGeCHz8AB9GkXsFCEzGrCaZ2IVhxQpmLwWNCmAeEDyiG5WJpwuqb2/DBhMfCMmqlSit24CiwhULwKa/xO0CaLhWhBh+8mqRCHjuGlFpJqcCBFaQbInJiHfduoAXDXM60IdpRiKNQi5XLpOZQdmHLXdQIb75BcvoRhFaVmBd2oIgXwh+ph14JsUV9HLwOPAlQcGwyLdmftnflAHgQPUIBSsqD8zJBYsqXDHfURXULIGIP4RBTEyBj9+6G5NrwR6gwVvHO3ak7ZrRqfIfGAz4Law1xOQ1SgIVAmuAGxXvcrHCXstmAD2RCW5jG8ZmpLhci6rtOKBfZYXrYS/0UIePIUvIq5ZJekProT5NrJo9TAIfnkNKkkYN2UIwG3C1Brz25Mu6WDagGlI5KajICYJuYuGgVLgr1NwYZAb5xdWBV62YSqaInAOgYyG2KpqRWZ5SbEgHFATqEN+AXIBaAfbl0ZaQoel6EXVzQoQMa8Yeih2w8egj4b50BgNDOsCrgaEfU5VjBh7qUnXpg2SFT/+KbT+/ux+wQz4TjuAOkqfdvRTleORSVXDkPWCcUh5V1iRI7p5a9cWzlIbZbdCRALxKqHFqBofUQYuIhNH2l/xguMiJ4hupIerGPmIgIGG0F8RP9IGQA6bdF8ir03+KUxy0MfsoQTTAwdtogcsv1BIu+VSQStEE2ItJFpB5olK5o/wZaa6NoVKdBoGJ5sVtXW48A9QH4mbyIFvDMIQDvBiYOJgv1MCAczBKun3XF5KCU+FxsWIAF3Aruj8qGGIE0NWoYWBctdtRgmkZCRMIUEoRcnuCjh6davJMVZdgRwCoKCIUIaouAvuORJy9+jrzP/qWsVA2M2bkbzhaRkQU7+4kZ0l9gghy55JLRYPVA8n5CeAjnfeRnsWXYUQIAU7KiTU7yLipogypXs2hnnF5SlS4qCpHoxI6dzJIBa1BWpDvWilCsmI2BUcqzk/ohxiCYGBJf1xleAcsgtQEvbA7NtO85gXwSVeJi4zcTUua+1k5kX4DWwJOJL8HgGGz6jgV9lpWo0OtB92Af8R+xsZfrbg0lMq+3I5qmpwGupMxOwA1upBEg5JgescUcDGjvOKgMGklmORIfqq+uA8aRA0TG1IiCCIqSEtqoLTffUKBA8kOh+KyBU1gZcj1RBhfLouzZW4dPtP6VCgHF5CHaRVjSHQWbojZRm2gGT/VXQdiJpV1xQRkGsN6W+SdKB0usZrG6TIyxP2GrooqVUzfuphfUqqqVIexKq6hXftJUcohYAyQKKAfIG7Y8QEM4C3xQ0cqFNoiAUDRT8lsLVz5HUE5GtzX0QBaVSXlR9giFhJiIItVf9ZCJo4NyuYypvCH7CA80Xnh8mZRsTm9jVl6654h3bU+Z+NYOf5D6W4hakC4ptVlKM3kpqtTQe0w3E1FaDTDUfok7gvywV8X2eRHFNBglsS+h5zAratSiv9WVpvMMf/iSCjzO6do0hP1PvEPElUyOJAuRdVcwoypxMKjmzWq3COXUxTQ6oNxDPCURPJ8vKUtb1W7xmhBZsV6Ujzg+bcqTzBUhfSPrINK5hWNgONhrOVFNP6NwUcHAZZ++DOTabURUJLW817LgZe0k/RqVeOAv8MIwLhkgQoLdzu1FxykLiKRuBDgpZMBmXmIHGZOMM6ccYL5KtNEB0OgdZYGUglcx5IGcCoNk4MZNDOEEuCKAwb6ohQTjuQIvOG5XBfuAq/S4ciR8ejhWifBuE2QpcG0AZmGO7uz1XRVxlHlCpNRjgfdCHC0CJiJaQKAYNHBeAJ0ZDy0gFw7R3rISVOjTSoxX3q5u0PTeBpsX0cjVDUgVfJqFeTUkquQcUGqAez4cRR9A4OAA9dV+1NGSMhsQV7PXC6avGrFsKBYdSLIsm9Vc1aX2cch4T+hGy5MF2/eVTXtYJBhOuCMo4TyhCZaLCu0tOiIQGqkcUgN7a+a9YWvVb/tROaAEB/U4gAz0qnj91V+WUKVV2L/GEr4tQlwN9Aa0asgAFoeLaPWEc6ACK587Lj8QoLb7Ax7fiuPQetn3ELWyh7pjHWrJs9PhDRECmbixcFR35mqP/hqBhvjg/XzDPYNTJuWd7xsJNruLau25zwrsu/kmf3QmWH2rfY/YICc4NaGkpb4D0wWOAb4HpUpFxxKVpKbKFuhw4vvgb6teIjl8Wdo2B1QFY+vVfF2Ka6AWJmqTkKeTGJfVSoaDYDjJH7gFqKhaWF67BuCSvheVZqCu7mQSpe0ceq8wdVtLfggUVtHkcG0WQ5APMT0cN+kCIfUKs0CSywhdPyrW2rVFu+Tu9MCn8q+EMzYzP9GAm9wHBUGIvWAEkmx5ddJVKe8qKp+/I50OFAZYo+4VWtVQDhcSTNY+AuPiIvUfoePoyH/qlabplYrAPjjS1YvyHDbuOWgIgLRNNRquuSF2whqozDAKMoryVzfpuXLyozITat9Ao9CNA8cTnddNQ3V7bUKp9bVq7IcAAcS90By7rSftx1AZFcZBv0s7WbQ3CSEE4wUqnc+bChPJeSP3d8koAwFYCHrimwpuzGFZaVlaiPChSAX5e3fYmeJ9YGmoBY8X4LNrdoTgVsxmYi9LF4ji8SMW92ECHR1WohcwRBUMoGS9OOEVB26ixzEq6h2jiDaDJrpwMnPt963kQvgPdTz1t7C7SSTxnukBDhpAYfwu844r/fvAu44SMM+tJZNJHatOXgV2wK3fME6FIbaXE7G3UFQCGbsRLl1RNFRWmq7bC1sBX73qlqH0HScMMiaEQsju0inqu5kLcQjiqQ6mE7cgNwBms4RVGE2jtBUQ1OKpCQMQIqWkepBGRjTBb+3BVZqOVA1+aw4wAupjNFlN526OrUwntXkY2hS4iDCu+htZgmF42P2KjtmMoZzVGK7btUG0UmZT2fsa9we4we8qJNhp8zokUrxLRclcoGBMPQ+A6UV5KtKwVMVrcxXtVuo9o4Qgy2aAwGC4BGsAYCuB/pQU4HbU8cCzKpWkKr6La6r9MYNvJXHa5xUvRqIp4y4ccCMVlWKyAw5LXv8yqqGPyHUpMyylCUQAKlr3IZMtZY/j5pWhTfYuOZiku1HRMskEvccIatILlaTITjNQsOmthUjrkTynjtZz9Qg+MdmVJAx3NoCDQK2WYZ09ZfjWn/EYanevrRghrpTVQLNmr0MMyoVwseYxLzR4LxpHtyRIbMhRhQ/VJ7mIOPJ3CyRFKESLWM2rSQA3g0iR21icKKGGB6Ot0+t3QBsJkXUfJn7dVyQdC9luZSKeyC60+buIIuKfgxgNe66vDYf+JiIJ9UJzIRgJ64BOZTEyDoa2pZJWkx7/9Tf8BpEnRr8sKv1GPJIGaTOQzyPTQGFN0emqfXMIxwIVsj16b9zIvK9LkRTQQJqLVCVFkYIpIV+MUu7aw3WcpJb2slVJKN6BDaxBExqTEta6mMYLSlKyV5Tlb+pRzLiz7fa2fZWq1L9LDVj47vb31Vr/8d3qdZSr+BWIMEIPs2L5yeAypiK76i4JsUWkxjJ2+LGZlLsglOXEcDRcQmF3NVyhWouxqiLfge2AhdJruRCvBNmA0wnjDAOTOZxJPMyyJODBuVZYFw0ezAgiKi4Urmv+7784J65ZYZCbQNFS5s2QaushUgn52Zz+Cv7S1RDn4++LZShrlaCkKBifrTiSUjiY8KQaylM5CIbAT31nDr1+WFl8g6MeOFGvHJDcgAoQscuTALZpKa45pvKrPBm07JA1CIEMurwjmtOFVTuCIoBMzQlOycxO8RE0jUthiGlVCdB5XTguZ2FfHrlGkhP6+hk8OwOmgHRl9bhSJaFORv5hEC2lo7Z8PLYEZ+4tMLNrUeAeijhtD6FRILvO8l63V0SAwgdTlkIyZKIp4SMvEXOQcVNpmtxq5z9MiQJhuYQhBJqBsJIKHAG3Y2cBVtFXVBk6BCqTC0GbcPXcJLB9UiKBmYXZEOuL203MEUd1/06efAIDrCC4oZK8uezKEfAYQA4Bu9UOdJgOBihC6tg1xm5hHgxvQg2kyCoWrVzTE1m4oEJxAS0ITkGyoPigH+YWo80xvXo5HhemNh7kArGJniAmI76ImQ4ELcZBXjbVB5Aj/cZyOO9VmHOVHmWIiswEjiZxyvBQ+8IQqLfS12Py5y6FuUwJZqS+iYu43m3V2lbcAuZMNcXXanfnPsUZdESOfimZWGwB92c0kXVah2JQXy1Jy3Pxr+n8e3K00wi94KdIZHVYPgMWK7S66U66BM0mkq/QRiANEeNKyORDRuSIpK5lhW0Ko8M4y5P9Rrh0NSeI1lPJPruJlmJnMZgYg+XWgT6BRLxb/Oo9hrVGn4ZjkvOouoDXujFey0EOrnQOOBWSYOhCLx8q2kVKqudxR/VFBH2S40KWsGMOMrNAFsN6oVWqaNMFCV53lEnxBXyWF1GaJwh0CqQjFqFZCcBvinPxX2qaVhCEzY6VQtWzEchANXpVN9CBAE5UIB4QOOdXbWrEQrGjCvvhBdHBSdVmwALIzeeGSV1H/VGxKi1fShH0AdOFXf1GErJAZODoDDP5QijNoZPnZwAZFKTD9ooAB0PC9BCanIFMDMqoW3x2r1aB16AG4hG1ABcKawsDldzP37QcPSqHizihLiZfgLOpR90crwNCYqpAXgfG6otQHLCi/SgzKIyC5KqLNgElCOIpcFRA7OrtMdtIwpmUZvO8eoYRyh7gMa0pQLJMNRWDwgP3Mtcr0cOyEXEgB2McqpqPucal0qKz24Atv5Ml3BTTD3TdOX8IEcMxVEbVW3YZi4cHPRKZXEyg66etkkMx1MDw3BffUcOspZHBUdUE9SmOYdaZxEYzPsJ2JqqUAP70H6FUEQDHmARFX+AFFw9Oq02d996Q9Qgy4yRFQUrseOJoDbTmsFbrb+fmwGueFoXscMreLf56sl4CkId8M8gDqFYulZP8a6o36PugSQ9IDGU1LxRm7r5gQj1PuDNUIcLIYQg2hjFMpyagNDXVV2mS80tW9sn3ko+9n4rREnOpZBfJ1TQlYxRe2bpCRmy1J6dArxmS5uwGGv5yUjCbBHx+FMjm7rVhhqKcQdZxV9V/DvO/PrDnYAeOMrDrWlXgrZJoJHCBSyR88wbaiTE5zkCJIC/0HnUE9UmRDtUfDghkYtaUEgnuGnaqEHscV1bG51KJ+JAvkYIq4sLH4r+ZTQKqKAdgEnhgNSFSws+HAxdoRq8Ji2H7E6fNuEtCH6rc9g7LkkpB2YxAgvdUfLreYAYV7UsE0j2FjUqaDXL88+R/4hERKzaIJlUroBJ8RcUylBRq9yWrIWpISwHFTXVVaiOE6eVJpnMZIOYOUGLxSQxJ1MjD9osM1URzCkAJv4dK6Z1C5hXax6ZI8OJfSx31kJ3LDWoqm01ItJMywQIJC1XGFB+tTSqDRBoSuyk+tORS3BL5uzk3DKC1d2mehkaDajGgOXXxs2sV+3j4fSk4E5V9Q2Tot+EEP4PSSexBdi+7qVtQS47BEAY2FCdXX0B/SBPR1PDK6wGd0FSxAMmQ1v/0BtVq3bolithNbWZQrsOA1KKgzBRUv3cEhl3whiYn/p27TCp6oGvavHz8sh4kqXlYJ8ws4zulbJxGJ5260e+mAfh1eNS0fpJTVQKJnTbeK1uNrQFBUut/gNsqvo0tH9Tqi67puWsObSjdqjhWWY5S2xr0CDLqIbQtF7jCfBKmMyBZexdlUtlOHnlyWnHzGndYGekWU4TaVhbmEVtNX0ykhtS2yp2gF4wbVrtpZY2UkxUHNQZZaYPDhKGEnAndbDhC+CIG1JrXICWJ6LyEvNdGqoP06sVHExx6F4rmlhMKTs8ruNmkDJX7bA5hlTx2k2La21L7mmfyUFyEZYdn0TUq29rDUFKVjERcEibC0P5T7WbEVVF3UlD22aRTVttoEHLk9+NE+tP1Z+dt0+4dFVg8P/POm0npwx9kTM489OEF1ruDFplJLi9dtoQiFALINzULRKqOgdOU09jUoVic9HqQAj44sTIRMGQqUbwzEQaf9SgnkaLWjsp6v89T8RpLwrmkBvQNhCnBh1sO4Th83rxhIRDLKMbrRJ26mFXgHS8IiY/qU0Mvc/vvVbXwUzZBm1huEtr8oeZj2oJ71o/mH6oMwH2vUOtikjRySACc0DxRqzIhamzXn19kj6lOJlCra99duNg9RCZ5JUHE2ZfSAx1iE85+IbCbF711LHW24qCQiWD1UsSPNx/tYNBO2zGJn1TUPPHCa9eYpJmEiPI4IBGIhcvuExcSb9C9FAPvPiamOEQ8MJL2oCyQrmsDVrAJ0cPqAGsOP8P3ULsz2WDDGh3rSxmrReSxIqjVkFhgEMNxVGrJidqbYTPqpChFYgE0lgE+xZIGbWHlKhGkkJrp4qIm/bsuDzVSPkqcaDGBpiYqalFMlTbbgJB03Y39RCDWVprt4NCOOotJqlzW0Xyz6mymNTPruaXOhkuhODk5kD/jq5A2qACuler7Y317ZNO6ssH2FbXEimWlxty8hKJVC7aCMJnSFqCHjV/S9ISptp7eKHmuXVlQixuYkaIZE9VsDckRQ46glz7ZqHIo4L4wDOD8pjXNN8aktbFELBak0raKsm/t1ZISQYhGYqzTkKrO4+R1GZMGM9XKTpsix3QArycr5rdtAqg7U2qR1lfaiJLghTm9WodlcFCRFR5T3l9BvqzWYGIBTtQEtGObXWyqPoHmYwGQqObEAtJIi1WUzuoxxqo99gYIlQLeaPuRG1+gtDVlnIAUJQd+G/aiGOICtQDoyPxhSRDvcM7IwBg6BRnap4s6tvAKh6sN6OBMy9efR1c0bkqziIAdwMJIVBVLbUdZA0V0UZufAX7XGIa0CMw3XwdssWrF0yJuAORjJLURgzj4sgrddujXuN4jQ6wx/AIaCXkcNpsNcSd2vXYsLNIhqsG9qcP+SrfKnjCCULvdtA6GJIzM87ovtb/wMGCy9oiNbtaz4AhFLQHmfBmBHXXTseStb+PicUyeO22Pf2zXolpIw02UUxIheSQFzosygv+9wNJ7J8bQ7pXrRvhsa/2xF0t/iAo6reGry273907nt9mfD+KceMz0C0RGxNJHS3dILzEo7JrRSsSdWm9HQtYtDp4MRYTilGHjvotFvooqxSmzACIEqdWywPoKtyvTa1sXR1Jc9zP+iz6i2yGmov2dqqtQL2+fbiVXpeGsPrdu/Y35vkp0mHM3uah1xFZQGQIVr2eEAywq904B205cOlYUUz2egxT+ytFimYkp7SZRJJGhX+8/2kqJr1VJu3O6ipjaiWbzCODy41ufK+kTgVFazfBeVgQJI/2ucz7ene8qj8VtY3rQkPkhPUjqZKppz+T8NsJn7HEjWnBlJH35LU2gGNk4F0tfCbNuaSZqrJKOy0+aYdvnBAXc4mnVo0ta2+04VBi1xBiVMglGIHbv6JMYrqphHnFMEsbQ49KkmkGZGqpTxZVP4BaVfDVrpSntnDioolOprkmqbyhYBEtbVRE8QvOWumtoKnt9KBhNiJm+u2YpbjExgZ7oZQQw/OCh3ESyMjMVbRtXeybr5pATDuHMH9kMrmjTY8a8dScvF08rxe1zrcJemlVlijMqma+NllM+UZ44seJVT1ABJ2Gl0PQaDsv/MYYOGweuhQZZ0ktD5yIgxC94BcCFaPCbcGOoDVIyzyQbsAR7kobe8vbLzNUpHACxYH3VcuNTgkSwOdNKmZwK0ndavicOVXuykftQ8cOOPhj5cg+Pznl3I/c+4fvCGs+zrWU147HoKsBP8Kf2qqK+9NOUwePIXgRmVNrztphAN5V1OQMWt6DsdSOTFrcZ7Ur4wHaL7g0kDtqBuxav/QOvnmLOGqeQt8xN4uJgDQIkhdw6kZXSQKatGBq1wZU1cfB3O6iisLaMSOPu6RmVKX/9SpeRrRqcU5WAGlRvTajkJ1yDHr8AGgxhiRpE4WhiAlsE2Uj8HpmYD8idb16+ARIhgogaiD1GlFtJ1b9R506W3vlA65FnRdqccASgpDYBVyDNbXZqoiCM9nEHc4qqLCVuGStDhIW5rWlQEtte2rtjt9q0TLrASKYY8z4VhHzZm0vwPVgeA+6EHGmtskgTVO0lxDRy8xz61C4WITxxH4q+iWTQcijXVR6UoE2sr1WECACVCHq1H+WtAErAgLnKoy10q2yjzpfSjNt+lBDZXcE/iBwM1AOLl+4QqEtU1bVofK2U/qw4VQYCBedL3euvgn0Ge5hNnUSMBAO4+u1o5lsQ9Fi/TbsMxg/IZGe1uIxXOq856KRM0H1lwJUCy0lNtVAskgv57XoKf1ial/nixfzaWXLayurSqylfLaI7+ixbj19kgPu+9nVjKHEHU054qRGOq2xaRN/ClW7Z+2zRD/VtpnM7tLKnx6QoKanolVkaIALDMy3IY9HtVEAGDX2mdYUoBkVQVS5exvtcJ+ocEMbwo/ktt6slgUp5/pKeWAQkS0M3wzQxKMdEkBN2VK9oWDb9MAE7eTCVyLcR1PHHlFP0h1t6DtFuy30GBunSv0JF73f1JdqjCzquqhcCZiQiSMGBJUIK09DQavlep3XdctfwrJpAXBijs8hV0EVdLCqcWZxv0Ek4P6plelv32dWkeUOZeLbHrHVlle5ONLwVm5a0K3FoK72d/X7R+hAy0SSIW+HnuZlleWS5jzhhqCNFtQzkmTq7vkuQixVwLAJCDG1Uw3t3C4tqdMx5hhxpXHDa6iRYby1QjTcdtVuNrU2KSdHeJ0V4ATmcmjnf0Pp7Y2+VstHv8JBLbO+nZYuj8cUuWoTeFELL+JjVqyZ8AVNK65bajdvWtiUt0fywEUgulf7EaHO+AfX8GBqh9MWKlMlBaxKAeXT29T6X9O2saV9z5Ax4oQps6SqJJqHyIIzj4pV3THfqDvtjmLatTOILMjLE53ohG7alaRilrREHMwsYqLo/qKKaYAogUTmluwQGep3TlNrPdojHfU0Hj0TwpNMQ2s4CFu8G0AIFUS4QgXki5ZkSslstARQqYLmBvv0iJaUrlZ4i57Wwyc7imQX1QPygBP1gCVuhEwbTWu/XYsP2n8a0O6AjUNvBq2h83Etr/amyp6KEBdyZoTVNITHJY200VwbyoDzKHuQVNZQHBER5NruZcAvDdQpdvt9LcfqQ9K+PjPtvmdkJJXTa+fhJfCzgO+R6yTttGoq31+UbNqzeFULfsBxVLcCL6sKUtpgpqca5YtnklaKWSx0ifs5tPmASJIORI0As0HLEh5DzFhod7LqLCe+PYu3kZioPrXNgSJx/UO+4fvV6Cgph/JUI2CTJxXiQOldYxYDtkg3HU2PguOitLwwyACtqoN1i+xermoNHjuD7tXDQZZaM5WLCYkLMCCIpvrP1FimSZjaOLTVNxSZGmIelQlDHXN6TIS9Zj/BEmnAVCHgVVtSvwOsy2SpS75rOfsA8QCD9sCtT+s/vB+R0+Y8X1XEiiejKxBEHFJ9SHMmdG3Xtvuaix7ogykkFDh95bxYnypQ2HqwykbEOFmoOGF24lVNF4zMK2WbHgx39PC5rRw4460dt6qte1yQmoFgvarFDtWCllO39tazNZC8W0/u4C6XFgoJV+2dO1q/AqgGpzNJtduhxeL13CPUUVHtibG5Tlst4Z1WZdgQEH2qpCpVL7tctDNxQrwM5Ykq51l7fRmKd9EFSgWZyzy498gIQrboQSd6Nh7GWCGkJ59ps3CN6WNx8PgW1LyK5Gva80L2NDRWSAia0V3RY5KE00yWdq8OJAnvKMfrKRXgOBDtQRc9aQkIEaSjgQVYECcXKFVKKDTHC14P7UEsSadN+SM9h0UdSpCzKkdo9oPvS+hkdcB2tcCv1oJWXwzOupB8cnr8SdDjV7yqeEO9jLhfj5Kwof0Z0DHwjJ4mZveQvDbsJeeTHRNSkN/qlnX9dRoCXBsM75ATiHG1dKwNaCnqsU8Jh7u0WR73WUS0CdXLBM9nBvNrM8CuE7dEIHMHRL+mTQWfOLxo/UZlXOQtPiUenYVfwBlcOrSgpfWf/cNuBDhRTIcK07ekGvRWLZHwQbe8h6+kx3fcgNIJ/tBSKgOstX89FavYFGarN09V1a/7RvD9d4aWAhLaFnWbdqTaceQp5LxU2akiRzWNAFtRvWrcBhFvaphDcmNFZtbKxS1BVUDUif9sdtImckcwhLc6FLRJTT5RSzcnRURKz58cwFFt7V+LarLlRvBl4ar8jXfiYzoOxg9Zz1UYt6wHciT/dmqCydoapCb2AXOebWKUfXCdU4WHo854lfy1dAAmeXOq5CVt6oAkiaKlBmSTkbwBeW8JgQY2a3NdiWXIZKjxXh3pmJNsRByRVZ8awUKrsR0q9hpDxqh2PSOwaFPgUAHN9GQTbAMwgexFl4DynRRILxnUpNOrS9I3es5Y08MQEJza9iNg21KWUcv9B3+nR8+g5rWw1Loa7FCl2oZwtOIpRHK1te3BwADOvN7790QzZPf6lGUU9EhbjMUhmfZFblQ9aUfz9XznkZy4y5Hfe6u22qpWK7SgSLAO4eSBtg6XpGcSVNN2W5JsPVDJ/buLECD9/Oh+u9Pmv30vRz3N0jV6ClaWuXBWqwpeXg8F0hNLEKPab7nlC/T0Fm1bxb6hVdqVotRjGZdmREUIe3BxtIfUzaH+2teo9BSKtY+C89xsUBODVgpMz+F7VuNmrT8m7adC9ZLMTDBjMibKX3P/VgL0BLZ7IbtXvSGrwc0lL0sOry1ExDd17bS7QAI2Z7asDU0wWsNmDT0aBby/qqpJrqnK2tRserX/Ymv9VAIUa9jQ73hn2IQpeVWKAZYjEdGv7gXBHWpe1Ha1SGpcGZsetbfFQ6OY7QquIuzs7dlf6iBJ2uENjqlvUgs3lQOp+ZVf7cXrM3xNFMHifVH5nFzM0lfxbUSab9cwA+MnXDq7TG2SEHcqYSKxySnos0gQBzXwkz1B/VTazI3ZhYn1MBVCFmOssp26x/TIMi7TsM56KAfKQJvV8VRHXTCTDDcIFq2n5wFEPTUPykTB1tdLhEfRpl4vc6jiUn8+yA/HeKg9U8+3mno2xvyxiP3fSibExtYzWP8XPvlxLUWfs/oAAAGFaUNDUElDQyBwcm9maWxlAAB4nH2RPUjDUBSFT1OlohUHi0hxyFCdLIiKOEoVi2ChtBVadTB56R80aUhSXBwF14KDP4tVBxdnXR1cBUHwB8TRyUnRRUq8Lym0iPHC432cd8/hvfsAoVFhqtk1AaiaZaTiMTGbWxUDr/AhjCH0wS8xU0+kFzPwrK976qa6i/Is774/q1/JmwzwicRzTDcs4g3imU1L57xPHGIlSSE+Jx436ILEj1yXXX7jXHRY4JkhI5OaJw4Ri8UOljuYlQyVeJo4oqga5QtZlxXOW5zVSo217slfGMxrK2mu0xpBHEtIIAkRMmooowILUdo1Ukyk6Dzm4Q87/iS5ZHKVwcixgCpUSI4f/A9+z9YsTE26ScEY0P1i2x+jQGAXaNZt+/vYtpsngP8ZuNLa/moDmP0kvd7WIkfAwDZwcd3W5D3gcgcYftIlQ3IkPy2hUADez+ibcsDgLdC75s6tdY7TByBDs1q+AQ4OgbEiZa97vLunc27/9rTm9wMtE3KLJ+uWiAAADRhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+Cjx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDQuNC4wLUV4aXYyIj4KIDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+CiAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgIHhtbG5zOkdJTVA9Imh0dHA6Ly93d3cuZ2ltcC5vcmcveG1wLyIKICAgIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIgogICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIgogICB4bXBNTTpEb2N1bWVudElEPSJnaW1wOmRvY2lkOmdpbXA6MWE1MjgxNjgtOTBkZi00MWJkLTkzYTAtZmJlYTY2OGI4NGQ1IgogICB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjQ5MjcwMDI1LWE0MDItNDY2Zi04ZTc3LWIxMjE5MzhjMTg1ZiIKICAgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOmJjNmYyOGRlLWYxOTQtNDBhMS04YjlkLTRhOTBjMTMwMTc5NCIKICAgZGM6Rm9ybWF0PSJpbWFnZS9wbmciCiAgIEdJTVA6QVBJPSIyLjAiCiAgIEdJTVA6UGxhdGZvcm09IldpbmRvd3MiCiAgIEdJTVA6VGltZVN0YW1wPSIxNjQzMzAwNDg4OTM2NjQ4IgogICBHSU1QOlZlcnNpb249IjIuMTAuMjgiCiAgIHRpZmY6T3JpZW50YXRpb249IjEiCiAgIHhtcDpDcmVhdG9yVG9vbD0iR0lNUCAyLjEwIj4KICAgPHhtcE1NOkhpc3Rvcnk+CiAgICA8cmRmOlNlcT4KICAgICA8cmRmOmxpCiAgICAgIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiCiAgICAgIHN0RXZ0OmNoYW5nZWQ9Ii8iCiAgICAgIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6OWIzMWFhMDMtMTM5ZC00MTYwLWI2MzUtNDE5NTc2MjIxODFjIgogICAgICBzdEV2dDpzb2Z0d2FyZUFnZW50PSJHaW1wIDIuMTAgKFdpbmRvd3MpIgogICAgICBzdEV2dDp3aGVuPSIyMDIyLTAxLTI3VDEwOjIxOjI4Ii8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PktH6HwAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAHdElNRQfmARsQFRyJI7I6AAAgAElEQVR42uWdd5jc1XnvP+/5/X5Td7YXrVZdFEmooKWDkAFjmoGAjU1wHIhbEttxbuxgO3aSm+RJ4hIXntjmxiW+TlwwDjYIbAMuCNORgRVoJVRAXbvaPrvT51fOuX/MaLWStkq7srh+n2ce6dmZOXPO+Z63v+f9CWUym29SQFyWr0szg9RWs8JuTbb7k/hcGHgzMAt4HXCAOPBEa7J96KjPRoEWoAroBJIIBkN9a7K9g5NAZvNNNYgMylkPmBMZR0YMuAxYA+pbsvx+M90T3jjvHDHFANzgBiCHLY+19m4y5Q2tAi4tz+iXrQPtblvtSoUxy4F/BN4E7AciwGbgztZk+56jQFkMfBNoKAO4G1gJfKk12f7ozIJxswLzD8A3Zfm6jhMGxOx6u0Mu+DoQBfkjWf7ACQPS1rBK4etq4DzgLKACSJQ3aS3wdeAHwOXAXwFJ4N+A+wAXWFX+3mLgg0DjiOFfBj4EtAPhMvco4C7gnUdN5XXgT4B95TEiwACwuzXZXphGQDYAP+Wsqn8W+e/j3j8bILM9d0vF3PAfA8+WQZoODjFAofzvx8uiZyT9JfAuoL68mQfKQM0Fnil/57oxxj67DNymspiqADTQNMpnTwO+V55LLZArH4TvA9uniUcUsBDDR/u+1/FL4PnjBuTlhavqdn6084Mtn653aldWLFE2dvmETp0r6lcKgWmWsHVwddfLpq1mRQjoAraNAog66tSfX36Z8ubKBD/XUn5NhhaOOCT3AU8C/WVRp4DG1mR71wkgMjtwdXX300NWz13JO1858+x3r9r+8nFxn9JFvVL36BUdX+ojtTNfj2HZCUxMAX9pisH5bTUr7gTuB34GXDBFMWqVx5pukrJI+zFwX1vNimuAc4Bb25pXywnIgkv7N2ak56tJTMpcoLP6jOPmEDGsNT7V9gILJ2EphLeVZfTEHFG7IoJhHlANhAhMBDgDeLq8oWNuqoiU12KmR0BOjSqBy4BLgF7gJxT8y9tqVrhAEehHZH/rwCZvEtaVDVwdrrOV1aLwe4NmfLO6LE6nfqJNjqsi14RY8OEm4s1hAa43W26aPcnva+Ci8ol7qMwR15d106hg2CGbcDyMHbYRSyEIv0NygNnAnwHrymu4B1iCMXqSY5wOXFK5KMa8jzVhr7ItXHPxK4tWHdfCVPzt4WULPtREfHYYBLRnVvT+NvXBjfNXxif6cutAuwv8ChgEaspWlHMMN1gKJ+oQq4rhhB38oo9X8NB+gDGGU4BC5bnXlI2LZ1uT7cFEX3p5ycragc2ZO01gFomCqkVRFv7NLCLXhpdIjT4+QFpusuxoXajEftpw8IlBu/Mr/R83efO1VxasmjuJMfrGs1ZCsRDxRAzHcSjmXfKZAoEfcIqSAV5pTbYPTgjGgpXLdJ/5zoGv9v1JX9thXzre4jD3FstqeV/2+HRIKJzdZgL/XHFskq9m6f1SEpMxYeAOnTbXbmxe+Z+IWS8N1r75n4wPxioPFoyf8wA/clNXgMKgOVBezPCpUJYiEo9g2RZu0aWYK/4udMXx0LaXWGmdw6agsG6WBcZW4ZrQUGdd5MC/ZmopmIUY3qrT5g40FcGWQDq+0Ef0rjAVc8IQ+DjRzA57tndcq7V1MfWAzqbOtapqSSyMUv2eBMm7U6ARo00TBf4W4X9Fl3i9jtPXY4JCT1lEZQb/77zsns+bBt0tV4xUBpZjEYlHEKUo5Ap4Be+Ejqwpqf5hM0nNnN4RNH8VWhOszny4JQ1BHCSh3UxNJEpT6EyrobhBNWCIDn+hWqh/XzXRBgcMBKmka4pD6yM3dRwfIGj3Ib9v5/vBLLDjVdLy1howmsH/ymDSJekafZNfMfv6dIXt+AvLO2OKQw4HH65A9wkjwVC2IhKPokTIZ/P4RX9Kmx9gCIzBL3r4nodWgjRWQNgufSjvYXozWAi2Y2OHHCwRps08UJzpbVdndP4iweyr0tixQDA+TmyQ2W8L0UmC4m8V+KBmCXXvr6L5siqUCvD7ewgG923G6CeO+0SU2JLbEPVNcRJRCcUIitDzVI6B74eIv9mn+ao0TvzwxnoZmwPrKsn/2jrGfYtVxrAci0J28pyhgSIBvtYExQBZ0UL8LWuJnbGYUH09ViSKWFaJV4IAP5fD7e4hu3UHuZ8+Bh1DWI6FoyxCqOlxYCxI3Ogx+9oUlnPY4ComHToeSuBuUTTc4VN/bgyxNKaYxXiZXjC3Ifb6yB8cMMfHokBh3WwF+u3A54EFgGhfyHeHiDR6R0wIwM9ZdPy8ktxzNiZ5pAKPRCMU88WSzpgEEK7r4Z5ej7N6GfFVK6g5/xwSixdjhUIgClGjn3ujNRiDXyiQ2radgQ0vkN+0Gb9tK+H9aZyQfULAqCZIXObRfOUQyjbHrL84ZBNrchFlAAJgK/CRyE1dv5mWaG9h3SwFLAfeU35VHYpqaVeR2hMhsaCAFdLDXLL/3koKz1ilgZQiVhnDGEM+ncPo8Q9IkYCCFxD/0NtpuP5aEgvm41RVoZSasiksImjfp5gcJL1zJ933PYB7z6+JOjbOccLiXOOx8A9S2JHSev28RbYzTOXCfAmEwxG/7nKg9HuRm7p2Tkco4QgqrGuxIFgIfBi4zM9b8zsfqazI/sZ26t5doOHcNKIgtSdK53/E0T2lIZywQyQeIZfOEXhjm7XaGApRhVx7EbP+8B3Un9taEkcyTYraGALXpfvJp+n70U+QX7YREWtK+sXHUFjssfRPcyQaPbSv6PpNgsH7Q1S9zXWb35QeUo7eAzxcAkN6Ijcd1NMx/XHnWVg3q2loV/S0zrvjK02vLIteGaycf9vgEqBhz/eqpbDeGnYDo4koWhuK2bFjagGGQlOcmk98kKbL30S4rm4GPQpDrqubgw8/TOZL3yGW1ZMCxQAZ8fF9Q90tPktuyGgvZx3c8x/VW70tapM1x2yZ86F0e7y5uDNyU9fATATbJqSXT18lpteo2g8UnMYL0/bOb9b+b/dFdSeH1igQr4qTzxTQYzh9gTEUz1tI40f+jKY1FyO2fVKciqBYpPPRX5L82reJbO1BWeMvOU9AQfQh/90k1ugPn/2eof/ec09tkHvM8aXe0qs2b5wxj2rKcqItuqKBED9Hcd5IUzccCZPP5Mc4dYbipcto+dRHqVm2bPrE02SZxQ/oe/FFuv/5i0Q2d47JGUU0eQmOtjwelhy3XuFuy5yMuU5d40VYheKI8LKyFG5x9BSKCQxu6wJmf/wvjw8Mo0H7oL3yywdjpnSWxLaoP/886j/+FxQX1MBRBocBXDQFCUbboVZTwWkn6/BMSW60Na0SXP12Slm6w4coMGOLqjMbafr0x6hdtXJKjCuFJDK0C8keRNxBRJfMaKOimHANpqIFXbUQQgkmE5MRpWi6dA3m0x5Dn/48dl9uGIw8GleCsUZpAq6abEripIqstpoVs4Ad5cjoxH6GQPhf/4K577wF5TiT+IKPZLuxDjyG6r8fkSHEBrFDiO2UhJ/vYTwXE1gYatFN7yJovgQTrQNlTWxB5XLs++a3Ce66twyGjysTArpdoPWKgW25U4pDgNspFQlMTIUA/ugymm9466TAkMIg1p6HUf0PYkW7UQ11iNNcVv4j0/wCRmOCAOMW0INfRvU+RND4NoJ5V4AzftbAjsWYdest7Hr8Wdy2nQQTY2iA00yJS9bNNCDWFLgjRinLth0OK/QxV7Gghsa/v5P4vLkTmqeS6cDe/C/YhZ/hNCawErWIE0KUGssTRJRCnBAqVo1ystD7C1SyH1N1FjjRcZnfqUigZzcy+Oh6CCZ0H4zA14DK90ebnvpOvndGY9ZqCsLNBb7IJPPjoWvWEl+0YOJhU3tLYIS24syai4ScclBlkn6WCCoaw5k1D9v/BfaWLyPZ3gkFdc3KFUSuuXiye1Qn8JVAzXz+YNKAtA60+2UFN7F2thWxNRfhxMcXH5JPYr/6WezoHuza2RBeAtV/CE2fhJo7ILSMQAuFoiad9cnkfIquJhglLCO2jd04H5tnsbd/C7zxxX2oqorKNReBksnIrGsA9/K+V/VMAzJVHXL1hGJOGzizmepzWyfw2FysnfdhqS3Y1Qsgei60vBciI6qF3MvY8vQPeeAn/85gCpSC+hqHJQsTnHNWFXNnxY60okVQ1fWogz/E3rsMf9GNYyp6sSzqLjyfnogDuQmrnuqAC4H1pwwg5fql8ye0zFIe8Xdcj1NRMT5rDu1DDf4cu6kFlAN11x0JBkColqrF1/PbPQ/z/IYNpe8JREM9LF8U5m/et5ALz64l5KiRjg8SrUR1P4jMuhBT0Tym7oq3tBC7/k3kvvsoRKyJuOTykwHIVBzDynJofnyqdoitWD6hA6i6nsCKpZFwGERBbP7ow1VX09LSghyytQzkioZntxS44++38chT3Xj+YRFm3BzihEFvRPW1T+ibVF++FpPLT8Y9WPp47ZLQqQRIFZOoFFTLWnDqasdfnZtC9f0AFa8djk/gJkePLeXzDA0NjaamSOcNX71nP7sOlAoKtFvA+CUHUoWjqIP3lzz7cSg6twU1p2Yy65+jS4fylAGk8WgPfdTNrq/BjsXGtYpkcDeicsgh/8QEMLAegiMjxUEQ8MQTT7ChLK5Go/UbC/z8iW6M1phiZoSOCCHFDUhufIvLiVegFsyazPqbJrP+k6nUZ1Eqah4fkHgUCY3P2SrbgVgWMlLhZh6lb3ORdOV1VFRUkMvleOihh7j77rtJp9PDlY5HU02F8N8PdvP+GxqISeFI4EWQXA8mMbsc/xplLqEQqiLOJAqTEmVQdp5KgKTgcMXF6NZLqSJxfAurMIr1E7Bn273c/NF/ZOny1ezdu5cdO3ZQV1c3JhiHhHs6p0n29ROvt4+MR4lBvPGDtGJZ4Ey4DbnyTzWeEiJr4+zVAswHvgMTHCajJ471iV363NHyPBJCBF5qa6O/v5+6SSawLAUhe5zfGtdM16XXBIEgSlcaGk4JQIw3XBa5dyKz1xRcjDd+tYmJ1GICfWTu3MCcWTFaGmwmk1I3xqC1pugb1ix3qElYR54DYzBGSkFHM14808cUJizIqAJ+I6XLQaeMUt9TPiHjAzKUJigUxjXodWJ+KRTsH2kBVcZtPvKuOZM4sHD22Wfzzne+k7UXn8+7r67CPioTaEwAUl/2Q8ZGJMjn0b1JJuZpqQK61886a0aza5PSIa29r+i2mhVbgE9MBIje20WQTo/rYpmKZnTkEoL0iyjqECdcChYKXHlRA7e+ZYD7HhsaNaphjKGhoYG77rqLhQsXMtC9l+oDn6N0J2jE59w0uu5PME5s3LW5AwPozZ1QPW4QW9nIH4eNev+FXVt+98HFttqVNnAHpdL78UXJjn6K+/ZN8Ks2uuVt6HQSnekjSHURpPsxhSwNlcLHb5/LDReEiIePSe6hteb0089gyZIlJBIJ5s1bQLxq/jF6wfiN6FmXjn9+jCGzZTNmUmkhOS+EWnpqiCxjrqdUqzUxRR1yj63HBOPrfl27BB29Cl3Igg4wXo4gN0CQ6mJhdYbP/XkjX/jzGq49J0R/vxl+DaYt5oQ207/tV5ih3Zju5yHffsQm63wak3gLunLe+MZeLkvqZ48ilRM74AZTCbxn46zVMyqyJhy8rWZFLfATSrmQyQ1aE2bO/d8kvPh0xtPQ1sEXsF77JCpWROxjNyXQUChqegd9+gZ9RISmWou6KptIOI5YNaCHwGRHiKoCutiEt/xLmJrF46586PnneO32j2GKE3shIRRxYxWBC1qT7a/8LjnkAuDcqQxqBoukn3lmQmsrmHUOeu4n0Tk16mctBfGoYmFziPOWxTh3aZQ5jSGiYYWQh6DzKDCK6GINwWmfGh8MwOQLDDz33KTAGGGPhIH3lQOtJx+QtvqVVllUVUwJEAOpJ5/B65soUaTw512Obv4oOh/GuMVROcqUxxyT2YzBFPPoYj3BvDsJmiY+P4WDB8g89dxUwDhEl8ykgzg+0oFZDtw4lQE1kBWf5FMbST+1fmKnywrhL76R4LTPoP2l6GwPxnMnd7nHmBJXZDoJ5BL8JZ8hmH/5hMUOxnUZfPinFDe8PpVjdug/i4Azflci63am4AwFGDLi42HQOaH3e9+lsOUVJtxdZRM0n4fX+kWCuk+ii3MJMj6mUIDABx0c9qh1AIGHKeQJMgbtn07Q/Hm8s/8J3XDWxGrRaHLPP0nvveswlnM8e1YNXLxx3jkzotztcZR5DaWE1KTIx5CTgOHqJgXp9iR9991Dc3MLVn3jhOLLRGrwl9yOylyFDO1Ep15DsjsRb1dJeQOoOkx4Eab6NHTlaZjqxZhYPZOtaPIO7KP7vh9R3J+fUhHUUbe2bjVZ7wsThpGm2TFsZjIJqTJnZMU/tizBQP+jTxNtbKD2vR9GYvGJBxNBJ5qhYhbMvhACrxSeN+UrAAgoG6xye5MpVEIGyQEGvv1Vhp5sn/JGhcwRwmQ52pwNvHQyAVlA6ZrwBDrDkJVgzBoRtyeg+ycPYFdVkrj5j1AVicnNTKQUGFTTU5QdDPQx+INv0fOrZ/EH9ZSrmq0jr8xZwB/MBCDj6ZA5lPpTHT7wCrIVNoEtw2ouJ5pgAh2R3RvQde+PSN3zLXR6iJN6HdcY/N5uhv7zLrrXPUKhM+B4LiPqowL7wLltNSsqpnu6o5ojbc2rBV+/A1gz8u+ZqhD/Z1E1C7WmMuNTkIDemhBYgu2Oc+oMuEmfoGc71mA3VlMLVk3dzGOhNe7WdlLfu5ue9U+T3eUe91lQAqNckvvJNwo9gzMvsgJziEMOHwkD2bCiAIgxeBiKYnipKUGfpVgzkGX2wbGTQcY3DO3w8P311HfuJn71O4hccgUqGpv+6wlGE6TT5B/7ObnHH6TnlQPk9/snxJijaO9GSl2G9sw8IEZL2bw70kKxbRQG0YaClNpiXL6jj966GBsaKqhOF4llxvbOTQCZ14oEhdepOfhlKrZtInzJlYROX4qqqmZScffxYiFS0hXu9s0Un3qU1IvPkNzj4XYdn5g6KpbFUZcgKoElwOMnS6kf854VBBiEQAl++biJNjT0ZWmqjpCOOVQYH7EFzwXl6iOOVlBeWG6/T7E/oCr1C6q2v4jdvJDwBVcQbr0QVVFZKrAWmZhzyu678TyCoSTFDU/gbnwa7+BeBnYOkN3noQuG6bjALsfegxfg0rbGs7/e2vOymVlARAyltgGH1y5QWfBxBTriDmeKDMcyxEAk0LTXxpH5ESIhYfuAy4VWEdUd4PUE9IhPuxTxMDRjsyoXIflKgezBLhJz+olufYHww7Owl1+CPe80rIZZqMpqJBorFU0cKrwONMYronNZ9FCSoKeLYPd2/M1PUBhMkx2CzD4XP6lnpuPWkXQZXhCi1NJpQkqlUnFKpVSFysrKfVMBBKDn6D/HUx5XZ1werYwQzK9iyf4hVGBIV4d5JR5mv6V42XdQPhwcGqLXSvOWlkoGMy4/LWR4i4lTg6I4wnns63PZkywwJxYiXNtJZeeDRKoiWOFIKXEViSNOtBRphPI1hDwUsmiviC7kyQ8WSXW6uIMBOm9K8ZtpBmMMJmuk1BeybRwQhFIK+F3An1MqSw2Sg0Mv9gwUPrujI7PVGLI3rl1sxg2/t9Ws+GtK1e5HBuViFk/MTfBU1OFKO2B+peFXvcI2sYZDSMYYduzYQTKfxw9gpW3xPlPBGUdFYTRwv6RIonm/qUbKzf2sSsGptXFiCjskKFvKDQRMKYoSGIKixstq3P6AIGMQC2ay9VYERdRYowW4/qo12f6VcQC5CPgMo6Qv0jk/v3Xv0K+zRf1DgftuXLvYH0+H7Ac8jup/FckFXLYnhbWwgt7bzsRakGB22oUdSbpeGyKf8kkNZCgWi0RFwIZ+DHOObaPFTnH5DS4fMYlhJxwLgqwhyHoUGOGMy2G1gT7SlZGTcKF3jE4qAqzcWLtSVg9sMqNwxmXAPQaafD8g5wZYlhALOSiBRMyOttRHr3+tI3sFcOZDT+78l/EY+wClOqxjwwjFgLPm2bTMq8BEbCobYixd08Kad51J6/XziNQJa25ZzuLWZtxMQDLpckB7w0sSIINmPTlasZmHM2742ARg/NKrbBmcSjTbGDNa4n4V8K1A61ndybQcGMpRUBZeKMxBz9Dnltzp6oqQhG0VB/4UWDXe2eqg1N/2GA/OtyC7ohE/5hxh8NghCytk0bSwmnOvPgPfC8jdXuDAa90MbDxIYWuO9IDLXnF5jgJ70XzEVBI9Cdp3hnQI5f2JAdmjlPe/a2MWH+hLgROiprYCI8KedIGDeZeYJVxQHcVxFCFHUfR1M3DleID0A7sYpbBBytJTtMEcVRrStWuQ+rmV2I6F7VhEYiHqZlURXLCIr9//Eg+t28IabM7C5jri43PH8TsNnMRWjlUjUxSpVMoCPqGNWdvZn8JFaKiuIEB4bShHd6EkKfIBFAJNwlI49vBkrxnzaLYm2zPAC6MJCDsQmh7eTeLgkRLNdwP2t/dRWRs7yl0wiNFci+JHpo6Pm2puMgkWmMN5dGmpgfg0VPs7FtbSllJ5/PRwRnoCIRnlyJzR6cC7M3mXVMGnvr4aEcWedJ7ewmGxHWDwjEEpqK0Mk4jaWEqWTjTrexmjqXJ8U4F5/7OFyq70sKXcuzeFxidaceTGul6B5GAHs5JD1GNRgSKEUJSAgglQCxuZ97n/TeSK8094A+3VpzH/8/9E9OYrYArN08bhtceAlBkbk0MNNEmn0wLcoI1Z0D2Yoaa2EmVZHMwV6ci7o49gIBKymFUXZXZ9tFpNEFHbBvxi1LdCQtXzaeZ+fxOVXSkCX9O7L02oUghFS4Boo0nlk3QM7qKQ7UcP+aTQ9BHgYggbCz8ISJ45H3vhfKqvuwoTso5fZ4dtat95MzXLltJw0w34xuCJOVFAfgb0jBPUCVGuOTDGRIAPDmbyyjdCJBKm6Gs68sVRo7qWSKmNtzGIQCRkZcc1GFv7NwVtNSv+C3gLo1S9WwjVz6QRaSf7juX0d2SI1Fho8RnKpUkXkmTdFAJk8x53DyRZL6XbStfjcJ2JcZodRj/0HBt+eQPOjVdQCGvwXWyEkFE4CLYRLGRU1a/L7B9ojXXWYuyF89n31NOkXngRqY5gF04oqWcEeQLMzWbsIkGnrNQB3qqNWTCYKRCLR7AsRU+uSM4/Fk5bhLAStDYjiwF3T2jBF6PWBsfV21Vgzh41fh9SVP02Q0K20591qZ+tOTi0i8B4Jd1xiKMGXC7da/EearGAxyTHNyXNdXi8KRSnXgv6/ieJKQjExhNNVgUU0bjl9JeFDCeKzPBuCBGjiIjC2rGPjk/8I9I3BMkcljphPdJlFLtFy3MGc50ZPbrmAPFUKqWAa/xAS8HzaWqIYYCO3OiiKmYpQkrwPY0+jMgLEwLydyuaGm/uz1RftDuNjIDyUFLK8gVxoXAgT4ocC5qq8PWRasfxDVe9VKTSj2HKv3iLSbCQAp3i4WKwEZQqcYFjSpucGGEs6XI87dAMlDkcHRmeVcaDTHf5A9Oi1NsDCx3WPKDhHwzGGcVBPMQhlcBizw+wbBvHscl4AdkxesDU2ApHCTlPH95S4flxZ33bbbeJZcxVj1SGW4px++dHiysN9J4D226L8ZvqKG7IpaLm2KLlM3flSbzkDoNRErzCBUS5wSTG9UPMCCtWGbDKLxnx3gzSi7btgFI7DLSNkRm1KLUbiQONvtY4Yad0kcj1R/2GJTA3ZqMDQ94dBqwX2DQuIENDQ2KMudK1rA12MbiT0tNtRhwNIdZj2O1E2G80DctCxzQIC4Y8os8OIaPYaqoMzO+0+/v4Oaltl3dsMmv7tvgGs06Pb/qGgDgGLFUyTPJjtO1YFHWosC2yhWBk8d+rGHaNC4jWWsrRzA2bF9fuAN5P6Xkgh2NbnVD/QgFdcKmbFxmWMWKgOu0z8Egn32vvZ794vMFoiNJTeQ7RdoMpjOkcGqMAUUqGFY0epdSy2lbMjzl4XkAy7R7KyWlj+MHSRY1D4wIiItqyrK/Ytv3Ae599XLcm2zcAN1N6HMWw/3Fad5br81nmRhwSeU3jkM/yHVkuuXeAW59TNGjFOjKk0G8UMAzwkpTCR8P2jTBKhzOjUel0rOyv+SHbQpcr/4++GxlTwrKKMDGl6OjNs6c7S2d/jnTOfzoIzA8myhjyyCOPmFtuueWLvu+PhHoDcAvwXuBTCknUFITL+jWDv8xiIjmsQY3Tq5G0ISIWN5oK/k6SXIdPJaE3BCACXxek67B4FXPM6bUsBuev4vXWSy6ODhRr6qtCLSHHJmIJgR8QGxEtiCnh7KoIdSGLnmSBA32FUhOEQjBQcAv/cv2aRcUJAQH48Y9/HBwVUjFA98aaFf8WwCCYrylERVxFYkupjHSkUpCyRRZBsE9VbXEsecDjlw9szY0Iv1cJEjoUSQ2qath37pW8dPpq3nzDsssQLnN9g2NDU1WcjOdRH7LpshUJS7Eo7lDtWKSyHrsP5kY20Pmu1uapkXr1uGh1sj3ISvD9rAT+sPUhckxQTwPbxGUOiqo3QFT3kIOGkuFA3TMtq0QwS6ScG3KbZvPba+7g6TPPJxOKMJB26e4v0NWfLxhjBkWERMimxoILq6OsqgpT7VgMZjy27ksdsqwM8D/AP924dnHhhAEB8JXJ+Zj2rAQH8xIwWv1iEcNuPFbgEH9jALIXaDPW4eZYWmsEqRRAV1Tw0ptuZXP9PHJaSGc8Nm7q4JUtnXznhy+tM6VH9L1+yLwNWyXnr6M3x6t7UuSL+hAYDwAfu3Ht4iPquk4o1yaWGLR5LMA8G2C+wSiPrQshvM0kCL8BRJbASwY+L1B7RfeW4dN16cF2s37B5Y87nvuBwZZlFZtVgoFkjkBrPF/T1ZfmhZe7kqm0d7/vBT8LhexXUznvlkzO/3Aq6zWl8r5VKGp06R54CvgS8B83rl3cP4W8y+Rofe3S042YTgwfoLv5MQ8AAAXnSURBVJSDt3hjUh74Y4FfA1VXDGwbNnmvvv3eJQKfOs3P/6HvOKGuULRUoqo1vq9p9PLdvU70T0PR8M8e/MbNw0D+ZP3rs2xbbpXSLTSnnF96ANhwqKhh2gE5RI/VLjmjHBlu5iRcsJ9mKgCvAte/eWDbwZFvXH37vVcCX3EstcS2LZFyfqfoBYjRrB7q4pydTz+uMG+5afP9x5jFDz25U8qevADFG9cuHjfaOW3lAQr2aXhRIGdKF33eMBaVwIMG+iyR7pFvXHPHvbYg37Ut1WyXy5D8QOMFmoTvcnHPa6xs/znhYq5TQvaoTlaZE/KTncy0AXL5wLbC47VLvl1+ROdcIGam9kDJ3wXdT6kF7FcFopf1bz1iU0O2bUQYVCLNBvD8gCDQNHp5rnn9aVr2biTuuSjsbRIOT9fBnj66fGDbo5QeGPx9U3qWbfcpDMbrwD9I6bmFW0K2/dgx4ubbtwRK5HNam5zr+Zgg4Ox0N+98+UEWvf48Cc9DIUXg1dX7XpyWOOdMVDR1AQ8okbQ25j+BT8EpZ+/6Ap81lrxKYHoEhtb0bB51Q7Ux93l+IJ7h42uT+/NrNj18TiLVJyMerNRb1j/TZenNHD1euzSiMfcBb4VTxuYNgG+Io/7iiu5Xp3Sq2+KLFxOKbTnKaHkCuGkyzz486SLrWBG2tbDfKt5TkFLjw6wEBHLyq9xcMRTLzwTJSZDZY+XvnyoYABKJ7aFUiTOS2qcLDE6GKImhTuuwCk5eApLKY5eVP9HCgylRUTSvWznSEpBWAR1WsSKB03I8Y63ubw8oNXHro3QvpL8c/pg2mtGq2LaGVUr7+qJ+5bHNyhhXjHhojAWLgyiWkZMARp60+HiWJmSUOcuvsCqNvaqt+WxpPXgc9zqEH2N4hVLt8wJkei9+zmyZcmAsBasbtINtKthqZymKZkA8jAULgghho/AxaIHQCQJUFI1jSg+ZzEnALitPppzCiBuLpX6FVJQq2FdT6pI3ZUBaB9pTHL592zPdWzazIsuYeqAeoMY4stqvZJGOGgthUDxes3LkRNOvPHZauWE5nz3y4SpZSuFwc6ypZMgf0g0q4DUrR0oFDCmf1+0cGQlwEM4MYqzyE1Qcvk6wdJJNsk46zXQh//yRoEeN4kw/Lo0qZDpVUQbFZ6eVQwEpCeiwiswJIuy3ClRrp9ikQ67AV4FrKd1SOo9SarU2wKQ7VTHkiQnPDcLsVQVSEtClXFw0jlEsMGFadNhUavvoza9HmzhjVPf//wxI3Wh2dq12pFrbw9ZPQbRJis9BVZQ9Kk9ONDmrMFht7PaoUV8FtpRbIyWBxwQ+mFXB7l7lnmMj4V2WxhPDGTpmqrRNBCURo3CMQkY3twWo/X0EpGIs/0MhRMr1V1UgTYRYIBHzqp3BRQtg7bHyX/5wz/6uZxqW31sI/KUCninJ7337VTHmYS72MTSYkDnDi+NM7X61fSqKrJk2e3NTUZwRo+T0IC6R0rTCg1KqMrukd7MW2A38SuB1QR5Oi+8B4QpjsziIiTP1y+7BqQjITJ+SKceyolpRaWwK4g5XlQOUH8h1KMft/WtTcy1gVRubsJnyuQooXUb6veOQ7YxxnWHsEyIkjG3K4Ynq0T7z2fkLBWgWoNrY5jgWsQslmd8/QByVZooPQRGg0gw/THjUJlvG94Vy66gqbR9POenD2Er/3gHS2vOKBr4BTPo0GiB2uAh44WfmzJVj3RtTNqmFqLGmqjt6gPtau182v38cUqLHgO9PRYmGD3vstWM0vhSgMYSYqT2YmwJwNzPQ5+oNA0hrsj1LKSdy12T1iX0YkE1/27H/GEhExAAbHDMlyyoD/D3whdZku/d7C0gZlEHg74C/plRBP9Hlv4Igvypz1jH06Y79WsOXFfLCJEAuUgqZfwC4qzXZnucUppMez2mrWbEAWAu8jVKDtLqyOEtS8jWeD8Q8vt4ZeOaT3Z1jBu8+2dIkp3vROa1e4lLgCkrNnudRujijKGUu11Mqu3m2Ndl+kDcA/T8fLllOyXIZVAAAAABJRU5ErkJggg==" />
		<span class="cardsubtitle2"><br></span>
        <div style="text-align:left; font-size: 12px; margin-left: 5px;">The scan context and run time information have been provided below.</div>	
	</div>		
	<table>
		 <tr>
			<td class="cardsubtitle" style="vertical-align:top">Domain</td>
			<td >					
				<span class="AclEntryRight" style="width:160px;word-wrap: break-word;">$TargetDomain</span>				
			</td>
		 </tr>
		 <tr>
			<td class="cardsubtitle" style="vertical-align:top">DC</td>
			<td >					
				<span class="AclEntryRight" style="width:160px;word-wrap: break-word;">$DomainController</span>				
			</td>
		 </tr>	
		 <tr>
			<td class="cardsubtitle" style="vertical-align: top;">Start Time</td>
			<td>					
				<span class="AclEntryRight" style="width:160px;word-wrap: break-word;">$StartTime</span>				
			</td>
		 </tr>
		 <tr>
			<td class="cardsubtitle" style="vertical-align:top">Stop Time</td>
			<td >					
				<span class="AclEntryRight" style="width:160px;word-wrap: break-word;">$EndTime</span>				
			</td>
		 </tr>
		 <tr>
			<td class="cardsubtitle" style="vertical-align:top">Duration</td>
			<td >					
				<span class="AclEntryRight" style="width:160px;word-wrap: break-word;">$RunTime</span>				
			</td>
		 </tr>
		 <tr>
			<td class="cardsubtitle" style="vertical-align:top">Src Host</td>
			<td >					
				<span class="AclEntryRight" style="width:160px;word-wrap: break-word;">$SourceHost</span>				
			</td>
		 </tr>
		 <tr>
			<td class="cardsubtitle" style="vertical-align:top">Src IPs</td>
			<td >					
				<span class="AclEntryRight" style="width:160px;word-wrap: break-word;">$SourceIps</span>				
			</td>
		 </tr>		
		 <tr>
			<td class="cardsubtitle" style="vertical-align:top">Src User</td>
			<td >					
				<span class="AclEntryRight" style="width:160px;word-wrap: break-word;">$username</span>				
			</td>
		 </tr>		 
		</table> 		  
 </div>
</a>

<!-- home text -->
<div style="margin-left:320px;"> 
<br>
<div style="float:left;display:block;position:relative;">
<h4>How do I use this report?</h4>
Follow the guidance below to get the most out of this report. Click each step for more information.
<br><br>
<button class="collapsible"><span style="color:#CE112D;">1</span> | Review Reports and Insights</button>
<div class="content">
<div class="landingtext" >
Review the reports and data insights to get a quick feel for the level of SMB share exposure in your environment.
<br><br>
<strong style="color:#333">Reports</strong><br>
The <em>Scan, Computer, Share, and ACL</em> summary sections will provide a  summary of the results.  
<br>
<br>
<strong style="color:#333">Data Insights</strong><br>
The <em>Data Insights</em> sections are intented to highlight natural data groupings that can help centralize and expedite remediation on scale in Active Directory environments.
<br>
</div>
</div>
<button class="collapsible"><span style="color:#CE112D;">2</span> | Review Detailed CSV Files</button>
<div class="content">
<div class="landingtext">
Review potentially excessive share ACL entry details in the associated HTML and CSV files.
</div>
</div>

<button class="collapsible"><span style="color:#CE112D;">3</span> | Review Definitions</button>
<div class="content">
<div class="landingtext">
Review the definitions below to ensure you understand what was targeted and how privileges have been qualified as excessive.
<br><br>
<strong style="color:#333">Excessive Privileges</strong><br>
In the context of this report, excessive read and write share permissions have been defined as any network share ACL containing an explicit entry for the <em>"Everyone", "Authenticated Users", "BUILTIN\Users", "Domain Users", or "Domain Computers"</em> groups. 
All provide domain users access to the affected shares due to privilege inheritance. 
<Br><br>
Please note that share permissions can be overruled by NTFS permissions. Also, be aware that testing excluded share names containing the following keywords: <em>"print$", "prnproc$", "printer", "netlogon",and "sysvol"</em>.
<br><br>
<strong style="color:#333">High Risk Shares</strong>
<br>
In the context of this report, high risk shares have been defined as shares that provide unauthorized remote access to a system or application. By default, that includes <em>wwwroot, inetpub, c$, and admin$</em> shares.  However, additional exposures may exist that are not called out beyond that.
<br>
</div>
</div>

<button class="collapsible"><span style="color:#CE112D;">4</span> | Verify and Remediate Issues</button>
<div class="content">
<div class="landingtext" >
Follow the guidance in the Exploit Share Access, Detect Share Access, and Prioritize Remediation sections.</div>
</div>

<button class="collapsible"><span style="color:#CE112D;">5</span> | Run Scan Again</button>
<div class="content">
<div class="landingtext" style="">
Collect SMB Share data and generate this HTML report by running <a href="https://github.com/NetSPI/PowerShell/blob/master/Invoke-HuntSMBShares.ps1">Invoke-HuntSMBShares.ps1</a> audit script.<br>
The command examples below can be used to identify potentially malicious share permissions. 
<br><br>
<strong style="color:#333">From Domain System</strong>
<div style="border: 2px solid #CCC;margin-top:5px;padding: 5px;padding-left: 15px;width:95%;background-color:white;color:#757575;font-family:Lucida, Grande, sans-serif;">
Invoke-HuntSMBShares -Threads 20 -RunSpaceTimeOut 10 -OutputDirectory c:\folder\ 
</div>
<br>
<strong style="color:#333">From Non-Domain System</strong>
<div style="border: 2px solid #CCC;margin-top:5px;padding: 5px;padding-left: 15px;width:95%;background-color:white;color:#757575;font-family:Lucida, Grande, sans-serif;">
runas /netonly /user:domain\user PowerShell.exe<Br>
Import-Module Invoke-HuntSMBShares.ps1<br>
Invoke-HuntSMBShares -Threads 20 -RunSpaceTimeOut 10 -OutputDirectory c:\folder\ -DomainController 10.1.1.1 -Username domain\user -Password password 
</div>
</div>
</div>
<Br>
<br>
</div>
<br>
<script>


// --------------------------
// side menu collapse function
// --------------------------

	    function toggleMenu() {
            const menu = document.getElementById('sideMenu');
            const icon = document.querySelector('.menu-button .icon');
            menu.classList.toggle('collapsed');
			if (menu.classList.contains('collapsed')) {
				icon.innerHTML = '<span style="font-size: 16px; color:#F56A00; transition: color 0.3s ease;" onmouseover="this.style.color=\'white\'" onmouseout="this.style.color=\'#F56A00\'">☰</span>';
			} else {
				icon.innerHTML = '<span style="font-size: 16px; color:#F56A00; transition: color 0.3s ease;" onmouseover="this.style.color=\'white\'" onmouseout="this.style.color=\'#F56A00\'"><i class="fas fa-times"></i></span>';
			}	
        }

// --------------------------
// ACE Page: Type chart
// --------------------------

// Initialize ApexCharts
const ChartAceTypeOptions = {
  series: [{
    data: $UniqueFileSystemRightsSeries
  }],
  chart: {
    type: 'bar',
    height: 200
  },
  plotOptions: {
    bar: {		 
      borderRadius: 0,
      borderRadiusApplication: 'end',
      horizontal: true,
      colors: {
        backgroundBarColors: ['#e0e0e0'],
        backgroundBarOpacity: 1,
        ranges: [{
          from: 0,
          to: 1000,
          color: '#f08c41'
        }]
      }
    }
  },
  dataLabels: {
    enabled: false
  },
  grid: {
    show: false
  },
  xaxis: {
    categories: [$UniqueFileSystemRightsCategories]
  },
		  title: {
			text: 'ACE Type Count',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
};

const ChartAceType = new ApexCharts(document.querySelector("#ChartAceType"), ChartAceTypeOptions);
ChartAceType.render();

// --------------------------
// ACE Page: Risk Level chart
// --------------------------

// Initialize ApexCharts
const ChartAceRiskOptions = {
  series: [{
    data: [$RiskLevelCountCritical, $RiskLevelCountHigh, $RiskLevelCountMedium, $RiskLevelCountLow]
  }],
  chart: {
    type: 'bar',
    height: 200
  },
  plotOptions: {
    bar: {		 
      borderRadius: 0,
      borderRadiusApplication: 'end',
      horizontal: true,
      colors: {
        backgroundBarColors: ['#e0e0e0'],
        backgroundBarOpacity: 1,
        ranges: [{
          from: 0,
          to: 1000,
          color: '#f08c41'
        }]
      }
    }
  },
  dataLabels: {
    enabled: false
  },
  grid: {
    show: false
  },
  xaxis: {
    categories: ['Critical','High','Medium','Low']
  },
		  title: {
			text: 'ACE Count by Risk Level',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
};

const ChartAceRisk = new ApexCharts(document.querySelector("#ChartAceRisk"), ChartAceRiskOptions);
ChartAceRisk.render();

// --------------------------
// ACE Page: Chart - Interesting Files
// --------------------------

const datac = $IFCategoryListCount;
const categoriesc = $ChartCategoryCatDash;

const ChartAcesIFOptions = {
          series: [{
          data: datac
        }],
          chart: {
          type: 'bar',
          height: 200
        },
        plotOptions: {
          bar: {		 
            borderRadius: 0,
            borderRadiusApplication: 'end',
            horizontal: true,
			colors: {
				backgroundBarColors: ['#e0e0e0'],
				backgroundBarOpacity: 1,
                ranges: [{
                    from: 0,
                    to: 1000,
                    color: '#f08c41'
                }]
            }
          }
        },
        dataLabels: {
          enabled: false
        },
		  grid: {
			show: false
		  },
        xaxis: {
          categories: categoriesc,
        },
		  title: {
			text: 'Interesting File Exposure',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
        };

const ChartAcesIF = new ApexCharts(document.querySelector("#ChartAcesIF"), ChartAcesIFOptions);
ChartAcesIF.render();

// --------------------------
// Computers Page - Computers Found
// --------------------------

// Initialize ApexCharts
const ChartComputersDiscoOptions = {
  series: [{
    data:  [$ComputerPingableCount,$Computers445OpenCount,$AllComputersWithSharesCount,$ComputerwithNonDefaultCount,$ComputerWithExcessive,$ComputerWithReadCount,$ComputerWithWriteCount]
  }],
  chart: {
    type: 'bar',
    height: 200
  },
  plotOptions: {
    bar: {		 
      borderRadius: 0,
      borderRadiusApplication: 'end',
      horizontal: true,
      colors: {
        backgroundBarColors: ['#e0e0e0'],
        backgroundBarOpacity: 1,
        ranges: [{
          from: 0,
          to: 1000,
          color: '#f08c41'
        }]
      }
    }
  },
  dataLabels: {
    enabled: false
  },
  grid: {
    show: false
  },
  xaxis: {
    categories: ['Ping Response','445Open','Host Shares','Non Default','Excessive Privs','Readable','Writable']
  },
		  title: {
			text: 'Computer Count by Share Exposure',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
};

const ChartComputersDisco = new ApexCharts(document.querySelector("#ChartComputersDisco"), ChartComputersDiscoOptions);
ChartComputersDisco.render();

// --------------------------
// Computers Page - Computers Risk Levels
// --------------------------

// Initialize ApexCharts
const ChartComputersRiskOptionsa = {
  series: [{
    data: [$RiskLevelComputersCountCritical, $RiskLevelComputersCountHigh, $RiskLevelComputersCountMedium, $RiskLevelComputersCountLow]
  }],
  chart: {
    type: 'bar',
    height: 200
  },
  plotOptions: {
    bar: {		 
      borderRadius: 0,
      borderRadiusApplication: 'end',
      horizontal: true,
      colors: {
        backgroundBarColors: ['#e0e0e0'],
        backgroundBarOpacity: 1,
        ranges: [{
          from: 0,
          to: 1000,
          color: '#f08c41'
        }]
      }
    }
  },
  dataLabels: {
    enabled: false
  },
  grid: {
    show: false
  },
  xaxis: {
    categories: ['Critical','High','Medium','Low']
  },
		  title: {
			text: 'Computer Count by Risk Level',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
};

const ChartComputersRisk = new ApexCharts(document.querySelector("#ChartComputersRisk"), ChartComputersRiskOptionsa);
ChartComputersRisk.render();

// --------------------------
// Folder Group Page: Chart - Interesting Files
// --------------------------

const datab = $IFCategoryListCount;
const categoriesb = $ChartCategoryCatDash;

const ChartFGPageIFOptions = {
          series: [{
          data: datab
        }],
          chart: {
          type: 'bar',
          height: 200
        },
        plotOptions: {
          bar: {		 
            borderRadius: 0,
            borderRadiusApplication: 'end',
            horizontal: true,
			colors: {
				backgroundBarColors: ['#e0e0e0'],
				backgroundBarOpacity: 1,
                ranges: [{
                    from: 0,
                    to: 1000,
                    color: '#f08c41'
                }]
            }
          }
        },
        dataLabels: {
          enabled: false
        },
		  grid: {
			show: false
		  },
        xaxis: {
          categories: categoriesb,
        },
		  title: {
			text: 'Interesting File Exposure',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
        };

const ChartFGPageIF = new ApexCharts(document.querySelector("#ChartFGPageIF"), ChartFGPageIFOptions);
ChartFGPageIF.render();

// --------------------------
// Folder Group Page: Chart - Risk Levels
// --------------------------

// Initialize ApexCharts
const ChartFGRiskOptionsa = {
  series: [{
    data: [$RiskLevelFolderGroupCountCritical, $RiskLevelFolderGroupCountHigh, $RiskLevelFolderGroupCountMedium , $RiskLevelFolderGroupCountLow]
  }],
  chart: {
    type: 'bar',
    height: 200
  },
  plotOptions: {
    bar: {		 
      borderRadius: 0,
      borderRadiusApplication: 'end',
      horizontal: true,
      colors: {
        backgroundBarColors: ['#e0e0e0'],
        backgroundBarOpacity: 1,
        ranges: [{
          from: 0,
          to: 1000,
          color: '#f08c41'
        }]
      }
    }
  },
  dataLabels: {
    enabled: false
  },
  grid: {
    show: false
  },
  xaxis: {
    categories: ['Critical','High','Medium','Low']
  },
		  title: {
			text: 'Folder Group Count by Risk Level',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
};

const ChartFGRiska = new ApexCharts(document.querySelector("#ChartFGRiska"), ChartFGRiskOptionsa);
ChartFGRiska.render();

// --------------------------
// Share Names Page: Chart - Interesting Files
// --------------------------

const dataa = $IFCategoryListCount;
const categoriesa = $ChartCategoryCatDash;

const ChartSharePageIFOptions = {
          series: [{
          data: dataa
        }],
          chart: {
          type: 'bar',
          height: 200
        },
        plotOptions: {
          bar: {		 
            borderRadius: 0,
            borderRadiusApplication: 'end',
            horizontal: true,
			colors: {
				backgroundBarColors: ['#e0e0e0'],
				backgroundBarOpacity: 1,
                ranges: [{
                    from: 0,
                    to: 1000,
                    color: '#f08c41'
                }]
            }
          }
        },
        dataLabels: {
          enabled: false
        },
		  grid: {
			show: false
		  },
        xaxis: {
          categories: categoriesa,
        },
		  title: {
			text: 'Interesting File Exposure',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
        };
const ChartSharePageIF = new ApexCharts(document.querySelector("#ChartSharePageIF"), ChartSharePageIFOptions);
ChartSharePageIF.render();

// --------------------------
// Share Names Page: Chart - Risk Levels
// --------------------------

// Initialize ApexCharts
const ChartShareNameRiskOptionsa = {
  series: [{
    data: [$RiskLevelShareNameCountCritical, $RiskLevelShareNameCountHigh, $RiskLevelShareNameCountMedium,  $RiskLevelShareNameCountLow]
  }],
  chart: {
    type: 'bar',
    height: 200
  },
  plotOptions: {
    bar: {		 
      borderRadius: 0,
      borderRadiusApplication: 'end',
      horizontal: true,
      colors: {
        backgroundBarColors: ['#e0e0e0'],
        backgroundBarOpacity: 1,
        ranges: [{
          from: 0,
          to: 1000,
          color: '#f08c41'
        }]
      }
    }
  },
  dataLabels: {
    enabled: false
  },
  grid: {
    show: false
  },
  xaxis: {
    categories: ['Critical','High','Medium','Low']
  },
		  title: {
			text: 'Share Name Count by Risk Level',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
};

const ChartShareNameRiska = new ApexCharts(document.querySelector("#ChartShareNameRiska"), ChartShareNameRiskOptionsa);
ChartShareNameRiska.render();

// --------------------------
// Dashboard Page: Chart - Interesting Files
// --------------------------

// Data and categories
const data = $IFCategoryListCount;
const categories = $ChartCategoryCatDash;

// Combine data and categories into an array of objects
//const combined = data.map((value, index) => {
//  return { value, category: categories[index] };
//});

// Sort the combined array based on the data values (largest to smallest)
//combined.sort((a, b) => b.value - a.value);

// Separate the sorted data and categories back into individual arrays
//const sortedData = combined.map(item => item.value);
//const sortedCategories = combined.map(item => item.category);

// Initialize ApexCharts
const ChartDashboardIFOptions = {
          series: [{
          data: data
        }],
          chart: {
          type: 'bar',
          height: 300
        },
        plotOptions: {
          bar: {		 
            borderRadius: 0,
            borderRadiusApplication: 'end',
            horizontal: true,
			colors: {
				backgroundBarColors: ['#e0e0e0'],
				backgroundBarOpacity: 1,
                ranges: [{
                    from: 0,
                    to: 1000,
                    color: '#f08c41'
                }]
            }
          }
        },
        dataLabels: {
          enabled: false
        },
		  grid: {
			show: false
		  },
        xaxis: {
          categories: categories,
        },
  title: {
    text: 'Interesting File Exposure',
    align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
    margin: 10, // Adjusts the space between the title and the chart
    style: {
      fontSize: '16px',
      fontWeight: 'bold',
      color: 'gray'
    }
  }
        };

const ChartDashboardIF = new ApexCharts(document.querySelector("#ChartDashboardIF"), ChartDashboardIFOptions);
ChartDashboardIF.render();

// --------------------------
// Dashboard Page: Risk Level chart
// --------------------------

//  Set data series
var DataSeriesComputers = [$RiskLevelComputersCountLow, $RiskLevelComputersCountMedium, $RiskLevelComputersCountHigh, $RiskLevelComputersCountCritical];
var DataSeriesShares    = [$RiskLevelSharePathCountLow, $RiskLevelSharePathCountMedium, $RiskLevelSharePathCountHigh, $RiskLevelSharePathCountCritical];
var DataSeriesACEs      = [$RiskLevelCountLow, $RiskLevelCountMedium, $RiskLevelCountHigh,$RiskLevelCountCritical];

// Reverse each array
DataSeriesComputers.reverse();
DataSeriesShares.reverse();
DataSeriesACEs.reverse();

// Find max values
var maxComputer     = Math.max(...DataSeriesComputers);
var maxShares       = Math.max(...DataSeriesShares);
var maxACEs         = Math.max(...DataSeriesACEs);
var maxValueOverall = Math.max(maxComputer, maxShares, maxACEs);

// Initialize ApexCharts
const ChartDashboardRiskOptions = {
  series: [{
    name: 'Computers',
    data: DataSeriesComputers
    //color: 'blue'  // Set color for Computers series
  },{
    name: 'Shares',
    data: DataSeriesShares
    //color: 'green'  // Set color for Shares series
  },{
    name: 'ACEs',
    data: DataSeriesACEs 
    //color: 'red'  // Set color for ACEs series
  }],
  chart: {
    type: 'bar',
    height: 300
  },
  plotOptions: {
    bar: {		 
      borderRadius: 0,
      borderRadiusApplication: 'end',
      horizontal: true,
      barHeight: '90%', // Reduce bar height for more space
      barGap: '0%',     // Adds gap between bars in the same group
     // barSpacing: 0.0  // Adds space between the groups (risk levels)
    }
  },
  colors: ['#DBDCD6', '#E4A628', '#07142A'],  // Colors for the bars
  dataLabels: {
    enabled: true,
    style: {
      fontSize: '12px',
      colors: ['#07142A', '#07142A', '#E4A628'] // colors for the lables #FF9965
    },
    offsetX: 0
  },
  grid: {
    show: true,
	opacity: 0.5
  },
  xaxis: {
    categories: ['Critical','High','Medium','Low'],
	max: maxValueOverall,
	min: 0
  },
  title: {
    text: 'Asset Count by Risk Level',
    align: 'center',
    margin: 10,
    style: {
      fontSize: '16px',
      fontWeight: 'bold',
      color: 'gray'
    }
  }
};

const ChartDashboardRisk = new ApexCharts(document.querySelector("#ChartDashboardRisk"), ChartDashboardRiskOptions);
ChartDashboardRisk.render();

// --------------------------
// Dashboard Page: Chart - Remediation Prioritization
// --------------------------

		//  Set data series
		var DataSeriesAverage = $RemediationBase;		
		var DataSeriesActual  = $RemediationSave;
		
		
		// Find max values
		var maxValueAverage = Math.max(...DataSeriesAverage);
		var maxValueActual = Math.max(...DataSeriesActual);
		var maxValueOverall = Math.max(maxValueAverage, maxValueActual);

        var RemCompareOptions = {
          series: [{
          name: 'Affected Shares',
          data: DataSeriesAverage
        }, {
          name: 'Grouping',
          data: DataSeriesActual
        }],
          chart: {
          type: 'bar',
          height: 250
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '55%',
            endingShape: 'rounded'
          },
        },
        colors: ['#07142A', '#f08c41'],  // Reversed colors for Average and Actual bars
        dataLabels: {
          enabled: true,  // Enable data labels
          style: {
            fontSize: '12px',
            colors: ['#f08c41', '#07142A'],  // Colors for labels
          },
          formatter: function (val, opts) {
            return val;  // Display values with percentage sign
          },
          offsetY: -6  // Adjust position of the label
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent']
        },
        xaxis: {
          categories: ['Individul ACEs (No Grouping)','Folder Groups', 'Share Name Groups (High Similarity)'],  // X-axis categories
          labels: {
            style: {
              colors: '#808080',  // Set x-axis labels to gray
            }
          }
        },
        yaxis: {
          title: {
            text: 'Remediation Tasks',
            style: {
              fontWeight: 'normal',
              color: '#808080'  // Set "Percentage" text to gray
            }
          },
          labels: {
            style: {
              colors: '#808080',  // Set y-axis labels to gray
            },
            formatter: function (val) {
              return val;  // Format y-axis labels with percentage sign
            }
          },
          max: Math.ceil(maxValueOverall * 1.1),
          min: 0
        },
        fill: {
          opacity: 1
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val + "%";  // Show percentage in tooltip
            }
          }
        },
        title: {
          text: 'Remediation Effort Saving',  // Updated chart title
          align: 'center',
          style: {
            fontSize: '18px',
            fontWeight: 'normal',
            color: '#808080'
          }
        }
        };

        var RemCompareOptionschart = new ApexCharts(document.querySelector("#ChartDashboardRemediate"), RemCompareOptions);
        RemCompareOptionschart.render();

// --------------------------
// Dashboard Page: Chart - Peer Comparison
// --------------------------

		//  Set data series
		var DataSeriesAverage = $PeerCompareAverageP;		
		var DataSeriesActual  = $PeerCompareActuaP;
		
		
		// Find max values
		var maxValueAverage = Math.max(...DataSeriesAverage);
		var maxValueActual = Math.max(...DataSeriesActual);
		var maxValueOverall = Math.max(maxValueAverage, maxValueActual);

        var PeerCompareOptions = {
          series: [{
          name: 'Peer Average',
          data: DataSeriesAverage
        }, {
          name: 'This Environment',
          data: DataSeriesActual
        }],
          chart: {
          type: 'bar',
          height: 250
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '55%',
            endingShape: 'rounded'
          },
        },
        colors: ['#07142A', '#f08c41'],  // Reversed colors for Average and Actual bars
        dataLabels: {
          enabled: true,  // Enable data labels
          style: {
            fontSize: '12px',
            colors: ['#f08c41', '#07142A'],  // Colors for labels
          },
          formatter: function (val, opts) {
            return val + '%';  // Display values with percentage sign
          },
          offsetY: -6  // Adjust position of the label
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent']
        },
        xaxis: {
          categories: ['Computers', 'Shares', 'ACEs'],  // X-axis categories
          labels: {
            style: {
              colors: '#808080',  // Set x-axis labels to gray
            }
          }
        },
        yaxis: {
          title: {
            text: 'Percentage (%)',
            style: {
              fontWeight: 'normal',
              color: '#808080'  // Set "Percentage" text to gray
            }
          },
          labels: {
            style: {
              colors: '#808080',  // Set y-axis labels to gray
            },
            formatter: function (val) {
              return val + '%';  // Format y-axis labels with percentage sign
            }
          },
          max: Math.ceil(maxValueOverall * 1.1),
          min: 0
        },
        fill: {
          opacity: 1
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val + "%";  // Show percentage in tooltip
            }
          }
        },
        title: {
          text: 'Percent of Assets with Excessive Privileges',  // Updated chart title
          align: 'center',
          style: {
            fontSize: '18px',
            fontWeight: 'normal',
            color: '#808080'
          }
        }
        };

        var PeerCompareOptionschart = new ApexCharts(document.querySelector("#ChartDashboardPeerCompare"), PeerCompareOptions);
        PeerCompareOptionschart.render();

// --------------------------
// Function to support collapsing and expanding sections
// --------------------------
var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.maxHeight){

      content.style.maxHeight = null;

      // Adjust width  
      content.style.width = 0;

    } else {
      content.style.Height = content.scrollHeight + "px";
      content.style.maxHeight = "100%";
      
      // Adjust width  
      content.style.width = "auto";  
    } 
  });
}

function toggleDiv(TargetObjectId) {
    var content = document.getElementById(TargetObjectId);
    if (content.style.display === "none") {
        content.style.display = "block";        
    } else {
        content.style.display = "none";  
        content.style.width = 0;    
    }
}

// --------------------------
// String to update bar chart - Interesting Files
// --------------------------
// Function to count strings in the current displayed rows
function countStringInDisplayedRows(searchString) {
    var count = 0;
    currentFilteredRows.forEach(row => {
        var cells = row.getElementsByTagName('td');
        var cellValue = cells[2].innerText || cells[2].textContent;
        if (cellValue === searchString) {
            count++;
        }
    });
    return count;
}

// Update the chart with counts based on displayed rows
function updateChart() {
    $ChartCategoryCatVarsFlat

    chart.updateSeries([{
        name: 'Count',
        $ChartCategoryDat
    }]);
}


// --------------------------
// Interesting Files - Bar Chart
// --------------------------

// Initialize ApexCharts
const chartOptions = {
    chart: {
        type: 'bar',
        height: 200,
        events: {
                    dataPointSelection: function(event, chartContext, config) {
                        // Get the clicked category
                        var category = config.w.config.xaxis.categories[config.dataPointIndex];
                        handleCategoryClick(category);
                    }
        }
    },
    series: [{
        name: 'Count',
        data: [1, 1, 1]
    }],
    xaxis: {
        $ChartCategoryCat
        labels: {
            style: {
               // fontSize: '18px',
               // fontWeight: 'bold',
               // colors: '#f08c41'
            }
        }
    },
    yaxis: {
        labels: {
            style: {
               // fontSize: '14px',
               // colors: '#b3afaf'
            }
        }
    },
    plotOptions: {
        bar: {
            borderRadius: 0,
            horizontal: true,
            colors: {
                ranges: [{
                    from: 0,
                    to: 1000,
                    color: '#f08c41'
                }]
            }
        }
    },
    dataLabels: {
        enabled: false,
        style: {
            fontSize: '18px',
            fontWeight: 'bold',
            colors: ['#07142A']  // Set text color to black
        },
        formatter: function (val) {
            return '' + val;
        },
        offsetY: 0,  // Adjust this value to position the labels above the bars
        background: {
            enabled: false  // Disable background for data labels
        }
    },
    tooltip: {
        y: {
            formatter: function (val) {
                return '' + val;
            }
        }
    },
		  title: {
			text: 'Interesting File Exposure',
			align: 'center', // Aligns the title, can be 'left', 'center', or 'right'
			margin: 10, // Adjusts the space between the title and the chart
			style: {
			  fontSize: '16px',
			  fontWeight: 'bold',
			  color: 'gray'
			}
		  }
};

const chart = new ApexCharts(document.querySelector("#chart"), chartOptions);
chart.render();

// apply category filter to interestiong table rows
function handleCategoryClick(category) {
    //alert("Category clicked: " + category);
	document.getElementById('filterInputIF').value = category;
	applyFiltersAndSort('InterestingFileTable', 'filterInputIF', 'filterCounterIF', 'paginationIF',2);
}

// --------------------------
// Sorting Functions
// --------------------------
const rowsPerPage = 10;
let currentPage = 1;
let currentSortColumn = -1;
let currentSortDir = "asc";
let currentFilteredRows = [];

// Sorting Function
function sortTable(tableId, columnIndex, dataType = 'number') {
    const table = document.getElementById(tableId);
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.rows);
    const dir = currentSortColumn === columnIndex && currentSortDir === "asc" ? "desc" : "asc";
    currentSortDir = dir;
    currentSortColumn = columnIndex;

    rows.sort((a, b) => {
        const cellA = a.cells[columnIndex].innerText.toLowerCase();
        const cellB = b.cells[columnIndex].innerText.toLowerCase();

        if (dataType === 'number') {
            if (!isNaN(parseFloat(cellA)) && !isNaN(parseFloat(cellB))) {
                return dir === "asc" ? parseFloat(cellA) - parseFloat(cellB) : parseFloat(cellB) - parseFloat(cellA);
            } else if (cellA.includes('%') && cellB.includes('%')) {
                const numA = parseFloat(cellA.replace('%', ''));
                const numB = parseFloat(cellB.replace('%', ''));
                return dir === "asc" ? numA - numB : numB - numA;
            } else {
                if (cellA < cellB) return dir === "asc" ? -1 : 1;
                if (cellA > cellB) return dir === "asc" ? 1 : -1;
                return 0;
            }
        } else {
            if (cellA < cellB) return dir === "asc" ? -1 : 1;
            if (cellA > cellB) return dir === "asc" ? 1 : -1;
            return 0;
        }
    });

    rows.forEach(row => tbody.appendChild(row));
    updateSortIndicators(tableId, columnIndex);
    applyFiltersAndSort(tableId, searchInputIdForTable(tableId), filterCounterIdForTable(tableId), paginationIdForTable(tableId));
}

function updateSortIndicators(tableId, columnIndex) {
    const table = document.getElementById(tableId);
    const headers = table.querySelectorAll("th");
    headers.forEach((th, index) => {
        th.classList.remove("asc", "desc");
        if (index === columnIndex) {
            th.classList.add(currentSortDir);
        }
    });
}

// Filtering Function
function applyFiltersAndSort(tableId, searchInputId, filterCounterId, paginationId, columnId = null) {
    const table = document.getElementById(tableId);
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.rows);
    const searchInput = searchInputId ? document.getElementById(searchInputId) : null;
    const filterCounter = filterCounterId ? document.getElementById(filterCounterId) : null;
    const checkboxes = document.querySelectorAll('.filter-checkbox');

    const filterInputValue = searchInput ? searchInput.value.toLowerCase() : '';
    const checkedFilters = Array.from(checkboxes)
        .filter(cb => cb.checked)
        .map(cb => cb.name);

    currentFilteredRows = rows.filter(row => { // Update filtered rows
        const cells = Array.from(row.cells);
        const matchesTextFilter = columnId !== null 
            ? cells[columnId].innerText.toLowerCase().includes(filterInputValue)
            : cells.some(cell => cell.innerText.toLowerCase().includes(filterInputValue));
        const matchesCheckboxFilter = checkedFilters.every(filter => row.getAttribute(filter) === "Yes");

        return matchesTextFilter && matchesCheckboxFilter;
    });

    let maxPage = Math.ceil(currentFilteredRows.length / rowsPerPage) || 1;
    if (currentPage > maxPage) {
        currentPage = maxPage;
    }

    displayRows(tableId, currentFilteredRows, filterCounterId, paginationId);
    updateChart();
}

function updateFilterCounter(filterCounterId, visibleRows) {
    const filterCounter = document.getElementById(filterCounterId);
    filterCounter.textContent = ```${visibleRows} matches found``;
}

// Pagination Functions
function displayRows(tableId, filteredRows, filterCounterId, paginationId) {
    const table = document.getElementById(tableId);
    const tbody = table.querySelector('tbody');
    const startIndex = (currentPage - 1) * rowsPerPage;
    const endIndex = currentPage * rowsPerPage;

    Array.from(tbody.rows).forEach(row => row.classList.add('hidden'));
    filteredRows.slice(startIndex, endIndex).forEach(row => row.classList.remove('hidden'));

    if (paginationId) {
        updatePagination(tableId, paginationId, filteredRows.length);
    }
    if (filterCounterId) {
        updateFilterCounter(filterCounterId, filteredRows.length);
    }

    if (filteredRows.length === 0 || filteredRows.slice(startIndex, endIndex).length === 0) {
        if (currentPage > 1) {
            currentPage--;
            displayRows(tableId, filteredRows, filterCounterId, paginationId);
        }
    }
}

function updatePagination(tableId, paginationId, totalRows) {
    const pagination = document.getElementById(paginationId);
    const pageCount = Math.ceil(totalRows / rowsPerPage);
    pagination.innerHTML = '';

    createPageButton(1, tableId, paginationId);
    for (let i = 2; i <= Math.min(pageCount, 10); i++) {
        createPageButton(i, tableId, paginationId);
    }

    if (pageCount > 10) {
        createEllipsis(pagination);

        const startPage = Math.max(11, currentPage - 2);
        const endPage = Math.min(pageCount - 1, currentPage + 2);

        if (currentPage > 10) {
            for (let i = startPage; i <= endPage; i++) {
                createPageButton(i, tableId, paginationId);
            }
            if (currentPage < pageCount - 2) {
                createEllipsis(pagination);
            }
        }
        createPageButton(pageCount, tableId, paginationId);
    }

    createNavigationArrows(pagination, pageCount, tableId, paginationId);
}

function createPageButton(pageNumber, tableId, paginationId) {
    const pagination = document.getElementById(paginationId);
    const pageButton = document.createElement('button');
    pageButton.textContent = pageNumber;
    pageButton.classList.add('pagination-button');
    if (pageNumber === currentPage) pageButton.classList.add('active');
    pageButton.addEventListener('click', () => {
        currentPage = pageNumber;
        applyFiltersAndSort(tableId, searchInputIdForTable(tableId), filterCounterIdForTable(tableId), paginationId);
    });
    pagination.appendChild(pageButton);
}

function createEllipsis(pagination) {
    const ellipsis = document.createElement('span');
    ellipsis.textContent = '...';
    ellipsis.classList.add('ellipsis');
    pagination.appendChild(ellipsis);
}

function createNavigationArrows(pagination, pageCount, tableId, paginationId) {
    const nextButton = document.createElement('button');
    nextButton.textContent = '→';
    nextButton.classList.add('pagination-button');
    nextButton.addEventListener('click', () => {
        if (currentPage < pageCount) {
            currentPage++;
            applyFiltersAndSort(tableId, searchInputIdForTable(tableId), filterCounterIdForTable(tableId), paginationId);
        }
    });
    pagination.appendChild(nextButton);
}

function searchInputIdForTable(tableId) {
    if (tableId === 'sharenametable') return 'filterInput';
    if (tableId === 'foldergrouptable') return 'filterInputTwo';
    if (tableId === 'InterestingFileTable') return 'filterInputIF';
    return null;
}

function filterCounterIdForTable(tableId) {
    if (tableId === 'sharenametable') return 'filterCounter';
    if (tableId === 'foldergrouptable') return 'filterCounterTwo';
    if (tableId === 'InterestingFileTable') return 'filterCounterIF';
    return null;
}

function paginationIdForTable(tableId) {
    if (tableId === 'sharenametable') return 'pagination';
    if (tableId === 'foldergrouptable') return 'paginationfg';
    if (tableId === 'InterestingFileTable') return 'paginationIF';
    return null;
}

// Initialize share name table 
document.getElementById('filterInput').addEventListener("keyup", () => applyFiltersAndSort('sharenametable', 'filterInput', 'filterCounter', 'pagination'));
document.querySelectorAll('.filter-checkbox').forEach(checkbox => checkbox.addEventListener('change', () => applyFiltersAndSort('sharenametable', 'filterInput', 'filterCounter', 'pagination')));
applyFiltersAndSort('sharenametable', 'filterInput', 'filterCounter', 'pagination');

// Initialize folder group table    
document.getElementById('filterInputTwo').addEventListener("keyup", () => applyFiltersAndSort('foldergrouptable', 'filterInputTwo', 'filterCounterTwo', 'paginationfg'));
applyFiltersAndSort('foldergrouptable', 'filterInputTwo', 'filterCounterTwo', 'paginationfg');	

// Initialize interesting files table
document.getElementById('filterInputIF').addEventListener("keyup", () => applyFiltersAndSort('InterestingFileTable', 'filterInputIF', 'filterCounterIF', 'paginationIF'));
applyFiltersAndSort('InterestingFileTable', 'filterInputIF', 'filterCounterIF', 'paginationIF');	

// Initialize computers table
document.getElementById('computerfilterInput').addEventListener("keyup", () => applyFiltersAndSort('ComputersTable', 'computerfilterInput', 'computerfilterCounter', 'computerpagination'));
applyFiltersAndSort('ComputersTable', 'computerfilterInput', 'computerfilterCounter', 'computerpagination');

// Initialize ace table
document.getElementById('acefilterInput').addEventListener("keyup", () => applyFiltersAndSort('aceTable', 'acefilterInput', 'acefilterCounter', 'acepagination'));
applyFiltersAndSort('aceTable', 'acefilterInput', 'acefilterCounter', 'acepagination');	

// Initialize identity table
document.getElementById('IdentityfilterInput').addEventListener("keyup", () => applyFiltersAndSort('IdentityTable', 'IdentityfilterInput', 'IdentityfilterCounter', 'Identitypagination'));
applyFiltersAndSort('IdentityTable', 'IdentityfilterInput', 'IdentityfilterCounter', 'Identitypagination');	

// CSV export function
function extractAndDownloadCSV(tableId, columnIndex) {
    // Regex to match \\server\share, \\server\share folder, and \\server\share\file.ext formats, allowing spaces
    const regex = /\\\\[^\\\s]+\\[^\\]+(?:\\[^\\]*)*/g;
    const uncPaths = [];

    // Get the table element by ID
    const table = document.getElementById(tableId);

    // Determine rows to process: filtered rows or all rows if no filter is applied
    const rowsToProcess = currentFilteredRows.length > 0 ? currentFilteredRows : Array.from(table.rows);

    // Loop through each row to process
    rowsToProcess.forEach(row => {
        const cells = row.getElementsByTagName('td');
        if (cells[columnIndex]) {
            // Get the div with class 'content' inside the cell
            const contentDiv = cells[columnIndex].querySelector('.content');
            if (contentDiv) {
                const cellValue = contentDiv.innerText;
                const matches = cellValue.match(regex);
                if (matches) {
                    uncPaths.push(...matches);
                }
            }
        }
    });

    // Remove empty or whitespace-only entries
    const cleanUncPaths = uncPaths.map(path => path.trim()).filter(path => path.length > 0);

    // Generate CSV content
    let csvContent = 'data:text/csv;charset=utf-8,';
    csvContent += cleanUncPaths.join('\n');

    // Set output file name
    let CombinedName = tableId + '_unc_paths.csv' 

    // Create a link to download the CSV file
    const encodedUri = encodeURI(csvContent);
    const link = document.createElement('a');
    link.setAttribute('href', encodedUri);
    link.setAttribute('download', CombinedName);
    document.body.appendChild(link);

    // Force download the file
    link.click();

    // Clean up by removing the link
    document.body.removeChild(link);
}

function updateLabelColors(divId, objectId) {
    // Get the div element by its ID
    var divElement = document.getElementById(divId);

	// Check if the div element exists
    if (divElement) {
        // Get all label elements that are children of the div
        var labels = divElement.getElementsByTagName('label');
        
		// Loop through all label elements
        for (var i = 0; i < labels.length; i++) {
            var label = labels[i];

            // Check if the ID does not start with "noactionmenu"
            if (!label.id.startsWith("noactionmenu")) {
                // Reset the styles for labels that do not start with "noactionmenu"
                label.style.fontWeight = '';
                label.style.color = '';
                label.style.backgroundColor = '';
                label.style.transition = '';
                label.style.textDecoration = '';
                label.style.paddingLeft = '';
                label.style.borderRadius = '';
                label.style.paddingTop = '';
                label.style.paddingBottom = '';
                label.style.marginRight = '';
                label.style.marginLeft = '';
            }
        }
    } else {
        console.error("Div with id '" + divId + "' not found.");
    }
	
    // Check if the div element exists
    if (divElement) {
        // Get all label elements that are children of the div
        var labels = divElement.getElementsByTagName('label');
        
        // Loop through all label elements and clear their classes and inline styles, then reapply
        for (var i = 0; i < labels.length; i++) {
            // Save the class name and inline styles
            var className = labels[i].className;
            var style = labels[i].style.cssText;

            // Remove all classes and inline styles
            labels[i].className = '';
            labels[i].style.cssText = '';

            // Reapply the saved class name and inline styles
            labels[i].className = className;
            labels[i].style.cssText = style;
        }
    } else {
        console.error("Div with id '" + divId + "' not found.");
    }

    // Get the element by its object ID and set its background color to #25648C
    var objectElement = document.getElementById(objectId);

    if (objectElement) {
        // Apply the desired styles
        objectElement.style.fontWeight = 'normal';
        objectElement.style.color = 'white';
        objectElement.style.backgroundColor = '#17405A';
        objectElement.style.transition = 'background-color 0.9s ease, color 0.3s ease';
        objectElement.style.textDecoration = 'none';
        objectElement.style.paddingLeft = '15px';
        objectElement.style.borderRadius = '5px';
        objectElement.style.paddingTop = '5px';
        objectElement.style.paddingBottom = '5px';
        objectElement.style.marginRight = '5px';
        objectElement.style.marginLeft = '5px';
    } else {
        console.error("Element with id '" + objectId + "' not found.");
    }
}
	
</script>
</div>
</div>
</div>
</div>
<!--  
|||||||||| FOOTER
-->

<div style="float:right;border-top: 1px solid #DEDFE1 ; background-color:#f0f3f5;width:100%">
<img style="float:right;margin-right:15px;margin-top:15px;margin-bottom:15px;margin-right:50px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAAAzCAYAAADSDUdEAAAA63pUWHRSYXcgcHJvZmlsZSB0eXBlIGV4aWYAAHjajVHbDcMwCPz3FB2Bl1/jOE0idYOO33OCm7pSpSJB4CDHw2F7PvZw6yJFgsVcUk2JIFatSoNT6JTlsEx22EPuI8czHlQ9IYC673EVxzfg8Nnj6kQ86gfRcLjBi1eiNceXGV+cUMo3kU+gfHam1X9wIhWfyObVUi15Wm290yzlUtMsKSbOBmtCOacKvwhZxj3XPqjmoz2F0WkAIx6lgplkU1aCVbVzSu1q2vCNsIgDChkFDcqwEYT98ISnxAggrifx3uh9zM/bXDf6If+sFV6gxXW2kUL0lAAAAYVpQ0NQSUNDIHByb2ZpbGUAAHicfZE9SMNAHMVfU4siFUE7iIhkqE52URHBpVSxCBZKW6FVB5NLv6BJQ5Li4ii4Fhz8WKw6uDjr6uAqCIIfIM4OToouUuL/kkKLGA+O+/Hu3uPuHSA0Kkw1u6KAqllGKh4Ts7lVsfsVAYQwgFHMSczUE+nFDDzH1z18fL2L8Czvc3+OPiVvMsAnEkeZbljEG8Qzm5bOeZ84xEqSQnxOPGHQBYkfuS67/Ma56LDAM0NGJjVPHCIWix0sdzArGSrxNHFYUTXKF7IuK5y3OKuVGmvdk78wmNdW0lynOYI4lpBAEiJk1FBGBRYitGqkmEjRfszDP+z4k+SSyVUGI8cCqlAhOX7wP/jdrVmYmnSTgjEg8GLbH2NA9y7QrNv297FtN08A/zNwpbX91QYw+0l6va2Fj4D+beDiuq3Je8DlDjD0pEuG5Eh+mkKhALyf0TflgMFboHfN7a21j9MHIENdLd8AB4fAeJGy1z3e3dPZ279nWv39AAdjcuJhaaNVAAANdmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNC40LjAtRXhpdjIiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iCiAgICB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIgogICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICAgeG1sbnM6R0lNUD0iaHR0cDovL3d3dy5naW1wLm9yZy94bXAvIgogICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgIHhtcE1NOkRvY3VtZW50SUQ9ImdpbXA6ZG9jaWQ6Z2ltcDo4M2I4NjM2Yy0yNzJlLTQwMjUtOWJiNS02OGIzMTI4ZjhjMjQiCiAgIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6MTgxYTkxZDctZmUwZC00MTRmLWFhYjctYzg4MjlhM2I2MDY3IgogICB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NmQ2ODg0ZjctYzc5YS00MmMxLWEzMWYtMzgzZTEzMDc5YmNmIgogICBkYzpGb3JtYXQ9ImltYWdlL3BuZyIKICAgR0lNUDpBUEk9IjIuMCIKICAgR0lNUDpQbGF0Zm9ybT0iV2luZG93cyIKICAgR0lNUDpUaW1lU3RhbXA9IjE3MTYyMjk5MTkzNDA1ODMiCiAgIEdJTVA6VmVyc2lvbj0iMi4xMC4zNCIKICAgdGlmZjpPcmllbnRhdGlvbj0iMSIKICAgeG1wOkNyZWF0b3JUb29sPSJHSU1QIDIuMTAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjQ6MDU6MjBUMTM6MzE6NTctMDU6MDAiCiAgIHhtcDpNb2RpZnlEYXRlPSIyMDI0OjA1OjIwVDEzOjMxOjU3LTA1OjAwIj4KICAgPHhtcE1NOkhpc3Rvcnk+CiAgICA8cmRmOlNlcT4KICAgICA8cmRmOmxpCiAgICAgIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiCiAgICAgIHN0RXZ0OmNoYW5nZWQ9Ii8iCiAgICAgIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6Yzk5OTQxMWEtZmZjZS00ZDViLWFkMzQtMzI2NWJlZWQ5MjBhIgogICAgICBzdEV2dDpzb2Z0d2FyZUFnZW50PSJHaW1wIDIuMTAgKFdpbmRvd3MpIgogICAgICBzdEV2dDp3aGVuPSIyMDI0LTA1LTIwVDEzOjMxOjU5Ii8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgumjoYAAAAGYktHRAD/AP8A/6C9p5MAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfoBRQSHztCq+xTAAAAGXRFWHRDb21tZW50AENyZWF0ZWQgd2l0aCBHSU1QV4EOFwAAECBJREFUeNrtnXl0HNWVxn+fZFUbuw0M1WCWYQjhEFJiAgMDeNgMJDDsxgQYwjJDcDDQYsswHJbDOICJCQcywWzuIQxbgAAxZjfgYMBsCWFxkgFUQGAImBgwKgimbaOypDt/VMlut6pb3bIkS1DfOXUkdVW9rvfe3b777itBihQpUqRIkSJFihQpUgwetKSFcBg9rwEnjp7BLenUpRgMjACahtkzN6TTliIVthQpUgVJkSJVkBQpUgVJkeLLStKroZMoc1QJjYD68L0D1W4POK43AtGYeNJYHgZ+Vx1tNaKEMTM6wsDvHO7C4LjeusDGghxoLcO6gMXAQuDDMPCXr9Y49Qajq5bvcHKeAKfOtjvCwO90XE+o7F6jA9GI0dk9j07OawCaqnViiRm7AJ9UEmLBHMRWdQ5DlxmHAr+vcF4S1wIH98ekS/oRcFLimMmuc1zvgjDwrcbmjhW6rOfYczpw1zBVii0Qh2EcIulbwKjYOEmRjTKgA1jouM2Pgt0BPFfVIEhHCq6of7LozOSaP8bsRYPZwJww8Jf2vIwNgedBI2vXjxVztD7GLUAOMQrjA2Ca0Nkme9txvdPCwDeM4yVdUk1BzMQHY2bwcaL25BkRD1z9dgIWZQu8n9huCwKW9aMMZIENkudDpxv2C+CtGttaK6Etiz8fborhSpoCnACMruKvu6311yROBk02+LXjev8eBv4bFe4ZWWnMa8BGSNsIJgG+43pnhIE/tyc10Pp1jPuKOQoDf5HjegcJTTDYFewcgTC7WLCXobGO6wXA0YAzgq821kH6T8f1JtUTag0B4RbwLcHaZac+A15t78UjOq63haR7gG368PWNgv2R/tFxvX8JA/+pAeqmgGZJDzqudypwYx2evirCwO/MuM1dgEW/e41Ap8GDYIfH0c1CYJOvPEkXfA/Ycfg9NlchPVV2XIWkXpTjbyRm9VE5SrGBpJmO6zUPcF9HSroa2GsQBnUWMBH4AUTVGl91DwKQkXSR43oHhYHfMcyUpCHhs6qeR+hsYNsKlywHXomPwIyRwrZEGkdPbwWwvqQrnZx3QNhWE4H/KCb9SRgNjI0TND1DW3GF43o7x5ykE1gQh3IAuZg7rcJ1Yy/QHRkUa3i+D4E/x8bjt6ulIBZ98SOCLevOKAw97A3sBzz05Q8p+X6Fc6+Y2YnAS6WGwnE9YbYpMF3SxAQl3AtjD2Bu7zJjFwpuSCIIGCOikIofg/Yt/x6hvzfsQGBmrGjblBiFW4HDeyaZbJykIP673PgtBj4oeYS3gRC4PnqOrnZofKPPCpIt0FVs4RwzHpe4BthiGAtOY+xFHg8Df9mXVz+0fQXy/LGZTQgD/88J8boB7zmudwxwP7BPwtgd7eS8x8O2XjlCZ3tlT7MceNlxvUORzRQ6qAcxF0c4rnd3e/Q97QAZ1xNSJf4Ytre1ticqq2we8BRAe+B3OTlvctjmdwIfOTnvhfa2N8zJNX+3oRfmX7XD2Rl0ZQs8asY4jBvryGpVbHf0DGwNSc92wLGDEtO5XoPjems5bnPWcb3B9L5bkbw4PBt4txdiu8zMLo7Dm3LsivVP0WsY+F8AU2JrXhY/aqeSsGr1vqfNt7BtZWImVo4V56KfrZ3VPMioBrhvSQs9NN6MPwEXZgssjL1JUMwzGeN+iauAzaq02yBRWNLCYuCW0TO4GaCYZ2OJW+Kwr3kQhGVJHPeuGH9J5zmuNysM/E8GIPOUjUO5iUg7CNaP+qplmVzzO2BPmnGv4I/tCRk1x23eCNlF3TG60DeSFMCw652cVxLVcGd3mlTqEad3T2hQU4ZIzAfmA+uVmbt2YAwQ9MtgGa2ItxLkYAPAheQlgoFANQVpBHaNf283KGC8K9EisSewfzHPGcB92QJd2QJdwAPFPM8DP5M4skL7AraPfy9NEY4Exg8Sn+k0OF9waZlF2hw4Bbi4HxWjEThc4hLQ5hWI9Cag3STOBfu143pnhYH/ejl/EDq+lznbUGhS2WevdvMDM1ucmOSSdnJcr6m3VeywzV+ScZt3S9YdLe/H+ekAew9UriBNwDqDqSANNWr0rRhnZgtMN+OfzPg5MFbiLuDGJfmVcW22wCLEcWYcDfxlCKeAXgD7ZU9Z0RmO6/1dPynHSMRVkm4HfZ3ey2eaQAdKetZxvQP6qau2sm+8ViFE2gX4D8f1eg2T2oPWsMJhvQfQdTyzVQrXNahLEw01StM72ULU7WyBT4C8GROBBRLHIV4o5jmwmI/ay86gM1tgphk7WZR1GIp1Sl0GP6ZnKY2LODdejFtdz3GZUL5C6rIaXEl3OK63W3922Iw/AO9USFJMk/SEk/OOcHLe2KbV7P9qWq8GpA2T5gysOPQUJCGDlS3wsBnjDG4GNpG4F/jvYh635LqFGEebcRxRjnlIIWzz3zGzKxPCheNYzYU0ie9Kyid4jc/NrGBmB5jZ7phNNux3CXZ3bUnXOa63dglnmgs8Fv/8NOFrPy25pvtYUEKAl5rZz1i5NlAuC7sJ/UrozQbpKcf1znZcbzvH9UbV655X039sHCcUyvFZv/GcfuAgtSjKx8U8PzAici4xGfh2MU8L8Fi2gGULdAC3F/M8jbhaURHiUFrBvxo4Dvh6aYJC0gWO6x3Rlypdx/VGg6YmjO+HZnZIGPgvlHz2rON6txp2maTTysTLi5/t6jBoXQDsH7ffADwpaXxZ+/8L7Nve1lqtbOYGsL1AR1S5Zm1gd0m7A9OADzI572kz7gXmhYE/YELquJ4kTo1Jf7nmtFLbgt+a8yBL8mxcbOGgYkscTkXe5L44nLqDqKjtQeCqYp51S5RpAcbhZpwAyQWQa8SLBP6nZjY1waoeRF/LG6T9gPIsUydmp5cpR/cztAPnxRmiMkqk79fCDerob2jGJDO7ucbQdwSwKegYSXdLej3jetc6rrfZACjHSMTpoB9WCBFnD3bNXP2WXIwRzMT4n2Ke9UsU4EOMf43JeSBxKuK3xTx7FvORVcwW6MgWuMmMcWY8UsHVrwncacbvygmzpAsd18vUawGBQxPG9jWDB6oI7lLDbk44tTXwtX42CkXgBDM7EvDrpNU5pBZJ8x3XmxxzrQppgTLRMSY4rjc14bg44zZfJ2m+0BUVMpmfEBngQUVfQ6wREscDexbznALMiT1JJ/CrYp7fSEwXTEQ8asa1xTwXZQtRHU62wDvFPIeYseEQ8SLtjutNAT3Cqm952ZmohOH2OixIk2CnhBPzJHVlcs1NVVI3f4yteqnQOTEf+lM/97kTmOW43sPAt4Hj45AqV6PhXE9SAbOxjutdsoplV0XPepAiz1x/fsHsijDw3x9s2VhdLrC5xP2IGcX8ysWjbIH3zfgexvHAZxJnSjxbzLNLiTdZni2sJJBDAPMM7isfH0lTSohyLXO5LrBRwomjidYkKh5Ct5JcgLj5ABqHZWHgzw4D/3Az29LMxhs21bCX4sRANTQS7Sn554GcGMMeAH66JoSiP8hyk+AkReHU3qXh1OgCt8bc5EFga4m5wLRinuyQy2gFfidmFwKfl536BjC5jqbWBTKJoUnUVrVjsyT7K2mdQRqDxWHgPxe2+RdgjDOzrSzijXcmjMsKD6doT82I3kKsPmC5mV2PcWxcgjIsFWSFIEk8JJhezLNOiTd5F+MwM04Elkqch3i6mGfHYssqwtBAP+1DXw34mP08gSif5bhereFg0wD0o2ENGIyuMPD/Egats8Kg9Sgz2w6zShW7O1BarNr33htR0WJgZrPM7DuIk2POtEbQ3/tBMojTBXsX8+SBZ+JU73LghmKepwTXSOyDeNKMy4t5Lge+iN30Gt2fEga+Oa53ueAoYOOSUxsizsJq2prbnmhDzV4heZGuFql5fQh42Lcd1ztS8CKrpsS7eVIz8EYvodJ0oUerEI0QWAS8Hwb+Z0MhshgogWyWmGPGNcU8U7OFyD1nC7xVzDMB4wSJaRIXAkcZLIqJrYaAIHyUcb1Lka4sfR6hEw27qYYmPiXaU9+0qnDorjBonbam+rXOel7DMnEwPTc+GfBgLQIZBv4nmVzzbOC0BJ7k1vAYre1trXMYRqimIF8A58ax58sln38Yx+QjgAuBTSrcP1LiLGCfYp484vnsDCxbIARmFPPMldgV6C6fu7nk3pNZg9tgDW5U9DKD0tX0MZJOqeH2xUTFdM1lIrSt43rqrWo24zb3MBKr1Dn1EcuEEOcI7ZyQITocuKfGppZWCI3a+RKimoJ0dMEvy99qMnoGnwE3x281+SGqqCDd2FZirhlXFPP8JFuIMiPZAm8Cb5ZfHL/VZN81qSBh4C9xXO9Hkmaxasq1lpqqDuA35QoiGG9RmXjFVWjH9Q5GtJSJXlf8Zo+3VrNPnZlc83yi1PWqHAtNdlzvgd62HDtu8wgzxiUUBBu97CcZrhgs8jdK4nyJecU8O3RnuoY4Zhv2WF94jBn30HMRdANBvlIRpON6a0k6n2jr78pDbE0/1bGZ2RySFmfFPoIznZzXWEV5G8AmSexWIax87avmQQYCO0g8Eb+Q7tWhPDBh4Hc4rjcFsQd1v/fKngT+EG9xLaExOg+zNzOud3fppijH9UYKLiNhgdHMbquQxUmy9jIj47jNpSUknWHQ2v33E7HX/mbZfY1Ilwjb1XG9a0AvgS2NqIWNAv4BOFHSYYkyY/YQlV8w2O/I5LwM0V6lWKFtbAJ9bZTYI5PzFkfDSGsY+AuHuoJA9PaJ0cPEgLxsZrdJmlyncn3huN75EvezatnEKEm3YRzpuN59Eh9jbIV0NMmr7+8pKqYsb78rk2t+i2gFvBTjpJJMUsRcLiJ+UUIcOl4k6baEcLERNEFiQsQ7tTiKDDWGxMLBld7D4NL+emdVjciBZlN9++0o0N0lfx9fxnOHVIg1LBFP+jSgrQ+3z8HssoSQpomoFP4XoEeQpldQjqVmdlJ74H9UIVy6l57Fhhlg0xWH2BR6LMrOxOwaqi/njYmTLxv3ohztYKcm7H4cpFzKgFybKkidSvKumU2vd5DDwDeDqYb9BKh3O+pfDfu3MPAfrXLN44bd04f+dBqcjdm01cw8LTKzY8wGv4Dwy0jShzuupfb395YK43JMU8xsItFejd6qlzuA2Wa2e9jmz+q9bU4wsxt6UUAl3Bu2B/4Uw74D9lAdimLAJ4ZdadiOYeDPGuTQakiR9CbBKcWW5II1gwbVtjjUUynFscUWxleaAVH3G+OrYV6CYFo9maEw8P/quM0tEvv1DHWgWgYnjNYwHnZc73FgT2BfiXGgvyVaTFyC2f8Bzxg8Avy+1j0PYeAvdlxvspldDewhaZNVuEX0bPMr3t/mP+e43gSwLYDxQtsjvkn09vS14hY+x1gAvGLYi8AzNWyYes3gvxLSda/005wWgSup8f9r9jZH1aAlLQw3CzBp9AxuGu6WKd5H0QB0DEUrHO9atC+7hxiKWawUrNiP0TmEn68rnaWUg6RIkSpIihSpgqRIkSpIihSDT9JvGEbPayRUAKdIkSJFihQpUgwt/D9wDl8pDiNzdgAAAABJRU5ErkJggg=="/>
<br>
</div>
</body>
</html>
"@

$NewHtmlReport | Out-File "$OutputDirectory\Summary-Report-$TargetDomain.html"
$Time =  Get-Date -UFormat "%m/%d/%Y %R"
Write-Output " [*][$Time]   - Done." 
Write-Output ""
Write-Output ""  
# Write-Output " [*] Saving results to $OutputDirectory\_Report-$TargetDomain-Share-Inventory-Summary.html"     
                
        # ----------------------------------------------------------------------
        # Generate Excessive Privilege Findings
        # ----------------------------------------------------------------------
        if($ExportFindings){ 
                      
             $Time =  Get-Date -UFormat "%m/%d/%Y %R"           
             Write-Output " [*][$Time]   - Generating exccessive privileges export."                    

            # Define excessive priv fields           
            $ExcessivePrivID = "M:2989294"
            $ExcessivePrivName = "Excessive Privileges - Network Shares"
            $ExcessivePrivFinding = "At least one network share has been configured with excessive privileges.  Excessive privileges include shares that are configured to provide the Everyone, BUILTIN\Users, Authenticated Users, or Domain Users groups with access that is not required."
            $ExcessivePrivRecommmend = "Practice the principle of least privileges and only allow users with a defined business need to access the affected shares."
            
            # Create a finding for each instance
            $PrivExport = $ExcessiveSharePrivs |  
            Foreach {

                # Grab default fields
                $ComputerName      =  $_.ComputerName
                $IpAddress         =  $_.IpAddress 
                $ShareName         =  $_.ShareName
                $SharePath         =  $_.SharePath
                $ShareDescription  =  $_.ShareDescription
                $ShareOwner        =  $_.ShareOwner
                $ShareACcess       =  $_.ShareACcess
                $FileSystemRights  =  $_.FileSystemRights
                $AccessControlType =  $_.AccessControlType
                $IdentityReference =  $_.IdentityReference
                $IdentitySID       =  $_.IdentitySID
                $AccessControlType =  $_.AccessControlType
                $LastModifiedDate  =  $_.LastModifiedDate
                $FileCount         =  $_.FileCount
                $FileList          =  $_.FileList 

                # Create new finding object
                $object = New-Object psobject
                $object | add-member noteproperty MasterFindingSourceIdentifier $ExcessivePrivID
                $object | add-member noteproperty InstanceName            "Excessive Share ACL"
                $object | add-member noteproperty AssetName               $ComputerName       
                $object | add-member noteproperty IssueFirstFoundDate     $EndTime
                $object | add-member noteproperty VerificationCaption01   "$IdentityReference has $FileSystemRights privileges on $SharePath." 
                $ShareDetails = @"
Computer Name: $ComputerName
IP Address: $IpAddress 
Share Name: $ShareName
Share Path: $SharePath
Share Description: $ShareDescription
Share Owner $ShareOwner
Share Accses: $ShareACcess
File System Rights: $FileSystemRights
Access Control Type: $AccessControlType
Identify Reference: $IdentityReference
Identity SID: $IdentitySID
Access Control Type: $AccessControlType
Last Modification Date: $LastModifiedDate
File Count: $FileCount
File List Sample: 
$FileList 
"@                
                $object | add-member noteproperty VerificationText01      $ShareDetails
                $object | add-member noteproperty VerificationCaption02   "caption 2"
                $object | add-member noteproperty VerificationText02      "text 2"
                $object | add-member noteproperty VerificationCaption03   "caption 3"
                $object | add-member noteproperty VerificationText03      "text 3"
                $object | add-member noteproperty VerificationCaption04   "caption 4"
                $object | add-member noteproperty VerificationText04      "text 4"
                $object
            }

            # Write export file            
            $PrivExport | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Excessive-Privileges-EXPORT.csv" -Append

            # Create record containing verification summary for domain
            $object = New-Object psobject
            $object | add-member noteproperty MasterFindingSourceIdentifier $ExcessivePrivID
            $object | add-member noteproperty InstanceName            "Domain ACL Summary"
            $object | add-member noteproperty AssetName               $TargetDomain       
            $object | add-member noteproperty IssueFirstFoundDate     $EndTime            
            $object | add-member noteproperty VerificationCaption01   "$ExcessiveSharesCount shares across $ComputerWithExcessive systems are configured with $ExcessiveSharePrivsCount potentially excessive ACLs." 
            $ShareDetails = $ExcessiveSharePrivs | Select-Object SharePath -Unique -ExpandProperty SharePath | Out-String            
            $object | add-member noteproperty VerificationText01      $ShareDetails
            $object | add-member noteproperty VerificationCaption02   "$TargetDomain SMB Share Scan Summary"
            $Summary1 = @"
Target Domain: $TargetDomain

Scan Summary
Start Time: $StartTime
End Time: $EndTime
Run Time: $RunTime

Computer Summary
$ComputerCount domain computers found
$ComputerPingableCount domain computers responded to ping
$Computers445OpenCount domain computers had TCP port 445 accessible         

Share Summary
$AllSMBSharesCount shares were found.
$ExcessiveSharesCount shares across $ComputerWithExcessive systems are configured with $ExcessiveSharePrivsCount potentially excessive ACLs.
$SharesWithWriteCount shares across $ComputerWithWriteCount systems can be written to.</li>
$SharesHighRiskCount shares across $ComputerwithHighRisk systems are considered high risk.
$Top5ShareCountTotal of $AllAccessibleSharesCount ($DupPercent) shares are associated with the top $SampleSum share names.

The 5 most common share names are:

"@

            $Summary2 = $CommonShareNamesTop5 |
            foreach {
                $ShareCount = $_.count
                $ShareName = $_.name
                Write-Output "- $ShareCount $ShareName"   
            } | Out-String                

            $SummaryFinal = $Summary1 + $Summary2

            $object | add-member noteproperty VerificationText02      "$SummaryFinal"
            $object | add-member noteproperty VerificationCaption03   "caption 3"
            $object | add-member noteproperty VerificationText03      "text 3"
            $object | add-member noteproperty VerificationCaption04   "caption 4"
            $object | add-member noteproperty VerificationText04      "text 4"
            
            # Write record to file
            $object | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Excessive-Privileges-EXPORT.csv" -Append
        }

        # ----------------------------------------------------------------------
        # Generate Excessive Privilege Findings - High Risk
        # ----------------------------------------------------------------------
        if($ExportFindings){

            $Time =  Get-Date -UFormat "%m/%d/%Y %R"    
            Write-Output " [*][$Time]   - Generating HIGH RISK exccessive privileges export." 

            # Define excessive priv fields 
            $ExcessivehighRiskID = "MAN:M:e581ab69-a0fc-4cb1-a7ff-87256c1a9e91"
            $ExcessivehighRiskName = "Excessive Privileges - Network Shares - High Risk"
            $ExcessiveHighRiskFinding = "At least one network share has been configured with high risk excessive privileges.  High risk excessive privileges  provide the Everyone, BUILTIN\Users, Authenticated Users, or Domain Users groups with read/write access to system shares, web roots, or directories containing potentially sensitive data."
            $ExcessiveHighRiskRecommmend = "Practice the principle of least privileges and only allow users with a defined business need to access the affected shares."
                

            # Create a finding for each instance
            $PrivHighExport = $SharesHighRisk | 
            Foreach {

                # Grab default fields
                $ComputerName      =  $_.ComputerName
                $IpAddress         =  $_.IpAddress 
                $ShareName         =  $_.ShareName
                $SharePath         =  $_.SharePath
                $ShareDescription  =  $_.ShareDescription
                $ShareOwner        =  $_.ShareOwner
                $ShareACcess       =  $_.ShareACcess
                $FileSystemRights  =  $_.FileSystemRights
                $AccessControlType =  $_.AccessControlType
                $IdentityReference =  $_.IdentityReference
                $IdentitySID       =  $_.IdentitySID
                $AccessControlType =  $_.AccessControlType
                $LastModifiedDate  =  $_.LastModifiedDate
                $FileCount         =  $_.FileCount
                $FileList          =  $_.FileList 

                # Create new finding object
                $object = New-Object psobject
                $object | add-member noteproperty MasterFindingSourceIdentifier $ExcessivehighRiskID
                $object | add-member noteproperty InstanceName            "Excessive Share ACL"
                $object | add-member noteproperty AssetName               $ComputerName       
                $object | add-member noteproperty IssueFirstFoundDate     $EndTime
                $object | add-member noteproperty VerificationCaption01   "$IdentityReference has $FileSystemRights privileges on $SharePath." 
                $ShareDetails = @"
Computer Name: $ComputerName
IP Address: $IpAddress 
Share Name: $ShareName
Share Path: $SharePath
Share Description: $ShareDescription
Share Owner $ShareOwner
Share Accses: $ShareACcess
File System Rights: $FileSystemRights
Access Control Type: $AccessControlType
Identify Reference: $IdentityReference
Identity SID: $IdentitySID
Access Control Type: $AccessControlType
Last Modification Date: $LastModifiedDate
File Count: $FileCount
File List Sample: 
$FileList 
"@                
                $object | add-member noteproperty VerificationText01      $ShareDetails
                $object | add-member noteproperty VerificationCaption02   "caption 2"
                $object | add-member noteproperty VerificationText02      "text 2"
                $object | add-member noteproperty VerificationCaption03   "caption 3"
                $object | add-member noteproperty VerificationText03      "text 3"
                $object | add-member noteproperty VerificationCaption04   "caption 4"
                $object | add-member noteproperty VerificationText04      "text 4"
                $object
            }

            # Write export file            
            $PrivHighExport | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Excessive-Privileges-EXPORT.csv" -Append


            # Create record containing verification summary for domain
            $object = New-Object psobject
            $object | add-member noteproperty MasterFindingSourceIdentifier $ExcessivehighRiskID
            $object | add-member noteproperty InstanceName            "Domain ACL Summary"
            $object | add-member noteproperty AssetName               $TargetDomain       
            $object | add-member noteproperty IssueFirstFoundDate     $EndTime            
            $object | add-member noteproperty VerificationCaption01   "$SharesHighRiskCount shares across $ComputerwithHighRisk systems are considered high risk." 
            $ShareDetails = $SharesHighRisk | Select-Object SharePath -Unique -ExpandProperty SharePath | Out-String            
            $object | add-member noteproperty VerificationText01      $ShareDetails
            $object | add-member noteproperty VerificationCaption02   "$TargetDomain SMB Share Scan Summary"
            $Summary1 = @"
Target Domain: $TargetDomain

Scan Summary
Start Time: $StartTime
End Time: $EndTime
Run Time: $RunTime

Computer Summary
$ComputerCount domain computers found
$ComputerPingableCount domain computers responded to ping
$Computers445OpenCount domain computers had TCP port 445 accessible         

Share Summary
$AllSMBSharesCount shares were found.
$ExcessiveSharesCount shares across $ComputerWithExcessive systems are configured with $ExcessiveSharePrivsCount potentially excessive ACLs.
$SharesWithWriteCount shares across $ComputerWithWriteCount systems can be written to.</li>
$SharesHighRiskCount shares across $ComputerwithHighRisk systems are considered high risk.
$Top5ShareCountTotal of $AllAccessibleSharesCount ($DupPercent) shares are associated with the top $SampleSum share names.

The 5 most common share names are:

"@

            $Summary2 = $CommonShareNamesTop5 |
            foreach {
                $ShareCount = $_.count
                $ShareName = $_.name
                Write-Output "- $ShareCount $ShareName"   
            } | Out-String                

            $SummaryFinal = $Summary1 + $Summary2

            $object | add-member noteproperty VerificationText02      "$SummaryFinal"
            $object | add-member noteproperty VerificationCaption03   "caption 3"
            $object | add-member noteproperty VerificationText03      "text 3"
            $object | add-member noteproperty VerificationCaption04   "caption 4"
            $object | add-member noteproperty VerificationText04      "text 4"
            
            # Write record to file
            $object | Export-Csv -NoTypeInformation "$OutputDirectory\$TargetDomain-Excessive-Privileges-EXPORT.csv" -Append
        }       
        
        #Write-Output " [*] Results exported to $OutputDirectory\$TargetDomain-Excessive-Privileges-EXPORT.csv"               
    }
}


# //////////////////////////////////////////////////////////////////////////
# Functions used by Get-SmbShareInventory
# //////////////////////////////////////////////////////////////////////////

# -------------------------------------------
# Function: Get-CardCreationTime
# -------------------------------------------
function Get-CardCreationTime
{    
    [CmdletBinding()]
    Param(
       [Parameter(Mandatory = $false,
        HelpMessage = 'Data table to parse. This should be the excessive privileges ACL table')]
        $MyDataTable,
        [Parameter(Mandatory = $false,
        HelpMessage = 'Output file path.')]
        [string]$OutFilePath = "Share-ACL-CreationDate-Monthly-Summary.csv"        
    )

# Get list of years for CreationdDate
$ExcessivePrivsAclCount = $MyDataTable | measure | select count -expandproperty count
$ExcessivePrivsYears = $MyDataTable | select CreationDateYear -unique | Sort-Object CreationDateYear
$ExcessivePrivsYearsCount = $ExcessivePrivsYears | measure | select count -expandproperty count
$ExcessivePrivsYearsfirst = $ExcessivePrivsYears | select CreationDateYear -first 1 | select CreationDateYear -ExpandProperty CreationDateYear
$ExcessivePrivsYearsLast  = $ExcessivePrivsYears | select CreationDateYear -last 1 | select CreationDateYear -ExpandProperty CreationDateYear

# Create data table to store summary data for chart scale
$ChartDataSummary  = New-Object System.Data.DataTable
$null = $ChartDataSummary.Columns.Add("Year")
$null = $ChartDataSummary.Columns.Add("Month")
$null = $ChartDataSummary.Columns.Add("Computer")
$null = $ChartDataSummary.Columns.Add("Share")
$null = $ChartDataSummary.Columns.Add("ShareAcl")
$null = $ChartDataSummary.Columns.Add("AclRead")
$null = $ChartDataSummary.Columns.Add("AclWrite")
$null = $ChartDataSummary.Columns.Add("AclHR")

# ///////////////////////// Get bar chart ranges

# Year Loop
$ExcessivePrivsYears |
foreach {

    $TargetYear = $_.CreationDateYear
    $TargetYearData = $MyDataTable | where CreationDateYear -like "$TargetYear" 

    # Month looop
    1..12 |
    foreach {        

        # do last day of month look up here
        $currentMonth = $_
        $monthnames = @(0,"January","February","March","April","May","June","July","August","September","October","November","December")
        $monthdays = @(0,31,28,31,30,31,30,31,31,30,31,30,31)
        $enddays = $monthdays[$_]
        $currentmonthname = $monthnames[$_]

        # setup start and end dates
        [Datetime]$startDate = Get-Date -Year $TargetYear -Month $_ -Day 1
	    [Datetime]$endDate = Get-Date -Year $TargetYear -Month $_ -Day $enddays               

        # get data for the month
        $MonthAcls = $TargetYearData | Where-Object {([Datetime]$_.CreationDate.trim() -ge $startDate -and [Datetime]$_.CreationDate.trim() -le $endDate)}
        
        # Get acl count & and % of total        
        $MonthAclsCount = $MonthAcls | Measure-Object | select count -ExpandProperty count
        if($MonthAclsCount -eq 0){
            $MonthAclsCountP = 0;
        }else{
            $MonthAclsCountP = [math]::Round($MonthAclsCount/$ExcessivePrivsAclCount,4).tostring("P") -replace(" ","")       
        }

        # Get share count
        $MonthShareCount = $MonthAcls | select sharepath -Unique | Measure-Object | select count -ExpandProperty count
        
        # Get computer count        
        $MonthComputerCount = $MonthAcls | select computername -Unique| Measure-Object | select count -ExpandProperty count

        # Get read count
        $MonthAclReadCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*Read*") -or ($_.FileSystemRights -like "*Append*") } | Where-Object {($_.FileSystemRights -notlike "*GenericAll*") -and ($_.FileSystemRights -notlike "*Write*")} |  Measure-Object | select count -ExpandProperty count

        # Get write count 
        $MonthAclWriteCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*")} | Measure-Object | select count -ExpandProperty count

        # Get hr count 
        $MonthAclHrCount = $MonthAcls | Where-Object {($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share')} | Measure-Object | select count -ExpandProperty count            

        # Populate table
        $null = $ChartDataSummary.Rows.Add("$TargetYear","$currentmonthname",$MonthComputerCount,$MonthShareCount,$MonthAclsCount,$MonthAclReadCount,$MonthAclWriteCount,$MonthAclHrCount)

        # Export Results
        $ChartDataSummary | Export-Csv -NoTypeInformation $OutFilePath
    
	} #End Month    
} # End year

# Get highest ShareAcl
$HighestAclCountinMonth = $ChartDataSummary | select shareacl | sort {[int]$_.shareacl} -Descending | select shareacl -First 1 -ExpandProperty shareacl 

# Get highest AclRead
$HighestAclReadCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclRead} -Descending | Select-Object AclRead -First 1 -ExpandProperty AclRead

# Get highest AclWrite
$HighestAclWriteCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclWrite} -Descending | Select-Object AclWrite -First 1 -ExpandProperty AclWrite

# Get highest AclHR
$HighestAclHRCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclHR} -Descending | Select-Object AclHR -First 1 -ExpandProperty AclHR

# Get highst ACL type count
$TypeCounts = $HighestAclReadCountinMonth,$HighestAclWriteCountinMont,$HighestAclHRCountinMonth
$HighestTypeCount = $TypeCounts | Sort-Object {[int]$_} -Descending | select -First 1


# ///////////////////////// Get bar chart data

# Start Table
$HTML1 = @"
<div class="LargeCard" style="width: 90.75%;">	
<span style="margin-left: 50px; font-size:18px;font-weight:bold;color:gray;">Share Creation Timeline</span><br>
		<span style="margin-left: 50px;">for share ACLs configured with excessive privileges</span><br>		

<div class="container" style="position: relative;float:left;bottom:0;left:0;height:195px;width:50px;">
  <div style="top:5;position:absolute;color:#757575;width:100%;font-size:10;" align="right">$HighestAclCountinMonth <span style="color: #ccc">-</span> </div>
  <div style="bottom: 98;position:absolute;color:#757575;border-bottom:1px solid #ccc;width:100%;font-size:10;padding-right:1px;" align="right">0 <span style="color: #ccc">-</span></div>
  <div style="bottom:55;position:absolute;width:100%;font-size:10">
	  <div width="100%" align="right" style="padding-right:3px;color:#757575">High Risk<br></div>
	  <div width="100%" align="right" style="padding-right:3px;color:#757575">Write<br></div>
	  <div width="100%" align="right" style="padding-right:3px;color:#757575">Read<br></div>
  </div>
</div>
<div class="TimelineChart" Style="grid-template-columns: 1px repeat($ExcessivePrivsYearsCount, 204px) 1px;">		
"@

$HTML1

# Year Loop
$ExcessivePrivsYears |
foreach {

    $TargetYear = $_.CreationDateYear
    $TargetYearData = $MyDataTable | where CreationDateYear -like "$TargetYear" 

    # Start Year 
    $HTMLYearStart = @'    
	    <div class="YearItem" >	
			<div id="YearWrapper" style="float:left;background-color:#F2F3F4;">
				<div id="MonthsWrapper" style="position: relative;float:left">

'@
    $HTMLYearStart

    # Month looop
    1..12 |
    foreach {        

        # do last day of month look up here
        $currentMonth = $_
        $monthnames = @(0,"January","February","March","April","May","June","July","August","September","October","November","December")
        $monthdays = @(0,31,28,31,30,31,30,31,31,30,31,30,31)
        $enddays = $monthdays[$_]
        $currentmonthname = $monthnames[$_]

        # setup start and end dates
        [Datetime]$startDate = Get-Date -Year $TargetYear -Month $_ -Day 1
	    [Datetime]$endDate = Get-Date -Year $TargetYear -Month $_ -Day $enddays               

        # get data for the month
        $MonthAcls = $TargetYearData | Where-Object {([Datetime]$_.CreationDate.trim() -ge $startDate -and [Datetime]$_.CreationDate.trim() -le $endDate)}
        
        # Get acl count & and % of total        
        $MonthAclsCount = $MonthAcls | Measure-Object | select count -ExpandProperty count
        if($MonthAclsCount -eq 0){
            $MonthAclsCountP = 0;
        }else{
            $MonthAclsCountP = [math]::Round($MonthAclsCount/$HighestAclCountinMonth,4).tostring("P") -replace(" ","")       
        }

        # Get share count
        $MonthShareCount = $MonthAcls | select sharepath -Unique | Measure-Object | select count -ExpandProperty count
        
        # Get computer count        
        $MonthComputerCount = $MonthAcls | select computername -Unique| Measure-Object | select count -ExpandProperty count

        # Get read count
        $MonthAclReadCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*Read*") -or ($_.FileSystemRights -like "*Append*") } | Where-Object {($_.FileSystemRights -notlike "*GenericAll*") -and ($_.FileSystemRights -notlike "*Write*")} |  Measure-Object | select count -ExpandProperty count
        if($MonthAclReadCount -eq 0){
            $MonthAclReadCountP = 0;
            $ReadDot = "<div class=`"TimelineDot`" style=`"bottom:15px;background-color:gray;`"></div>"
        }else{
            $MonthAclReadCountP = [math]::Round($MonthAclReadCount/$HighestTypeCount,4).tostring("P") -replace(" ","")    
            $ReadDot = "<div class=`"TimelineDot`" style=`"bottom:15px;background-color:Orange;opacity: .25;`"></div>"
        }

        # Get write count 
        $MonthAclWriteCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*")} | Measure-Object | select count -ExpandProperty count
        if($MonthAclWriteCount -eq 0){
            $MonthAclWriteCountP = 0;
            $WriteDot = "<div class=`"TimelineDot`" style=`"bottom:30px;background-color:gray;`"></div>"
        }else{
            $MonthAclWriteCountP = [math]::Round($MonthAclWriteCount/$HighestTypeCount,4).tostring("P") -replace(" ","")       
            $WriteDot = "<div class=`"TimelineDot`" style=`"bottom:30px;background-color:Orange;opacity: .5;`"></div>"
        }

        # Get hr count 
        $MonthAclHrCount = $MonthAcls | Where-Object {($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share')} | Measure-Object | select count -ExpandProperty count            
        if($MonthAclHrCount -eq 0){
            $MonthAclHrCountP = 0;
            $HrDot = "<div class=`"TimelineDot`" style=`"bottom:45px;background-color:gray;`"></div>"
        }else{
            $MonthAclHrCountP = [math]::Round($MonthAclHrCount/$HighestTypeCount,4).tostring("P") -replace(" ","")    
            $HrDot = "<div class=`"TimelineDot`" style=`"bottom:45px;background-color:Orange;opacity: 1;`"></div>"  
        }

        # Debug
        # write-host "$TargetYear - $_ - $startDate to $endDate - a=$MonthAclsCount s=$MonthShareCount c=$MonthComputerCount w=$MonthAclWriteCount r=$MonthAclReadCount hr=$MonthAclHrCount"
        

        # build column
        $HTMLMonth = @"
                    <div id="MonthItem" style="position: relative;float:left;padding-left:1px;padding-right:0px">
						<div class="TimelineBarOutside" >
                            <div class="popwrapper" style="height:90px;position:relative;bottom:0;" >
                                <div class="TimelinePopup" style="position:absolute;">	
                                       <div class="TimelineMinicard">
                                            <div class="TimelineMinicardtitle" align="center">
		                                        $currentmonthname $TargetYear<br>
	                                        </div>
                                            <div class="TimelineMinicardcontainer" align="left">

                                                <div style="margin-top:2px;padding-bottom:1px;">									          	                                                		                                                
                                                <strong>Affected</strong><br>
                                                &nbsp;&nbsp;Computers:  $MonthComputerCount<br>	
                                                &nbsp;&nbsp;Shares:  $MonthShareCount<Br>
                                                &nbsp;&nbsp;ACLs: $MonthAclsCount<Br>	
                                                </div>	

									            <div style="margin-top:1px;padding-bottom:1px;">									          
                                                <strong>ACL Summary</strong><br>
                                                &nbsp;&nbsp;Read: $MonthAclReadCount<br>
									            &nbsp;&nbsp;Write: $MonthAclWriteCount<br>
									            &nbsp;&nbsp;High-Risk: $MonthAclHrCount<br>                                                 
									            </div>						           
									    </div>	
                                    </div>							
								  </div>
							    <div class="TimelineBarInside" style="height:$MonthAclsCountP;width:100%;z-index: 0;"></div>								 	                                    
                            </div>
                            <div style="padding-bottom:15px;">
							    $ReadDot
							    $WriteDot
                                $HrDot
                            </div>
                              	 
						    <div style="font-size:10;bottom:1;position:absolute;padding-left:3px;">$currentMonth</div>
						</div>
					</div>

"@
         $HTMLMonth
    
	} # END MONTH

    
     $HTMLYearEnd = @"           
                </div>    
     			<div id="bottom" align="center">
				$TargetYear
				</div>
			</div>			
         </div> 
"@
    $HTMLYearEnd

} # END YEAR
  

$HTMLEND = @'
</div>
</div>
'@

$HTMLEND

}

# -------------------------------------------
# Function: Get-CardLastAccess
# -------------------------------------------
function Get-CardLastAccess
{    
    [CmdletBinding()]
    Param(
       [Parameter(Mandatory = $false,
        HelpMessage = 'Data table to parse. This should be the excessive privileges ACL table')]
        $MyDataTable,
        [Parameter(Mandatory = $false,
        HelpMessage = 'Output file path.')]
        [string]$OutFilePath = "Share-ACL-LastAccessDate-Monthly-Summary.csv"        
    )

# Get list of years for LastAccessDate - need to actual calculate all years to generate full timeline, even years with no data.
$ExcessivePrivsAclCount = $MyDataTable | measure | select count -expandproperty count
$ExcessivePrivsYears = $MyDataTable | select LastAccessDateYear -unique | Sort-Object LastAccessDateYear
$ExcessivePrivsYearsCount = $ExcessivePrivsYears | measure | select count -expandproperty count
$ExcessivePrivsYearsfirst = $ExcessivePrivsYears | select LastAccessDateYear -first 1 | select LastAccessDateYear -ExpandProperty LastAccessDateYear
$ExcessivePrivsYearsLast  = $ExcessivePrivsYears | select LastAccessDateYear -last 1 | select LastAccessDateYear -ExpandProperty LastAccessDateYear

# Create data table to store summary data for chart scale
$ChartDataSummary  = New-Object System.Data.DataTable
$null = $ChartDataSummary.Columns.Add("Year")
$null = $ChartDataSummary.Columns.Add("Month")
$null = $ChartDataSummary.Columns.Add("Computer")
$null = $ChartDataSummary.Columns.Add("Share")
$null = $ChartDataSummary.Columns.Add("ShareAcl")
$null = $ChartDataSummary.Columns.Add("AclRead")
$null = $ChartDataSummary.Columns.Add("AclWrite")
$null = $ChartDataSummary.Columns.Add("AclHR")

# ///////////////////////// Get bar chart ranges

# Year Loop
$ExcessivePrivsYears |
foreach {

    $TargetYear = $_.LastAccessDateYear
    $TargetYearData = $MyDataTable | where LastAccessDateYear -like "$TargetYear" 

    # Month looop
    1..12 |
    foreach {        

        # do last day of month look up here
        $currentMonth = $_
        $monthnames = @(0,"January","February","March","April","May","June","July","August","September","October","November","December")
        $monthdays = @(0,31,28,31,30,31,30,31,31,30,31,30,31)
        $enddays = $monthdays[$_]
        $currentmonthname = $monthnames[$_]

        # setup start and end dates
        [Datetime]$startDate = Get-Date -Year $TargetYear -Month $_ -Day 1
	    [Datetime]$endDate = Get-Date -Year $TargetYear -Month $_ -Day $enddays               

        # get data for the month
        $MonthAcls = $TargetYearData | Where-Object {([Datetime]$_.LastAccessDate.trim() -ge $startDate -and [Datetime]$_.LastAccessDate.trim() -le $endDate)}
        
        # Get acl count & and % of total        
        $MonthAclsCount = $MonthAcls | Measure-Object | select count -ExpandProperty count
        if($MonthAclsCount -eq 0){
            $MonthAclsCountP = 0;
        }else{
            $MonthAclsCountP = [math]::Round($MonthAclsCount/$ExcessivePrivsAclCount,4).tostring("P") -replace(" ","")       
        }

        # Get share count
        $MonthShareCount = $MonthAcls | select sharepath -Unique | Measure-Object | select count -ExpandProperty count
        
        # Get computer count        
        $MonthComputerCount = $MonthAcls | select computername -Unique| Measure-Object | select count -ExpandProperty count

        # Get read count
        $MonthAclReadCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*Read*") -or ($_.FileSystemRights -like "*Append*") } | Where-Object {($_.FileSystemRights -notlike "*GenericAll*") -and ($_.FileSystemRights -notlike "*Write*")} |  Measure-Object | select count -ExpandProperty count

        # Get write count 
        $MonthAclWriteCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*")} | Measure-Object | select count -ExpandProperty count

        # Get hr count 
        $MonthAclHrCount = $MonthAcls | Where-Object {($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share')} | Measure-Object | select count -ExpandProperty count            

        # Populate table
        $null = $ChartDataSummary.Rows.Add("$TargetYear","$currentmonthname",$MonthComputerCount,$MonthShareCount,$MonthAclsCount,$MonthAclReadCount,$MonthAclWriteCount,$MonthAclHrCount)

        # Export Results
        $ChartDataSummary | Export-Csv -NoTypeInformation $OutFilePath
    
	} #End Month    
} # End year

# Get highest ShareAcl
$HighestAclCountinMonth = $ChartDataSummary | select shareacl | sort {[int]$_.shareacl} -Descending | select shareacl -First 1 -ExpandProperty shareacl 

# Get highest AclRead
$HighestAclReadCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclRead} -Descending | Select-Object AclRead -First 1 -ExpandProperty AclRead

# Get highest AclWrite
$HighestAclWriteCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclWrite} -Descending | Select-Object AclWrite -First 1 -ExpandProperty AclWrite

# Get highest AclHR
$HighestAclHRCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclHR} -Descending | Select-Object AclHR -First 1 -ExpandProperty AclHR

# Get highst ACL type count
$TypeCounts = $HighestAclReadCountinMonth,$HighestAclWriteCountinMont,$HighestAclHRCountinMonth
$HighestTypeCount = $TypeCounts | Sort-Object {[int]$_} -Descending | select -First 1


# ///////////////////////// Get bar chart data

# Start Table
$HTML1 = @"
<div class="LargeCard">	
	<div class="LargeCardTitle" style = "background-color: #07142A">
		Last Access Timeline<br>
		<span class="LargeCardSubtitle2">for share ACLs configured with excessive privileges</span>
	</div>
	<div class="LargeCardContainer" align="center">			

<div class="container" style="position: relative;float:left;bottom:0;left:0;height:195px;width:50px;">
  <div style="top:5;position:absolute;color:#757575;width:100%;font-size:10;" align="right">$HighestAclCountinMonth <span style="color: #ccc">-</span> </div>
  <div style="bottom: 98;position:absolute;color:#757575;border-bottom:1px solid #ccc;width:100%;font-size:10;padding-right:1px;" align="right">0 <span style="color: #ccc">-</span></div>
  <div style="bottom:55;position:absolute;width:100%;font-size:10">
	  <div width="100%" align="right" style="padding-right:3px;color:#757575">High Risk<br></div>
	  <div width="100%" align="right" style="padding-right:3px;color:#757575">Write<br></div>
	  <div width="100%" align="right" style="padding-right:3px;color:#757575">Read<br></div>
  </div>
</div>
<div class="TimelineChart" Style="grid-template-columns: 1px repeat($ExcessivePrivsYearsCount, 204px) 1px;">		
"@

$HTML1

# Year Loop
$ExcessivePrivsYears |
foreach {

    $TargetYear = $_.LastAccessDateYear
    $TargetYearData = $MyDataTable | where LastAccessDateYear -like "$TargetYear" 

    # Start Year 
    $HTMLYearStart = @'    
	    <div class="YearItem" >	
			<div id="YearWrapper" style="float:left;background-color:#F2F3F4;">
				<div id="MonthsWrapper" style="position: relative;float:left">

'@
    $HTMLYearStart

    # Month looop
    1..12 |
    foreach {        

        # do last day of month look up here
        $currentMonth = $_
        $monthnames = @(0,"January","February","March","April","May","June","July","August","September","October","November","December")
        $monthdays = @(0,31,28,31,30,31,30,31,31,30,31,30,31)
        $enddays = $monthdays[$_]
        $currentmonthname = $monthnames[$_]

        # setup start and end dates
        [Datetime]$startDate = Get-Date -Year $TargetYear -Month $_ -Day 1
	    [Datetime]$endDate = Get-Date -Year $TargetYear -Month $_ -Day $enddays               

        # get data for the month
        $MonthAcls = $TargetYearData | Where-Object {([Datetime]$_.LastAccessDate.trim() -ge $startDate -and [Datetime]$_.LastAccessDate.trim() -le $endDate)}
        
        # Get acl count & and % of total        
        $MonthAclsCount = $MonthAcls | Measure-Object | select count -ExpandProperty count
        if($MonthAclsCount -eq 0){
            $MonthAclsCountP = 0;
        }else{
            $MonthAclsCountP = [math]::Round($MonthAclsCount/$HighestAclCountinMonth,4).tostring("P") -replace(" ","")       
        }

        # Get share count
        $MonthShareCount = $MonthAcls | select sharepath -Unique | Measure-Object | select count -ExpandProperty count
        
        # Get computer count        
        $MonthComputerCount = $MonthAcls | select computername -Unique| Measure-Object | select count -ExpandProperty count

        # Get read count
        $MonthAclReadCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*Read*") -or ($_.FileSystemRights -like "*Append*") } | Where-Object {($_.FileSystemRights -notlike "*GenericAll*") -and ($_.FileSystemRights -notlike "*Write*")} |  Measure-Object | select count -ExpandProperty count
        if($MonthAclReadCount -eq 0){
            $MonthAclReadCountP = 0;
            $ReadDot = "<div class=`"TimelineDot`" style=`"bottom:15px;background-color:gray;`"></div>"
        }else{
            $MonthAclReadCountP = [math]::Round($MonthAclReadCount/$HighestTypeCount,4).tostring("P") -replace(" ","")    
            $ReadDot = "<div class=`"TimelineDot`" style=`"bottom:15px;background-color:Orange;opacity: .25;`"></div>"
        }

        # Get write count 
        $MonthAclWriteCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*")} | Measure-Object | select count -ExpandProperty count
        if($MonthAclWriteCount -eq 0){
            $MonthAclWriteCountP = 0;
            $WriteDot = "<div class=`"TimelineDot`" style=`"bottom:30px;background-color:gray;`"></div>"
        }else{
            $MonthAclWriteCountP = [math]::Round($MonthAclWriteCount/$HighestTypeCount,4).tostring("P") -replace(" ","")       
            $WriteDot = "<div class=`"TimelineDot`" style=`"bottom:30px;background-color:Orange;opacity: .5;`"></div>"
        }

        # Get hr count 
        $MonthAclHrCount = $MonthAcls | Where-Object {($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share')} | Measure-Object | select count -ExpandProperty count            
        if($MonthAclHrCount -eq 0){
            $MonthAclHrCountP = 0;
            $HrDot = "<div class=`"TimelineDot`" style=`"bottom:45px;background-color:gray;`"></div>"
        }else{
            $MonthAclHrCountP = [math]::Round($MonthAclHrCount/$HighestTypeCount,4).tostring("P") -replace(" ","")    
            $HrDot = "<div class=`"TimelineDot`" style=`"bottom:45px;background-color:Orange;opacity: 1;`"></div>"  
        }

        # Debug
        # write-host "$TargetYear - $_ - $startDate to $endDate - a=$MonthAclsCount s=$MonthShareCount c=$MonthComputerCount w=$MonthAclWriteCount r=$MonthAclReadCount hr=$MonthAclHrCount"
        

        # build column
        $HTMLMonth = @"
                    <div id="MonthItem" style="position: relative;float:left;padding-left:1px;padding-right:0px">
						<div class="TimelineBarOutside" >
                            <div class="popwrapper" style="height:90px;position:relative;bottom:0;" >
                                <div class="TimelinePopup" style="position:absolute;">	
                                       <div class="TimelineMinicard">
                                            <div class="TimelineMinicardtitle" align="center">
		                                        $currentmonthname $TargetYear<br>
	                                        </div>
                                            <div class="TimelineMinicardcontainer" align="left">

                                                <div style="margin-top:2px;padding-bottom:1px;">									          	                                                		                                                
                                                <strong>Affected</strong><br>
                                                &nbsp;&nbsp;Computers:  $MonthComputerCount<br>	
                                                &nbsp;&nbsp;Shares:  $MonthShareCount<Br>
                                                &nbsp;&nbsp;ACLs: $MonthAclsCount<Br>	
                                                </div>	

									            <div style="margin-top:1px;padding-bottom:1px;">									          
                                                <strong>ACL Summary</strong><br>
                                                &nbsp;&nbsp;Read: $MonthAclReadCount<br>
									            &nbsp;&nbsp;Write: $MonthAclWriteCount<br>
									            &nbsp;&nbsp;High-Risk: $MonthAclHrCount<br>                                                 
									            </div>						           
									    </div>	
                                    </div>							
								  </div>
							    <div class="TimelineBarInside" style="height:$MonthAclsCountP;width:100%;z-index: 0;"></div>								 	                                    
                            </div>
                            <div style="padding-bottom:15px;">
							    $ReadDot
							    $WriteDot
                                $HrDot
                            </div>
                              	 
						    <div style="font-size:10;bottom:1;position:absolute;padding-left:3px;">$currentMonth</div>
						</div>
					</div>

"@
         $HTMLMonth
    
	} # END MONTH

    
     $HTMLYearEnd = @"           
                </div>    
     			<div id="bottom" align="center">
				$TargetYear
				</div>
			</div>			
         </div> 
"@
    $HTMLYearEnd

} # END YEAR
  

$HTMLEND = @'
</div>
</div>
</div>
'@

$HTMLEND

}

# -------------------------------------------
# Function: Get-CardLastModified
# -------------------------------------------
function Get-CardLastModified
{    
    [CmdletBinding()]
    Param(
       [Parameter(Mandatory = $true,
        HelpMessage = 'Data table to parse. This should be the excessive privileges ACL table.')]
        $MyDataTable,   
        [Parameter(Mandatory = $false,
        HelpMessage = 'Output file path.')]
        [string]$OutFilePath = "Share-ACL-LastModifiedDate-Monthly-Summary.csv"  
    )

    # Get list of years for LastModifiedDate - need to actual calculate all years to generate full timeline, even years with no data.
    $ExcessivePrivsAclCount = $MyDataTable | measure | select count -expandproperty count
    $ExcessivePrivsYears = $MyDataTable | select LastModifiedDateYear -unique | Sort-Object LastModifiedDateYear
    $ExcessivePrivsYearsCount = $ExcessivePrivsYears | measure | select count -expandproperty count
    $ExcessivePrivsYearsfirst = $ExcessivePrivsYears | select LastModifiedDateYear -first 1 | select LastModifiedDateYear -ExpandProperty LastModifiedDateYear
    $ExcessivePrivsYearsLast  = $ExcessivePrivsYears | select LastModifiedDateYear -last 1 | select LastModifiedDateYear -ExpandProperty LastModifiedDateYear

    # Create data table to store summary data for chart scale
    $ChartDataSummary  = New-Object System.Data.DataTable
    $null = $ChartDataSummary.Columns.Add("Year")
    $null = $ChartDataSummary.Columns.Add("Month")
    $null = $ChartDataSummary.Columns.Add("Computer")
    $null = $ChartDataSummary.Columns.Add("Share")
    $null = $ChartDataSummary.Columns.Add("ShareAcl")
    $null = $ChartDataSummary.Columns.Add("AclRead")
    $null = $ChartDataSummary.Columns.Add("AclWrite")
    $null = $ChartDataSummary.Columns.Add("AclHR")

    # ///////////////////////// Get bar chart ranges

    # Year Loop
    $ExcessivePrivsYears |
    foreach {

        $TargetYear = $_.LastModifiedDateYear
        $TargetYearData = $MyDataTable | where LastModifiedDateYear -like "$TargetYear" 

        # Month looop
        1..12 |
        foreach {        

            # do last day of month look up here
            $currentMonth = $_
            $monthnames = @(0,"January","February","March","April","May","June","July","August","September","October","November","December")
            $monthdays = @(0,31,28,31,30,31,30,31,31,30,31,30,31)
            $enddays = $monthdays[$_]
            $currentmonthname = $monthnames[$_]

            # setup start and end dates
            [Datetime]$startDate = Get-Date -Year $TargetYear -Month $_ -Day 1
	        [Datetime]$endDate = Get-Date -Year $TargetYear -Month $_ -Day $enddays               

            # get data for the month
            $MonthAcls = $TargetYearData | Where-Object {([Datetime]$_.LastModifiedDate.trim() -ge $startDate -and [Datetime]$_.LastModifiedDate.trim() -le $endDate)}
        
            # Get acl count & and % of total        
            $MonthAclsCount = $MonthAcls | Measure-Object | select count -ExpandProperty count
            if($MonthAclsCount -eq 0){
                $MonthAclsCountP = 0;
            }else{
                $MonthAclsCountP = [math]::Round($MonthAclsCount/$ExcessivePrivsAclCount,4).tostring("P") -replace(" ","")       
            }

            # Get share count
            $MonthShareCount = $MonthAcls | select sharepath -Unique | Measure-Object | select count -ExpandProperty count
        
            # Get computer count        
            $MonthComputerCount = $MonthAcls | select computername -Unique| Measure-Object | select count -ExpandProperty count

            # Get read count
            $MonthAclReadCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*Read*") -or ($_.FileSystemRights -like "*Append*") } | Where-Object {($_.FileSystemRights -notlike "*GenericAll*") -and ($_.FileSystemRights -notlike "*Write*")} |  Measure-Object | select count -ExpandProperty count

            # Get write count 
            $MonthAclWriteCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*")} | Measure-Object | select count -ExpandProperty count

            # Get hr count 
            $MonthAclHrCount = $MonthAcls | Where-Object {($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share')} | Measure-Object | select count -ExpandProperty count            

            # Populate table
            $null = $ChartDataSummary.Rows.Add("$TargetYear","$currentmonthname",$MonthComputerCount,$MonthShareCount,$MonthAclsCount,$MonthAclReadCount,$MonthAclWriteCount,$MonthAclHrCount)

            # Export Results
            $ChartDataSummary | Export-Csv -NoTypeInformation $OutFilePath
    
	    } #End Month  Loop   
    } # End ear loop

    # Get highest ShareAcl
    $HighestAclCountinMonth = $ChartDataSummary | select shareacl | sort {[int]$_.shareacl} -Descending | select shareacl -First 1 -ExpandProperty shareacl 

    # Get highest AclRead
    $HighestAclReadCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclRead} -Descending | Select-Object AclRead -First 1 -ExpandProperty AclRead

    # Get highest AclWrite
    $HighestAclWriteCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclWrite} -Descending | Select-Object AclWrite -First 1 -ExpandProperty AclWrite

    # Get highest AclHR
    $HighestAclHRCountinMonth = $ChartDataSummary | Sort-Object {[int]$_.AclHR} -Descending | Select-Object AclHR -First 1 -ExpandProperty AclHR

    # Get highst ACL type count
    $TypeCounts = $HighestAclReadCountinMonth,$HighestAclWriteCountinMont,$HighestAclHRCountinMonth
    $HighestTypeCount = $TypeCounts | Sort-Object {[int]$_} -Descending | select -First 1


    # ///////////////////////// Get bar chart data

    # Start Table
    $HTML1 = @"
    <div class="LargeCard" style="width: 90.75%;">	
	    <span style="margin-left: 50px; font-size:18px;font-weight:bold;color:gray;">Last Modified Timeline</span><br>
		<span style="margin-left: 50px;">for share ACLs configured with excessive privileges</span><br>	 		
    <div class="container" style="position: relative;float:left;bottom:0;left:0;height:195px;width:50px;">
      <div style="top:5;position:absolute;color:#757575;width:100%;font-size:10;" align="right">$HighestAclCountinMonth <span style="color: #ccc">-</span> </div>
      <div style="bottom: 98;position:absolute;color:#757575;border-bottom:1px solid #ccc;width:100%;font-size:10;padding-right:1px;" align="right">0 <span style="color: #ccc">-</span></div>
      <div style="bottom:55;position:absolute;width:100%;font-size:10">
	      <div width="100%" align="right" style="padding-right:3px;color:#757575">High Risk<br></div>
	      <div width="100%" align="right" style="padding-right:3px;color:#757575">Write<br></div>
	      <div width="100%" align="right" style="padding-right:3px;color:#757575">Read<br></div>
      </div>
    </div>
    <div class="TimelineChart" Style="grid-template-columns: 1px repeat($ExcessivePrivsYearsCount, 204px) 1px;">		
"@

    $HTML1

    # Year Loop
    $ExcessivePrivsYears |
    foreach {

        $TargetYear = $_.LastModifiedDateYear
        $TargetYearData = $MyDataTable | where LastModifiedDateYear -like "$TargetYear" 

        # Start Year 
        $HTMLYearStart = @'    
	        <div class="YearItem" >	
			    <div id="YearWrapper" style="float:left;background-color:#F2F3F4;">
				    <div id="MonthsWrapper" style="position: relative;float:left">

'@
        $HTMLYearStart

        # Month looop
        1..12 |
        foreach {        

            # do last day of month look up here
            $currentMonth = $_
            $monthnames = @(0,"January","February","March","April","May","June","July","August","September","October","November","December")
            $monthdays = @(0,31,28,31,30,31,30,31,31,30,31,30,31)
            $enddays = $monthdays[$_]
            $currentmonthname = $monthnames[$_]

            # setup start and end dates
            [Datetime]$startDate = Get-Date -Year $TargetYear -Month $_ -Day 1
	        [Datetime]$endDate = Get-Date -Year $TargetYear -Month $_ -Day $enddays               

            # get data for the month
            $MonthAcls = $TargetYearData | Where-Object {([Datetime]$_.LastModifiedDate.trim() -ge $startDate -and [Datetime]$_.LastModifiedDate.trim() -le $endDate)}
        
            # Get acl count & and % of total        
            $MonthAclsCount = $MonthAcls | Measure-Object | select count -ExpandProperty count
            if($MonthAclsCount -eq 0){
                $MonthAclsCountP = 0;
            }else{
                $MonthAclsCountP = [math]::Round($MonthAclsCount/$HighestAclCountinMonth,4).tostring("P") -replace(" ","")       
            }

            # Get share count
            $MonthShareCount = $MonthAcls | select sharepath -Unique | Measure-Object | select count -ExpandProperty count
        
            # Get computer count        
            $MonthComputerCount = $MonthAcls | select computername -Unique| Measure-Object | select count -ExpandProperty count

            # Get read count
            $MonthAclReadCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*Read*") -or ($_.FileSystemRights -like "*Append*") } | Where-Object {($_.FileSystemRights -notlike "*GenericAll*") -and ($_.FileSystemRights -notlike "*Write*")} |  Measure-Object | select count -ExpandProperty count
            if($MonthAclReadCount -eq 0){
                $MonthAclReadCountP = 0;
                $ReadDot = "<div class=`"TimelineDot`" style=`"bottom:15px;background-color:gray;`"></div>"
            }else{
                $MonthAclReadCountP = [math]::Round($MonthAclReadCount/$HighestTypeCount,4).tostring("P") -replace(" ","")    
                $ReadDot = "<div class=`"TimelineDot`" style=`"bottom:15px;background-color:Orange;opacity: .25;`"></div>"
            }

            # Get write count 
            $MonthAclWriteCount = $MonthAcls | Where-Object {($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*")} | Measure-Object | select count -ExpandProperty count
            if($MonthAclWriteCount -eq 0){
                $MonthAclWriteCountP = 0;
                $WriteDot = "<div class=`"TimelineDot`" style=`"bottom:30px;background-color:gray;`"></div>"
            }else{
                $MonthAclWriteCountP = [math]::Round($MonthAclWriteCount/$HighestTypeCount,4).tostring("P") -replace(" ","")       
                $WriteDot = "<div class=`"TimelineDot`" style=`"bottom:30px;background-color:Orange;opacity: .5;`"></div>"
            }

            # Get hr count 
            $MonthAclHrCount = $MonthAcls | Where-Object {($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share')} | Measure-Object | select count -ExpandProperty count            
            if($MonthAclHrCount -eq 0){
                $MonthAclHrCountP = 0;
                $HrDot = "<div class=`"TimelineDot`" style=`"bottom:45px;background-color:gray;`"></div>"
            }else{
                $MonthAclHrCountP = [math]::Round($MonthAclHrCount/$HighestTypeCount,4).tostring("P") -replace(" ","")    
                $HrDot = "<div class=`"TimelineDot`" style=`"bottom:45px;background-color:Orange;opacity: 1;`"></div>"  
            }

            # Debug
            # write-host "$TargetYear - $_ - $startDate to $endDate - a=$MonthAclsCount s=$MonthShareCount c=$MonthComputerCount w=$MonthAclWriteCount r=$MonthAclReadCount hr=$MonthAclHrCount"
        

            # build column
            $HTMLMonth = @"
                        <div id="MonthItem" style="position: relative;float:left;padding-left:1px;padding-right:0px">
						    <div class="TimelineBarOutside" >
                                <div class="popwrapper" style="height:90px;position:relative;bottom:0;" >
                                    <div class="TimelinePopup" style="position:absolute;">	
                                           <div class="TimelineMinicard">
                                                <div class="TimelineMinicardtitle" align="center">
		                                            $currentmonthname $TargetYear<br>
	                                            </div>
                                                <div class="TimelineMinicardcontainer" align="left">

                                                    <div style="margin-top:2px;padding-bottom:1px;">									          	                                                		                                                
                                                    <strong>Affected</strong><br>
                                                    &nbsp;&nbsp;Computers:  $MonthComputerCount<br>	
                                                    &nbsp;&nbsp;Shares:  $MonthShareCount<Br>
                                                    &nbsp;&nbsp;ACLs: $MonthAclsCount<Br>	
                                                    </div>	

									                <div style="margin-top:1px;padding-bottom:1px;">									          
                                                    <strong>ACL Summary</strong><br>
                                                    &nbsp;&nbsp;Read: $MonthAclReadCount<br>
									                &nbsp;&nbsp;Write: $MonthAclWriteCount<br>
									                &nbsp;&nbsp;High-Risk: $MonthAclHrCount<br>                                                 
									                </div>						           
									        </div>	
                                        </div>							
								      </div>
							        <div class="TimelineBarInside" style="height:$MonthAclsCountP;width:100%;z-index: 0;"></div>								 	                                    
                                </div>
                                <div style="padding-bottom:15px;">
							        $ReadDot
							        $WriteDot
                                    $HrDot
                                </div>
                              	 
						        <div style="font-size:10;bottom:1;position:absolute;padding-left:3px;">$currentMonth</div>
						    </div>
					    </div>

"@
             $HTMLMonth
    
	    } #END MONTH LOOP

         
         $HTMLYearEnd = @"           
                    </div>    
     			    <div id="bottom" align="center">
				    $TargetYear
				    </div>
			    </div>			
             </div> 
"@
        $HTMLYearEnd

    } # End YEAR LOOP
  

    # End Page

    $HTMLEND = @'
    </div>
    </div>
'@

    $HTMLEND    
}

# -------------------------------------------
# Function: Get-PercentDisplay
# -------------------------------------------
function Get-PercentDisplay
{
    param (
        $TargetCount,
        $FullCount
    )

    if($FullCount -ne 0){
        $Percent = [math]::Round($TargetCount/$FullCount,4)
        $PercentString = $Percent.tostring("P") -replace(" ","")
        $PercentBarVal = ($Percent *2).tostring("P") -replace(" %","px")
    }

    # Return object with all counts
    $TheCounts = new-object psobject            
    $TheCounts | add-member  Noteproperty PercentString         $PercentString
    $TheCounts | add-member  Noteproperty PercentBarVal         $PercentBarVal    
    $TheCounts
}

# -------------------------------------------
# Function: Get-ExPrivSumData
# -------------------------------------------
# get the computer, share, and acl summary data for a provided data table
function Get-ExPrivSumData
{
    param (
        $DataTable,
        $AllComputerCount,
        $AllShareCount,
        $AllAclCount
    )

    # Get acl counts
    $UserAcls = $DataTable 
    $UserAclsCount = $UserAcls | measure | select count -ExpandProperty count
    $UserAclsPercent = [math]::Round($UserAclsCount/$AllAclCount,4)
    $UserAclsPercentString = $UserAclsPercent.tostring("P") -replace(" ","")
    $UserAclsPercentBarVal = ($UserAclsPercent *2).tostring("P") -replace(" %","px")
    $UserAclsPercentBarCode = "<span class=`"dashboardsub2`">$UserAclsPercentString ($UserAclsCount of $AllAclCount)</span><br><div class=`"cardbarouter`"><div class=`"cardbarinside`" style=`"width: $UserAclsPercentString;`"></div></div>"

    # Get share counts
    $UserShare = $UserAcls | Select-Object SharePath -Unique
    $UserShareCount = $UserShare | measure | select count -ExpandProperty count
    $UserSharePercent = [math]::Round($UserShareCount/$AllShareCount,4)
    $UserSharePercentString = $UserSharePercent.tostring("P") -replace(" ","")
    $UserSharePercentBarVal = ($UserSharePercent *2).tostring("P") -replace(" %","px")
    $UserSharePercentBarCode = "<span class=`"dashboardsub2`">$UserSharePercentString ($UserShareCount of $AllShareCount)</span><br><div class=`"cardbarouter`"><div class=`"cardbarinside`" style=`"width: $UserSharePercentString;`"></div></div>"

    # Get computer counts
    $UserComputer = $UserAcls | Select-Object ComputerName -Unique
    $UserComputerCount = $UserComputer | measure | select count -ExpandProperty count   
    $UserComputerPercent = [math]::Round($UserComputerCount/$AllComputerCount,4)
    $UserComputerPercentString = $UserComputerPercent.tostring("P") -replace(" ","")
    $UserComputerPercentBarVal = ($UserComputerPercent *2).tostring("P") -replace(" %","px")
    $UserComputerPercentBarCode = "<span class=`"dashboardsub2`">$UserComputerPercentString ($UserComputerCount of $AllComputerCount)</span><br><div class=`"cardbarouter`"><div class=`"cardbarinside`" style=`"width: $UserComputerPercentString;`"></div></div>"

    # Return object with all counts
    $TheCounts = new-object psobject            
    $TheCounts | add-member  Noteproperty ComputerBar   $UserComputerPercentBarCode
    $TheCounts | add-member  Noteproperty ShareBar      $UserSharePercentBarCode    
    $TheCounts | add-member  Noteproperty AclBar        $UserAclsPercentBarCode
    $TheCounts
}

# -------------------------------------------
# Function: Get-GroupOwnerBar
# -------------------------------------------
function Get-GroupOwnerBar
{
    param (
        $DataTable,
        $Name,
        $AllComputerCount,
        $AllShareCount,
        $AllAclCount
    )

    # Get acl counts
    $UserAcls = $DataTable | Where ShareOwner -like "$Name" | Select-Object ComputerName,ShareOwner,SharePath,FileSystemRights
    $UserAclsCount = $UserAcls | measure | select count -ExpandProperty count
    $UserAclsPercent = [math]::Round($UserAclsCount/$AllAclCount,4)
    $UserAclsPercentString = $UserAclsPercent.tostring("P") -replace(" ","")
    $UserAclsPercentBarVal = ($UserAclsPercent *2).tostring("P") -replace(" %","px")
    $UserAclsPercentBarCode = "<span class=`"dashboardsub2`">$UserAclsPercentString ($UserAclsCount of $AllAclCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserAclsPercentString;`"></div></div>"

    # Get share counts
    $UserShare = $UserAcls | Select-Object SharePath -Unique
    $UserShareCount = $UserShare | measure | select count -ExpandProperty count
    $UserSharePercent = [math]::Round($UserShareCount/$AllShareCount,4)
    $UserSharePercentString = $UserSharePercent.tostring("P") -replace(" ","")
    $UserSharePercentBarVal = ($UserSharePercent *2).tostring("P") -replace(" %","px")
    $UserSharePercentBarCode = "<span class=`"dashboardsub2`">$UserSharePercentString ($UserShareCount of $AllShareCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserSharePercentString;`"></div></div>"

    # Get computer counts
    $UserComputer = $UserAcls | Select-Object ComputerName -Unique
    $UserComputerCount = $UserComputer | measure | select count -ExpandProperty count   
    $UserComputerPercent = [math]::Round($UserComputerCount/$AllComputerCount,4)
    $UserComputerPercentString = $UserComputerPercent.tostring("P") -replace(" ","")
    $UserComputerPercentBarVal = ($UserComputerPercent *2).tostring("P") -replace(" %","px")
    $UserComputerPercentBarCode = "<span class=`"dashboardsub2`">$UserComputerPercentString ($UserComputerCount of $AllComputerCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserComputerPercentString;`"></div></div>"

    # Return object with all counts
    $TheCounts = new-object psobject            
    $TheCounts | add-member  Noteproperty ComputerBar   $UserComputerPercentBarCode
    $TheCounts | add-member  Noteproperty ShareBar      $UserSharePercentBarCode    
    $TheCounts | add-member  Noteproperty AclBar        $UserAclsPercentBarCode
    $TheCounts
}

# -------------------------------------------
# Function: Get-GroupNameBar
# -------------------------------------------
function Get-GroupNameBar
{
    param (
        $DataTable,
        $Name,
        $AllComputerCount,
        $AllShareCount,
        $AllAclCount
    )

    # Get acl counts
    $UserAcls = $DataTable | Where ShareName -like "$Name" | Select-Object ComputerName, ShareName, SharePath, FileSystemRights
    $UserAclsCount = $UserAcls | measure | select count -ExpandProperty count
    $UserAclsPercent = [math]::Round($UserAclsCount/$AllAclCount,4)
    $UserAclsPercentString = $UserAclsPercent.tostring("P") -replace(" ","")
    $UserAclsPercentBarVal = ($UserAclsPercent *2).tostring("P") -replace(" %","px")
    $UserAclsPercentBarCode = "<span class=`"dashboardsub2`">$UserAclsPercentString ($UserAclsCount of $AllAclCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserAclsPercentString;`"></div></div>"

    # Get share counts
    $UserShare = $UserAcls | Select-Object SharePath -Unique
    $UserShareCount = $UserShare | measure | select count -ExpandProperty count
    $UserSharePercent = [math]::Round($UserShareCount/$AllShareCount,4)
    $UserSharePercentString = $UserSharePercent.tostring("P") -replace(" ","")
    $UserSharePercentBarVal = ($UserSharePercent *2).tostring("P") -replace(" %","px")
    $UserSharePercentBarCode = "<span class=`"dashboardsub2`">$UserSharePercentString ($UserShareCount of $AllShareCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserSharePercentString;`"></div></div>"

    # Get computer counts
    $UserComputer = $UserAcls | Select-Object ComputerName -Unique
    $UserComputerCount = $UserComputer | measure | select count -ExpandProperty count   
    $UserComputerPercent = [math]::Round($UserComputerCount/$AllComputerCount,4)
    $UserComputerPercentString = $UserComputerPercent.tostring("P") -replace(" ","")
    $UserComputerPercentBarVal = ($UserComputerPercent *2).tostring("P") -replace(" %","px")
    $UserComputerPercentBarCode = "<span class=`"dashboardsub2`">$UserComputerPercentString ($UserComputerCount of $AllComputerCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserComputerPercentString;`"></div></div>"

    # Return object with all counts
    $TheCounts = new-object psobject            
    $TheCounts | add-member  Noteproperty ComputerBar   $UserComputerPercentBarCode
    $TheCounts | add-member  Noteproperty ShareBar      $UserSharePercentBarCode    
    $TheCounts | add-member  Noteproperty AclBar        $UserAclsPercentBarCode
    $TheCounts
}

# -------------------------------------------
# Function: Get-GroupNameNoBar
# -------------------------------------------
function Get-GroupNameNoBar
{
    param (
        $DataTable,
        $Name,
        $AllComputerCount,
        $AllShareCount,
        $AllAclCount
    )

    # Get acl counts
    $UserAcls = $DataTable | Where ShareName -like "$Name" | Select-Object ComputerName, ShareName, SharePath, FileSystemRights
    $UserAclsCount = $UserAcls | measure | select count -ExpandProperty count
    $UserAclsPercent = [math]::Round($UserAclsCount/$AllAclCount,4)
    $UserAclsPercentString = $UserAclsPercent.tostring("P") -replace(" ","")
    $UserAclsPercentBarVal = ($UserAclsPercent *2).tostring("P") -replace(" %","px")
    $UserAclsPercentBarCode = "$UserAclsCount of $AllAclCount ($UserAclsPercentString)"

    # Get share counts
    $UserShare = $UserAcls | Select-Object SharePath -Unique
    $UserShareCount = $UserShare | measure | select count -ExpandProperty count
    $UserSharePercent = [math]::Round($UserShareCount/$AllShareCount,4)
    $UserSharePercentString = $UserSharePercent.tostring("P") -replace(" ","")
    $UserSharePercentBarVal = ($UserSharePercent *2).tostring("P") -replace(" %","px")
    $UserSharePercentBarCode = "$UserShareCount of $AllShareCount ($UserSharePercentString)"

    # Get computer counts
    $UserComputer = $UserAcls | Select-Object ComputerName -Unique
    $UserComputerCount = $UserComputer | measure | select count -ExpandProperty count   
    $UserComputerPercent = [math]::Round($UserComputerCount/$AllComputerCount,4)
    $UserComputerPercentString = $UserComputerPercent.tostring("P") -replace(" ","")
    $UserComputerPercentBarVal = ($UserComputerPercent *2).tostring("P") -replace(" %","px")
    $UserComputerPercentBarCode = "$UserComputerCount of $AllComputerCount ($UserComputerPercentString)"

    # Return object with all counts
    $TheCounts = new-object psobject            
    $TheCounts | add-member  Noteproperty ComputerBar   $UserComputerPercentBarCode
    $TheCounts | add-member  Noteproperty ShareBar      $UserSharePercentBarCode    
    $TheCounts | add-member  Noteproperty AclBar        $UserAclsPercentBarCode
    $TheCounts
}

# -------------------------------------------
# Function: Get-GroupFileBar
# -------------------------------------------
function Get-GroupFileBar
{
    param (
        $DataTable,
        $Name,
        $AllComputerCount,
        $AllShareCount,
        $AllAclCount
    )

    # Get acl counts
    $UserAcls = $DataTable | Where FileListGroup -like "$Name" | Select-Object ComputerName, ShareName, SharePath, FileSystemRights, FileCount, FileList
    $FolderInfo = $UserAcls | select FileCount, FileList -First 1
    $FileCount = $FolderInfo.FileCount 
    $FileList = $FolderInfo.FileList 
    $UserAclsCount = $UserAcls | measure | select count -ExpandProperty count
    $UserAclsPercent = [math]::Round($UserAclsCount/$AllAclCount,4)
    $UserAclsPercentString = $UserAclsPercent.tostring("P") -replace(" ","")
    $UserAclsPercentBarVal = ($UserAclsPercent *2).tostring("P") -replace(" %","px")
    $UserAclsPercentBarCode = "<span class=`"dashboardsub2`">$UserAclsPercentString ($UserAclsCount of $AllAclCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserAclsPercentString;`"></div></div>"

    # Get share counts
    $UserShare = $UserAcls | Select-Object SharePath -Unique
    $UserShareCount = $UserShare | measure | select count -ExpandProperty count
    $UserSharePercent = [math]::Round($UserShareCount/$AllShareCount,4)
    $UserSharePercentString = $UserSharePercent.tostring("P") -replace(" ","")
    $UserSharePercentBarVal = ($UserSharePercent *2).tostring("P") -replace(" %","px")
    $UserSharePercentBarCode = "<span class=`"dashboardsub2`">$UserSharePercentString ($UserShareCount of $AllShareCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserSharePercentString;`"></div></div>"

    # Get computer counts
    $UserComputer = $UserAcls | Select-Object ComputerName -Unique
    $UserComputerCount = $UserComputer | measure | select count -ExpandProperty count
    if($AllComputerCount -ne 0){   
        $UserComputerPercent = [math]::Round($UserComputerCount/$AllComputerCount,4)
    }
    $UserComputerPercentString = $UserComputerPercent.tostring("P") -replace(" ","")
    $UserComputerPercentBarVal = ($UserComputerPercent *2).tostring("P") -replace(" %","px")
    $UserComputerPercentBarCode = "<span class=`"dashboardsub2`">$UserComputerPercentString ($UserComputerCount of $AllComputerCount)</span><br><div class=`"divbarDomain`"><div class=`"divbarDomainInside`" style=`"width: $UserComputerPercentString;`"></div></div>"

    # Return object with all counts
    $TheCounts = new-object psobject            
    $TheCounts | add-member  Noteproperty ComputerBar   $UserComputerPercentBarCode
    $TheCounts | add-member  Noteproperty ShareBar      $UserSharePercentBarCode    
    $TheCounts | add-member  Noteproperty AclBar        $UserAclsPercentBarCode
    $TheCounts | add-member  Noteproperty FileCount     $FileCount
    $TheCounts | add-member  Noteproperty FileList      $FileList
    $TheCounts | add-member  Noteproperty ShareCount    $UserShareCount
    $TheCounts
}

# -------------------------------------------
# Function: Get-UserAceCounts
# -------------------------------------------
function Get-UserAceCounts
{
    param (
        $DataTable,
        $UserName
    )

    # Get acl counts
    $UserAcls = $DataTable | Where IdentityReference -like "$UserName" | Select-Object ComputerName, ShareName, SharePath, FileSystemRights
    $UserAclsCount = $UserAcls | measure | select count -ExpandProperty count

    # Get share counts
    $UserShare = $UserAcls | Select-Object SharePath -Unique
    $UserShareCount = $UserShare  | measure | select count -ExpandProperty count

    # Get computer counts
    $UserComputer = $UserAcls | Select-Object ComputerName -Unique
    $UserComputerCount = $UserComputer | measure | select count -ExpandProperty count

    # Get read counts 
    $UserReadAcl = $UserAcls | 
    Foreach {

        if(($_.FileSystemRights -like "*read*"))
        {
            $_ 
        }
    }
    $UserReadAclCount = $UserReadAcl | measure | select count -ExpandProperty count

    # Get write counts
    $UserWriteAcl = $UserAcls | 
    Foreach {

        if(($_.FileSystemRights -like "*GenericAll*") -or ($_.FileSystemRights -like "*Write*"))
        {
            $_ 
        }
    }
    $UserWriteAclCount = $UserWriteAcl | measure | select count -ExpandProperty count

    # Get high risk counts
    $UserHighRiskAcl = $UserAcls | 
    Foreach {

        if(($_.ShareName -like 'c$') -or ($_.ShareName -like 'admin$') -or ($_.ShareName -like "*wwwroot*") -or ($_.ShareName -like "*inetpub*") -or ($_.ShareName -like 'c') -or ($_.ShareName -like 'c_share'))
        {
            $_ 
        }
    }
    $UserHighRiskAclCount = $UserHighRiskAcl | measure | select count -ExpandProperty count

    # Return object with all counts
    $TheCounts = new-object psobject            
    $TheCounts | add-member  Noteproperty UserAclsCount          $UserAclsCount
    $TheCounts | add-member  Noteproperty UserShareCount         $UserShareCount
    $TheCounts | add-member  Noteproperty UserComputerCount      $UserComputerCount
    $TheCounts | add-member  Noteproperty UserReadAclCount       $UserReadAclCount
    $TheCounts | add-member  Noteproperty UserWriteAclCount      $UserWriteAclCount
    $TheCounts | add-member  Noteproperty UserHighRiskAclCount   $UserHighRiskAclCount
    $TheCounts
}

# -------------------------------------------
# Function: Convert-DataTableToHtmlTable
# -------------------------------------------
function Convert-DataTableToHtmlTable
{
    <#
            .SYNOPSIS
            This function can be used to convert a data table or ps object into a html table.
            .PARAMETER $DataTable
            The datatable to input.
            .PARAMETER $Outfile
            The output file path.
            .PARAMETER $Title
            Title of the page.
            .PARAMETER $Description
            Description of the page.
            .EXAMPLE
            $object = New-Object psobject
            $Object | Add-Member Noteproperty Name "my name 1"
            $Object | Add-Member Noteproperty Description "my description 1"
            Convert-DataTableToHtmlTable -Verbose -DataTable $object -Outfile ".\MyPsDataTable.html" -Title "MyPage" -Description "My description" -DontExport
            Convert-DataTableToHtmlTable -Verbose -DataTable $object -Outfile ".\MyPsDataTable.html" -Title "MyPage" -Description "My description"            
            .\MyPsDataTable.html
	        .NOTES
	        Author: Scott Sutherland (@_nullbind)
    #>
    param (
        [Parameter(Mandatory = $true,
        HelpMessage = 'The datatable to input.')]
        $DataTable,
        [Parameter(Mandatory = $false,
        HelpMessage = 'The output file path.')]
        [string]$Outfile = ".\MyPsDataTable.html",
        [Parameter(Mandatory = $false,
        HelpMessage = 'Title of page.')]
        [string]$Title = "HTML Table",
        [Parameter(Mandatory = $false,
        HelpMessage = 'Description of page.')]
        [string]$Description = "HTML Table",
        [Parameter(Mandatory = $false,
        HelpMessage = 'Disable file save.')]
        [switch]$DontExport
    )

    # Setup HTML begin
    Write-Verbose "[+] Creating html top." 
    $HTMLSTART = @"
    <html>
        <head>
          <title>$Title</title>
          <style> 	
  
	        {box-sizing:border-box}
	        body,html{
		        font-family:"Open Sans", 
		        sans-serif;font-weight:400;
		        min-height:100%;;color:#3d3935;
		        margin:1px;line-height:1.5;		       
	        }
		
	        table{
		        width:100%;
		        max-width:100%;
		        margin-bottom:1rem;
		        border-collapse:collapse
	        }
	
	        table thead th{
		        vertical-align:bottom;
		        border-bottom:2px solid #eceeef
	        }
	
	        table tbody tr:nth-of-type(odd){
		        background-color:#f9f9f9
	        }
	
	        table tbody tr:hover{
		        background-color:#f5f5f5
	        }
	
	        table td,table th{
		        padding:.75rem;
		        line-height:1.5;
		        text-align:left;
		        font-size:1rem;
		        vertical-align:top;
		        border-top:1px solid #eceeef
	        }

	
	        h1,h2,h3,h4,h5,h6{
		        padding-left: 10px;
		        font-family:inherit;
		        font-weight:500;
		        line-height:1.1;
		        color:inherit
	        }
	
	        code{
		        padding:.2rem .4rem;
		        font-size:1rem;
		        color:#bd4147;
		        background-color:#f7f7f9;
		        --border-radius:.25rem
	        }
	
	        p{
		        margin-top:0;
		        margin-bottom:1rem
	        }
	
	        a,a:visited{
		        text-decoration:none;
		        font-size: 14;
		        color: gray;
		        font-weight: bold;
	        }
	
	        a:hover{
		        color:#9B3722;
		        text-decoration:underline
	        }
		
	        .link:hover{
		        text-decoration:underline
	        }
	
	        li{
		        list-style-type:none
	        }	

            .pageDescription {
                margin: 10px;
            }
  
	        .divbarDomain{
		        background:#d9d7d7;
		        width:200px;
		        border: 1px solid #999999;
		        height: 25px;
		        text-align:center;
	        }
  
	        .divbarDomainInside{
		        background:#9B3722;
		        width:100px;
		        text-align:center;
		        height: 25px;
		        vertical-align:middle;
            }
            .pageDescription {
                padding-left: 0px;
            }	                       			
          </style>
        </head>
        <body>
        <p class="pageDescription"><a href="javascript:history.back()">Back to Report</a></p>
        <p class="pageDescription"><h3>$Title</h3></p>
        <p class="pageDescription">$Description</p>
            <table class="table table-striped table-hover">
"@
    
    # Get list of columns
    Write-Verbose "[+] Parsing data table columns."
    $MyCsvColumns = $DataTable | Get-Member | Where-Object MemberType -like "NoteProperty" | Select-Object Name -ExpandProperty Name

    # Print columns creation
    Write-Verbose "[+] Creating html table columns."   
    $HTMLTableHeadStart= "<thead><tr>" 
    $MyCsvColumns |
    ForEach-Object {

        # Add column
        $HTMLTableColumn = "<th>$_</th>$HTMLTableColumn"    
    }
    $HTMLTableColumn = "$HTMLTableHeadStart$HTMLTableColumn</tr></thead>" 

     # Create table rows
    Write-Verbose "[+] Creating html table rows."     
    $HTMLTableRow = $DataTable |
    ForEach-Object {
    
        # Create a value contain row data
        $CurrentRow = $_
        $PrintRow = ""
        $MyCsvColumns | 
        ForEach-Object{

            try{
                $GetValue = $CurrentRow | Select-Object $_ -ExpandProperty $_ -ErrorAction SilentlyContinue
                if($PrintRow -eq ""){
                    $PrintRow = "<td>$GetValue</td>"               
                }else{         
                    $PrintRow = "<td>$GetValue</td>$PrintRow"
                }
            }catch{}            
        }
        
        # Return row
        $HTMLTableHeadstart = "<tr>" 
        $HTMLTableHeadend = "</tr>" 
        "$HTMLTableHeadStart$PrintRow$HTMLTableHeadend"
    }

    # Setup HTML end
    Write-Verbose "[+] Creating html bottom." 
    $HTMLEND = @"
  </tbody>
</table>
</body>
</html>
"@

    # Return it
    "$HTMLSTART $HTMLTableColumn $HTMLTableRow $HTMLEND" 

    # Write file
    if(-not $DontExport){
        "$HTMLSTART $HTMLTableColumn $HTMLTableRow $HTMLEND"  | Out-File $Outfile
    }
}

# -------------------------------------------
# Function: Convert-DataTableToHtmlReport
# -------------------------------------------
function Convert-DataTableToHtmlReport
{
    <#
            .SYNOPSIS
            This function can be used to convert a data table or ps object into a generic html table.
            .PARAMETER $DataTable
            The datatable to input.
            .EXAMPLE
            $object = New-Object psobject
            $Object | Add-Member Noteproperty Name "my name 1"
            $Object | Add-Member Noteproperty Description "my description 1"
            Convert-DataTableToHtmlReport -Verbose -DataTable $object 
	        .NOTES
	        Author: Scott Sutherland (@_nullbind)
    #>
    param (
        [Parameter(Mandatory = $true,
        HelpMessage = 'The datatable to input.')]
        $DataTable
    )

    # Setup HTML begin
    Write-Verbose "[+] Creating html top." 
    $HTMLSTART = @"
    <table class="table table-striped table-hover tabledrop">
"@
    
    # Get list of columns
    $MyCsvColumns = $DataTable | Get-Member | Where-Object MemberType -like "NoteProperty" | Select-Object Name -ExpandProperty Name

    # Print columns creation  
    $HTMLTableHeadStart= "<thead><tr>" 
    $MyCsvColumns |
    ForEach-Object {

        # Add column
        $HTMLTableColumn = "<th>$_</th>$HTMLTableColumn"    
    }
    $HTMLTableColumn = "$HTMLTableHeadStart$HTMLTableColumn</tr></thead>" 

     # Create table rows
    Write-Verbose "[+] Creating html table rows."     
    $HTMLTableRow = $DataTable |
    ForEach-Object {
    
        # Create a value contain row data
        $CurrentRow = $_
        $PrintRow = ""
        $MyCsvColumns | 
        ForEach-Object{

            try{
                $GetValue = $CurrentRow | Select-Object $_ -ExpandProperty $_ -ErrorAction SilentlyContinue
                if($PrintRow -eq ""){
                    $PrintRow = "<td>$GetValue</td>"               
                }else{         
                    $PrintRow = "<td>$GetValue</td>$PrintRow"
                }
            }catch{}            
        }
        
        # Return row
        $HTMLTableHeadstart = "<tr>" 
        $HTMLTableHeadend = "</tr>" 
        "$HTMLTableHeadStart$PrintRow$HTMLTableHeadend"
    }

    # Setup HTML end
    Write-Verbose "[+] Creating html bottom." 
    $HTMLEND = @"
  </tbody>
</table>
"@

    # Return it
    "$HTMLSTART $HTMLTableColumn $HTMLTableRow $HTMLEND" 
}

# -------------------------------------------
# Function: Get-FolderGroupMd5
# -------------------------------------------
function Get-FolderGroupMd5{
    
    param (
        [string]$FolderList
    )

    <#
    $stringAsStream = [System.IO.MemoryStream]::new()
    $writer = [System.IO.StreamWriter]::new($stringAsStream)
    $writer.write($FolderList)
    $writer.Flush()
    $stringAsStream.Position = 0
    Get-FileHash -InputStream $stringAsStream -Algorithm MD5 | Select-Object Hash
    #>

    $MyMd5Provider = [System.Security.Cryptography.MD5CryptoServiceProvider]::Create()
    $enc = [system.Text.Encoding]::UTF8
    $FolderListBytes = $enc.GetBytes($FolderList) 
    $MyMd5HashBytes = $MyMd5Provider.ComputeHash($FolderListBytes)
    $MysStringBuilder = new-object System.Text.StringBuilder
    $MyMd5HashBytes|
    foreach {
       $MyMd5HashByte =  $_.ToString("x2").ToLower()
       $MyMd5Hash = "$MyMd5Hash$MyMd5HashByte"
    }
    $MyMd5Hash
}

# -------------------------------------------
# Function: Get-LdapQuery
# -------------------------------------------
# Author: Will Schroeder
# Modifications: Scott Sutherland
function Get-LdapQuery
{
    <#
            .SYNOPSIS
            Used to query domain controllers via LDAP. Supports alternative credentials from non-domain system
            Note: This will use the default logon server by default.
            .PARAMETER Username
            Domain account to authenticate to Active Directory.
            .PARAMETER Password
            Domain password to authenticate to Active Directory.
            .PARAMETER Credential
            Domain credential to authenticate to Active Directory.
            .PARAMETER DomainController
            Domain controller to authenticated to. Requires username/password or credential.
            .PARAMETER LdapFilter
            LDAP filter.
            .PARAMETER LdapPath
            Ldap path.
            .PARAMETER $Limit
            Maximum number of Objects to pull from AD, limit is 1,000.".
            .PARAMETER SearchScope
            Scope of a search as either a base, one-level, or subtree search, default is subtree..
            .EXAMPLE
            PS C:\temp> Get-DomainObject -LdapFilter "(&(servicePrincipalName=*))"
            .EXAMPLE
            PS C:\temp> Get-DomainObject -LdapFilter "(&(servicePrincipalName=*))" -DomainController 10.0.0.1:389
            It will use the security context of the current process to authenticate to the domain controller.
            IP:Port can be specified to reach a pivot machine.
            .EXAMPLE
            PS C:\temp> Get-DomainObject -LdapFilter "(&(servicePrincipalName=*))" -DomainController 10.0.0.1  -Username Domain\User  -Password Password123!
            .Notes
            This was based on Will Schroeder's Get-ADObject function from https://github.com/PowerShellEmpire/PowerTools/blob/master/PowerView/powerview.ps1
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false,
        HelpMessage = 'Domain user to authenticate with domain\user.')]
        [string]$Username,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Domain password to authenticate with domain\user.')]
        [string]$Password,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Credentials to use when connecting to a Domain Controller.')]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Domain controller for Domain and Site that you want to query against.')]
        [string]$DomainController,

        [Parameter(Mandatory = $false,
        HelpMessage = 'LDAP Filter.')]
        [string]$LdapFilter = '',

        [Parameter(Mandatory = $false,
        HelpMessage = 'LDAP path.')]
        [string]$LdapPath,

        [Parameter(Mandatory = $false,
        HelpMessage = 'Maximum number of Objects to pull from AD, limit is 1,000 .')]
        [int]$Limit = 1000,

        [Parameter(Mandatory = $false,
        HelpMessage = 'scope of a search as either a base, one-level, or subtree search, default is subtree.')]
        [ValidateSet('Subtree','OneLevel','Base')]
        [string]$SearchScope = 'Subtree'
    )
    Begin
    {
        # Create PS Credential object
        if($Username -and $Password)
        {
            $secpass = ConvertTo-SecureString $Password -AsPlainText -Force
            $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($Username, $secpass)
        }

        # Create Create the connection to LDAP
        if ($DomainController)
        {
           
            # Test credentials and grab domain
            try {

                $ArgumentList = New-Object Collections.Generic.List[string]
                $ArgumentList.Add("LDAP://$DomainController")

                if($Username -or $Credential){
                    $ArgumentList.Add($Credential.UserName)
                    $ArgumentList.Add($Credential.GetNetworkCredential().Password)
                }

                $objDomain = (New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $ArgumentList).distinguishedname

                # Authentication failed. distinguishedName property can not be empty.
                if(-not $objDomain){ throw }

            }catch{
                $Time =  Get-Date -UFormat "%m/%d/%Y %R"
                Write-Host " [!][$Time] Authentication failed or domain controller is not reachable."
                Write-Host " [!][$Time] Aborting operation."
                Break
            }

            # add ldap path
            if($LdapPath)
            {
                $LdapPath = '/'+$LdapPath+','+$objDomain
                $ArgumentList[0] = "LDAP://$DomainController$LdapPath"
            }

            $objDomainPath= New-Object System.DirectoryServices.DirectoryEntry -ArgumentList $ArgumentList

            $objSearcher = New-Object -TypeName System.DirectoryServices.DirectorySearcher $objDomainPath
        }
        else
        {
            $objDomain = ([ADSI]'').distinguishedName

            # add ldap path
            if($LdapPath)
            {
                $LdapPath = $LdapPath+','+$objDomain
                $objDomainPath  = [ADSI]"LDAP://$LdapPath"
            }
            else
            {
                $objDomainPath  = [ADSI]''
            }

            $objSearcher = New-Object -TypeName System.DirectoryServices.DirectorySearcher -ArgumentList $objDomainPath
        }

        # Setup LDAP filter
        $objSearcher.PageSize = $Limit
        $objSearcher.Filter = $LdapFilter
        $objSearcher.SearchScope = 'Subtree'
    }

    Process
    {
        try
        {
            # Return object
            $objSearcher.FindAll() | ForEach-Object -Process {
                $_
            }
        }
        catch
        {
            "Error was $_"
            $line = $_.InvocationInfo.ScriptLineNumber
            "Error was in Line $line"
        }
    }

    End
    {
    }
}


# -------------------------------------------
# Function: Get-DomainSubnet
# -------------------------------------------
function Get-DomainSubnet
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$false,
        HelpMessage="Domain user to authenticate with domain\user.")]
        [string]$username,

        [Parameter(Mandatory=$false,
        HelpMessage="Domain password to authenticate with domain\user.")]
        [string]$password,

        [Parameter(Mandatory=$false,
        HelpMessage="Credentials to use when connecting to a Domain Controller.")]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        
        [Parameter(Mandatory=$false,
        HelpMessage="Domain controller for Domain and Site that you want to query against.")]
        [string]$DomainController,

        [Parameter(Mandatory=$false,
        HelpMessage="LDAP Filter.")]
        [string]$LdapFilter = "",

        [Parameter(Mandatory=$false,
        HelpMessage="LDAP path.")]
        [string]$LdapPath,

        [Parameter(Mandatory=$false,
        HelpMessage="Maximum number of Objects to pull from AD, limit is 1,000 .")]
        [int]$Limit = 1000,

        [Parameter(Mandatory=$false,
        HelpMessage="scope of a search as either a base, one-level, or subtree search, default is subtree.")]
        [ValidateSet("Subtree","OneLevel","Base")]
        [string]$SearchScope = "Subtree"
    )
    Begin
    {
        Write-Verbose "Getting subnets..."

        # Create PS Credential object
        if($Password){
            $secpass = ConvertTo-SecureString $Password -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $secpass)                
        }        

        # Create Create the connection to LDAP       
        if ($DomainController -and $Credential.GetNetworkCredential().Password)
        {
            $objDomain = (New-Object System.DirectoryServices.DirectoryEntry "LDAP://$DomainController", $Credential.UserName,$Credential.GetNetworkCredential().Password).distinguishedname           

            # add ldap path
            if($LdapPath)
            {
                $LdapPath = "/"+$LdapPath+","+$objDomain
                $objDomainPath = New-Object System.DirectoryServices.DirectoryEntry "LDAP://$DomainController$LdapPath", $Credential.UserName,$Credential.GetNetworkCredential().Password
            }else{
                $objDomainPath= New-Object System.DirectoryServices.DirectoryEntry "LDAP://$DomainController", $Credential.UserName,$Credential.GetNetworkCredential().Password
            }
            
            $objSearcher = New-Object System.DirectoryServices.DirectorySearcher $objDomainPath
        }else{
            $objDomain = ([ADSI]"").distinguishedName
            
            # add ldap path
            if($LdapPath)
            {
                $LdapPath = $LdapPath+","+$objDomain
                $LdapPath
                $objDomainPath  = [ADSI]"LDAP://$LdapPath"
            }else{
                $objDomainPath  = [ADSI]""
            }
              
            $objSearcher = New-Object System.DirectoryServices.DirectorySearcher $objDomainPath
        }

        # Create table for object information
        $TableDomainSubnets = New-Object System.Data.DataTable
        $TableDomainSubnets.Columns.Add("Site") | Out-Null
        $TableDomainSubnets.Columns.Add("Subnet") | Out-Null        
        $TableDomainSubnets.Columns.Add("Description") | Out-Null                
        $TableDomainSubnets.Columns.Add("whencreated") | Out-Null  
        $TableDomainSubnets.Columns.Add("whenchanged") | Out-Null 
        $TableDomainSubnets.Columns.Add("distinguishedname") | Out-Null      
        $TableDomainSubnets.Clear()
    }

    Process
    {        
        try
        {
            # Get results
            Get-LdapQuery -DomainController $DomainController -username $username -password $password -Credential $Credential -Verbose -LdapFilter "(objectCategory=subnet)" -LdapPath "CN=Subnets,CN=Sites,CN=Configuration" | 
            ForEach-Object {
            
                # Add results to table
                $TableDomainSubnets.Rows.Add(                     
                    [string]$_.properties.siteobject.split(",")[0].split("=")[1],   
                    [string]$_.properties.name,    
                    [string]$_.properties.description,  
                    [string]$_.properties.whencreated,
                    [string]$_.properties.whenchanged,
                    [string]$_.properties.distinguishedname
                ) | Out-Null
            }
        }
        catch
        {
          #"Error was $_"
          #$line = $_.InvocationInfo.ScriptLineNumber
          #"Error was in Line $line"
        }                    
    }

    End
    {
        # Check for subnets
        if($TableDomainSubnets.Rows.Count -gt 0)
        {
        $TableDomainSubnetsCount = $TableDomainSubnets.Rows.Count
            Write-Verbose "$TableDomainSubnetsCount subnets found."
            Return $TableDomainSubnets
        }else{
            Write-Verbose "0 subnets were found."
        } 
    }
}


# -------------------------------------------
# Function: Invoke-Parallel
# -------------------------------------------
# Author: RamblingCookieMonster
# Source: https://github.com/RamblingCookieMonster/Invoke-Parallel
# Notes: Added "ImportSessionFunctions" to import custom functions from the current session into the runspace pool.
function Invoke-Parallel
{
    <#
            .SYNOPSIS
            Function to control parallel processing using runspaces

            .DESCRIPTION
            Function to control parallel processing using runspaces

            Note that each runspace will not have access to variables and commands loaded in your session or in other runspaces by default.
            This behaviour can be changed with parameters.

            .PARAMETER ScriptFile
            File to run against all input objects.  Must include parameter to take in the input object, or use $args.  Optionally, include parameter to take in parameter.  Example: C:\script.ps1

            .PARAMETER ScriptBlock
            Scriptblock to run against all computers.

            You may use $Using:<Variable> language in PowerShell 3 and later.

            The parameter block is added for you, allowing behaviour similar to foreach-object:
            Refer to the input object as $_.
            Refer to the parameter parameter as $parameter

            .PARAMETER InputObject
            Run script against these specified objects.

            .PARAMETER Parameter
            This object is passed to every script block.  You can use it to pass information to the script block; for example, the path to a logging folder

            Reference this object as $parameter if using the scriptblock parameterset.

            .PARAMETER ImportVariables
            If specified, get user session variables and add them to the initial session state

            .PARAMETER ImportModules
            If specified, get loaded modules and pssnapins, add them to the initial session state

            .PARAMETER Throttle
            Maximum number of threads to run at a single time.

            .PARAMETER SleepTimer
            Milliseconds to sleep after checking for completed runspaces and in a few other spots.  I would not recommend dropping below 200 or increasing above 500

            .PARAMETER RunspaceTimeout
            Maximum time in seconds a single thread can run.  If execution of your code takes longer than this, it is disposed.  Default: 0 (seconds)

            WARNING:  Using this parameter requires that maxQueue be set to throttle (it will be by default) for accurate timing.  Details here:
            http://gallery.technet.microsoft.com/Run-Parallel-Parallel-377fd430

            .PARAMETER NoCloseOnTimeout
            Do not dispose of timed out tasks or attempt to close the runspace if threads have timed out. This will prevent the script from hanging in certain situations where threads become non-responsive, at the expense of leaking memory within the PowerShell host.

            .PARAMETER MaxQueue
            Maximum number of powershell instances to add to runspace pool.  If this is higher than $throttle, $timeout will be inaccurate

            If this is equal or less than throttle, there will be a performance impact

            The default value is $throttle times 3, if $runspaceTimeout is not specified
            The default value is $throttle, if $runspaceTimeout is specified

            .PARAMETER LogFile
            Path to a file where we can log results, including run time for each thread, whether it completes, completes with errors, or times out.

            .PARAMETER Quiet
            Disable progress bar.

            .EXAMPLE
            Each example uses Test-ForPacs.ps1 which includes the following code:
            param($computer)

            if(test-connection $computer -count 1 -quiet -BufferSize 16){
            $object = [pscustomobject] @{
            Computer=$computer;
            Available=1;
            Kodak=$(
            if((test-path "\\$computer\c$\users\public\desktop\Kodak Direct View Pacs.url") -or (test-path "\\$computer\c$\documents and settings\all users

            \desktop\Kodak Direct View Pacs.url") ){"1"}else{"0"}
            )
            }
            }
            else{
            $object = [pscustomobject] @{
            Computer=$computer;
            Available=0;
            Kodak="NA"
            }
            }

            $object

            .EXAMPLE
            Invoke-Parallel -scriptfile C:\public\Test-ForPacs.ps1 -inputobject $(get-content C:\pcs.txt) -runspaceTimeout 10 -throttle 10

            Pulls list of PCs from C:\pcs.txt,
            Runs Test-ForPacs against each
            If any query takes longer than 10 seconds, it is disposed
            Only run 10 threads at a time

            .EXAMPLE
            Invoke-Parallel -scriptfile C:\public\Test-ForPacs.ps1 -inputobject c-is-ts-91, c-is-ts-95

            Runs against c-is-ts-91, c-is-ts-95 (-computername)
            Runs Test-ForPacs against each

            .EXAMPLE
            $stuff = [pscustomobject] @{
            ContentFile = "windows\system32\drivers\etc\hosts"
            Logfile = "C:\temp\log.txt"
            }

            $computers | Invoke-Parallel -parameter $stuff {
            $contentFile = join-path "\\$_\c$" $parameter.contentfile
            Get-Content $contentFile |
            set-content $parameter.logfile
            }

            This example uses the parameter argument.  This parameter is a single object.  To pass multiple items into the script block, we create a custom object (using a PowerShell v3 language) with properties we want to pass in.

            Inside the script block, $parameter is used to reference this parameter object.  This example sets a content file, gets content from that file, and sets it to a predefined log file.

            .EXAMPLE
            $test = 5
            1..2 | Invoke-Parallel -ImportVariables {$_ * $test}

            Add variables from the current session to the session state.  Without -ImportVariables $Test would not be accessible

            .EXAMPLE
            $test = 5
            1..2 | Invoke-Parallel {$_ * $Using:test}

            Reference a variable from the current session with the $Using:<Variable> syntax.  Requires PowerShell 3 or later. Note that -ImportVariables parameter is no longer necessary.

            .FUNCTIONALITY
            PowerShell Language

            .NOTES
            Credit to Boe Prox for the base runspace code and $Using implementation
            http://learn-powershell.net/2012/05/10/speedy-network-information-query-using-powershell/
            http://gallery.technet.microsoft.com/scriptcenter/Speedy-Network-Information-5b1406fb#content
            https://github.com/proxb/PoshRSJob/

            Credit to T Bryce Yehl for the Quiet and NoCloseOnTimeout implementations

            Credit to Sergei Vorobev for the many ideas and contributions that have improved functionality, reliability, and ease of use

            .LINK
            https://github.com/RamblingCookieMonster/Invoke-Parallel
    #>
    [cmdletbinding(DefaultParameterSetName = 'ScriptBlock')]
    Param (
        [Parameter(Mandatory = $false,position = 0,ParameterSetName = 'ScriptBlock')]
        [System.Management.Automation.ScriptBlock]$ScriptBlock,

        [Parameter(Mandatory = $false,ParameterSetName = 'ScriptFile')]
        [ValidateScript({
                    Test-Path $_ -PathType leaf
        })]
        $ScriptFile,

        [Parameter(Mandatory = $true,ValueFromPipeline = $true)]
        [Alias('CN','__Server','IPAddress','Server','ComputerName')]
        [PSObject]$InputObject,

        [PSObject]$Parameter,

        [switch]$ImportSessionFunctions,

        [switch]$ImportVariables,

        [switch]$ImportModules,

        [int]$Throttle = 20,

        [int]$SleepTimer = 200,

        [int]$RunspaceTimeout = 0,

        [switch]$NoCloseOnTimeout = $false,

        [int]$MaxQueue,

        [validatescript({
                    Test-Path (Split-Path -Path $_ -Parent)
        })]
        [string]$LogFile = 'C:\temp\log.log',

        [switch] $Quiet = $true
    )

    Begin {

        #No max queue specified?  Estimate one.
        #We use the script scope to resolve an odd PowerShell 2 issue where MaxQueue isn't seen later in the function
        if( -not $PSBoundParameters.ContainsKey('MaxQueue') )
        {
            if($RunspaceTimeout -ne 0)
            {
                $script:MaxQueue = $Throttle
            }
            else
            {
                $script:MaxQueue = $Throttle * 3
            }
        }
        else
        {
            $script:MaxQueue = $MaxQueue
        }        

        #If they want to import variables or modules, create a clean runspace, get loaded items, use those to exclude items
        if ($ImportVariables -or $ImportModules)
        {
            $StandardUserEnv = [powershell]::Create().addscript({
                    #Get modules and snapins in this clean runspace
                    $Modules = Get-Module | Select-Object -ExpandProperty Name
                    $Snapins = Get-PSSnapin | Select-Object -ExpandProperty Name

                    #Get variables in this clean runspace
                    #Called last to get vars like $? into session
                    $Variables = Get-Variable | Select-Object -ExpandProperty Name

                    #Return a hashtable where we can access each.
                    @{
                        Variables = $Variables
                        Modules   = $Modules
                        Snapins   = $Snapins
                    }
            }).invoke()[0]

            if ($ImportVariables)
            {
                #Exclude common parameters, bound parameters, and automatic variables
                Function _temp
                {
                    [cmdletbinding()] param()
                }
                $VariablesToExclude = @( (Get-Command _temp | Select-Object -ExpandProperty parameters).Keys + $PSBoundParameters.Keys + $StandardUserEnv.Variables )
                #Write-Verbose "Excluding variables $( ($VariablesToExclude | sort ) -join ", ")"

                # we don't use 'Get-Variable -Exclude', because it uses regexps.
                # One of the veriables that we pass is '$?'.
                # There could be other variables with such problems.
                # Scope 2 required if we move to a real module
                $UserVariables = @( Get-Variable | Where-Object -FilterScript {
                        -not ($VariablesToExclude -contains $_.Name)
                } )
                #Write-Verbose "Found variables to import: $( ($UserVariables | Select -expandproperty Name | Sort ) -join ", " | Out-String).`n"
            }

            if ($ImportModules)
            {
                $UserModules = @( Get-Module |
                    Where-Object -FilterScript {
                        $StandardUserEnv.Modules -notcontains $_.Name -and (Test-Path -Path $_.Path -ErrorAction SilentlyContinue)
                    } |
                Select-Object -ExpandProperty Path )
                $UserSnapins = @( Get-PSSnapin |
                    Select-Object -ExpandProperty Name |
                    Where-Object -FilterScript {
                        $StandardUserEnv.Snapins -notcontains $_
                } )
            }
        }

        #region functions

        Function Get-RunspaceData
        {
            [cmdletbinding()]
            param( [switch]$Wait )

            #loop through runspaces
            #if $wait is specified, keep looping until all complete
            Do
            {
                #set more to false for tracking completion
                $more = $false

                #Progress bar if we have inputobject count (bound parameter)
                if (-not $Quiet)
                {
                    Write-Progress  -Activity 'Running Query' -Status 'Starting threads'`
                    -CurrentOperation "$startedCount threads defined - $totalCount input objects - $script:completedCount input objects processed"`
                    -PercentComplete $( Try
                        {
                            $script:completedCount / $totalCount * 100
                        }
                        Catch
                        {
                            0
                        }
                    )
                }

                #run through each runspace.
                Foreach($runspace in $runspaces)
                {
                    #get the duration - inaccurate
                    $currentdate = Get-Date
                    $runtime = $currentdate - $runspace.startTime
                    $runMin = [math]::Round( $runtime.totalminutes ,2 )

                    #set up log object
                    $log = '' | Select-Object -Property Date, Action, Runtime, Status, Details
                    $log.Action = "Removing:'$($runspace.object)'"
                    $log.Date = $currentdate
                    $log.Runtime = "$runMin minutes"

                    #If runspace completed, end invoke, dispose, recycle, counter++
                    If ($runspace.Runspace.isCompleted)
                    {
                        $script:completedCount++

                        #check if there were errors
                        if($runspace.powershell.Streams.Error.Count -gt 0)
                        {
                            #set the logging info and move the file to completed
                            $log.status = 'CompletedWithErrors'
                            #Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                            foreach($ErrorRecord in $runspace.powershell.Streams.Error)
                            {
                                Write-Error -ErrorRecord $ErrorRecord
                            }
                        }
                        else
                        {
                            #add logging details and cleanup
                            $log.status = 'Completed'
                            #Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                        }

                        #everything is logged, clean up the runspace
                        $runspace.powershell.EndInvoke($runspace.Runspace)
                        $runspace.powershell.dispose()
                        $runspace.Runspace = $null
                        $runspace.powershell = $null
                    }

                    #If runtime exceeds max, dispose the runspace
                    ElseIf ( $RunspaceTimeout -ne 0 -and $runtime.totalseconds -gt $RunspaceTimeout)
                    {
                        $script:completedCount++
                        $timedOutTasks = $true

                        #add logging details and cleanup
                        $log.status = 'TimedOut'
                        #Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                        Write-Error -Message "Runspace timed out at $($runtime.totalseconds) seconds for the object:`n$($runspace.object | Out-String)"

                        #Depending on how it hangs, we could still get stuck here as dispose calls a synchronous method on the powershell instance
                        if (!$NoCloseOnTimeout)
                        {
                            $runspace.powershell.dispose()
                        }
                        $runspace.Runspace = $null
                        $runspace.powershell = $null
                        $completedCount++
                    }

                    #If runspace isn't null set more to true
                    ElseIf ($runspace.Runspace -ne $null )
                    {
                        $log = $null
                        $more = $true
                    }
                }

                #Clean out unused runspace jobs
                $temphash = $runspaces.clone()
                $temphash |
                Where-Object -FilterScript {
                    $_.runspace -eq $null
                } |
                ForEach-Object -Process {
                    $runspaces.remove($_)
                }

                #sleep for a bit if we will loop again
                if($PSBoundParameters['Wait'])
                {
                    Start-Sleep -Milliseconds $SleepTimer
                }

                #Loop again only if -wait parameter and there are more runspaces to process
            }
            while ($more -and $PSBoundParameters['Wait'])

            #End of runspace function
        }

        #endregion functions

        #region Init

        if($PSCmdlet.ParameterSetName -eq 'ScriptFile')
        {
            $ScriptBlock = [scriptblock]::Create( $(Get-Content $ScriptFile | Out-String) )
        }
        elseif($PSCmdlet.ParameterSetName -eq 'ScriptBlock')
        {
            #Start building parameter names for the param block
            [string[]]$ParamsToAdd = '$_'
            if( $PSBoundParameters.ContainsKey('Parameter') )
            {
                $ParamsToAdd += '$Parameter'
            }

            $UsingVariableData = $null


            # This code enables $Using support through the AST.
            # This is entirely from  Boe Prox, and his https://github.com/proxb/PoshRSJob module; all credit to Boe!

            if($PSVersionTable.PSVersion.Major -gt 2)
            {
                #Extract using references
                $UsingVariables = $ScriptBlock.ast.FindAll({
                        $args[0] -is [System.Management.Automation.Language.UsingExpressionAst]
                },$true)

                If ($UsingVariables)
                {
                    $List = New-Object -TypeName 'System.Collections.Generic.List`1[System.Management.Automation.Language.VariableExpressionAst]'
                    ForEach ($Ast in $UsingVariables)
                    {
                        [void]$List.Add($Ast.SubExpression)
                    }

                    $UsingVar = $UsingVariables |
                    Group-Object -Property SubExpression |
                    ForEach-Object -Process {
                        $_.Group |
                        Select-Object -First 1
                    }

                    #Extract the name, value, and create replacements for each
                    $UsingVariableData = ForEach ($Var in $UsingVar)
                    {
                        Try
                        {
                            $Value = Get-Variable -Name $Var.SubExpression.VariablePath.UserPath -ErrorAction Stop
                            [pscustomobject]@{
                                Name       = $Var.SubExpression.Extent.Text
                                Value      = $Value.Value
                                NewName    = ('$__using_{0}' -f $Var.SubExpression.VariablePath.UserPath)
                                NewVarName = ('__using_{0}' -f $Var.SubExpression.VariablePath.UserPath)
                            }
                        }
                        Catch
                        {
                            Write-Error -Message "$($Var.SubExpression.Extent.Text) is not a valid Using: variable!"
                        }
                    }
                    $ParamsToAdd += $UsingVariableData | Select-Object -ExpandProperty NewName -Unique

                    $NewParams = $UsingVariableData.NewName -join ', '
                    $Tuple = [Tuple]::Create($List, $NewParams)
                    $bindingFlags = [Reflection.BindingFlags]'Default,NonPublic,Instance'
                    $GetWithInputHandlingForInvokeCommandImpl = ($ScriptBlock.ast.gettype().GetMethod('GetWithInputHandlingForInvokeCommandImpl',$bindingFlags))

                    $StringScriptBlock = $GetWithInputHandlingForInvokeCommandImpl.Invoke($ScriptBlock.ast,@($Tuple))

                    $ScriptBlock = [scriptblock]::Create($StringScriptBlock)

                    #Write-Verbose $StringScriptBlock
                }
            }

            $ScriptBlock = $ExecutionContext.InvokeCommand.NewScriptBlock("param($($ParamsToAdd -Join ', '))`r`n" + $ScriptBlock.ToString())
        }
        else
        {
            Throw 'Must provide ScriptBlock or ScriptFile'
            Break
        }

        Write-Debug -Message "`$ScriptBlock: $($ScriptBlock | Out-String)"
        If (-not($SuppressVerbose)){
            Write-Verbose -Message 'Creating runspace pool and session states'
        }


        #If specified, add variables and modules/snapins to session state
        $sessionstate = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
        if ($ImportVariables)
        {
            if($UserVariables.count -gt 0)
            {
                foreach($Variable in $UserVariables)
                {
                    $sessionstate.Variables.Add( (New-Object -TypeName System.Management.Automation.Runspaces.SessionStateVariableEntry -ArgumentList $Variable.Name, $Variable.Value, $null) )
                }
            }
        }
        if ($ImportModules)
        {
            if($UserModules.count -gt 0)
            {
                foreach($ModulePath in $UserModules)
                {
                    $sessionstate.ImportPSModule($ModulePath)
                }
            }
            if($UserSnapins.count -gt 0)
            {
                foreach($PSSnapin in $UserSnapins)
                {
                    [void]$sessionstate.ImportPSSnapIn($PSSnapin, [ref]$null)
                }
            }
        }

        # --------------------------------------------------
        #region - Import Session Functions
        # --------------------------------------------------
        # Import functions from the current session into the RunspacePool sessionstate

        if($ImportSessionFunctions)
        {
            # Import all session functions into the runspace session state from the current one
            Get-ChildItem -Path Function:\ |
            Where-Object -FilterScript {
                $_.name -notlike '*:*'
            } |
            Select-Object -Property name -ExpandProperty name |
            ForEach-Object -Process {
                # Get the function code
                $Definition = Get-Content -Path "function:\$_" -ErrorAction Stop

                # Create a sessionstate function with the same name and code
                $SessionStateFunction = New-Object -TypeName System.Management.Automation.Runspaces.SessionStateFunctionEntry -ArgumentList "$_", $Definition

                # Add the function to the session state
                $sessionstate.Commands.Add($SessionStateFunction)
            }
        }
        #endregion

        #Create runspace pool
        $runspacepool = [runspacefactory]::CreateRunspacePool(1, $Throttle, $sessionstate, $Host)
        $runspacepool.Open()

        #Write-Verbose "Creating empty collection to hold runspace jobs"
        $Script:runspaces = New-Object -TypeName System.Collections.ArrayList

        #If inputObject is bound get a total count and set bound to true
        $bound = $PSBoundParameters.keys -contains 'InputObject'
        if(-not $bound)
        {
            [System.Collections.ArrayList]$allObjects = @()
        }

        <#
                #write initial log entry
                $log = "" | Select Date, Action, Runtime, Status, Details
                $log.Date = Get-Date
                $log.Action = "Batch processing started"
                $log.Runtime = $null
                $log.Status = "Started"
                $log.Details = $null
        #>
        $timedOutTasks = $false

        #endregion INIT
    }

    Process {

        #add piped objects to all objects or set all objects to bound input object parameter
        if($bound)
        {
            $allObjects = $InputObject
        }
        Else
        {
            [void]$allObjects.add( $InputObject )
        }
    }

    End {

        #Use Try/Finally to catch Ctrl+C and clean up.
        Try
        {
            #counts for progress
            $totalCount = $allObjects.count
            $script:completedCount = 0
            $startedCount = 0

            foreach($object in $allObjects)
            {
                #region add scripts to runspace pool

                #Create the powershell instance, set verbose if needed, supply the scriptblock and parameters
                $powershell = [powershell]::Create()

                if ($VerbosePreference -eq 'Continue')
                {
                    [void]$powershell.AddScript({
                            $VerbosePreference = 'Continue'
                    })
                }

                [void]$powershell.AddScript($ScriptBlock).AddArgument($object)

                if ($Parameter)
                {
                    [void]$powershell.AddArgument($Parameter)
                }

                # $Using support from Boe Prox
                if ($UsingVariableData)
                {
                    Foreach($UsingVariable in $UsingVariableData)
                    {
                        #Write-Verbose "Adding $($UsingVariable.Name) with value: $($UsingVariable.Value)"
                        [void]$powershell.AddArgument($UsingVariable.Value)
                    }
                }

                #Add the runspace into the powershell instance
                $powershell.RunspacePool = $runspacepool

                #Create a temporary collection for each runspace
                $temp = '' | Select-Object -Property PowerShell, StartTime, object, Runspace
                $temp.PowerShell = $powershell
                $temp.StartTime = Get-Date
                $temp.object = $object

                #Save the handle output when calling BeginInvoke() that will be used later to end the runspace
                $temp.Runspace = $powershell.BeginInvoke()
                $startedCount++

                #Add the temp tracking info to $runspaces collection
                #Write-Verbose ( "Adding {0} to collection at {1}" -f $temp.object, $temp.starttime.tostring() )
                $null = $runspaces.Add($temp)

                #loop through existing runspaces one time
                if($ShowRunpaceErrors){
                    Get-RunspaceData 
                }else{
                    Get-RunspaceData -ErrorAction SilentlyContinue
                }

                #If we have more running than max queue (used to control timeout accuracy)
                #Script scope resolves odd PowerShell 2 issue
                $firstRun = $true
                while ($runspaces.count -ge $script:MaxQueue)
                {
                    #give verbose output
                    if($firstRun)
                    {
                        #Write-Verbose "$($runspaces.count) items running - exceeded $Script:MaxQueue limit."
                    }
                    $firstRun = $false

                    #run get-runspace data and sleep for a short while
                    Get-RunspaceData
                    Start-Sleep -Milliseconds $SleepTimer
                }

                #endregion add scripts to runspace pool
            }

            #Write-Verbose ( "Finish processing the remaining runspace jobs: {0}" -f ( @($runspaces | Where {$_.Runspace -ne $Null}).Count) )
            Get-RunspaceData -wait

            if (-not $Quiet)
            {
                Write-Progress -Activity 'Running Query' -Status 'Starting threads' -Completed
            }
        }
        Finally
        {
            #Close the runspace pool, unless we specified no close on timeout and something timed out
            if ( ($timedOutTasks -eq $false) -or ( ($timedOutTasks -eq $true) -and ($NoCloseOnTimeout -eq $false) ) )
            {
                If (-not($SuppressVerbose)){
                    Write-Verbose -Message 'Closing the runspace pool'
                }
                $runspacepool.close()
            }

            #collect garbage
            [gc]::Collect()
        }
    }
}

# Source: https://stackoverflow.com/questions/35116636/bit-shifting-in-powershell-2-0
function Convert-BitShift {
    param (
        [Parameter(Position = 0, Mandatory = $True)]
        [int] $Number,

        [Parameter(ParameterSetName = 'Left', Mandatory = $False)]
        [int] $Left,

        [Parameter(ParameterSetName = 'Right', Mandatory = $False)]
        [int] $Right
    ) 

    $shift = 0
    if ($PSCmdlet.ParameterSetName -eq 'Left')
    { 
        $shift = $Left
    }
    else
    {
        $shift = -$Right
    }

    return [math]::Floor($Number * [math]::Pow(2,$shift))
}

function New-InMemoryModule
{

    Param
    (
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $ModuleName = [Guid]::NewGuid().ToString()
    )

    $LoadedAssemblies = [AppDomain]::CurrentDomain.GetAssemblies()

    ForEach ($Assembly in $LoadedAssemblies) {
        if ($Assembly.FullName -and ($Assembly.FullName.Split(',')[0] -eq $ModuleName)) {
            return $Assembly
        }
    }

    $DynAssembly = New-Object Reflection.AssemblyName($ModuleName)
    $Domain = [AppDomain]::CurrentDomain
    $AssemblyBuilder = $Domain.DefineDynamicAssembly($DynAssembly, 'Run')
    $ModuleBuilder = $AssemblyBuilder.DefineDynamicModule($ModuleName, $False)

    return $ModuleBuilder
}

function func
{
    Param
    (
        [Parameter(Position = 0, Mandatory = $True)]
        [String]
        $DllName,

        [Parameter(Position = 1, Mandatory = $True)]
        [String]
        $FunctionName,

        [Parameter(Position = 2, Mandatory = $True)]
        [Type]
        $ReturnType,

        [Parameter(Position = 3)]
        [Type[]]
        $ParameterTypes,

        [Parameter(Position = 4)]
        [Runtime.InteropServices.CallingConvention]
        $NativeCallingConvention,

        [Parameter(Position = 5)]
        [Runtime.InteropServices.CharSet]
        $Charset,

        [Switch]
        $SetLastError
    )

    $Properties = @{
        DllName = $DllName
        FunctionName = $FunctionName
        ReturnType = $ReturnType
    }

    if ($ParameterTypes) { $Properties['ParameterTypes'] = $ParameterTypes }
    if ($NativeCallingConvention) { $Properties['NativeCallingConvention'] = $NativeCallingConvention }
    if ($Charset) { $Properties['Charset'] = $Charset }
    if ($SetLastError) { $Properties['SetLastError'] = $SetLastError }

    New-Object PSObject -Property $Properties
}

function Add-Win32Type
{
    [OutputType([Hashtable])]
    Param(
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [String]
        $DllName,

        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [String]
        $FunctionName,

        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [Type]
        $ReturnType,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Type[]]
        $ParameterTypes,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Runtime.InteropServices.CallingConvention]
        $NativeCallingConvention = [Runtime.InteropServices.CallingConvention]::StdCall,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Runtime.InteropServices.CharSet]
        $Charset = [Runtime.InteropServices.CharSet]::Auto,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Switch]
        $SetLastError,

        [Parameter(Mandatory = $True)]
        [ValidateScript({($_ -is [Reflection.Emit.ModuleBuilder]) -or ($_ -is [Reflection.Assembly])})]
        $Module,

        [ValidateNotNull()]
        [String]
        $Namespace = ''
    )

    BEGIN
    {
        $TypeHash = @{}
    }

    PROCESS
    {
        if ($Module -is [Reflection.Assembly])
        {
            if ($Namespace)
            {
                $TypeHash[$DllName] = $Module.GetType("$Namespace.$DllName")
            }
            else
            {
                $TypeHash[$DllName] = $Module.GetType($DllName)
            }
        }
        else
        {
            # Define one type for each DLL
            if (!$TypeHash.ContainsKey($DllName))
            {
                if ($Namespace)
                {
                    $TypeHash[$DllName] = $Module.DefineType("$Namespace.$DllName", 'Public,BeforeFieldInit')
                }
                else
                {
                    $TypeHash[$DllName] = $Module.DefineType($DllName, 'Public,BeforeFieldInit')
                }
            }

            $Method = $TypeHash[$DllName].DefineMethod(
                $FunctionName,
                'Public,Static,PinvokeImpl',
                $ReturnType,
                $ParameterTypes)

            # Make each ByRef parameter an Out parameter
            $i = 1
            ForEach($Parameter in $ParameterTypes)
            {
                if ($Parameter.IsByRef)
                {
                    [void] $Method.DefineParameter($i, 'Out', $Null)
                }

                $i++
            }

            $DllImport = [Runtime.InteropServices.DllImportAttribute]
            $SetLastErrorField = $DllImport.GetField('SetLastError')
            $CallingConventionField = $DllImport.GetField('CallingConvention')
            $CharsetField = $DllImport.GetField('CharSet')
            if ($SetLastError) { $SLEValue = $True } else { $SLEValue = $False }

            # Equivalent to C# version of [DllImport(DllName)]
            $Constructor = [Runtime.InteropServices.DllImportAttribute].GetConstructor([String])
            $DllImportAttribute = New-Object Reflection.Emit.CustomAttributeBuilder($Constructor,
                $DllName, [Reflection.PropertyInfo[]] @(), [Object[]] @(),
                [Reflection.FieldInfo[]] @($SetLastErrorField, $CallingConventionField, $CharsetField),
                [Object[]] @($SLEValue, ([Runtime.InteropServices.CallingConvention] $NativeCallingConvention), ([Runtime.InteropServices.CharSet] $Charset)))

            $Method.SetCustomAttribute($DllImportAttribute)
        }
    }

    END
    {
        if ($Module -is [Reflection.Assembly])
        {
            return $TypeHash
        }

        $ReturnTypes = @{}

        ForEach ($Key in $TypeHash.Keys)
        {
            $Type = $TypeHash[$Key].CreateType()

            $ReturnTypes[$Key] = $Type
        }

        return $ReturnTypes
    }
}


function psenum
{
    [OutputType([Type])]
    Param
    (
        [Parameter(Position = 0, Mandatory = $True)]
        [ValidateScript({($_ -is [Reflection.Emit.ModuleBuilder]) -or ($_ -is [Reflection.Assembly])})]
        $Module,

        [Parameter(Position = 1, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $FullName,

        [Parameter(Position = 2, Mandatory = $True)]
        [Type]
        $Type,

        [Parameter(Position = 3, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [Hashtable]
        $EnumElements,

        [Switch]
        $Bitfield
    )

    if ($Module -is [Reflection.Assembly])
    {
        return ($Module.GetType($FullName))
    }

    $EnumType = $Type -as [Type]

    $EnumBuilder = $Module.DefineEnum($FullName, 'Public', $EnumType)

    if ($Bitfield)
    {
        $FlagsConstructor = [FlagsAttribute].GetConstructor(@())
        $FlagsCustomAttribute = New-Object Reflection.Emit.CustomAttributeBuilder($FlagsConstructor, @())
        $EnumBuilder.SetCustomAttribute($FlagsCustomAttribute)
    }

    ForEach ($Key in $EnumElements.Keys)
    {
        # Apply the specified enum type to each element
        $Null = $EnumBuilder.DefineLiteral($Key, $EnumElements[$Key] -as $EnumType)
    }

    $EnumBuilder.CreateType()
}

function field
{
    Param
    (
        [Parameter(Position = 0, Mandatory = $True)]
        [UInt16]
        $Position,

        [Parameter(Position = 1, Mandatory = $True)]
        [Type]
        $Type,

        [Parameter(Position = 2)]
        [UInt16]
        $Offset,

        [Object[]]
        $MarshalAs
    )

    @{
        Position = $Position
        Type = $Type -as [Type]
        Offset = $Offset
        MarshalAs = $MarshalAs
    }
}

function struct
{
    [OutputType([Type])]
    Param
    (
        [Parameter(Position = 1, Mandatory = $True)]
        [ValidateScript({($_ -is [Reflection.Emit.ModuleBuilder]) -or ($_ -is [Reflection.Assembly])})]
        $Module,

        [Parameter(Position = 2, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $FullName,

        [Parameter(Position = 3, Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [Hashtable]
        $StructFields,

        [Reflection.Emit.PackingSize]
        $PackingSize = [Reflection.Emit.PackingSize]::Unspecified,

        [Switch]
        $ExplicitLayout
    )

    if ($Module -is [Reflection.Assembly])
    {
        return ($Module.GetType($FullName))
    }

    [Reflection.TypeAttributes] $StructAttributes = 'AnsiClass,
        Class,
        Public,
        Sealed,
        BeforeFieldInit'

    if ($ExplicitLayout)
    {
        $StructAttributes = $StructAttributes -bor [Reflection.TypeAttributes]::ExplicitLayout
    }
    else
    {
        $StructAttributes = $StructAttributes -bor [Reflection.TypeAttributes]::SequentialLayout
    }

    $StructBuilder = $Module.DefineType($FullName, $StructAttributes, [ValueType], $PackingSize)
    $ConstructorInfo = [Runtime.InteropServices.MarshalAsAttribute].GetConstructors()[0]
    $SizeConst = @([Runtime.InteropServices.MarshalAsAttribute].GetField('SizeConst'))

    $Fields = New-Object Hashtable[]($StructFields.Count)

    # Sort each field according to the orders specified
    # Unfortunately, PSv2 doesn't have the luxury of the
    # hashtable [Ordered] accelerator.
    ForEach ($Field in $StructFields.Keys)
    {
        $Index = $StructFields[$Field]['Position']
        $Fields[$Index] = @{FieldName = $Field; Properties = $StructFields[$Field]}
    }

    ForEach ($Field in $Fields)
    {
        $FieldName = $Field['FieldName']
        $FieldProp = $Field['Properties']

        $Offset = $FieldProp['Offset']
        $Type = $FieldProp['Type']
        $MarshalAs = $FieldProp['MarshalAs']

        $NewField = $StructBuilder.DefineField($FieldName, $Type, 'Public')

        if ($MarshalAs)
        {
            $UnmanagedType = $MarshalAs[0] -as ([Runtime.InteropServices.UnmanagedType])
            if ($MarshalAs[1])
            {
                $Size = $MarshalAs[1]
                $AttribBuilder = New-Object Reflection.Emit.CustomAttributeBuilder($ConstructorInfo,
                    $UnmanagedType, $SizeConst, @($Size))
            }
            else
            {
                $AttribBuilder = New-Object Reflection.Emit.CustomAttributeBuilder($ConstructorInfo, [Object[]] @($UnmanagedType))
            }

            $NewField.SetCustomAttribute($AttribBuilder)
        }

        if ($ExplicitLayout) { $NewField.SetOffset($Offset) }
    }

    # Make the struct aware of its own size.
    # No more having to call [Runtime.InteropServices.Marshal]::SizeOf!
    $SizeMethod = $StructBuilder.DefineMethod('GetSize',
        'Public, Static',
        [Int],
        [Type[]] @())
    $ILGenerator = $SizeMethod.GetILGenerator()
    # Thanks for the help, Jason Shirk!
    $ILGenerator.Emit([Reflection.Emit.OpCodes]::Ldtoken, $StructBuilder)
    $ILGenerator.Emit([Reflection.Emit.OpCodes]::Call,
        [Type].GetMethod('GetTypeFromHandle'))
    $ILGenerator.Emit([Reflection.Emit.OpCodes]::Call,
        [Runtime.InteropServices.Marshal].GetMethod('SizeOf', [Type[]] @([Type])))
    $ILGenerator.Emit([Reflection.Emit.OpCodes]::Ret)

    # Allow for explicit casting from an IntPtr
    # No more having to call [Runtime.InteropServices.Marshal]::PtrToStructure!
    $ImplicitConverter = $StructBuilder.DefineMethod('op_Implicit',
        'PrivateScope, Public, Static, HideBySig, SpecialName',
        $StructBuilder,
        [Type[]] @([IntPtr]))
    $ILGenerator2 = $ImplicitConverter.GetILGenerator()
    $ILGenerator2.Emit([Reflection.Emit.OpCodes]::Nop)
    $ILGenerator2.Emit([Reflection.Emit.OpCodes]::Ldarg_0)
    $ILGenerator2.Emit([Reflection.Emit.OpCodes]::Ldtoken, $StructBuilder)
    $ILGenerator2.Emit([Reflection.Emit.OpCodes]::Call,
        [Type].GetMethod('GetTypeFromHandle'))
    $ILGenerator2.Emit([Reflection.Emit.OpCodes]::Call,
        [Runtime.InteropServices.Marshal].GetMethod('PtrToStructure', [Type[]] @([IntPtr], [Type])))
    $ILGenerator2.Emit([Reflection.Emit.OpCodes]::Unbox_Any, $StructBuilder)
    $ILGenerator2.Emit([Reflection.Emit.OpCodes]::Ret)

    $StructBuilder.CreateType()
}

filter Get-IniContent {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True, ValueFromPipelineByPropertyName=$True)]
        [Alias('FullName')]
        [ValidateScript({ Test-Path -Path $_ })]
        [String[]]
        $Path
    )

    ForEach($TargetPath in $Path) {
        $IniObject = @{}
        Switch -Regex -File $TargetPath {
            "^\[(.+)\]" # Section
            {
                $Section = $matches[1].Trim()
                $IniObject[$Section] = @{}
                $CommentCount = 0
            }
            "^(;.*)$" # Comment
            {
                $Value = $matches[1].Trim()
                $CommentCount = $CommentCount + 1
                $Name = 'Comment' + $CommentCount
                $IniObject[$Section][$Name] = $Value
            } 
            "(.+?)\s*=(.*)" # Key
            {
                $Name, $Value = $matches[1..2]
                $Name = $Name.Trim()
                $Values = $Value.split(',') | ForEach-Object {$_.Trim()}
                if($Values -isnot [System.Array]) {$Values = @($Values)}
                $IniObject[$Section][$Name] = $Values
            }
        }
        $IniObject
    }
}

filter Export-PowerViewCSV {

    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True, ValueFromPipelineByPropertyName=$True)]
        [System.Management.Automation.PSObject[]]
        $InputObject,

        [Parameter(Mandatory=$True, Position=0)]
        [String]
        [ValidateNotNullOrEmpty()]
        $OutFile
    )

    $ObjectCSV = $InputObject | ConvertTo-Csv -NoTypeInformation

    # mutex so threaded code doesn't stomp on the output file
    $Mutex = New-Object System.Threading.Mutex $False,'CSVMutex';
    $Null = $Mutex.WaitOne()

    if (Test-Path -Path $OutFile) {
        # hack to skip the first line of output if the file already exists
        $ObjectCSV | ForEach-Object { $Start=$True }{ if ($Start) {$Start=$False} else {$_} } | Out-File -Encoding 'ASCII' -Append -FilePath $OutFile
    }
    else {
        $ObjectCSV | Out-File -Encoding 'ASCII' -Append -FilePath $OutFile
    }

    $Mutex.ReleaseMutex()
}

filter Get-IPAddress {

    [CmdletBinding()]
    param(
        [Parameter(Position=0, ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = $Env:ComputerName
    )

    try {
        # extract the computer name from whatever object was passed on the pipeline
        $Computer = $ComputerName | Get-NameField

        # get the IP resolution of this specified hostname
        @(([Net.Dns]::GetHostEntry($Computer)).AddressList) | ForEach-Object {
            if ($_.AddressFamily -eq 'InterNetwork') {
                $Out = New-Object PSObject
                $Out | Add-Member Noteproperty 'ComputerName' $Computer
                $Out | Add-Member Noteproperty 'IPAddress' $_.IPAddressToString
                $Out
            }
        }
    }
    catch {
        Write-Verbose -Message 'Could not resolve host to an IP Address.'
    }
}

filter Convert-NameToSid {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [String]
        [Alias('Name')]
        $ObjectName,

        [String]
        $Domain
    )

    $ObjectName = $ObjectName -Replace "/","\"
    
    if($ObjectName.Contains("\")) {
        # if we get a DOMAIN\user format, auto convert it
        $Domain = $ObjectName.Split("\")[0]
        $ObjectName = $ObjectName.Split("\")[1]
    }
    elseif(-not $Domain) {
        $Domain = (Get-ThisThingDomain).Name
    }

    try {
        $Obj = (New-Object System.Security.Principal.NTAccount($Domain, $ObjectName))
        $SID = $Obj.Translate([System.Security.Principal.SecurityIdentifier]).Value
        
        $Out = New-Object PSObject
        $Out | Add-Member Noteproperty 'ObjectName' $ObjectName
        $Out | Add-Member Noteproperty 'SID' $SID
        $Out
    }
    catch {
        Write-Verbose "Invalid object/name: $Domain\$ObjectName"
        $Null
    }
}

filter Convert-SidToName {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [String]
        [ValidatePattern('^S-1-.*')]
        $SID
    )

    try {
        $SID2 = $SID.trim('*')

        # try to resolve any built-in SIDs first
        #   from https://support.microsoft.com/en-us/kb/243330
        Switch ($SID2) {
            'S-1-0'         { 'Null Authority' }
            'S-1-0-0'       { 'Nobody' }
            'S-1-1'         { 'World Authority' }
            'S-1-1-0'       { 'Everyone' }
            'S-1-2'         { 'Local Authority' }
            'S-1-2-0'       { 'Local' }
            'S-1-2-1'       { 'Console Logon ' }
            'S-1-3'         { 'Creator Authority' }
            'S-1-3-0'       { 'Creator Owner' }
            'S-1-3-1'       { 'Creator Group' }
            'S-1-3-2'       { 'Creator Owner Server' }
            'S-1-3-3'       { 'Creator Group Server' }
            'S-1-3-4'       { 'Owner Rights' }
            'S-1-4'         { 'Non-unique Authority' }
            'S-1-5'         { 'NT Authority' }
            'S-1-5-1'       { 'Dialup' }
            'S-1-5-2'       { 'Network' }
            'S-1-5-3'       { 'Batch' }
            'S-1-5-4'       { 'Interactive' }
            'S-1-5-6'       { 'Service' }
            'S-1-5-7'       { 'Anonymous' }
            'S-1-5-8'       { 'Proxy' }
            'S-1-5-9'       { 'Enterprise Domain Controllers' }
            'S-1-5-10'      { 'Principal Self' }
            'S-1-5-11'      { 'Authenticated Users' }
            'S-1-5-12'      { 'Restricted Code' }
            'S-1-5-13'      { 'Terminal Server Users' }
            'S-1-5-14'      { 'Remote Interactive Logon' }
            'S-1-5-15'      { 'This Organization ' }
            'S-1-5-17'      { 'This Organization ' }
            'S-1-5-18'      { 'Local System' }
            'S-1-5-19'      { 'NT Authority' }
            'S-1-5-20'      { 'NT Authority' }
            'S-1-5-80-0'    { 'All Services ' }
            'S-1-5-32-544'  { 'BUILTIN\Administrators' }
            'S-1-5-32-545'  { 'BUILTIN\Users' }
            'S-1-5-32-546'  { 'BUILTIN\Guests' }
            'S-1-5-32-547'  { 'BUILTIN\Power Users' }
            'S-1-5-32-548'  { 'BUILTIN\Account Operators' }
            'S-1-5-32-549'  { 'BUILTIN\Server Operators' }
            'S-1-5-32-550'  { 'BUILTIN\Print Operators' }
            'S-1-5-32-551'  { 'BUILTIN\Backup Operators' }
            'S-1-5-32-552'  { 'BUILTIN\Replicators' }
            'S-1-5-32-554'  { 'BUILTIN\Pre-Windows 2000 Compatible Access' }
            'S-1-5-32-555'  { 'BUILTIN\Remote Desktop Users' }
            'S-1-5-32-556'  { 'BUILTIN\Network Configuration Operators' }
            'S-1-5-32-557'  { 'BUILTIN\Incoming Forest Trust Builders' }
            'S-1-5-32-558'  { 'BUILTIN\Performance Monitor Users' }
            'S-1-5-32-559'  { 'BUILTIN\Performance Log Users' }
            'S-1-5-32-560'  { 'BUILTIN\Windows Authorization Access Group' }
            'S-1-5-32-561'  { 'BUILTIN\Terminal Server License Servers' }
            'S-1-5-32-562'  { 'BUILTIN\Distributed COM Users' }
            'S-1-5-32-569'  { 'BUILTIN\Cryptographic Operators' }
            'S-1-5-32-573'  { 'BUILTIN\Event Log Readers' }
            'S-1-5-32-574'  { 'BUILTIN\Certificate Service DCOM Access' }
            'S-1-5-32-575'  { 'BUILTIN\RDS Remote Access Servers' }
            'S-1-5-32-576'  { 'BUILTIN\RDS Endpoint Servers' }
            'S-1-5-32-577'  { 'BUILTIN\RDS Management Servers' }
            'S-1-5-32-578'  { 'BUILTIN\Hyper-V Administrators' }
            'S-1-5-32-579'  { 'BUILTIN\Access Control Assistance Operators' }
            'S-1-5-32-580'  { 'BUILTIN\Access Control Assistance Operators' }
            Default { 
                $Obj = (New-Object System.Security.Principal.SecurityIdentifier($SID2))
                $Obj.Translate( [System.Security.Principal.NTAccount]).Value
            }
        }
    }
    catch {
        Write-Verbose "Invalid SID: $SID"
        $SID
    }
}

filter Convert-ADName {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [String]
        $ObjectName,

        [String]
        [ValidateSet("NT4","Simple","Canonical")]
        $InputType,

        [String]
        [ValidateSet("NT4","Simple","Canonical")]
        $OutputType
    )

    $NameTypes = @{
        'Canonical' = 2
        'NT4'       = 3
        'Simple'    = 5
    }

    if(-not $PSBoundParameters['InputType']) {
        if( ($ObjectName.split('/')).Count -eq 2 ) {
            $ObjectName = $ObjectName.replace('/', '\')
        }

        if($ObjectName -match "^[A-Za-z]+\\[A-Za-z ]+") {
            $InputType = 'NT4'
        }
        elseif($ObjectName -match "^[A-Za-z ]+@[A-Za-z\.]+") {
            $InputType = 'Simple'
        }
        elseif($ObjectName -match "^[A-Za-z\.]+/[A-Za-z]+/[A-Za-z/ ]+") {
            $InputType = 'Canonical'
        }
        else {
            #Write-Warning "Can not identify InType for $ObjectName"
            return $ObjectName
        }
    }
    elseif($InputType -eq 'NT4') {
        $ObjectName = $ObjectName.replace('/', '\')
    }

    if(-not $PSBoundParameters['OutputType']) {
        $OutputType = Switch($InputType) {
            'NT4' {'Canonical'}
            'Simple' {'NT4'}
            'Canonical' {'NT4'}
        }
    }

    # try to extract the domain from the given format
    $Domain = Switch($InputType) {
        'NT4' { $ObjectName.split("\")[0] }
        'Simple' { $ObjectName.split("@")[1] }
        'Canonical' { $ObjectName.split("/")[0] }
    }

    # Accessor functions to simplify calls to NameTranslate
    function Invoke-Method([__ComObject] $Object, [String] $Method, $Parameters) {
        $Output = $Object.GetType().InvokeMember($Method, "InvokeMethod", $Null, $Object, $Parameters)
        if ( $Output ) { $Output }
    }
    function Set-Property([__ComObject] $Object, [String] $Property, $Parameters) {
        [Void] $Object.GetType().InvokeMember($Property, "SetProperty", $Null, $Object, $Parameters)
    }

    $Translate = New-Object -ComObject NameTranslate

    try {
        Invoke-Method $Translate "Init" (1, $Domain)
    }
    catch [System.Management.Automation.MethodInvocationException] { 
        Write-Verbose "Error with translate init in Convert-ADName: $_"
    }

    Set-Property $Translate "ChaseReferral" (0x60)

    try {
        Invoke-Method $Translate "Set" ($NameTypes[$InputType], $ObjectName)
        (Invoke-Method $Translate "Get" ($NameTypes[$OutputType]))
    }
    catch [System.Management.Automation.MethodInvocationException] {
        Write-Verbose "Error with translate Set/Get in Convert-ADName: $_"
    }
}

function ConvertFrom-UACValue {
    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        $Value,

        [Switch]
        $ShowAll
    )

    begin {
        # values from https://support.microsoft.com/en-us/kb/305144
        $UACValues = New-Object System.Collections.Specialized.OrderedDictionary
        $UACValues.Add("SCRIPT", 1)
        $UACValues.Add("ACCOUNTDISABLE", 2)
        $UACValues.Add("HOMEDIR_REQUIRED", 8)
        $UACValues.Add("LOCKOUT", 16)
        $UACValues.Add("PASSWD_NOTREQD", 32)
        $UACValues.Add("PASSWD_CANT_CHANGE", 64)
        $UACValues.Add("ENCRYPTED_TEXT_PWD_ALLOWED", 128)
        $UACValues.Add("TEMP_DUPLICATE_ACCOUNT", 256)
        $UACValues.Add("NORMAL_ACCOUNT", 512)
        $UACValues.Add("INTERDOMAIN_TRUST_ACCOUNT", 2048)
        $UACValues.Add("WORKSTATION_TRUST_ACCOUNT", 4096)
        $UACValues.Add("SERVER_TRUST_ACCOUNT", 8192)
        $UACValues.Add("DONT_EXPIRE_PASSWORD", 65536)
        $UACValues.Add("MNS_LOGON_ACCOUNT", 131072)
        $UACValues.Add("SMARTCARD_REQUIRED", 262144)
        $UACValues.Add("TRUSTED_FOR_DELEGATION", 524288)
        $UACValues.Add("NOT_DELEGATED", 1048576)
        $UACValues.Add("USE_DES_KEY_ONLY", 2097152)
        $UACValues.Add("DONT_REQ_PREAUTH", 4194304)
        $UACValues.Add("PASSWORD_EXPIRED", 8388608)
        $UACValues.Add("TRUSTED_TO_AUTH_FOR_DELEGATION", 16777216)
        $UACValues.Add("PARTIAL_SECRETS_ACCOUNT", 67108864)
    }

    process {

        $ResultUACValues = New-Object System.Collections.Specialized.OrderedDictionary

        if($Value -is [Int]) {
            $IntValue = $Value
        }
        elseif ($Value -is [PSCustomObject]) {
            if($Value.useraccountcontrol) {
                $IntValue = $Value.useraccountcontrol
            }
        }
        else {
            #Write-Warning "Invalid object input for -Value : $Value"
            return $Null 
        }

        if($ShowAll) {
            foreach ($UACValue in $UACValues.GetEnumerator()) {
                if( ($IntValue -band $UACValue.Value) -eq $UACValue.Value) {
                    $ResultUACValues.Add($UACValue.Name, "$($UACValue.Value)+")
                }
                else {
                    $ResultUACValues.Add($UACValue.Name, "$($UACValue.Value)")
                }
            }
        }
        else {
            foreach ($UACValue in $UACValues.GetEnumerator()) {
                if( ($IntValue -band $UACValue.Value) -eq $UACValue.Value) {
                    $ResultUACValues.Add($UACValue.Name, "$($UACValue.Value)")
                }
            }
        }
        $ResultUACValues
    }
}

filter Get-Proxy {
    param(
        [Parameter(ValueFromPipeline=$True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $ComputerName = $ENV:COMPUTERNAME
    )

    try {
        $Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('CurrentUser', $ComputerName)
        $RegKey = $Reg.OpenSubkey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Internet Settings")
        $ProxyServer = $RegKey.GetValue('ProxyServer')
        $AutoConfigURL = $RegKey.GetValue('AutoConfigURL')

        $Wpad = ""
        if($AutoConfigURL -and ($AutoConfigURL -ne "")) {
            try {
                $Wpad = (New-Object Net.Webclient).DownloadString($AutoConfigURL)
            }
            catch {
                #Write-Warning "Error connecting to AutoConfigURL : $AutoConfigURL"
            }
        }
        
        if($ProxyServer -or $AutoConfigUrl) {

            $Properties = @{
                'ProxyServer' = $ProxyServer
                'AutoConfigURL' = $AutoConfigURL
                'Wpad' = $Wpad
            }
            
            New-Object -TypeName PSObject -Property $Properties
        }
        else {
            Write-Warning "No proxy settings found for $ComputerName"
        }
    }
    catch {
        Write-Warning "Error enumerating proxy settings for $ComputerName : $_"
    }
}

function Request-SPNTicket {

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyName = $True)]
        [Alias('ServicePrincipalName')]
        [String[]]
        $SPN,
        
        [Alias('EncryptedPart')]
        [Switch]
        $EncPart
    )

    begin {
        Add-Type -AssemblyName System.IdentityModel
    }

    process {
        ForEach($UserSPN in $SPN) {
            Write-Verbose "Requesting ticket for: $UserSPN"
            if (!$EncPart) {
                New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList $UserSPN
            }
            else {
                $Ticket = New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList $UserSPN
                $TicketByteStream = $Ticket.GetRequest()
                if ($TicketByteStream)
                {
                    $TicketHexStream = [System.BitConverter]::ToString($TicketByteStream) -replace "-"
                    [System.Collections.ArrayList]$Parts = ($TicketHexStream -replace '^(.*?)04820...(.*)','$2') -Split "A48201"
                    $Parts.RemoveAt($Parts.Count - 1)
                    $Parts -join "A48201"
                    break
                }
            }
        }
    }
}

function Get-PathAcl {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [String]
        $Path,

        [Switch]
        $Recurse
    )

    begin {

        function Convert-FileRight {

            # From http://stackoverflow.com/questions/28029872/retrieving-security-descriptor-and-getting-number-for-filesystemrights

            [CmdletBinding()]
            param(
                [Int]
                $FSR
            )

            $AccessMask = @{
              [uint32]'0x80000000' = 'GenericRead'
              [uint32]'0x40000000' = 'GenericWrite'
              [uint32]'0x20000000' = 'GenericExecute'
              [uint32]'0x10000000' = 'GenericAll'
              [uint32]'0x02000000' = 'MaximumAllowed'
              [uint32]'0x01000000' = 'AccessSystemSecurity'
              [uint32]'0x00100000' = 'Synchronize'
              [uint32]'0x00080000' = 'WriteOwner'
              [uint32]'0x00040000' = 'WriteDAC'
              [uint32]'0x00020000' = 'ReadControl'
              [uint32]'0x00010000' = 'Delete'
              [uint32]'0x00000100' = 'WriteAttributes'
              [uint32]'0x00000080' = 'ReadAttributes'
              [uint32]'0x00000040' = 'DeleteChild'
              [uint32]'0x00000020' = 'Execute/Traverse'
              [uint32]'0x00000010' = 'WriteExtendedAttributes'
              [uint32]'0x00000008' = 'ReadExtendedAttributes'
              [uint32]'0x00000004' = 'AppendData/AddSubdirectory'
              [uint32]'0x00000002' = 'WriteData/AddFile'
              [uint32]'0x00000001' = 'ReadData/ListDirectory'
            }

            $SimplePermissions = @{
              [uint32]'0x1f01ff' = 'FullControl'
              [uint32]'0x0301bf' = 'Modify'
              [uint32]'0x0200a9' = 'ReadAndExecute'
              [uint32]'0x02019f' = 'ReadAndWrite'
              [uint32]'0x020089' = 'Read'
              [uint32]'0x000116' = 'Write'
            }

            $Permissions = @()

            # get simple permission
            $Permissions += $SimplePermissions.Keys |  % {
                              if (($FSR -band $_) -eq $_) {
                                $SimplePermissions[$_]
                                $FSR = $FSR -band (-not $_)
                              }
                            }

            # get remaining extended permissions
            $Permissions += $AccessMask.Keys |
                            ? { $FSR -band $_ } |
                            % { $AccessMask[$_] }

            ($Permissions | ?{$_}) -join ","
        }
    }

    process {

        try {
            $ACL = Get-Acl -Path $Path

            [String]$PathOwner = $ACL.Owner

            $ACL.GetAccessRules($true,$true,[System.Security.Principal.SecurityIdentifier]) | ForEach-Object {

                $Names = @()
                if ($_.IdentityReference -match '^S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+') {
                    $Object = Get-ADObject -SID $_.IdentityReference
                    $Names = @()
                    $SIDs = @($Object.objectsid)

                    if ($Recurse -and (@('268435456','268435457','536870912','536870913') -contains $Object.samAccountType)) {
                        $SIDs += Get-ThisThingGroupMember -SID $Object.objectsid | Select-Object -ExpandProperty MemberSid
                    }

                    $SIDs | ForEach-Object {
                        $Names += ,@($_, (Convert-SidToName $_))
                    }
                }
                else {
                    $Names += ,@($_.IdentityReference.Value, (Convert-SidToName $_.IdentityReference.Value))
                }

                ForEach($Name in $Names) {
                    $Out = New-Object PSObject
                    $Out | Add-Member Noteproperty 'Path' $Path
                    $Out | Add-Member Noteproperty 'PathOwner' $PathOwner
                    $Out | Add-Member Noteproperty 'FileSystemRights' (Convert-FileRight -FSR $_.FileSystemRights.value__)
                    $Out | Add-Member Noteproperty 'IdentityReference' $Name[1]
                    $Out | Add-Member Noteproperty 'IdentitySID' $Name[0]
                    $Out | Add-Member Noteproperty 'AccessControlType' $_.AccessControlType
                    $Out
                }
            }
        }
        catch {
            #Write-Warning $_
        }
    }
}

filter Get-NameField {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [Object]
        $Object,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [String]
        $DnsHostName,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [String]
        $Name
    )

    if($PSBoundParameters['DnsHostName']) {
        $DnsHostName
    }
    elseif($PSBoundParameters['Name']) {
        $Name
    }
    elseif($Object) {
        if ( [bool]($Object.PSobject.Properties.name -match "dnshostname") ) {
            # objects from Get-ThisThingComputer
            $Object.dnshostname
        }
        elseif ( [bool]($Object.PSobject.Properties.name -match "name") ) {
            # objects from Get-ThisThingDomainController
            $Object.name
        }
        else {
            # strings and catch alls
            $Object
        }
    }
    else {
        return $Null
    }
}

function Convert-LDAPProperty {
    param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [ValidateNotNullOrEmpty()]
        $Properties
    )

    $ObjectProperties = @{}

    $Properties.PropertyNames | ForEach-Object {
        if (($_ -eq "objectsid") -or ($_ -eq "sidhistory")) {
            # convert the SID to a string
            $ObjectProperties[$_] = (New-Object System.Security.Principal.SecurityIdentifier($Properties[$_][0],0)).Value
        }
        elseif($_ -eq "objectguid") {
            # convert the GUID to a string
            $ObjectProperties[$_] = (New-Object Guid (,$Properties[$_][0])).Guid
        }
        elseif( ($_ -eq "lastlogon") -or ($_ -eq "lastlogontimestamp") -or ($_ -eq "pwdlastset") -or ($_ -eq "lastlogoff") -or ($_ -eq "badPasswordTime") ) {
            # convert timestamps
            if ($Properties[$_][0] -is [System.MarshalByRefObject]) {
                # if we have a System.__ComObject
                $Temp = $Properties[$_][0]
                [Int32]$High = $Temp.GetType().InvokeMember("HighPart", [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
                [Int32]$Low  = $Temp.GetType().InvokeMember("LowPart",  [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
                $ObjectProperties[$_] = ([datetime]::FromFileTime([Int64]("0x{0:x8}{1:x8}" -f $High, $Low)))
            }
            else {
                $ObjectProperties[$_] = ([datetime]::FromFileTime(($Properties[$_][0])))
            }
        }
        elseif($Properties[$_][0] -is [System.MarshalByRefObject]) {
            # try to convert misc com objects
            $Prop = $Properties[$_]
            try {
                $Temp = $Prop[$_][0]
                Write-Verbose $_
                [Int32]$High = $Temp.GetType().InvokeMember("HighPart", [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
                [Int32]$Low  = $Temp.GetType().InvokeMember("LowPart",  [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
                $ObjectProperties[$_] = [Int64]("0x{0:x8}{1:x8}" -f $High, $Low)
            }
            catch {
                $ObjectProperties[$_] = $Prop[$_]
            }
        }
        elseif($Properties[$_].count -eq 1) {
            $ObjectProperties[$_] = $Properties[$_][0]
        }
        else {
            $ObjectProperties[$_] = $Properties[$_]
        }
    }

    New-Object -TypeName PSObject -Property $ObjectProperties
}

filter Get-DomainSearcher {
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [String]
        $ADSprefix,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    if(-not $Credential) {
        if(-not $Domain) {
            $Domain = (Get-ThisThingDomain).name
        }
        elseif(-not $DomainController) {
            try {
                # if there's no -DomainController specified, try to pull the primary DC to reflect queries through
                $DomainController = ((Get-ThisThingDomain).PdcRoleOwner).Name
            }
            catch {
                throw "Get-DomainSearcher: Error in retrieving PDC for current domain"
            }
        }
    }
    elseif (-not $DomainController) {
        # if a DC isn't specified
        try {
            $DomainController = ((Get-ThisThingDomain -Credential $Credential).PdcRoleOwner).Name
        }
        catch {
            throw "Get-DomainSearcher: Error in retrieving PDC for current domain"
        }

        if(!$DomainController) {
            throw "Get-DomainSearcher: Error in retrieving PDC for current domain"
        }
    }

    $SearchString = "LDAP://"

    if($DomainController) {
        $SearchString += $DomainController
        if($Domain){
            $SearchString += '/'
        }
    }

    if($ADSprefix) {
        $SearchString += $ADSprefix + ','
    }

    if($ADSpath) {
        if($ADSpath -Match '^GC://') {
            # if we're searching the global catalog
            $DN = $AdsPath.ToUpper().Trim('/')
            $SearchString = ''
        }
        else {
            if($ADSpath -match '^LDAP://') {
                if($ADSpath -match "LDAP://.+/.+") {
                    $SearchString = ''
                }
                else {
                    $ADSpath = $ADSpath.Substring(7)
                }
            }
            $DN = $ADSpath
        }
    }
    else {
        if($Domain -and ($Domain.Trim() -ne "")) {
            $DN = "DC=$($Domain.Replace('.', ',DC='))"
        }
    }

    $SearchString += $DN
    Write-Verbose "Get-DomainSearcher search string: $SearchString"

    if($Credential) {
        Write-Verbose "Using alternate credentials for LDAP connection"
        $DomainObject = New-Object DirectoryServices.DirectoryEntry($SearchString, $Credential.UserName, $Credential.GetNetworkCredential().Password)
        $Searcher = New-Object System.DirectoryServices.DirectorySearcher($DomainObject)
    }
    else {
        $Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
    }

    $Searcher.PageSize = $PageSize
    $Searcher.CacheResults = $False
    $Searcher
}

filter Convert-DNSRecord {
    param(
        [Parameter(Position=0, ValueFromPipelineByPropertyName=$True, Mandatory=$True)]
        [Byte[]]
        $DNSRecord
    )

    function Get-Name {
        # modified decodeName from https://raw.githubusercontent.com/mmessano/PowerShell/master/dns-dump.ps1
        [CmdletBinding()]
        param(
            [Byte[]]
            $Raw
        )

        [Int]$Length = $Raw[0]
        [Int]$Segments = $Raw[1]
        [Int]$Index =  2
        [String]$Name  = ""

        while ($Segments-- -gt 0)
        {
            [Int]$SegmentLength = $Raw[$Index++]
            while ($SegmentLength-- -gt 0) {
                $Name += [Char]$Raw[$Index++]
            }
            $Name += "."
        }
        $Name
    }

    $RDataLen = [BitConverter]::ToUInt16($DNSRecord, 0)
    $RDataType = [BitConverter]::ToUInt16($DNSRecord, 2)
    $UpdatedAtSerial = [BitConverter]::ToUInt32($DNSRecord, 8)

    $TTLRaw = $DNSRecord[12..15]
    # reverse for big endian
    $Null = [array]::Reverse($TTLRaw)
    $TTL = [BitConverter]::ToUInt32($TTLRaw, 0)

    $Age = [BitConverter]::ToUInt32($DNSRecord, 20)
    if($Age -ne 0) {
        $TimeStamp = ((Get-Date -Year 1601 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0).AddHours($age)).ToString()
    }
    else {
        $TimeStamp = "[static]"
    }

    $DNSRecordObject = New-Object PSObject

    if($RDataType -eq 1) {
        $IP = "{0}.{1}.{2}.{3}" -f $DNSRecord[24], $DNSRecord[25], $DNSRecord[26], $DNSRecord[27]
        $Data = $IP
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'A'
    }

    elseif($RDataType -eq 2) {
        $NSName = Get-Name $DNSRecord[24..$DNSRecord.length]
        $Data = $NSName
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'NS'
    }

    elseif($RDataType -eq 5) {
        $Alias = Get-Name $DNSRecord[24..$DNSRecord.length]
        $Data = $Alias
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'CNAME'
    }

    elseif($RDataType -eq 6) {
        # TODO: how to implement properly? nested object?
        $Data = $([System.Convert]::ToBase64String($DNSRecord[24..$DNSRecord.length]))
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'SOA'
    }

    elseif($RDataType -eq 12) {
        $Ptr = Get-Name $DNSRecord[24..$DNSRecord.length]
        $Data = $Ptr
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'PTR'
    }

    elseif($RDataType -eq 13) {
        # TODO: how to implement properly? nested object?
        $Data = $([System.Convert]::ToBase64String($DNSRecord[24..$DNSRecord.length]))
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'HINFO'
    }

    elseif($RDataType -eq 15) {
        # TODO: how to implement properly? nested object?
        $Data = $([System.Convert]::ToBase64String($DNSRecord[24..$DNSRecord.length]))
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'MX'
    }

    elseif($RDataType -eq 16) {

        [string]$TXT  = ""
        [int]$SegmentLength = $DNSRecord[24]
        $Index = 25
        while ($SegmentLength-- -gt 0) {
            $TXT += [char]$DNSRecord[$index++]
        }

        $Data = $TXT
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'TXT'
    }

    elseif($RDataType -eq 28) {
        # TODO: how to implement properly? nested object?
        $Data = $([System.Convert]::ToBase64String($DNSRecord[24..$DNSRecord.length]))
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'AAAA'
    }

    elseif($RDataType -eq 33) {
        # TODO: how to implement properly? nested object?
        $Data = $([System.Convert]::ToBase64String($DNSRecord[24..$DNSRecord.length]))
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'SRV'
    }

    else {
        $Data = $([System.Convert]::ToBase64String($DNSRecord[24..$DNSRecord.length]))
        $DNSRecordObject | Add-Member Noteproperty 'RecordType' 'UNKNOWN'
    }

    $DNSRecordObject | Add-Member Noteproperty 'UpdatedAtSerial' $UpdatedAtSerial
    $DNSRecordObject | Add-Member Noteproperty 'TTL' $TTL
    $DNSRecordObject | Add-Member Noteproperty 'Age' $Age
    $DNSRecordObject | Add-Member Noteproperty 'TimeStamp' $TimeStamp
    $DNSRecordObject | Add-Member Noteproperty 'Data' $Data
    $DNSRecordObject
}

filter Get-DNSZone {
    param(
        [Parameter(Position=0, ValueFromPipeline=$True)]
        [String]
        $Domain,

        [String]
        $DomainController,

        [ValidateRange(1,10000)]
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential,

        [Switch]
        $FullData
    )

    $DNSSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -PageSize $PageSize -Credential $Credential
    $DNSSearcher.filter="(objectClass=dnsZone)"

    if($DNSSearcher) {
        $Results = $DNSSearcher.FindAll()
        $Results | Where-Object {$_} | ForEach-Object {
            # convert/process the LDAP fields for each result
            $Properties = Convert-LDAPProperty -Properties $_.Properties
            $Properties | Add-Member NoteProperty 'ZoneName' $Properties.name

            if ($FullData) {
                $Properties
            }
            else {
                $Properties | Select-Object ZoneName,distinguishedname,whencreated,whenchanged
            }
        }
        $Results.dispose()
        $DNSSearcher.dispose()
    }

    $DNSSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -PageSize $PageSize -Credential $Credential -ADSprefix "CN=MicrosoftDNS,DC=DomainDnsZones"
    $DNSSearcher.filter="(objectClass=dnsZone)"

    if($DNSSearcher) {
        $Results = $DNSSearcher.FindAll()
        $Results | Where-Object {$_} | ForEach-Object {
            # convert/process the LDAP fields for each result
            $Properties = Convert-LDAPProperty -Properties $_.Properties
            $Properties | Add-Member NoteProperty 'ZoneName' $Properties.name

            if ($FullData) {
                $Properties
            }
            else {
                $Properties | Select-Object ZoneName,distinguishedname,whencreated,whenchanged
            }
        }
        $Results.dispose()
        $DNSSearcher.dispose()
    }
}

filter Get-DNSRecord {
    param(
        [Parameter(Position=0, ValueFromPipelineByPropertyName=$True, Mandatory=$True)]
        [String]
        $ZoneName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [ValidateRange(1,10000)]
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    $DNSSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -PageSize $PageSize -Credential $Credential -ADSprefix "DC=$($ZoneName),CN=MicrosoftDNS,DC=DomainDnsZones"
    $DNSSearcher.filter="(objectClass=dnsNode)"

    if($DNSSearcher) {
        $Results = $DNSSearcher.FindAll()
        $Results | Where-Object {$_} | ForEach-Object {
            try {
                # convert/process the LDAP fields for each result
                $Properties = Convert-LDAPProperty -Properties $_.Properties | Select-Object name,distinguishedname,dnsrecord,whencreated,whenchanged
                $Properties | Add-Member NoteProperty 'ZoneName' $ZoneName

                # convert the record and extract the properties
                if ($Properties.dnsrecord -is [System.DirectoryServices.ResultPropertyValueCollection]) {
                    # TODO: handle multiple nested records properly?
                    $Record = Convert-DNSRecord -DNSRecord $Properties.dnsrecord[0]
                }
                else {
                    $Record = Convert-DNSRecord -DNSRecord $Properties.dnsrecord
                }

                if($Record) {
                    $Record.psobject.properties | ForEach-Object {
                        $Properties | Add-Member NoteProperty $_.Name $_.Value
                    }
                }

                $Properties
            }
            catch {
                #Write-Warning "ERROR: $_"
                $Properties
            }
        }
        $Results.dispose()
        $DNSSearcher.dispose()
    }
}

filter Get-ThisThingDomain {
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Domain,

        [Management.Automation.PSCredential]
        $Credential
    )

    if($Credential) {
        
        Write-Verbose "Using alternate credentials for Get-ThisThingDomain"

        if(!$Domain) {
            # if no domain is supplied, extract the logon domain from the PSCredential passed
            $Domain = $Credential.GetNetworkCredential().Domain
            Write-Verbose "Extracted domain '$Domain' from -Credential"
        }
   
        $DomainContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $Domain, $Credential.UserName, $Credential.GetNetworkCredential().Password)
        
        try {
            [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainContext)
        }
        catch {
            Write-Verbose "The specified domain does '$Domain' not exist, could not be contacted, there isn't an existing trust, or the specified credentials are invalid."
            $Null
        }
    }
    elseif($Domain) {
        $DomainContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $Domain)
        try {
            [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainContext)
        }
        catch {
            Write-Verbose "The specified domain '$Domain' does not exist, could not be contacted, or there isn't an existing trust."
            $Null
        }
    }
    else {
        [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
    }
}

filter Get-ThisThingForest {
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Forest,

        [Management.Automation.PSCredential]
        $Credential
    )

    if($Credential) {
        
        Write-Verbose "Using alternate credentials for Get-ThisThingForest"

        if(!$Forest) {
            # if no domain is supplied, extract the logon domain from the PSCredential passed
            $Forest = $Credential.GetNetworkCredential().Domain
            Write-Verbose "Extracted domain '$Forest' from -Credential"
        }
   
        $ForestContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Forest', $Forest, $Credential.UserName, $Credential.GetNetworkCredential().Password)
        
        try {
            $ForestObject = [System.DirectoryServices.ActiveDirectory.Forest]::GetForest($ForestContext)
        }
        catch {
            Write-Verbose "The specified forest '$Forest' does not exist, could not be contacted, there isn't an existing trust, or the specified credentials are invalid."
            $Null
        }
    }
    elseif($Forest) {
        $ForestContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Forest', $Forest)
        try {
            $ForestObject = [System.DirectoryServices.ActiveDirectory.Forest]::GetForest($ForestContext)
        }
        catch {
            Write-Verbose "The specified forest '$Forest' does not exist, could not be contacted, or there isn't an existing trust."
            return $Null
        }
    }
    else {
        # otherwise use the current forest
        $ForestObject = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
    }

    if($ForestObject) {
        # get the SID of the forest root
        $ForestSid = (New-Object System.Security.Principal.NTAccount($ForestObject.RootDomain,"krbtgt")).Translate([System.Security.Principal.SecurityIdentifier]).Value
        $Parts = $ForestSid -Split "-"
        $ForestSid = $Parts[0..$($Parts.length-2)] -join "-"
        $ForestObject | Add-Member NoteProperty 'RootDomainSid' $ForestSid
        $ForestObject
    }
}

filter Get-ThisThingForestDomain {
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Forest,

        [Management.Automation.PSCredential]
        $Credential
    )

    $ForestObject = Get-ThisThingForest -Forest $Forest -Credential $Credential

    if($ForestObject) {
        $ForestObject.Domains
    }
}

filter Get-ThisThingForestCatalog {  
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Forest,

        [Management.Automation.PSCredential]
        $Credential
    )

    $ForestObject = Get-ThisThingForest -Forest $Forest -Credential $Credential

    if($ForestObject) {
        $ForestObject.FindAllGlobalCatalogs()
    }
}

filter Get-ThisThingDomainController {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Domain,

        [String]
        $DomainController,

        [Switch]
        $LDAP,

        [Management.Automation.PSCredential]
        $Credential
    )

    if($LDAP -or $DomainController) {
        # filter string to return all domain controllers
        Get-ThisThingComputer -Domain $Domain -DomainController $DomainController -Credential $Credential -FullData -Filter '(userAccountControl:1.2.840.113556.1.4.803:=8192)'
    }
    else {
        $FoundDomain = Get-ThisThingDomain -Domain $Domain -Credential $Credential
        if($FoundDomain) {
            $Founddomain.DomainControllers
        }
    }
}

function Get-ThisThingUser {
    param(
        [Parameter(Position=0, ValueFromPipeline=$True)]
        [String]
        $UserName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [String]
        $Filter,

        [Switch]
        $SPN,

        [Switch]
        $AdminCount,

        [Switch]
        $Unconstrained,

        [Switch]
        $AllowDelegation,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        # so this isn't repeated if users are passed on the pipeline
        $UserSearcher = Get-DomainSearcher -Domain $Domain -ADSpath $ADSpath -DomainController $DomainController -PageSize $PageSize -Credential $Credential
    }

    process {
        if($UserSearcher) {

            # if we're checking for unconstrained delegation
            if($Unconstrained) {
                Write-Verbose "Checking for unconstrained delegation"
                $Filter += "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
            }
            if($AllowDelegation) {
                Write-Verbose "Checking for users who can be delegated"
                # negation of "Accounts that are sensitive and not trusted for delegation"
                $Filter += "(!(userAccountControl:1.2.840.113556.1.4.803:=1048574))"
            }
            if($AdminCount) {
                Write-Verbose "Checking for adminCount=1"
                $Filter += "(admincount=1)"
            }

            # check if we're using a username filter or not
            if($UserName) {
                # samAccountType=805306368 indicates user objects
                $UserSearcher.filter="(&(samAccountType=805306368)(samAccountName=$UserName)$Filter)"
            }
            elseif($SPN) {
                $UserSearcher.filter="(&(samAccountType=805306368)(servicePrincipalName=*)$Filter)"
            }
            else {
                # filter is something like "(samAccountName=*blah*)" if specified
                $UserSearcher.filter="(&(samAccountType=805306368)$Filter)"
            }

            $Results = $UserSearcher.FindAll()
            $Results | Where-Object {$_} | ForEach-Object {
                # convert/process the LDAP fields for each result
                $User = Convert-LDAPProperty -Properties $_.Properties
                $User.PSObject.TypeNames.Add('PowerView.User')
                $User
            }
            $Results.dispose()
            $UserSearcher.dispose()
        }
    }
}

function Add-NetUser {
    [CmdletBinding()]
    Param (
        [ValidateNotNullOrEmpty()]
        [String]
        $UserName = 'backdoor',

        [ValidateNotNullOrEmpty()]
        [String]
        $Password = 'Password123!',

        [ValidateNotNullOrEmpty()]
        [String]
        $GroupName,

        [ValidateNotNullOrEmpty()]
        [Alias('HostName')]
        [String]
        $ComputerName = 'localhost',

        [ValidateNotNullOrEmpty()]
        [String]
        $Domain
    )

    if ($Domain) {

        $DomainObject = Get-ThisThingDomain -Domain $Domain
        if(-not $DomainObject) {
            #Write-Warning "Error in grabbing $Domain object"
            return $Null
        }

        # add the assembly we need
        Add-Type -AssemblyName System.DirectoryServices.AccountManagement

        # http://richardspowershellblog.wordpress.com/2008/05/25/system-directoryservices-accountmanagement/
        # get the domain context
        $Context = New-Object -TypeName System.DirectoryServices.AccountManagement.PrincipalContext -ArgumentList ([System.DirectoryServices.AccountManagement.ContextType]::Domain), $DomainObject

        # create the user object
        $User = New-Object -TypeName System.DirectoryServices.AccountManagement.UserPrincipal -ArgumentList $Context

        # set user properties
        $User.Name = $UserName
        $User.SamAccountName = $UserName
        $User.PasswordNotRequired = $False
        $User.SetPassword($Password)
        $User.Enabled = $True

        Write-Verbose "Creating user $UserName to with password '$Password' in domain $Domain"

        try {
            # commit the user
            $User.Save()
            "[*] User $UserName successfully created in domain $Domain"
        }
        catch {
            #Write-Warning '[!] User already exists!'
            return
        }
    }
    else {
        
        Write-Verbose "Creating user $UserName to with password '$Password' on $ComputerName"

        # if it's not a domain add, it's a local machine add
        $ObjOu = [ADSI]"WinNT://$ComputerName"
        $ObjUser = $ObjOu.Create('User', $UserName)
        $ObjUser.SetPassword($Password)

        # commit the changes to the local machine
        try {
            $Null = $ObjUser.SetInfo()
            "[*] User $UserName successfully created on host $ComputerName"
        }
        catch {
            #Write-Warning '[!] Account already exists!'
            return
        }
    }

    # if a group is specified, invoke Add-NetGroupUser and return its value
    if ($GroupName) {
        # if we're adding the user to a domain
        if ($Domain) {
            Add-NetGroupUser -UserName $UserName -GroupName $GroupName -Domain $Domain
            "[*] User $UserName successfully added to group $GroupName in domain $Domain"
        }
        # otherwise, we're adding to a local group
        else {
            Add-NetGroupUser -UserName $UserName -GroupName $GroupName -ComputerName $ComputerName
            "[*] User $UserName successfully added to group $GroupName on host $ComputerName"
        }
    }
}

function Add-NetGroupUser {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $UserName,

        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $GroupName,

        [ValidateNotNullOrEmpty()]
        [Alias('HostName')]
        [String]
        $ComputerName,

        [String]
        $Domain
    )

    # add the assembly if we need it
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement

    # if we're adding to a remote host's local group, use the WinNT provider
    if($ComputerName -and ($ComputerName -ne "localhost")) {
        try {
            Write-Verbose "Adding user $UserName to $GroupName on host $ComputerName"
            ([ADSI]"WinNT://$ComputerName/$GroupName,group").add("WinNT://$ComputerName/$UserName,user")
            "[*] User $UserName successfully added to group $GroupName on $ComputerName"
        }
        catch {
            Write-Warning "[!] Error adding user $UserName to group $GroupName on $ComputerName"
            return
        }
    }

    # otherwise it's a local machine or domain add
    else {
        try {
            if ($Domain) {
                Write-Verbose "Adding user $UserName to $GroupName on domain $Domain"
                $CT = [System.DirectoryServices.AccountManagement.ContextType]::Domain
                $DomainObject = Get-ThisThingDomain -Domain $Domain
                if(-not $DomainObject) {
                    return $Null
                }
                # get the full principal context
                $Context = New-Object -TypeName System.DirectoryServices.AccountManagement.PrincipalContext -ArgumentList $CT, $DomainObject            
            }
            else {
                # otherwise, get the local machine context
                Write-Verbose "Adding user $UserName to $GroupName on localhost"
                $Context = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine, $Env:ComputerName)
            }

            # find the particular group
            $Group = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($Context,$GroupName)

            # add the particular user to the group
            $Group.Members.add($Context, [System.DirectoryServices.AccountManagement.IdentityType]::SamAccountName, $UserName)

            # commit the changes
            $Group.Save()
        }
        catch {
            Write-Warning "Error adding $UserName to $GroupName : $_"
        }
    }
}

function Get-UserProperty {
    [CmdletBinding()]
    param(
        [String[]]
        $Properties,

        [String]
        $Domain,
        
        [String]
        $DomainController,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    if($Properties) {
        # extract out the set of all properties for each object
        $Properties = ,"name" + $Properties
        Get-ThisThingUser -Domain $Domain -DomainController $DomainController -PageSize $PageSize -Credential $Credential | Select-Object -Property $Properties
    }
    else {
        # extract out just the property names
        Get-ThisThingUser -Domain $Domain -DomainController $DomainController -PageSize $PageSize -Credential $Credential | Select-Object -First 1 | Get-Member -MemberType *Property | Select-Object -Property 'Name'
    }
}

filter Find-UserField {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [String]
        $SearchTerm = 'pass',

        [String]
        $SearchField = 'description',

        [String]
        $ADSpath,

        [String]
        $Domain,

        [String]
        $DomainController,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )
 
    Get-ThisThingUser -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -Credential $Credential -Filter "($SearchField=*$SearchTerm*)" -PageSize $PageSize | Select-Object samaccountname,$SearchField
}

filter Get-UserEvent {
    Param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $ComputerName = $Env:ComputerName,

        [String]
        [ValidateSet("logon","tgt","all")]
        $EventType = "logon",

        [DateTime]
        $DateStart = [DateTime]::Today.AddDays(-5),

        [Management.Automation.PSCredential]
        $Credential
    )

    if($EventType.ToLower() -like "logon") {
        [Int32[]]$ID = @(4624)
    }
    elseif($EventType.ToLower() -like "tgt") {
        [Int32[]]$ID = @(4768)
    }
    else {
        [Int32[]]$ID = @(4624, 4768)
    }

    if($Credential) {
        Write-Verbose "Using alternative credentials"
        $Arguments = @{
            'ComputerName' = $ComputerName;
            'Credential' = $Credential;
            'FilterHashTable' = @{ LogName = 'Security'; ID=$ID; StartTime=$DateStart};
            'ErrorAction' = 'SilentlyContinue';
        }
    }
    else {
        $Arguments = @{
            'ComputerName' = $ComputerName;
            'FilterHashTable' = @{ LogName = 'Security'; ID=$ID; StartTime=$DateStart};
            'ErrorAction' = 'SilentlyContinue';            
        }
    }

    # grab all events matching our filter for the specified host
    Get-WinEvent @Arguments | ForEach-Object {

        if($ID -contains 4624) {    
            # first parse and check the logon event type. This could be later adapted and tested for RDP logons (type 10)
            if($_.message -match '(?s)(?<=Logon Type:).*?(?=(Impersonation Level:|New Logon:))') {
                if($Matches) {
                    $LogonType = $Matches[0].trim()
                    $Matches = $Null
                }
            }
            else {
                $LogonType = ""
            }

            # interactive logons or domain logons
            if (($LogonType -eq 2) -or ($LogonType -eq 3)) {
                try {
                    # parse and store the account used and the address they came from
                    if($_.message -match '(?s)(?<=New Logon:).*?(?=Process Information:)') {
                        if($Matches) {
                            $UserName = $Matches[0].split("`n")[2].split(":")[1].trim()
                            $Domain = $Matches[0].split("`n")[3].split(":")[1].trim()
                            $Matches = $Null
                        }
                    }
                    if($_.message -match '(?s)(?<=Network Information:).*?(?=Source Port:)') {
                        if($Matches) {
                            $Address = $Matches[0].split("`n")[2].split(":")[1].trim()
                            $Matches = $Null
                        }
                    }

                    # only add if there was account information not for a machine or anonymous logon
                    if ($UserName -and (-not $UserName.endsWith('$')) -and ($UserName -ne 'ANONYMOUS LOGON')) {
                        $LogonEventProperties = @{
                            'Domain' = $Domain
                            'ComputerName' = $ComputerName
                            'Username' = $UserName
                            'Address' = $Address
                            'ID' = '4624'
                            'LogonType' = $LogonType
                            'Time' = $_.TimeCreated
                        }
                        New-Object -TypeName PSObject -Property $LogonEventProperties
                    }
                }
                catch {
                    Write-Verbose "Error parsing event logs: $_"
                }
            }
        }
        if($ID -contains 4768) {
            # the TGT event type
            try {
                if($_.message -match '(?s)(?<=Account Information:).*?(?=Service Information:)') {
                    if($Matches) {
                        $Username = $Matches[0].split("`n")[1].split(":")[1].trim()
                        $Domain = $Matches[0].split("`n")[2].split(":")[1].trim()
                        $Matches = $Null
                    }
                }

                if($_.message -match '(?s)(?<=Network Information:).*?(?=Additional Information:)') {
                    if($Matches) {
                        $Address = $Matches[0].split("`n")[1].split(":")[-1].trim()
                        $Matches = $Null
                    }
                }

                $LogonEventProperties = @{
                    'Domain' = $Domain
                    'ComputerName' = $ComputerName
                    'Username' = $UserName
                    'Address' = $Address
                    'ID' = '4768'
                    'LogonType' = ''
                    'Time' = $_.TimeCreated
                }

                New-Object -TypeName PSObject -Property $LogonEventProperties
            }
            catch {
                Write-Verbose "Error parsing event logs: $_"
            }
        }
    }
}

function Get-ObjectAcl {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$True)]
        [String]
        $SamAccountName,

        [Parameter(ValueFromPipelineByPropertyName=$True)]
        [String]
        $Name = "*",

        [Parameter(ValueFromPipelineByPropertyName=$True)]
        [String]
        $DistinguishedName = "*",

        [Switch]
        $ResolveGUIDs,

        [String]
        $Filter,

        [String]
        $ADSpath,

        [String]
        $ADSprefix,

        [String]
        [ValidateSet("All","ResetPassword","WriteMembers")]
        $RightsFilter,

        [String]
        $Domain,

        [String]
        $DomainController,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    begin {
        $Searcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -ADSprefix $ADSprefix -PageSize $PageSize 

        # get a GUID -> name mapping
        if($ResolveGUIDs) {
            $GUIDs = Get-GUIDMap -Domain $Domain -DomainController $DomainController -PageSize $PageSize
        }
    }

    process {

        if ($Searcher) {

            if($SamAccountName) {
                $Searcher.filter="(&(samaccountname=$SamAccountName)(name=$Name)(distinguishedname=$DistinguishedName)$Filter)"  
            }
            else {
                $Searcher.filter="(&(name=$Name)(distinguishedname=$DistinguishedName)$Filter)"  
            }
  
            try {
                $Results = $Searcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    $Object = [adsi]($_.path)

                    if($Object.distinguishedname) {
                        $Access = $Object.PsBase.ObjectSecurity.access
                        $Access | ForEach-Object {
                            $_ | Add-Member NoteProperty 'ObjectDN' $Object.distinguishedname[0]

                            if($Object.objectsid[0]){
                                $S = (New-Object System.Security.Principal.SecurityIdentifier($Object.objectsid[0],0)).Value
                            }
                            else {
                                $S = $Null
                            }
                            
                            $_ | Add-Member NoteProperty 'ObjectSID' $S
                            $_
                        }
                    }
                } | ForEach-Object {
                    if($RightsFilter) {
                        $GuidFilter = Switch ($RightsFilter) {
                            "ResetPassword" { "00299570-246d-11d0-a768-00aa006e0529" }
                            "WriteMembers" { "bf9679c0-0de6-11d0-a285-00aa003049e2" }
                            Default { "00000000-0000-0000-0000-000000000000"}
                        }
                        if($_.ObjectType -eq $GuidFilter) { $_ }
                    }
                    else {
                        $_
                    }
                } | ForEach-Object {
                    if($GUIDs) {
                        # if we're resolving GUIDs, map them them to the resolved hash table
                        $AclProperties = @{}
                        $_.psobject.properties | ForEach-Object {
                            if( ($_.Name -eq 'ObjectType') -or ($_.Name -eq 'InheritedObjectType') ) {
                                try {
                                    $AclProperties[$_.Name] = $GUIDS[$_.Value.toString()]
                                }
                                catch {
                                    $AclProperties[$_.Name] = $_.Value
                                }
                            }
                            else {
                                $AclProperties[$_.Name] = $_.Value
                            }
                        }
                        New-Object -TypeName PSObject -Property $AclProperties
                    }
                    else { $_ }
                }
                $Results.dispose()
                $Searcher.dispose()
            }
            catch {
                #Write-Warning $_
            }
        }
    }
}

function Add-ObjectAcl {
    [CmdletBinding()]
    Param (
        [String]
        $TargetSamAccountName,

        [String]
        $TargetName = "*",

        [Alias('DN')]
        [String]
        $TargetDistinguishedName = "*",

        [String]
        $TargetFilter,

        [String]
        $TargetADSpath,

        [String]
        $TargetADSprefix,

        [String]
        [ValidatePattern('^S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+')]
        $PrincipalSID,

        [String]
        $PrincipalName,

        [String]
        $PrincipalSamAccountName,

        [String]
        [ValidateSet("All","ResetPassword","WriteMembers","DCSync")]
        $Rights = "All",

        [String]
        $RightsGUID,

        [String]
        $Domain,

        [String]
        $DomainController,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    begin {
        $Searcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $TargetADSpath -ADSprefix $TargetADSprefix -PageSize $PageSize

        if($PrincipalSID) {
            $ResolvedPrincipalSID = $PrincipalSID
        }
        else {
            $Principal = Get-ADObject -Domain $Domain -DomainController $DomainController -Name $PrincipalName -SamAccountName $PrincipalSamAccountName -PageSize $PageSize
            
            if(!$Principal) {
                throw "Error resolving principal"
            }
            $ResolvedPrincipalSID = $Principal.objectsid
        }
        if(!$ResolvedPrincipalSID) {
            throw "Error resolving principal"
        }
    }

    process {

        if ($Searcher) {

            if($TargetSamAccountName) {
                $Searcher.filter="(&(samaccountname=$TargetSamAccountName)(name=$TargetName)(distinguishedname=$TargetDistinguishedName)$TargetFilter)"  
            }
            else {
                $Searcher.filter="(&(name=$TargetName)(distinguishedname=$TargetDistinguishedName)$TargetFilter)"  
            }
  
            try {
                $Results = $Searcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {

                    # adapted from https://social.technet.microsoft.com/Forums/windowsserver/en-US/df3bfd33-c070-4a9c-be98-c4da6e591a0a/forum-faq-using-powershell-to-assign-permissions-on-active-directory-objects

                    $TargetDN = $_.Properties.distinguishedname

                    $Identity = [System.Security.Principal.IdentityReference] ([System.Security.Principal.SecurityIdentifier]$ResolvedPrincipalSID)
                    $InheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance] "None"
                    $ControlType = [System.Security.AccessControl.AccessControlType] "Allow"
                    $ACEs = @()

                    if($RightsGUID) {
                        $GUIDs = @($RightsGUID)
                    }
                    else {
                        $GUIDs = Switch ($Rights) {
                            # ResetPassword doesn't need to know the user's current password
                            "ResetPassword" { "00299570-246d-11d0-a768-00aa006e0529" }
                            # allows for the modification of group membership
                            "WriteMembers" { "bf9679c0-0de6-11d0-a285-00aa003049e2" }
                            # 'DS-Replication-Get-Changes' = 1131f6aa-9c07-11d1-f79f-00c04fc2dcd2
                            # 'DS-Replication-Get-Changes-All' = 1131f6ad-9c07-11d1-f79f-00c04fc2dcd2
                            # 'DS-Replication-Get-Changes-In-Filtered-Set' = 89e95b76-444d-4c62-991a-0facbeda640c
                            #   when applied to a domain's ACL, allows for the use of DCSync
                            "DCSync" { "1131f6aa-9c07-11d1-f79f-00c04fc2dcd2", "1131f6ad-9c07-11d1-f79f-00c04fc2dcd2", "89e95b76-444d-4c62-991a-0facbeda640c"}
                        }
                    }

                    if($GUIDs) {
                        foreach($GUID in $GUIDs) {
                            $NewGUID = New-Object Guid $GUID
                            $ADRights = [System.DirectoryServices.ActiveDirectoryRights] "ExtendedRight"
                            $ACEs += New-Object System.DirectoryServices.ActiveDirectoryAccessRule $Identity,$ADRights,$ControlType,$NewGUID,$InheritanceType
                        }
                    }
                    else {
                        # deault to GenericAll rights
                        $ADRights = [System.DirectoryServices.ActiveDirectoryRights] "GenericAll"
                        $ACEs += New-Object System.DirectoryServices.ActiveDirectoryAccessRule $Identity,$ADRights,$ControlType,$InheritanceType
                    }

                    Write-Verbose "Granting principal $ResolvedPrincipalSID '$Rights' on $($_.Properties.distinguishedname)"

                    try {
                        # add all the new ACEs to the specified object
                        ForEach ($ACE in $ACEs) {
                            Write-Verbose "Granting principal $ResolvedPrincipalSID '$($ACE.ObjectType)' rights on $($_.Properties.distinguishedname)"
                            $Object = [adsi]($_.path)
                            $Object.PsBase.ObjectSecurity.AddAccessRule($ACE)
                            $Object.PsBase.commitchanges()
                        }
                    }
                    catch {
                        Write-Warning "Error granting principal $ResolvedPrincipalSID '$Rights' on $TargetDN : $_"
                    }
                }
                $Results.dispose()
                $Searcher.dispose()
            }
            catch {
                Write-Warning "Error: $_"
            }
        }
    }
}

function Invoke-ACLScanner {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SamAccountName,

        [String]
        $Name = "*",

        [Alias('DN')]
        [String]
        $DistinguishedName = "*",

        [String]
        $Filter,

        [String]
        $ADSpath,

        [String]
        $ADSprefix,

        [String]
        $Domain,

        [String]
        $DomainController,

        [Switch]
        $ResolveGUIDs,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    # Get all domain ACLs with the appropriate parameters
    Get-ObjectACL @PSBoundParameters | ForEach-Object {
        # add in the translated SID for the object identity
        $_ | Add-Member Noteproperty 'IdentitySID' ($_.IdentityReference.Translate([System.Security.Principal.SecurityIdentifier]).Value)
        $_
    } | Where-Object {
        # check for any ACLs with SIDs > -1000
        try {
            # TODO: change this to a regex for speedup?
            [int]($_.IdentitySid.split("-")[-1]) -ge 1000
        }
        catch {}
    } | Where-Object {
        # filter for modifiable rights
        ($_.ActiveDirectoryRights -eq "GenericAll") -or ($_.ActiveDirectoryRights -match "Write") -or ($_.ActiveDirectoryRights -match "Create") -or ($_.ActiveDirectoryRights -match "Delete") -or (($_.ActiveDirectoryRights -match "ExtendedRight") -and ($_.AccessControlType -eq "Allow"))
    }
}

filter Get-GUIDMap {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Domain,

        [String]
        $DomainController,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    $GUIDs = @{'00000000-0000-0000-0000-000000000000' = 'All'}

    $SchemaPath = (Get-ThisThingForest).schema.name

    $SchemaSearcher = Get-DomainSearcher -ADSpath $SchemaPath -DomainController $DomainController -PageSize $PageSize
    if($SchemaSearcher) {
        $SchemaSearcher.filter = "(schemaIDGUID=*)"
        try {
            $Results = $SchemaSearcher.FindAll()
            $Results | Where-Object {$_} | ForEach-Object {
                # convert the GUID
                $GUIDs[(New-Object Guid (,$_.properties.schemaidguid[0])).Guid] = $_.properties.name[0]
            }
            $Results.dispose()
            $SchemaSearcher.dispose()
        }
        catch {
            Write-Verbose "Error in building GUID map: $_"
        }
    }

    $RightsSearcher = Get-DomainSearcher -ADSpath $SchemaPath.replace("Schema","Extended-Rights") -DomainController $DomainController -PageSize $PageSize -Credential $Credential
    if ($RightsSearcher) {
        $RightsSearcher.filter = "(objectClass=controlAccessRight)"
        try {
            $Results = $RightsSearcher.FindAll()
            $Results | Where-Object {$_} | ForEach-Object {
                # convert the GUID
                $GUIDs[$_.properties.rightsguid[0].toString()] = $_.properties.name[0]
            }
            $Results.dispose()
            $RightsSearcher.dispose()
        }
        catch {
            Write-Verbose "Error in building GUID map: $_"
        }
    }

    $GUIDs
}

function Get-ThisThingComputer {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String]
        $ComputerName = '*',

        [String]
        $SPN,

        [String]
        $OperatingSystem,

        [String]
        $ServicePack,

        [String]
        $Filter,

        [Switch]
        $Printers,

        [Switch]
        $Ping,

        [Switch]
        $FullData,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [String]
        $SiteName,

        [Switch]
        $Unconstrained,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        # so this isn't repeated if multiple computer names are passed on the pipeline
        $CompSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize -Credential $Credential
    }

    process {

        if ($CompSearcher) {

            # if we're checking for unconstrained delegation
            if($Unconstrained) {
                Write-Verbose "Searching for computers with for unconstrained delegation"
                $Filter += "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
            }
            # set the filters for the seracher if it exists
            if($Printers) {
                Write-Verbose "Searching for printers"
                # $CompSearcher.filter="(&(objectCategory=printQueue)$Filter)"
                $Filter += "(objectCategory=printQueue)"
            }
            if($SPN) {
                Write-Verbose "Searching for computers with SPN: $SPN"
                $Filter += "(servicePrincipalName=$SPN)"
            }
            if($OperatingSystem) {
                $Filter += "(operatingsystem=$OperatingSystem)"
            }
            if($ServicePack) {
                $Filter += "(operatingsystemservicepack=$ServicePack)"
            }
            if($SiteName) {
                $Filter += "(serverreferencebl=$SiteName)"
            }

            $CompFilter = "(&(sAMAccountType=805306369)(dnshostname=$ComputerName)$Filter)"
            Write-Verbose "Get-ThisThingComputer filter : '$CompFilter'"
            $CompSearcher.filter = $CompFilter

            try {
                $Results = $CompSearcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    $Up = $True
                    if($Ping) {
                        # TODO: how can these results be piped to ping for a speedup?
                        $Up = Test-Connection -Count 1 -Quiet -ComputerName $_.properties.dnshostname
                    }
                    if($Up) {
                        # return full data objects
                        if ($FullData) {
                            # convert/process the LDAP fields for each result
                            $Computer = Convert-LDAPProperty -Properties $_.Properties
                            $Computer.PSObject.TypeNames.Add('PowerView.Computer')
                            $Computer
                        }
                        else {
                            # otherwise we're just returning the DNS host name
                            $_.properties.dnshostname
                        }
                    }
                }
                $Results.dispose()
                $CompSearcher.dispose()
            }
            catch {
                #Write-Warning "Error: $_"
            }
        }
    }
}

function Get-ADObject {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SID,

        [String]
        $Name,

        [String]
        $SamAccountName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [String]
        $Filter,

        [Switch]
        $ReturnRaw,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )
    process {
        if($SID) {
            # if a SID is passed, try to resolve it to a reachable domain name for the searcher
            try {
                $Name = Convert-SidToName $SID
                if($Name) {
                    $Canonical = Convert-ADName -ObjectName $Name -InputType NT4 -OutputType Canonical
                    if($Canonical) {
                        $Domain = $Canonical.split("/")[0]
                    }
                    else {
                        #Write-Warning "Error resolving SID '$SID'"
                        return $Null
                    }
                }
            }
            catch {
                #Write-Warning "Error resolving SID '$SID' : $_"
                return $Null
            }
        }

        $ObjectSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize

        if($ObjectSearcher) {
            if($SID) {
                $ObjectSearcher.filter = "(&(objectsid=$SID)$Filter)"
            }
            elseif($Name) {
                $ObjectSearcher.filter = "(&(name=$Name)$Filter)"
            }
            elseif($SamAccountName) {
                $ObjectSearcher.filter = "(&(samAccountName=$SamAccountName)$Filter)"
            }

            $Results = $ObjectSearcher.FindAll()
            $Results | Where-Object {$_} | ForEach-Object {
                if($ReturnRaw) {
                    $_
                }
                else {
                    # convert/process the LDAP fields for each result
                    Convert-LDAPProperty -Properties $_.Properties
                }
            }
            $Results.dispose()
            $ObjectSearcher.dispose()
        }
    }
}

function Set-ADObject {
    [CmdletBinding()]
    Param (
        [String]
        $SID,

        [String]
        $Name,

        [String]
        $SamAccountName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $Filter,

        [Parameter(Mandatory = $True)]
        [String]
        $PropertyName,

        $PropertyValue,

        [Int]
        $PropertyXorValue,

        [Switch]
        $ClearValue,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    $Arguments = @{
        'SID' = $SID
        'Name' = $Name
        'SamAccountName' = $SamAccountName
        'Domain' = $Domain
        'DomainController' = $DomainController
        'Filter' = $Filter
        'PageSize' = $PageSize
        'Credential' = $Credential
    }
    # splat the appropriate arguments to Get-ADObject
    $RawObject = Get-ADObject -ReturnRaw @Arguments
    
    try {
        # get the modifiable object for this search result
        $Entry = $RawObject.GetDirectoryEntry()
        
        if($ClearValue) {
            Write-Verbose "Clearing value"
            $Entry.$PropertyName.clear()
            $Entry.commitchanges()
        }

        elseif($PropertyXorValue) {
            $TypeName = $Entry.$PropertyName[0].GetType().name

            # UAC value references- https://support.microsoft.com/en-us/kb/305144
            $PropertyValue = $($Entry.$PropertyName) -bxor $PropertyXorValue 
            $Entry.$PropertyName = $PropertyValue -as $TypeName       
            $Entry.commitchanges()     
        }

        else {
            $Entry.put($PropertyName, $PropertyValue)
            $Entry.setinfo()
        }
    }
    catch {
        Write-Warning "Error setting property $PropertyName to value '$PropertyValue' for object $($RawObject.Properties.samaccountname) : $_"
    }
}

function Invoke-DowngradeAccount {
    [CmdletBinding()]
    Param (
        [Parameter(ParameterSetName = 'SamAccountName', Position=0, ValueFromPipeline=$True)]
        [String]
        $SamAccountName,

        [Parameter(ParameterSetName = 'Name')]
        [String]
        $Name,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $Filter,

        [Switch]
        $Repair,

        [Management.Automation.PSCredential]
        $Credential
    )

    process {
        $Arguments = @{
            'SamAccountName' = $SamAccountName
            'Name' = $Name
            'Domain' = $Domain
            'DomainController' = $DomainController
            'Filter' = $Filter
            'Credential' = $Credential
        }

        # splat the appropriate arguments to Get-ADObject
        $UACValues = Get-ADObject @Arguments | select useraccountcontrol | ConvertFrom-UACValue

        if($Repair) {

            if($UACValues.Keys -contains "ENCRYPTED_TEXT_PWD_ALLOWED") {
                # if reversible encryption is set, unset it
                Set-ADObject @Arguments -PropertyName useraccountcontrol -PropertyXorValue 128
            }

            # unset the forced password change
            Set-ADObject @Arguments -PropertyName pwdlastset -PropertyValue -1
        }

        else {

            if($UACValues.Keys -contains "DONT_EXPIRE_PASSWORD") {
                # if the password is set to never expire, unset
                Set-ADObject @Arguments -PropertyName useraccountcontrol -PropertyXorValue 65536
            }

            if($UACValues.Keys -notcontains "ENCRYPTED_TEXT_PWD_ALLOWED") {
                # if reversible encryption is not set, set it
                Set-ADObject @Arguments -PropertyName useraccountcontrol -PropertyXorValue 128
            }

            # force the password to be changed on next login
            Set-ADObject @Arguments -PropertyName pwdlastset -PropertyValue 0
        }
    }
}

function Get-ComputerProperty {
    [CmdletBinding()]
    param(
        [String[]]
        $Properties,

        [String]
        $Domain,

        [String]
        $DomainController,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    if($Properties) {
        # extract out the set of all properties for each object
        $Properties = ,"name" + $Properties | Sort-Object -Unique
        Get-ThisThingComputer -Domain $Domain -DomainController $DomainController -Credential $Credential -FullData -PageSize $PageSize | Select-Object -Property $Properties
    }
    else {
        # extract out just the property names
        Get-ThisThingComputer -Domain $Domain -DomainController $DomainController -Credential $Credential -FullData -PageSize $PageSize | Select-Object -first 1 | Get-Member -MemberType *Property | Select-Object -Property "Name"
    }
}

function Find-ComputerField {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Term')]
        [String]
        $SearchTerm = 'pass',

        [Alias('Field')]
        [String]
        $SearchField = 'description',

        [String]
        $ADSpath,

        [String]
        $Domain,

        [String]
        $DomainController,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    process {
        Get-ThisThingComputer -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -Credential $Credential -FullData -Filter "($SearchField=*$SearchTerm*)" -PageSize $PageSize | Select-Object samaccountname,$SearchField
    }
}

function Get-ThisThingOU {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $OUName = '*',

        [String]
        $GUID,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [Switch]
        $FullData,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        $OUSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize
    }
    process {
        if ($OUSearcher) {
            if ($GUID) {
                # if we're filtering for a GUID in .gplink
                $OUSearcher.filter="(&(objectCategory=organizationalUnit)(name=$OUName)(gplink=*$GUID*))"
            }
            else {
                $OUSearcher.filter="(&(objectCategory=organizationalUnit)(name=$OUName))"
            }

            try {
                $Results = $OUSearcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    if ($FullData) {
                        # convert/process the LDAP fields for each result
                        $OU = Convert-LDAPProperty -Properties $_.Properties
                        $OU.PSObject.TypeNames.Add('PowerView.OU')
                        $OU
                    }
                    else { 
                        # otherwise just returning the ADS paths of the OUs
                        $_.properties.adspath
                    }
                }
                $Results.dispose()
                $OUSearcher.dispose()
            }
            catch {
                Write-Warning $_
            }
        }
    }
}

function Get-ThisThingSite {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SiteName = "*",

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [String]
        $GUID,

        [Switch]
        $FullData,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        $SiteSearcher = Get-DomainSearcher -ADSpath $ADSpath -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSprefix "CN=Sites,CN=Configuration" -PageSize $PageSize
    }
    process {
        if($SiteSearcher) {

            if ($GUID) {
                # if we're filtering for a GUID in .gplink
                $SiteSearcher.filter="(&(objectCategory=site)(name=$SiteName)(gplink=*$GUID*))"
            }
            else {
                $SiteSearcher.filter="(&(objectCategory=site)(name=$SiteName))"
            }
            
            try {
                $Results = $SiteSearcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    if ($FullData) {
                        # convert/process the LDAP fields for each result
                        $Site = Convert-LDAPProperty -Properties $_.Properties
                        $Site.PSObject.TypeNames.Add('PowerView.Site')
                        $Site
                    }
                    else {
                        # otherwise just return the site name
                        $_.properties.name
                    }
                }
                $Results.dispose()
                $SiteSearcher.dispose()
            }
            catch {
                Write-Verbose $_
            }
        }
    }
}

function Get-ThisThingSubnet {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $SiteName = "*",

        [String]
        $Domain,

        [String]
        $ADSpath,

        [String]
        $DomainController,

        [Switch]
        $FullData,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        $SubnetSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -ADSprefix "CN=Subnets,CN=Sites,CN=Configuration" -PageSize $PageSize
    }

    process {
        if($SubnetSearcher) {

            $SubnetSearcher.filter="(&(objectCategory=subnet))"

            try {
                $Results = $SubnetSearcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    if ($FullData) {
                        # convert/process the LDAP fields for each result
                        Convert-LDAPProperty -Properties $_.Properties | Where-Object { $_.siteobject -match "CN=$SiteName" }
                    }
                    else {
                        # otherwise just return the subnet name and site name
                        if ( ($SiteName -and ($_.properties.siteobject -match "CN=$SiteName,")) -or ($SiteName -eq '*')) {

                            $SubnetProperties = @{
                                'Subnet' = $_.properties.name[0]
                            }
                            try {
                                $SubnetProperties['Site'] = ($_.properties.siteobject[0]).split(",")[0]
                            }
                            catch {
                                $SubnetProperties['Site'] = 'Error'
                            }

                            New-Object -TypeName PSObject -Property $SubnetProperties
                        }
                    }
                }
                $Results.dispose()
                $SubnetSearcher.dispose()
            }
            catch {
                Write-Warning $_
            }
        }
    }
}

function Get-DomainSID {


    param(
        [String]
        $Domain,

        [String]
        $DomainController
    )

    $DCSID = Get-ThisThingComputer -Domain $Domain -DomainController $DomainController -FullData -Filter '(userAccountControl:1.2.840.113556.1.4.803:=8192)' | Select-Object -First 1 -ExpandProperty objectsid
    if($DCSID) {
        $DCSID.Substring(0, $DCSID.LastIndexOf('-'))
    }
    else {
        Write-Verbose "Error extracting domain SID for $Domain"
    }
}

function Get-ThisThingGroup {

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $GroupName = '*',

        [String]
        $SID,

        [String]
        $UserName,

        [String]
        $Filter,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [Switch]
        $AdminCount,

        [Switch]
        $FullData,

        [Switch]
        $RawSids,

        [Switch]
        $AllTypes,

        [ValidateRange(1,10000)]
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        $GroupSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize
        if (!$AllTypes)
        {
          $Filter += "(groupType:1.2.840.113556.1.4.803:=2147483648)"
        }
    }

    process {
        if($GroupSearcher) {

            if($AdminCount) {
                Write-Verbose "Checking for adminCount=1"
                $Filter += "(admincount=1)"
            }

            if ($UserName) {
                # get the raw user object
                $User = Get-ADObject -SamAccountName $UserName -Domain $Domain -DomainController $DomainController -Credential $Credential -ReturnRaw -PageSize $PageSize | Select-Object -First 1

                if($User) {
                    # convert the user to a directory entry
                    $UserDirectoryEntry = $User.GetDirectoryEntry()

                    # cause the cache to calculate the token groups for the user
                    $UserDirectoryEntry.RefreshCache("tokenGroups")

                    $UserDirectoryEntry.TokenGroups | ForEach-Object {
                        # convert the token group sid
                        $GroupSid = (New-Object System.Security.Principal.SecurityIdentifier($_,0)).Value

                        # ignore the built in groups
                        if($GroupSid -notmatch '^S-1-5-32-.*') {
                            if($FullData) {
                                $Group = Get-ADObject -SID $GroupSid -PageSize $PageSize -Domain $Domain -DomainController $DomainController -Credential $Credential
                                $Group.PSObject.TypeNames.Add('PowerView.Group')
                                $Group
                            }
                            else {
                                if($RawSids) {
                                    $GroupSid
                                }
                                else {
                                    Convert-SidToName -SID $GroupSid
                                }
                            }
                        }
                    }
                }
                else {
                    Write-Warning "UserName '$UserName' failed to resolve."
                }
            }
            else {
                if ($SID) {
                    $GroupSearcher.filter = "(&(objectCategory=group)(objectSID=$SID)$Filter)"
                }
                else {
                    $GroupSearcher.filter = "(&(objectCategory=group)(samaccountname=$GroupName)$Filter)"
                }

                $Results = $GroupSearcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    # if we're returning full data objects
                    if ($FullData) {
                        # convert/process the LDAP fields for each result
                        $Group = Convert-LDAPProperty -Properties $_.Properties
                        $Group.PSObject.TypeNames.Add('PowerView.Group')
                        $Group
                    }
                    else {
                        # otherwise we're just returning the group name
                        $_.properties.samaccountname
                    }
                }
                $Results.dispose()
                $GroupSearcher.dispose()
            }
        }
    }
}

function Get-ThisThingGroupMember {

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $GroupName,

        [String]
        $SID,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [Switch]
        $FullData,

        [Switch]
        $Recurse,

        [Switch]
        $UseMatchingRule,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        if($DomainController) {
            $TargetDomainController = $DomainController
        }
        else {
            $TargetDomainController = ((Get-ThisThingDomain -Credential $Credential).PdcRoleOwner).Name
        }

        if($Domain) {
            $TargetDomain = $Domain
        }
        else {
            $TargetDomain = Get-ThisThingDomain -Credential $Credential | Select-Object -ExpandProperty name
        }

        # so this isn't repeated if users are passed on the pipeline
        $GroupSearcher = Get-DomainSearcher -Domain $TargetDomain -DomainController $TargetDomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize
    }

    process {
        if ($GroupSearcher) {
            if ($Recurse -and $UseMatchingRule) {
                # resolve the group to a distinguishedname
                if ($GroupName) {
                    $Group = Get-ThisThingGroup -AllTypes -GroupName $GroupName -Domain $TargetDomain -DomainController $TargetDomainController -Credential $Credential -FullData -PageSize $PageSize
                }
                elseif ($SID) {
                    $Group = Get-ThisThingGroup -AllTypes -SID $SID -Domain $TargetDomain -DomainController $TargetDomainController -Credential $Credential -FullData -PageSize $PageSize
                }
                else {
                    # default to domain admins
                    $SID = (Get-DomainSID -Domain $TargetDomain -DomainController $TargetDomainController) + "-512"
                    $Group = Get-ThisThingGroup -AllTypes -SID $SID -Domain $TargetDomain -DomainController $TargetDomainController -Credential $Credential -FullData -PageSize $PageSize
                }
                $GroupDN = $Group.distinguishedname
                $GroupFoundName = $Group.samaccountname

                if ($GroupDN) {
                    $GroupSearcher.filter = "(&(samAccountType=805306368)(memberof:1.2.840.113556.1.4.1941:=$GroupDN)$Filter)"
                    $GroupSearcher.PropertiesToLoad.AddRange(('distinguishedName','samaccounttype','lastlogon','lastlogontimestamp','dscorepropagationdata','objectsid','whencreated','badpasswordtime','accountexpires','iscriticalsystemobject','name','usnchanged','objectcategory','description','codepage','instancetype','countrycode','distinguishedname','cn','admincount','logonhours','objectclass','logoncount','usncreated','useraccountcontrol','objectguid','primarygroupid','lastlogoff','samaccountname','badpwdcount','whenchanged','memberof','pwdlastset','adspath'))

                    $Members = $GroupSearcher.FindAll()
                    $GroupFoundName = $GroupName
                }
                else {
                    Write-Error "Unable to find Group"
                }
            }
            else {
                if ($GroupName) {
                    $GroupSearcher.filter = "(&(objectCategory=group)(samaccountname=$GroupName)$Filter)"
                }
                elseif ($SID) {
                    $GroupSearcher.filter = "(&(objectCategory=group)(objectSID=$SID)$Filter)"
                }
                else {
                    # default to domain admins
                    $SID = (Get-DomainSID -Domain $TargetDomain -DomainController $TargetDomainController) + "-512"
                    $GroupSearcher.filter = "(&(objectCategory=group)(objectSID=$SID)$Filter)"
                }

                try {
                    $Result = $GroupSearcher.FindOne()
                }
                catch {
                    $Members = @()
                }

                $GroupFoundName = ''

                if ($Result) {
                    $Members = $Result.properties.item("member")

                    if($Members.count -eq 0) {

                        $Finished = $False
                        $Bottom = 0
                        $Top = 0

                        while(!$Finished) {
                            $Top = $Bottom + 1499
                            $MemberRange="member;range=$Bottom-$Top"
                            $Bottom += 1500
                            
                            $GroupSearcher.PropertiesToLoad.Clear()
                            [void]$GroupSearcher.PropertiesToLoad.Add("$MemberRange")
                            [void]$GroupSearcher.PropertiesToLoad.Add("samaccountname")
                            try {
                                $Result = $GroupSearcher.FindOne()
                                $RangedProperty = $Result.Properties.PropertyNames -like "member;range=*"
                                $Members += $Result.Properties.item($RangedProperty)
                                $GroupFoundName = $Result.properties.item("samaccountname")[0]

                                if ($Members.count -eq 0) { 
                                    $Finished = $True
                                }
                            }
                            catch [System.Management.Automation.MethodInvocationException] {
                                $Finished = $True
                            }
                        }
                    }
                    else {
                        $GroupFoundName = $Result.properties.item("samaccountname")[0]
                        $Members += $Result.Properties.item($RangedProperty)
                    }
                }
                $GroupSearcher.dispose()
            }

            $Members | Where-Object {$_} | ForEach-Object {
                # if we're doing the LDAP_MATCHING_RULE_IN_CHAIN recursion
                if ($Recurse -and $UseMatchingRule) {
                    $Properties = $_.Properties
                } 
                else {
                    if($TargetDomainController) {
                        $Result = [adsi]"LDAP://$TargetDomainController/$_"
                    }
                    else {
                        $Result = [adsi]"LDAP://$_"
                    }
                    if($Result){
                        $Properties = $Result.Properties
                    }
                }

                if($Properties) {

                    $IsGroup = @('268435456','268435457','536870912','536870913') -contains $Properties.samaccounttype

                    if ($FullData) {
                        $GroupMember = Convert-LDAPProperty -Properties $Properties
                    }
                    else {
                        $GroupMember = New-Object PSObject
                    }

                    $GroupMember | Add-Member Noteproperty 'GroupDomain' $TargetDomain
                    $GroupMember | Add-Member Noteproperty 'GroupName' $GroupFoundName

                    if($Properties.objectSid) {
                        $MemberSID = ((New-Object System.Security.Principal.SecurityIdentifier $Properties.objectSid[0],0).Value)
                    }
                    else {
                        $MemberSID = $Null
                    }

                    try {
                        $MemberDN = $Properties.distinguishedname[0]

                        if (($MemberDN -match 'ForeignSecurityPrincipals') -and ($MemberDN -match 'S-1-5-21')) {
                            try {
                                if(-not $MemberSID) {
                                    $MemberSID = $Properties.cn[0]
                                }
                                $MemberSimpleName = Convert-SidToName -SID $MemberSID | Convert-ADName -InputType 'NT4' -OutputType 'Simple'
                                if($MemberSimpleName) {
                                    $MemberDomain = $MemberSimpleName.Split('@')[1]
                                }
                                else {
                                    Write-Warning "Error converting $MemberDN"
                                    $MemberDomain = $Null
                                }
                            }
                            catch {
                                Write-Warning "Error converting $MemberDN"
                                $MemberDomain = $Null
                            }
                        }
                        else {
                            # extract the FQDN from the Distinguished Name
                            $MemberDomain = $MemberDN.subString($MemberDN.IndexOf("DC=")) -replace 'DC=','' -replace ',','.'
                        }
                    }
                    catch {
                        $MemberDN = $Null
                        $MemberDomain = $Null
                    }

                    if ($Properties.samaccountname) {
                        # forest users have the samAccountName set
                        $MemberName = $Properties.samaccountname[0]
                    } 
                    else {
                        # external trust users have a SID, so convert it
                        try {
                            $MemberName = Convert-SidToName $Properties.cn[0]
                        }
                        catch {
                            # if there's a problem contacting the domain to resolve the SID
                            $MemberName = $Properties.cn
                        }
                    }

                    $GroupMember | Add-Member Noteproperty 'MemberDomain' $MemberDomain
                    $GroupMember | Add-Member Noteproperty 'MemberName' $MemberName
                    $GroupMember | Add-Member Noteproperty 'MemberSID' $MemberSID
                    $GroupMember | Add-Member Noteproperty 'IsGroup' $IsGroup
                    $GroupMember | Add-Member Noteproperty 'MemberDN' $MemberDN
                    $GroupMember.PSObject.TypeNames.Add('PowerView.GroupMember')
                    $GroupMember

                    # if we're doing manual recursion
                    if ($Recurse -and !$UseMatchingRule -and $IsGroup -and $MemberName) {
                        if($FullData) {
                            Get-ThisThingGroupMember -FullData -Domain $MemberDomain -DomainController $TargetDomainController -Credential $Credential -GroupName $MemberName -Recurse -PageSize $PageSize
                        }
                        else {
                            Get-ThisThingGroupMember -Domain $MemberDomain -DomainController $TargetDomainController -Credential $Credential -GroupName $MemberName -Recurse -PageSize $PageSize
                        }
                    }
                }
            }
        }
    }
}

function Get-ThisThingFileServer {

    [CmdletBinding()]
    param(
        [String]
        $Domain,

        [String]
        $DomainController,

        [String[]]
        $TargetUsers,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    function SplitPath {
        # short internal helper to split UNC server paths
        param([String]$Path)

        if ($Path -and ($Path.split("\\").Count -ge 3)) {
            $Temp = $Path.split("\\")[2]
            if($Temp -and ($Temp -ne '')) {
                $Temp
            }
        }
    }
    $filter = "(!(userAccountControl:1.2.840.113556.1.4.803:=2))(|(scriptpath=*)(homedirectory=*)(profilepath=*))"
    Get-ThisThingUser -Domain $Domain -DomainController $DomainController -Credential $Credential -PageSize $PageSize -Filter $filter | Where-Object {$_} | Where-Object {
            # filter for any target users
            if($TargetUsers) {
                $TargetUsers -Match $_.samAccountName
            }
            else { $True }
        } | ForEach-Object {
            # split out every potential file server path
            if($_.homedirectory) {
                SplitPath($_.homedirectory)
            }
            if($_.scriptpath) {
                SplitPath($_.scriptpath)
            }
            if($_.profilepath) {
                SplitPath($_.profilepath)
            }

        } | Where-Object {$_} | Sort-Object -Unique
}

function Get-DFSshare {
    [CmdletBinding()]
    param(
        [String]
        [ValidateSet("All","V1","1","V2","2")]
        $Version = "All",

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    function Parse-Pkt {
        [CmdletBinding()]
        param(
            [byte[]]
            $Pkt
        )

        $bin = $Pkt
        $blob_version = [bitconverter]::ToUInt32($bin[0..3],0)
        $blob_element_count = [bitconverter]::ToUInt32($bin[4..7],0)
        $offset = 8
        #https://msdn.microsoft.com/en-us/library/cc227147.aspx
        $object_list = @()
        for($i=1; $i -le $blob_element_count; $i++){
               $blob_name_size_start = $offset
               $blob_name_size_end = $offset + 1
               $blob_name_size = [bitconverter]::ToUInt16($bin[$blob_name_size_start..$blob_name_size_end],0)

               $blob_name_start = $blob_name_size_end + 1
               $blob_name_end = $blob_name_start + $blob_name_size - 1
               $blob_name = [System.Text.Encoding]::Unicode.GetString($bin[$blob_name_start..$blob_name_end])

               $blob_data_size_start = $blob_name_end + 1
               $blob_data_size_end = $blob_data_size_start + 3
               $blob_data_size = [bitconverter]::ToUInt32($bin[$blob_data_size_start..$blob_data_size_end],0)

               $blob_data_start = $blob_data_size_end + 1
               $blob_data_end = $blob_data_start + $blob_data_size - 1
               $blob_data = $bin[$blob_data_start..$blob_data_end]
               switch -wildcard ($blob_name) {
                "\siteroot" {  }
                "\domainroot*" {
                    # Parse DFSNamespaceRootOrLinkBlob object. Starts with variable length DFSRootOrLinkIDBlob which we parse first...
                    # DFSRootOrLinkIDBlob
                    $root_or_link_guid_start = 0
                    $root_or_link_guid_end = 15
                    $root_or_link_guid = [byte[]]$blob_data[$root_or_link_guid_start..$root_or_link_guid_end]
                    $guid = New-Object Guid(,$root_or_link_guid) # should match $guid_str
                    $prefix_size_start = $root_or_link_guid_end + 1
                    $prefix_size_end = $prefix_size_start + 1
                    $prefix_size = [bitconverter]::ToUInt16($blob_data[$prefix_size_start..$prefix_size_end],0)
                    $prefix_start = $prefix_size_end + 1
                    $prefix_end = $prefix_start + $prefix_size - 1
                    $prefix = [System.Text.Encoding]::Unicode.GetString($blob_data[$prefix_start..$prefix_end])

                    $short_prefix_size_start = $prefix_end + 1
                    $short_prefix_size_end = $short_prefix_size_start + 1
                    $short_prefix_size = [bitconverter]::ToUInt16($blob_data[$short_prefix_size_start..$short_prefix_size_end],0)
                    $short_prefix_start = $short_prefix_size_end + 1
                    $short_prefix_end = $short_prefix_start + $short_prefix_size - 1
                    $short_prefix = [System.Text.Encoding]::Unicode.GetString($blob_data[$short_prefix_start..$short_prefix_end])

                    $type_start = $short_prefix_end + 1
                    $type_end = $type_start + 3
                    $type = [bitconverter]::ToUInt32($blob_data[$type_start..$type_end],0)

                    $state_start = $type_end + 1
                    $state_end = $state_start + 3
                    $state = [bitconverter]::ToUInt32($blob_data[$state_start..$state_end],0)

                    $comment_size_start = $state_end + 1
                    $comment_size_end = $comment_size_start + 1
                    $comment_size = [bitconverter]::ToUInt16($blob_data[$comment_size_start..$comment_size_end],0)
                    $comment_start = $comment_size_end + 1
                    $comment_end = $comment_start + $comment_size - 1
                    if ($comment_size -gt 0)  {
                        $comment = [System.Text.Encoding]::Unicode.GetString($blob_data[$comment_start..$comment_end])
                    }
                    $prefix_timestamp_start = $comment_end + 1
                    $prefix_timestamp_end = $prefix_timestamp_start + 7
                    # https://msdn.microsoft.com/en-us/library/cc230324.aspx FILETIME
                    $prefix_timestamp = $blob_data[$prefix_timestamp_start..$prefix_timestamp_end] #dword lowDateTime #dword highdatetime
                    $state_timestamp_start = $prefix_timestamp_end + 1
                    $state_timestamp_end = $state_timestamp_start + 7
                    $state_timestamp = $blob_data[$state_timestamp_start..$state_timestamp_end]
                    $comment_timestamp_start = $state_timestamp_end + 1
                    $comment_timestamp_end = $comment_timestamp_start + 7
                    $comment_timestamp = $blob_data[$comment_timestamp_start..$comment_timestamp_end]
                    $version_start = $comment_timestamp_end  + 1
                    $version_end = $version_start + 3
                    $version = [bitconverter]::ToUInt32($blob_data[$version_start..$version_end],0)

                    # Parse rest of DFSNamespaceRootOrLinkBlob here
                    $dfs_targetlist_blob_size_start = $version_end + 1
                    $dfs_targetlist_blob_size_end = $dfs_targetlist_blob_size_start + 3
                    $dfs_targetlist_blob_size = [bitconverter]::ToUInt32($blob_data[$dfs_targetlist_blob_size_start..$dfs_targetlist_blob_size_end],0)

                    $dfs_targetlist_blob_start = $dfs_targetlist_blob_size_end + 1
                    $dfs_targetlist_blob_end = $dfs_targetlist_blob_start + $dfs_targetlist_blob_size - 1
                    $dfs_targetlist_blob = $blob_data[$dfs_targetlist_blob_start..$dfs_targetlist_blob_end]
                    $reserved_blob_size_start = $dfs_targetlist_blob_end + 1
                    $reserved_blob_size_end = $reserved_blob_size_start + 3
                    $reserved_blob_size = [bitconverter]::ToUInt32($blob_data[$reserved_blob_size_start..$reserved_blob_size_end],0)

                    $reserved_blob_start = $reserved_blob_size_end + 1
                    $reserved_blob_end = $reserved_blob_start + $reserved_blob_size - 1
                    $reserved_blob = $blob_data[$reserved_blob_start..$reserved_blob_end]
                    $referral_ttl_start = $reserved_blob_end + 1
                    $referral_ttl_end = $referral_ttl_start + 3
                    $referral_ttl = [bitconverter]::ToUInt32($blob_data[$referral_ttl_start..$referral_ttl_end],0)

                    #Parse DFSTargetListBlob
                    $target_count_start = 0
                    $target_count_end = $target_count_start + 3
                    $target_count = [bitconverter]::ToUInt32($dfs_targetlist_blob[$target_count_start..$target_count_end],0)
                    $t_offset = $target_count_end + 1

                    for($j=1; $j -le $target_count; $j++){
                        $target_entry_size_start = $t_offset
                        $target_entry_size_end = $target_entry_size_start + 3
                        $target_entry_size = [bitconverter]::ToUInt32($dfs_targetlist_blob[$target_entry_size_start..$target_entry_size_end],0)
                        $target_time_stamp_start = $target_entry_size_end + 1
                        $target_time_stamp_end = $target_time_stamp_start + 7
                        # FILETIME again or special if priority rank and priority class 0
                        $target_time_stamp = $dfs_targetlist_blob[$target_time_stamp_start..$target_time_stamp_end]
                        $target_state_start = $target_time_stamp_end + 1
                        $target_state_end = $target_state_start + 3
                        $target_state = [bitconverter]::ToUInt32($dfs_targetlist_blob[$target_state_start..$target_state_end],0)

                        $target_type_start = $target_state_end + 1
                        $target_type_end = $target_type_start + 3
                        $target_type = [bitconverter]::ToUInt32($dfs_targetlist_blob[$target_type_start..$target_type_end],0)

                        $server_name_size_start = $target_type_end + 1
                        $server_name_size_end = $server_name_size_start + 1
                        $server_name_size = [bitconverter]::ToUInt16($dfs_targetlist_blob[$server_name_size_start..$server_name_size_end],0)

                        $server_name_start = $server_name_size_end + 1
                        $server_name_end = $server_name_start + $server_name_size - 1
                        $server_name = [System.Text.Encoding]::Unicode.GetString($dfs_targetlist_blob[$server_name_start..$server_name_end])

                        $share_name_size_start = $server_name_end + 1
                        $share_name_size_end = $share_name_size_start + 1
                        $share_name_size = [bitconverter]::ToUInt16($dfs_targetlist_blob[$share_name_size_start..$share_name_size_end],0)
                        $share_name_start = $share_name_size_end + 1
                        $share_name_end = $share_name_start + $share_name_size - 1
                        $share_name = [System.Text.Encoding]::Unicode.GetString($dfs_targetlist_blob[$share_name_start..$share_name_end])

                        $target_list += "\\$server_name\$share_name"
                        $t_offset = $share_name_end + 1
                    }
                }
            }
            $offset = $blob_data_end + 1
            $dfs_pkt_properties = @{
                'Name' = $blob_name
                'Prefix' = $prefix
                'TargetList' = $target_list
            }
            $object_list += New-Object -TypeName PSObject -Property $dfs_pkt_properties
            $prefix = $null
            $blob_name = $null
            $target_list = $null
        }

        $servers = @()
        $object_list | ForEach-Object {
            if ($_.TargetList) {
                $_.TargetList | ForEach-Object {
                    $servers += $_.split("\")[2]
                }
            }
        }

        $servers
    }

    function Get-DFSshareV1 {
        [CmdletBinding()]
        param(
            [String]
            $Domain,

            [String]
            $DomainController,

            [String]
            $ADSpath,

            [ValidateRange(1,10000)]
            [Int]
            $PageSize = 200,

            [Management.Automation.PSCredential]
            $Credential
        )

        $DFSsearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize

        if($DFSsearcher) {
            $DFSshares = @()
            $DFSsearcher.filter = "(&(objectClass=fTDfs))"

            try {
                $Results = $DFSSearcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    $Properties = $_.Properties
                    $RemoteNames = $Properties.remoteservername
                    $Pkt = $Properties.pkt

                    $DFSshares += $RemoteNames | ForEach-Object {
                        try {
                            if ( $_.Contains('\') ) {
                                New-Object -TypeName PSObject -Property @{'Name'=$Properties.name[0];'RemoteServerName'=$_.split("\")[2]}
                            }
                        }
                        catch {
                            Write-Verbose "Error in parsing DFS share : $_"
                        }
                    }
                }
                $Results.dispose()
                $DFSSearcher.dispose()

                if($pkt -and $pkt[0]) {
                    Parse-Pkt $pkt[0] | ForEach-Object {
                        # If a folder doesn't have a redirection it will
                        # have a target like
                        # \\null\TestNameSpace\folder\.DFSFolderLink so we
                        # do actually want to match on "null" rather than
                        # $null
                        if ($_ -ne "null") {
                            New-Object -TypeName PSObject -Property @{'Name'=$Properties.name[0];'RemoteServerName'=$_}
                        }
                    }
                }
            }
            catch {
                Write-Warning "Get-DFSshareV1 error : $_"
            }
            $DFSshares | Sort-Object -Property "RemoteServerName"
        }
    }

    function Get-DFSshareV2 {
        [CmdletBinding()]
        param(
            [String]
            $Domain,

            [String]
            $DomainController,

            [String]
            $ADSpath,

            [ValidateRange(1,10000)] 
            [Int]
            $PageSize = 200,

            [Management.Automation.PSCredential]
            $Credential
        )

        $DFSsearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize

        if($DFSsearcher) {
            $DFSshares = @()
            $DFSsearcher.filter = "(&(objectClass=msDFS-Linkv2))"
            $DFSSearcher.PropertiesToLoad.AddRange(('msdfs-linkpathv2','msDFS-TargetListv2'))

            try {
                $Results = $DFSSearcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    $Properties = $_.Properties
                    $target_list = $Properties.'msdfs-targetlistv2'[0]
                    $xml = [xml][System.Text.Encoding]::Unicode.GetString($target_list[2..($target_list.Length-1)])
                    $DFSshares += $xml.targets.ChildNodes | ForEach-Object {
                        try {
                            $Target = $_.InnerText
                            if ( $Target.Contains('\') ) {
                                $DFSroot = $Target.split("\")[3]
                                $ShareName = $Properties.'msdfs-linkpathv2'[0]
                                New-Object -TypeName PSObject -Property @{'Name'="$DFSroot$ShareName";'RemoteServerName'=$Target.split("\")[2]}
                            }
                        }
                        catch {
                            Write-Verbose "Error in parsing target : $_"
                        }
                    }
                }
                $Results.dispose()
                $DFSSearcher.dispose()
            }
            catch {
                Write-Warning "Get-DFSshareV2 error : $_"
            }
            $DFSshares | Sort-Object -Unique -Property "RemoteServerName"
        }
    }

    $DFSshares = @()

    if ( ($Version -eq "all") -or ($Version.endsWith("1")) ) {
        $DFSshares += Get-DFSshareV1 -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize
    }
    if ( ($Version -eq "all") -or ($Version.endsWith("2")) ) {
        $DFSshares += Get-DFSshareV2 -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize
    }

    $DFSshares | Sort-Object -Property ("RemoteServerName","Name") -Unique
}

filter Get-GptTmpl {

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [String]
        $GptTmplPath,

        [Switch]
        $UsePSDrive
    )

    if($UsePSDrive) {
        # if we're PSDrives, create a temporary mount point
        $Parts = $GptTmplPath.split('\')
        $FolderPath = $Parts[0..($Parts.length-2)] -join '\'
        $FilePath = $Parts[-1]
        $RandDrive = ("abcdefghijklmnopqrstuvwxyz".ToCharArray() | Get-Random -Count 7) -join ''

        Write-Verbose "Mounting path $GptTmplPath using a temp PSDrive at $RandDrive"

        try {
            $Null = New-PSDrive -Name $RandDrive -PSProvider FileSystem -Root $FolderPath  -ErrorAction Stop
        }
        catch {
            Write-Verbose "Error mounting path $GptTmplPath : $_"
            return $Null
        }

        # so we can cd/dir the new drive
        $TargetGptTmplPath = $RandDrive + ":\" + $FilePath
    }
    else {
        $TargetGptTmplPath = $GptTmplPath
    }

    Write-Verbose "GptTmplPath: $GptTmplPath"

    try {
        Write-Verbose "Parsing $TargetGptTmplPath"
        $TargetGptTmplPath | Get-IniContent -ErrorAction SilentlyContinue
    }
    catch {
        Write-Verbose "Error parsing $TargetGptTmplPath : $_"
    }

    if($UsePSDrive -and $RandDrive) {
        Write-Verbose "Removing temp PSDrive $RandDrive"
        Get-PSDrive -Name $RandDrive -ErrorAction SilentlyContinue | Remove-PSDrive -Force
    }
}

filter Get-GroupsXML {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [String]
        $GroupsXMLPath,

        [Switch]
        $UsePSDrive
    )

    if($UsePSDrive) {
        # if we're PSDrives, create a temporary mount point
        $Parts = $GroupsXMLPath.split('\')
        $FolderPath = $Parts[0..($Parts.length-2)] -join '\'
        $FilePath = $Parts[-1]
        $RandDrive = ("abcdefghijklmnopqrstuvwxyz".ToCharArray() | Get-Random -Count 7) -join ''

        Write-Verbose "Mounting path $GroupsXMLPath using a temp PSDrive at $RandDrive"

        try {
            $Null = New-PSDrive -Name $RandDrive -PSProvider FileSystem -Root $FolderPath  -ErrorAction Stop
        }
        catch {
            Write-Verbose "Error mounting path $GroupsXMLPath : $_"
            return $Null
        }

        # so we can cd/dir the new drive
        $TargetGroupsXMLPath = $RandDrive + ":\" + $FilePath
    }
    else {
        $TargetGroupsXMLPath = $GroupsXMLPath
    }

    try {
        [XML]$GroupsXMLcontent = Get-Content $TargetGroupsXMLPath -ErrorAction Stop

        # process all group properties in the XML
        $GroupsXMLcontent | Select-Xml "/Groups/Group" | Select-Object -ExpandProperty node | ForEach-Object {

            $Groupname = $_.Properties.groupName

            # extract the localgroup sid for memberof
            $GroupSID = $_.Properties.groupSid
            if(-not $GroupSID) {
                if($Groupname -match 'Administrators') {
                    $GroupSID = 'S-1-5-32-544'
                }
                elseif($Groupname -match 'Remote Desktop') {
                    $GroupSID = 'S-1-5-32-555'
                }
                elseif($Groupname -match 'Guests') {
                    $GroupSID = 'S-1-5-32-546'
                }
                else {
                    $GroupSID = Convert-NameToSid -ObjectName $Groupname | Select-Object -ExpandProperty SID
                }
            }

            # extract out members added to this group
            $Members = $_.Properties.members | Select-Object -ExpandProperty Member | Where-Object { $_.action -match 'ADD' } | ForEach-Object {
                if($_.sid) { $_.sid }
                else { $_.name }
            }

            if ($Members) {

                # extract out any/all filters...I hate you GPP
                if($_.filters) {
                    $Filters = $_.filters.GetEnumerator() | ForEach-Object {
                        New-Object -TypeName PSObject -Property @{'Type' = $_.LocalName;'Value' = $_.name}
                    }
                }
                else {
                    $Filters = $Null
                }

                if($Members -isnot [System.Array]) { $Members = @($Members) }

                $GPOGroup = New-Object PSObject
                $GPOGroup | Add-Member Noteproperty 'GPOPath' $TargetGroupsXMLPath
                $GPOGroup | Add-Member Noteproperty 'Filters' $Filters
                $GPOGroup | Add-Member Noteproperty 'GroupName' $GroupName
                $GPOGroup | Add-Member Noteproperty 'GroupSID' $GroupSID
                $GPOGroup | Add-Member Noteproperty 'GroupMemberOf' $Null
                $GPOGroup | Add-Member Noteproperty 'GroupMembers' $Members
                $GPOGroup
            }
        }
    }
    catch {
        Write-Verbose "Error parsing $TargetGroupsXMLPath : $_"
    }

    if($UsePSDrive -and $RandDrive) {
        Write-Verbose "Removing temp PSDrive $RandDrive"
        Get-PSDrive -Name $RandDrive -ErrorAction SilentlyContinue | Remove-PSDrive -Force
    }
}

function Get-ThisThingGPO {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $GPOname = '*',

        [String]
        $DisplayName,

        [String]
        $ComputerName,

        [String]
        $Domain,

        [String]
        $DomainController,
        
        [String]
        $ADSpath,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        $GPOSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $ADSpath -PageSize $PageSize
    }

    process {
        if ($GPOSearcher) {

            if($ComputerName) {
                $GPONames = @()
                $Computers = Get-ThisThingComputer -ComputerName $ComputerName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize

                if(!$Computers) {
                    throw "Computer $ComputerName in domain '$Domain' not found! Try a fully qualified host name"
                }
                
                # get the given computer's OU
                $ComputerOUs = @()
                ForEach($Computer in $Computers) {
                    # extract all OUs a computer is a part of
                    $DN = $Computer.distinguishedname

                    $ComputerOUs += $DN.split(",") | ForEach-Object {
                        if($_.startswith("OU=")) {
                            $DN.substring($DN.indexof($_))
                        }
                    }
                }
                
                Write-Verbose "ComputerOUs: $ComputerOUs"

                # find all the GPOs linked to the computer's OU
                ForEach($ComputerOU in $ComputerOUs) {
                    $GPONames += Get-ThisThingOU -Domain $Domain -DomainController $DomainController -ADSpath $ComputerOU -FullData -PageSize $PageSize | ForEach-Object { 
                        # get any GPO links
                        write-verbose "blah: $($_.name)"
                        $_.gplink.split("][") | ForEach-Object {
                            if ($_.startswith("LDAP")) {
                                $_.split(";")[0]
                            }
                        }
                    }
                }
                
                Write-Verbose "GPONames: $GPONames"

                # find any GPOs linked to the site for the given computer
                $ComputerSite = (Get-SiteName -ComputerName $ComputerName).SiteName
                if($ComputerSite -and ($ComputerSite -notlike 'Error*')) {
                    $GPONames += Get-ThisThingSite -SiteName $ComputerSite -FullData | ForEach-Object {
                        if($_.gplink) {
                            $_.gplink.split("][") | ForEach-Object {
                                if ($_.startswith("LDAP")) {
                                    $_.split(";")[0]
                                }
                            }
                        }
                    }
                }

                $GPONames | Where-Object{$_ -and ($_ -ne '')} | ForEach-Object {

                    # use the gplink as an ADS path to enumerate all GPOs for the computer
                    $GPOSearcher = Get-DomainSearcher -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $_ -PageSize $PageSize
                    $GPOSearcher.filter="(&(objectCategory=groupPolicyContainer)(name=$GPOname))"

                    try {
                        $Results = $GPOSearcher.FindAll()
                        $Results | Where-Object {$_} | ForEach-Object {
                            $Out = Convert-LDAPProperty -Properties $_.Properties
                            $Out | Add-Member Noteproperty 'ComputerName' $ComputerName
                            $Out
                        }
                        $Results.dispose()
                        $GPOSearcher.dispose()
                    }
                    catch {
                        Write-Warning $_
                    }
                }
            }

            else {
                if($DisplayName) {
                    $GPOSearcher.filter="(&(objectCategory=groupPolicyContainer)(displayname=$DisplayName))"
                }
                else {
                    $GPOSearcher.filter="(&(objectCategory=groupPolicyContainer)(name=$GPOname))"
                }

                try {
                    $Results = $GPOSearcher.FindAll()
                    $Results | Where-Object {$_} | ForEach-Object {
                        if($ADSPath -and ($ADSpath -Match '^GC://')) {
                            $Properties = Convert-LDAPProperty -Properties $_.Properties
                            try {
                                $GPODN = $Properties.distinguishedname
                                $GPODomain = $GPODN.subString($GPODN.IndexOf("DC=")) -replace 'DC=','' -replace ',','.'
                                $gpcfilesyspath = "\\$GPODomain\SysVol\$GPODomain\Policies\$($Properties.cn)"
                                $Properties | Add-Member Noteproperty 'gpcfilesyspath' $gpcfilesyspath
                                $Properties
                            }
                            catch {
                                $Properties
                            }
                        }
                        else {
                            # convert/process the LDAP fields for each result
                            Convert-LDAPProperty -Properties $_.Properties
                        }
                    }
                    $Results.dispose()
                    $GPOSearcher.dispose()
                }
                catch {
                    Write-Warning $_
                }
            }
        }
    }
}

function New-GPOImmediateTask {
    [CmdletBinding(DefaultParameterSetName = 'Create')]
    Param (
        [Parameter(ParameterSetName = 'Create', Mandatory = $True)]
        [String]
        [ValidateNotNullOrEmpty()]
        $TaskName,

        [Parameter(ParameterSetName = 'Create')]
        [String]
        [ValidateNotNullOrEmpty()]
        $Command = 'powershell',

        [Parameter(ParameterSetName = 'Create')]
        [String]
        [ValidateNotNullOrEmpty()]
        $CommandArguments,

        [Parameter(ParameterSetName = 'Create')]
        [String]
        [ValidateNotNullOrEmpty()]
        $TaskDescription = '',

        [Parameter(ParameterSetName = 'Create')]
        [String]
        [ValidateNotNullOrEmpty()]
        $TaskAuthor = 'NT AUTHORITY\System',

        [Parameter(ParameterSetName = 'Create')]
        [String]
        [ValidateNotNullOrEmpty()]
        $TaskModifiedDate = (Get-Date (Get-Date).AddDays(-30) -Format u).trim("Z"),

        [Parameter(ParameterSetName = 'Create')]
        [Parameter(ParameterSetName = 'Remove')]
        [String]
        $GPOname,

        [Parameter(ParameterSetName = 'Create')]
        [Parameter(ParameterSetName = 'Remove')]
        [String]
        $GPODisplayName,

        [Parameter(ParameterSetName = 'Create')]
        [Parameter(ParameterSetName = 'Remove')]
        [String]
        $Domain,

        [Parameter(ParameterSetName = 'Create')]
        [Parameter(ParameterSetName = 'Remove')]
        [String]
        $DomainController,
        
        [Parameter(ParameterSetName = 'Create')]
        [Parameter(ParameterSetName = 'Remove')]
        [String]
        $ADSpath,

        [Parameter(ParameterSetName = 'Create')]
        [Parameter(ParameterSetName = 'Remove')]
        [Switch]
        $Force,

        [Parameter(ParameterSetName = 'Remove')]
        [Switch]
        $Remove,

        [Parameter(ParameterSetName = 'Create')]
        [Parameter(ParameterSetName = 'Remove')]        
        [Management.Automation.PSCredential]
        $Credential
    )

    # build the XML spec for our 'immediate' scheduled task
    $TaskXML = '<?xml version="1.0" encoding="utf-8"?><ScheduledTasks clsid="{CC63F200-7309-4ba0-B154-A71CD118DBCC}"><ImmediateTaskV2 clsid="{9756B581-76EC-4169-9AFC-0CA8D43ADB5F}" name="'+$TaskName+'" image="0" changed="'+$TaskModifiedDate+'" uid="{'+$([guid]::NewGuid())+'}" userContext="0" removePolicy="0"><Properties action="C" name="'+$TaskName+'" runAs="NT AUTHORITY\System" logonType="S4U"><Task version="1.3"><RegistrationInfo><Author>'+$TaskAuthor+'</Author><Description>'+$TaskDescription+'</Description></RegistrationInfo><Principals><Principal id="Author"><UserId>NT AUTHORITY\System</UserId><RunLevel>HighestAvailable</RunLevel><LogonType>S4U</LogonType></Principal></Principals><Settings><IdleSettings><Duration>PT10M</Duration><WaitTimeout>PT1H</WaitTimeout><StopOnIdleEnd>true</StopOnIdleEnd><RestartOnIdle>false</RestartOnIdle></IdleSettings><MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy><DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries><StopIfGoingOnBatteries>true</StopIfGoingOnBatteries><AllowHardTerminate>false</AllowHardTerminate><StartWhenAvailable>true</StartWhenAvailable><AllowStartOnDemand>false</AllowStartOnDemand><Enabled>true</Enabled><Hidden>true</Hidden><ExecutionTimeLimit>PT0S</ExecutionTimeLimit><Priority>7</Priority><DeleteExpiredTaskAfter>PT0S</DeleteExpiredTaskAfter><RestartOnFailure><Interval>PT15M</Interval><Count>3</Count></RestartOnFailure></Settings><Actions Context="Author"><Exec><Command>'+$Command+'</Command><Arguments>'+$CommandArguments+'</Arguments></Exec></Actions><Triggers><TimeTrigger><StartBoundary>%LocalTimeXmlEx%</StartBoundary><EndBoundary>%LocalTimeXmlEx%</EndBoundary><Enabled>true</Enabled></TimeTrigger></Triggers></Task></Properties></ImmediateTaskV2></ScheduledTasks>'

    if (!$PSBoundParameters['GPOname'] -and !$PSBoundParameters['GPODisplayName']) {
        Write-Warning 'Either -GPOName or -GPODisplayName must be specified'
        return
    }

    # eunmerate the specified GPO(s)
    $GPOs = Get-ThisThingGPO -GPOname $GPOname -DisplayName $GPODisplayName -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -Credential $Credential 
    
    if(!$GPOs) {
        Write-Warning 'No GPO found.'
        return
    }

    $GPOs | ForEach-Object {
        $ProcessedGPOName = $_.Name
        try {
            Write-Verbose "Trying to weaponize GPO: $ProcessedGPOName"

            # map a network drive as New-PSDrive/New-Item/etc. don't accept -Credential properly :(
            if($Credential) {
                Write-Verbose "Mapping '$($_.gpcfilesyspath)' to network drive N:\"
                $Path = $_.gpcfilesyspath.TrimEnd('\')
                $Net = New-Object -ComObject WScript.Network
                $Net.MapNetworkDrive("N:", $Path, $False, $Credential.UserName, $Credential.GetNetworkCredential().Password)
                $TaskPath = "N:\Machine\Preferences\ScheduledTasks\"
            }
            else {
                $TaskPath = $_.gpcfilesyspath + "\Machine\Preferences\ScheduledTasks\"
            }

            if($Remove) {
                if(!(Test-Path "$TaskPath\ScheduledTasks.xml")) {
                    Throw "Scheduled task doesn't exist at $TaskPath\ScheduledTasks.xml"
                }

                if (!$Force -and !$psCmdlet.ShouldContinue('Do you want to continue?',"Removing schtask at $TaskPath\ScheduledTasks.xml")) {
                    return
                }

                Remove-Item -Path "$TaskPath\ScheduledTasks.xml" -Force
            }
            else {
                if (!$Force -and !$psCmdlet.ShouldContinue('Do you want to continue?',"Creating schtask at $TaskPath\ScheduledTasks.xml")) {
                    return
                }
                
                # create the folder if it doesn't exist
                $Null = New-Item -ItemType Directory -Force -Path $TaskPath

                if(Test-Path "$TaskPath\ScheduledTasks.xml") {
                    Throw "Scheduled task already exists at $TaskPath\ScheduledTasks.xml !"
                }

                $TaskXML | Set-Content -Encoding ASCII -Path "$TaskPath\ScheduledTasks.xml"
            }

            if($Credential) {
                Write-Verbose "Removing mounted drive at N:\"
                $Net = New-Object -ComObject WScript.Network
                $Net.RemoveNetworkDrive("N:")
            }
        }
        catch {
            Write-Warning "Error for GPO $ProcessedGPOName : $_"
            if($Credential) {
                Write-Verbose "Removing mounted drive at N:\"
                $Net = New-Object -ComObject WScript.Network
                $Net.RemoveNetworkDrive("N:")
            }
        }
    }
}

function Get-ThisThingGPOGroup {
    [CmdletBinding()]
    Param (
        [String]
        $GPOname = '*',

        [String]
        $DisplayName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [Switch]
        $ResolveMemberSIDs,

        [Switch]
        $UsePSDrive,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    $Option = [System.StringSplitOptions]::RemoveEmptyEntries

    # get every GPO from the specified domain with restricted groups set
    Get-ThisThingGPO -GPOName $GPOname -DisplayName $DisplayName -Domain $Domain -DomainController $DomainController -ADSpath $ADSpath -PageSize $PageSize | ForEach-Object {

        $GPOdisplayName = $_.displayname
        $GPOname = $_.name
        $GPOPath = $_.gpcfilesyspath

        $ParseArgs =  @{
            'GptTmplPath' = "$GPOPath\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf"
            'UsePSDrive' = $UsePSDrive
        }

        # parse the GptTmpl.inf 'Restricted Groups' file if it exists
        $Inf = Get-GptTmpl @ParseArgs

        if($Inf -and ($Inf.psbase.Keys -contains 'Group Membership')) {

            $Memberships = @{}

            # group the members/memberof fields for each entry
            ForEach ($Membership in $Inf.'Group Membership'.GetEnumerator()) {
                $Group, $Relation = $Membership.Key.Split('__', $Option) | ForEach-Object {$_.Trim()}

                # extract out ALL members
                $MembershipValue = $Membership.Value | Where-Object {$_} | ForEach-Object { $_.Trim('*') } | Where-Object {$_}

                if($ResolveMemberSIDs) {
                    # if the resulting member is username and not a SID, attempt to resolve it
                    $GroupMembers = @()
                    ForEach($Member in $MembershipValue) {
                        if($Member -and ($Member.Trim() -ne '')) {
                            if($Member -notmatch '^S-1-.*') {
                                $MemberSID = Convert-NameToSid -Domain $Domain -ObjectName $Member | Select-Object -ExpandProperty SID
                                if($MemberSID) {
                                    $GroupMembers += $MemberSID
                                }
                                else {
                                    $GroupMembers += $Member
                                }
                            }
                            else {
                                $GroupMembers += $Member
                            }
                        }
                    }
                    $MembershipValue = $GroupMembers
                }

                if(-not $Memberships[$Group]) {
                    $Memberships[$Group] = @{}
                }
                if($MembershipValue -isnot [System.Array]) {$MembershipValue = @($MembershipValue)}
                $Memberships[$Group].Add($Relation, $MembershipValue)
            }

            ForEach ($Membership in $Memberships.GetEnumerator()) {
                if($Membership -and $Membership.Key -and ($Membership.Key -match '^\*')) {
                    # if the SID is already resolved (i.e. begins with *) try to resolve SID to a name
                    $GroupSID = $Membership.Key.Trim('*')
                    if($GroupSID -and ($GroupSID.Trim() -ne '')) {
                        $GroupName = Convert-SidToName -SID $GroupSID
                    }
                    else {
                        $GroupName = $False
                    }
                }
                else {
                    $GroupName = $Membership.Key

                    if($GroupName -and ($GroupName.Trim() -ne '')) {
                        if($Groupname -match 'Administrators') {
                            $GroupSID = 'S-1-5-32-544'
                        }
                        elseif($Groupname -match 'Remote Desktop') {
                            $GroupSID = 'S-1-5-32-555'
                        }
                        elseif($Groupname -match 'Guests') {
                            $GroupSID = 'S-1-5-32-546'
                        }
                        elseif($GroupName.Trim() -ne '') {
                            $GroupSID = Convert-NameToSid -Domain $Domain -ObjectName $Groupname | Select-Object -ExpandProperty SID
                        }
                        else {
                            $GroupSID = $Null
                        }
                    }
                }

                $GPOGroup = New-Object PSObject
                $GPOGroup | Add-Member Noteproperty 'GPODisplayName' $GPODisplayName
                $GPOGroup | Add-Member Noteproperty 'GPOName' $GPOName
                $GPOGroup | Add-Member Noteproperty 'GPOPath' $GPOPath
                $GPOGroup | Add-Member Noteproperty 'GPOType' 'RestrictedGroups'
                $GPOGroup | Add-Member Noteproperty 'Filters' $Null
                $GPOGroup | Add-Member Noteproperty 'GroupName' $GroupName
                $GPOGroup | Add-Member Noteproperty 'GroupSID' $GroupSID
                $GPOGroup | Add-Member Noteproperty 'GroupMemberOf' $Membership.Value.Memberof
                $GPOGroup | Add-Member Noteproperty 'GroupMembers' $Membership.Value.Members
                $GPOGroup
            }
        }

        $ParseArgs =  @{
            'GroupsXMLpath' = "$GPOPath\MACHINE\Preferences\Groups\Groups.xml"
            'UsePSDrive' = $UsePSDrive
        }

        Get-GroupsXML @ParseArgs | ForEach-Object {
            if($ResolveMemberSIDs) {
                $GroupMembers = @()
                ForEach($Member in $_.GroupMembers) {
                    if($Member -and ($Member.Trim() -ne '')) {
                        if($Member -notmatch '^S-1-.*') {
                            # if the resulting member is username and not a SID, attempt to resolve it
                            $MemberSID = Convert-NameToSid -Domain $Domain -ObjectName $Member | Select-Object -ExpandProperty SID
                            if($MemberSID) {
                                $GroupMembers += $MemberSID
                            }
                            else {
                                $GroupMembers += $Member
                            }
                        }
                        else {
                            $GroupMembers += $Member
                        }
                    }
                }
                $_.GroupMembers = $GroupMembers
            }

            $_ | Add-Member Noteproperty 'GPODisplayName' $GPODisplayName
            $_ | Add-Member Noteproperty 'GPOName' $GPOName
            $_ | Add-Member Noteproperty 'GPOType' 'GroupPolicyPreferences'
            $_
        }
    }
}

function Find-GPOLocation {
    [CmdletBinding()]
    Param (
        [String]
        $UserName,

        [String]
        $GroupName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $LocalGroup = 'Administrators',
        
        [Switch]
        $UsePSDrive,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    if($UserName) {
        # if a group name is specified, get that user object so we can extract the target SID
        $User = Get-ThisThingUser -UserName $UserName -Domain $Domain -DomainController $DomainController -PageSize $PageSize | Select-Object -First 1
        $UserSid = $User.objectsid

        if(-not $UserSid) {    
            Throw "User '$UserName' not found!"
        }

        $TargetSIDs = @($UserSid)
        $ObjectSamAccountName = $User.samaccountname
        $TargetObject = $UserSid
    }
    elseif($GroupName) {
        # if a group name is specified, get that group object so we can extract the target SID
        $Group = Get-ThisThingGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize | Select-Object -First 1
        $GroupSid = $Group.objectsid

        if(-not $GroupSid) {    
            Throw "Group '$GroupName' not found!"
        }

        $TargetSIDs = @($GroupSid)
        $ObjectSamAccountName = $Group.samaccountname
        $TargetObject = $GroupSid
    }
    else {
        $TargetSIDs = @('*')
    }

    # figure out what the SID is of the target local group we're checking for membership in
    if($LocalGroup -like "*Admin*") {
        $TargetLocalSID = 'S-1-5-32-544'
    }
    elseif ( ($LocalGroup -like "*RDP*") -or ($LocalGroup -like "*Remote*") ) {
        $TargetLocalSID = 'S-1-5-32-555'
    }
    elseif ($LocalGroup -like "S-1-5-*") {
        $TargetLocalSID = $LocalGroup
    }
    else {
        throw "LocalGroup must be 'Administrators', 'RDP', or a 'S-1-5-X' SID format."
    }

    # if we're not listing all relationships, use the tokenGroups approach from Get-ThisThingGroup to 
    # get all effective security SIDs this object is a part of
    if($TargetSIDs[0] -and ($TargetSIDs[0] -ne '*')) {
        $TargetSIDs += Get-ThisThingGroup -Domain $Domain -DomainController $DomainController -PageSize $PageSize -UserName $ObjectSamAccountName -RawSids
    }

    if(-not $TargetSIDs) {
        throw "No effective target SIDs!"
    }

    Write-Verbose "TargetLocalSID: $TargetLocalSID"
    Write-Verbose "Effective target SIDs: $TargetSIDs"

    $GPOGroupArgs =  @{
        'Domain' = $Domain
        'DomainController' = $DomainController
        'UsePSDrive' = $UsePSDrive
        'ResolveMemberSIDs' = $True
        'PageSize' = $PageSize
    }

    # enumerate all GPO group mappings for the target domain that involve our target SID set
    $GPOgroups = Get-ThisThingGPOGroup @GPOGroupArgs | ForEach-Object {

        $GPOgroup = $_

        # if the locally set group is what we're looking for, check the GroupMembers ('members')
        #    for our target SID
        if($GPOgroup.GroupSID -match $TargetLocalSID) {
            $GPOgroup.GroupMembers | Where-Object {$_} | ForEach-Object {
                if ( ($TargetSIDs[0] -eq '*') -or ($TargetSIDs -Contains $_) ) {
                    $GPOgroup
                }
            }
        }
        # if the group is a 'memberof' the group we're looking for, check GroupSID against the targt SIDs 
        if( ($GPOgroup.GroupMemberOf -contains $TargetLocalSID) ) {
            if( ($TargetSIDs[0] -eq '*') -or ($TargetSIDs -Contains $GPOgroup.GroupSID) ) {
                $GPOgroup
            }
        }
    } | Sort-Object -Property GPOName -Unique

    $GPOgroups | ForEach-Object {

        $GPOname = $_.GPODisplayName
        $GPOguid = $_.GPOName
        $GPOPath = $_.GPOPath
        $GPOType = $_.GPOType
        if($_.GroupMembers) {
            $GPOMembers = $_.GroupMembers
        }
        else {
            $GPOMembers = $_.GroupSID
        }
        
        $Filters = $_.Filters

        if(-not $TargetObject) {
            # if the * wildcard was used, set the ObjectDistName as the GPO member SID set
            #   so all relationship mappings are output
            $TargetObjectSIDs = $GPOMembers
        }
        else {
            $TargetObjectSIDs = $TargetObject
        }

        # find any OUs that have this GUID applied and then retrieve any computers from the OU
        Get-ThisThingOU -Domain $Domain -DomainController $DomainController -GUID $GPOguid -FullData -PageSize $PageSize | ForEach-Object {
            if($Filters) {
                # filter for computer name/org unit if a filter is specified
                #   TODO: handle other filters (i.e. OU filters?) again, I hate you GPP...
                $OUComputers = Get-ThisThingComputer -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $_.ADSpath -FullData -PageSize $PageSize | Where-Object {
                    $_.adspath -match ($Filters.Value)
                } | ForEach-Object { $_.dnshostname }
            }
            else {
                $OUComputers = Get-ThisThingComputer -Domain $Domain -DomainController $DomainController -Credential $Credential -ADSpath $_.ADSpath -PageSize $PageSize
            }

            if($OUComputers) {
                if($OUComputers -isnot [System.Array]) {$OUComputers = @($OUComputers)}

                ForEach ($TargetSid in $TargetObjectSIDs) {
                    $Object = Get-ADObject -SID $TargetSid -Domain $Domain -DomainController $DomainController -Credential $Credential -PageSize $PageSize

                    $IsGroup = @('268435456','268435457','536870912','536870913') -contains $Object.samaccounttype

                    $GPOLocation = New-Object PSObject
                    $GPOLocation | Add-Member Noteproperty 'ObjectName' $Object.samaccountname
                    $GPOLocation | Add-Member Noteproperty 'ObjectDN' $Object.distinguishedname
                    $GPOLocation | Add-Member Noteproperty 'ObjectSID' $Object.objectsid
                    $GPOLocation | Add-Member Noteproperty 'Domain' $Domain
                    $GPOLocation | Add-Member Noteproperty 'IsGroup' $IsGroup
                    $GPOLocation | Add-Member Noteproperty 'GPODisplayName' $GPOname
                    $GPOLocation | Add-Member Noteproperty 'GPOGuid' $GPOGuid
                    $GPOLocation | Add-Member Noteproperty 'GPOPath' $GPOPath
                    $GPOLocation | Add-Member Noteproperty 'GPOType' $GPOType
                    $GPOLocation | Add-Member Noteproperty 'ContainerName' $_.distinguishedname
                    $GPOLocation | Add-Member Noteproperty 'ComputerName' $OUComputers
                    $GPOLocation.PSObject.TypeNames.Add('PowerView.GPOLocalGroup')
                    $GPOLocation
                }
            }
        }

        # find any sites that have this GUID applied
        Get-ThisThingSite -Domain $Domain -DomainController $DomainController -GUID $GPOguid -PageSize $PageSize -FullData | ForEach-Object {

            ForEach ($TargetSid in $TargetObjectSIDs) {
                $Object = Get-ADObject -SID $TargetSid -Domain $Domain -DomainController $DomainController -Credential $Credential -PageSize $PageSize

                $IsGroup = @('268435456','268435457','536870912','536870913') -contains $Object.samaccounttype

                $AppliedSite = New-Object PSObject
                $AppliedSite | Add-Member Noteproperty 'ObjectName' $Object.samaccountname
                $AppliedSite | Add-Member Noteproperty 'ObjectDN' $Object.distinguishedname
                $AppliedSite | Add-Member Noteproperty 'ObjectSID' $Object.objectsid
                $AppliedSite | Add-Member Noteproperty 'IsGroup' $IsGroup
                $AppliedSite | Add-Member Noteproperty 'Domain' $Domain
                $AppliedSite | Add-Member Noteproperty 'GPODisplayName' $GPOname
                $AppliedSite | Add-Member Noteproperty 'GPOGuid' $GPOGuid
                $AppliedSite | Add-Member Noteproperty 'GPOPath' $GPOPath
                $AppliedSite | Add-Member Noteproperty 'GPOType' $GPOType
                $AppliedSite | Add-Member Noteproperty 'ContainerName' $_.distinguishedname
                $AppliedSite | Add-Member Noteproperty 'ComputerName' $_.siteobjectbl
                $AppliedSite.PSObject.TypeNames.Add('PowerView.GPOLocalGroup')
                $AppliedSite
            }
        }
    }
}

function Find-GPOComputerAdmin {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $ComputerName,

        [String]
        $OUName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [Switch]
        $Recurse,

        [String]
        $LocalGroup = 'Administrators',

        [Switch]
        $UsePSDrive,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    process {
    
        if(!$ComputerName -and !$OUName) {
            Throw "-ComputerName or -OUName must be provided"
        }

        $GPOGroups = @()

        if($ComputerName) {
            $Computers = Get-ThisThingComputer -ComputerName $ComputerName -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize

            if(!$Computers) {
                throw "Computer $ComputerName in domain '$Domain' not found! Try a fully qualified host name"
            }
            
            $TargetOUs = @()
            ForEach($Computer in $Computers) {
                # extract all OUs a computer is a part of
                $DN = $Computer.distinguishedname

                $TargetOUs += $DN.split(",") | ForEach-Object {
                    if($_.startswith("OU=")) {
                        $DN.substring($DN.indexof($_))
                    }
                }
            }

            # enumerate any linked GPOs for the computer's site
            $ComputerSite = (Get-SiteName -ComputerName $ComputerName).SiteName
            if($ComputerSite -and ($ComputerSite -notlike 'Error*')) {
                $GPOGroups += Get-ThisThingSite -SiteName $ComputerSite -FullData | ForEach-Object {
                    if($_.gplink) {
                        $_.gplink.split("][") | ForEach-Object {
                            if ($_.startswith("LDAP")) {
                                $_.split(";")[0]
                            }
                        }
                    }
                } | ForEach-Object {
                    $GPOGroupArgs =  @{
                        'Domain' = $Domain
                        'DomainController' = $DomainController
                        'ResolveMemberSIDs' = $True
                        'UsePSDrive' = $UsePSDrive
                        'PageSize' = $PageSize
                    }

                    # for each GPO link, get any locally set user/group SIDs
                    Get-ThisThingGPOGroup @GPOGroupArgs
                }
            }
        }
        else {
            $TargetOUs = @($OUName)
        }

        Write-Verbose "Target OUs: $TargetOUs"

        $TargetOUs | Where-Object {$_} | ForEach-Object {

            $GPOLinks = Get-ThisThingOU -Domain $Domain -DomainController $DomainController -ADSpath $_ -FullData -PageSize $PageSize | ForEach-Object { 
                # and then get any GPO links
                if($_.gplink) {
                    $_.gplink.split("][") | ForEach-Object {
                        if ($_.startswith("LDAP")) {
                            $_.split(";")[0]
                        }
                    }
                }
            }

            $GPOGroupArgs =  @{
                'Domain' = $Domain
                'DomainController' = $DomainController
                'UsePSDrive' = $UsePSDrive
                'ResolveMemberSIDs' = $True
                'PageSize' = $PageSize
            }

            # extract GPO groups that are set through any gPlink for this OU
            $GPOGroups += Get-ThisThingGPOGroup @GPOGroupArgs | ForEach-Object {
                ForEach($GPOLink in $GPOLinks) {
                    $Name = $_.GPOName
                    if($GPOLink -like "*$Name*") {
                        $_
                    }
                }
            }
        }

        # for each found GPO group, resolve the SIDs of the members
        $GPOgroups | Sort-Object -Property GPOName -Unique | ForEach-Object {
            $GPOGroup = $_

            if($GPOGroup.GroupMembers) {
                $GPOMembers = $GPOGroup.GroupMembers
            }
            else {
                $GPOMembers = $GPOGroup.GroupSID
            }

            $GPOMembers | ForEach-Object {
                # resolve this SID to a domain object
                $Object = Get-ADObject -Domain $Domain -DomainController $DomainController -PageSize $PageSize -SID $_

                $IsGroup = @('268435456','268435457','536870912','536870913') -contains $Object.samaccounttype

                $GPOComputerAdmin = New-Object PSObject
                $GPOComputerAdmin | Add-Member Noteproperty 'ComputerName' $ComputerName
                $GPOComputerAdmin | Add-Member Noteproperty 'ObjectName' $Object.samaccountname
                $GPOComputerAdmin | Add-Member Noteproperty 'ObjectDN' $Object.distinguishedname
                $GPOComputerAdmin | Add-Member Noteproperty 'ObjectSID' $_
                $GPOComputerAdmin | Add-Member Noteproperty 'IsGroup' $IsGroup
                $GPOComputerAdmin | Add-Member Noteproperty 'GPODisplayName' $GPOGroup.GPODisplayName
                $GPOComputerAdmin | Add-Member Noteproperty 'GPOGuid' $GPOGroup.GPOName
                $GPOComputerAdmin | Add-Member Noteproperty 'GPOPath' $GPOGroup.GPOPath
                $GPOComputerAdmin | Add-Member Noteproperty 'GPOType' $GPOGroup.GPOType
                $GPOComputerAdmin

                # if we're recursing and the current result object is a group
                if($Recurse -and $GPOComputerAdmin.isGroup) {

                    Get-ThisThingGroupMember -Domain $Domain -DomainController $DomainController -SID $_ -FullData -Recurse -PageSize $PageSize | ForEach-Object {

                        $MemberDN = $_.distinguishedName

                        # extract the FQDN from the Distinguished Name
                        $MemberDomain = $MemberDN.subString($MemberDN.IndexOf("DC=")) -replace 'DC=','' -replace ',','.'

                        $MemberIsGroup = @('268435456','268435457','536870912','536870913') -contains $_.samaccounttype

                        if ($_.samAccountName) {
                            # forest users have the samAccountName set
                            $MemberName = $_.samAccountName
                        }
                        else {
                            # external trust users have a SID, so convert it
                            try {
                                $MemberName = Convert-SidToName $_.cn
                            }
                            catch {
                                # if there's a problem contacting the domain to resolve the SID
                                $MemberName = $_.cn
                            }
                        }

                        $GPOComputerAdmin = New-Object PSObject
                        $GPOComputerAdmin | Add-Member Noteproperty 'ComputerName' $ComputerName
                        $GPOComputerAdmin | Add-Member Noteproperty 'ObjectName' $MemberName
                        $GPOComputerAdmin | Add-Member Noteproperty 'ObjectDN' $MemberDN
                        $GPOComputerAdmin | Add-Member Noteproperty 'ObjectSID' $_.objectsid
                        $GPOComputerAdmin | Add-Member Noteproperty 'IsGroup' $MemberIsGrou
                        $GPOComputerAdmin | Add-Member Noteproperty 'GPODisplayName' $GPOGroup.GPODisplayName
                        $GPOComputerAdmin | Add-Member Noteproperty 'GPOGuid' $GPOGroup.GPOName
                        $GPOComputerAdmin | Add-Member Noteproperty 'GPOPath' $GPOGroup.GPOPath
                        $GPOComputerAdmin | Add-Member Noteproperty 'GPOType' $GPOTypep
                        $GPOComputerAdmin 
                    }
                }
            }
        }
    }
}

function Get-DomainPolicy {
    [CmdletBinding()]
    Param (
        [String]
        [ValidateSet("Domain","DC")]
        $Source ="Domain",

        [String]
        $Domain,

        [String]
        $DomainController,

        [Switch]
        $ResolveSids,

        [Switch]
        $UsePSDrive
    )

    if($Source -eq "Domain") {
        # query the given domain for the default domain policy object
        $GPO = Get-ThisThingGPO -Domain $Domain -DomainController $DomainController -GPOname "{31B2F340-016D-11D2-945F-00C04FB984F9}"
        
        if($GPO) {
            # grab the GptTmpl.inf file and parse it
            $GptTmplPath = $GPO.gpcfilesyspath + "\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf"

            $ParseArgs =  @{
                'GptTmplPath' = $GptTmplPath
                'UsePSDrive' = $UsePSDrive
            }

            # parse the GptTmpl.inf
            Get-GptTmpl @ParseArgs
        }

    }
    elseif($Source -eq "DC") {
        # query the given domain/dc for the default domain controller policy object
        $GPO = Get-ThisThingGPO -Domain $Domain -DomainController $DomainController -GPOname "{6AC1786C-016F-11D2-945F-00C04FB984F9}"

        if($GPO) {
            # grab the GptTmpl.inf file and parse it
            $GptTmplPath = $GPO.gpcfilesyspath + "\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf"

            $ParseArgs =  @{
                'GptTmplPath' = $GptTmplPath
                'UsePSDrive' = $UsePSDrive
            }

            # parse the GptTmpl.inf
            Get-GptTmpl @ParseArgs | ForEach-Object {
                if($ResolveSids) {
                    # if we're resolving sids in PrivilegeRights to names
                    $Policy = New-Object PSObject
                    $_.psobject.properties | ForEach-Object {
                        if( $_.Name -eq 'PrivilegeRights') {

                            $PrivilegeRights = New-Object PSObject
                            # for every nested SID member of PrivilegeRights, try to unpack everything and resolve the SIDs as appropriate
                            $_.Value.psobject.properties | ForEach-Object {

                                $Sids = $_.Value | ForEach-Object {
                                    try {
                                        if($_ -isnot [System.Array]) { 
                                            Convert-SidToName $_ 
                                        }
                                        else {
                                            $_ | ForEach-Object { Convert-SidToName $_ }
                                        }
                                    }
                                    catch {
                                        Write-Verbose "Error resolving SID : $_"
                                    }
                                }

                                $PrivilegeRights | Add-Member Noteproperty $_.Name $Sids
                            }

                            $Policy | Add-Member Noteproperty 'PrivilegeRights' $PrivilegeRights
                        }
                        else {
                            $Policy | Add-Member Noteproperty $_.Name $_.Value
                        }
                    }
                    $Policy
                }
                else { $_ }
            }
        }
    }
}

function Get-ThisThingLocalGroup {
    [CmdletBinding(DefaultParameterSetName = 'WinNT')]
    param(
        [Parameter(ParameterSetName = 'API', Position=0, ValueFromPipeline=$True)]
        [Parameter(ParameterSetName = 'WinNT', Position=0, ValueFromPipeline=$True)]
        [Alias('HostName')]
        [String[]]
        $ComputerName = $Env:ComputerName,

        [Parameter(ParameterSetName = 'WinNT')]
        [Parameter(ParameterSetName = 'API')]
        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,

        [Parameter(ParameterSetName = 'WinNT')]
        [Parameter(ParameterSetName = 'API')]
        [String]
        $GroupName = 'Administrators',

        [Parameter(ParameterSetName = 'WinNT')]
        [Switch]
        $ListGroups,

        [Parameter(ParameterSetName = 'WinNT')]
        [Switch]
        $Recurse,

        [Parameter(ParameterSetName = 'API')]
        [Switch]
        $API
    )

    process {

        $Servers = @()

        # if we have a host list passed, grab it
        if($ComputerFile) {
            $Servers = Get-Content -Path $ComputerFile
        }
        else {
            # otherwise assume a single host name
            $Servers += $ComputerName | Get-NameField
        }

        # query the specified group using the WINNT provider, and
        # extract fields as appropriate from the results
        ForEach($Server in $Servers) {

            if($API) {
                # if we're using the Netapi32 NetLocalGroupGetMembers API call to get the local group information
                # arguments for NetLocalGroupGetMembers
                $QueryLevel = 2
                $PtrInfo = [IntPtr]::Zero
                $EntriesRead = 0
                $TotalRead = 0
                $ResumeHandle = 0

                # get the local user information
                $Result = $Netapi32::NetLocalGroupGetMembers($Server, $GroupName, $QueryLevel, [ref]$PtrInfo, -1, [ref]$EntriesRead, [ref]$TotalRead, [ref]$ResumeHandle)

                # Locate the offset of the initial intPtr
                $Offset = $PtrInfo.ToInt64()

                $LocalUsers = @()

                # 0 = success
                if (($Result -eq 0) -and ($Offset -gt 0)) {

                    # Work out how much to increment the pointer by finding out the size of the structure
                    $Increment = $LOCALGROUP_MEMBERS_INFO_2::GetSize()

                    # parse all the result structures
                    for ($i = 0; ($i -lt $EntriesRead); $i++) {
                        # create a new int ptr at the given offset and cast the pointer as our result structure
                        $NewIntPtr = New-Object System.Intptr -ArgumentList $Offset
                        $Info = $NewIntPtr -as $LOCALGROUP_MEMBERS_INFO_2

                        $Offset = $NewIntPtr.ToInt64()
                        $Offset += $Increment

                        $SidString = ""
                        $Result2 = $Advapi32::ConvertSidToStringSid($Info.lgrmi2_sid, [ref]$SidString);$LastError = [Runtime.InteropServices.Marshal]::GetLastWin32Error()

                        if($Result2 -eq 0) {
                            Write-Verbose "Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
                        }
                        else {
                            $LocalUser = New-Object PSObject
                            $LocalUser | Add-Member Noteproperty 'ComputerName' $Server
                            $LocalUser | Add-Member Noteproperty 'AccountName' $Info.lgrmi2_domainandname
                            $LocalUser | Add-Member Noteproperty 'SID' $SidString

                            $IsGroup = $($Info.lgrmi2_sidusage -eq 'SidTypeGroup')
                            $LocalUser | Add-Member Noteproperty 'IsGroup' $IsGroup
                            $LocalUser.PSObject.TypeNames.Add('PowerView.LocalUserAPI')

                            $LocalUsers += $LocalUser
                        }
                    }

                    # free up the result buffer
                    $Null = $Netapi32::NetApiBufferFree($PtrInfo)

                    # try to extract out the machine SID by using the -500 account as a reference
                    $MachineSid = $LocalUsers | Where-Object {$_.SID -like '*-500'}
                    $Parts = $MachineSid.SID.Split('-')
                    $MachineSid = $Parts[0..($Parts.Length -2)] -join '-'

                    $LocalUsers | ForEach-Object {
                        if($_.SID -match $MachineSid) {
                            $_ | Add-Member Noteproperty 'IsDomain' $False
                        }
                        else {
                            $_ | Add-Member Noteproperty 'IsDomain' $True
                        }
                    }
                    $LocalUsers
                }
                else {
                    Write-Verbose "Error: $(([ComponentModel.Win32Exception] $Result).Message)"
                }
            }

            else {
                # otherwise we're using the WinNT service provider
                try {
                    if($ListGroups) {
                        # if we're listing the group names on a remote server
                        $Computer = [ADSI]"WinNT://$Server,computer"

                        $Computer.psbase.children | Where-Object { $_.psbase.schemaClassName -eq 'group' } | ForEach-Object {
                            $Group = New-Object PSObject
                            $Group | Add-Member Noteproperty 'Server' $Server
                            $Group | Add-Member Noteproperty 'Group' ($_.name[0])
                            $Group | Add-Member Noteproperty 'SID' ((New-Object System.Security.Principal.SecurityIdentifier $_.objectsid[0],0).Value)
                            $Group | Add-Member Noteproperty 'Description' ($_.Description[0])
                            $Group.PSObject.TypeNames.Add('PowerView.LocalGroup')
                            $Group
                        }
                    }
                    else {
                        # otherwise we're listing the group members
                        $Members = @($([ADSI]"WinNT://$Server/$GroupName,group").psbase.Invoke('Members'))

                        $Members | ForEach-Object {

                            $Member = New-Object PSObject
                            $Member | Add-Member Noteproperty 'ComputerName' $Server

                            $AdsPath = ($_.GetType().InvokeMember('Adspath', 'GetProperty', $Null, $_, $Null)).Replace('WinNT://', '')
                            $Class = $_.GetType().InvokeMember('Class', 'GetProperty', $Null, $_, $Null)

                            # try to translate the NT4 domain to a FQDN if possible
                            $Name = Convert-ADName -ObjectName $AdsPath -InputType 'NT4' -OutputType 'Canonical'
                            $IsGroup = $Class -eq "Group"

                            if($Name) {
                                $FQDN = $Name.split("/")[0]
                                $ObjName = $AdsPath.split("/")[-1]
                                $Name = "$FQDN/$ObjName"
                                $IsDomain = $True
                            }
                            else {
                                $ObjName = $AdsPath.split("/")[-1]
                                $Name = $AdsPath
                                $IsDomain = $False
                            }

                            $Member | Add-Member Noteproperty 'AccountName' $Name
                            $Member | Add-Member Noteproperty 'IsDomain' $IsDomain
                            $Member | Add-Member Noteproperty 'IsGroup' $IsGroup

                            if($IsDomain) {
                                # translate the binary sid to a string
                                $Member | Add-Member Noteproperty 'SID' ((New-Object System.Security.Principal.SecurityIdentifier($_.GetType().InvokeMember('ObjectSID', 'GetProperty', $Null, $_, $Null),0)).Value)
                                $Member | Add-Member Noteproperty 'Description' ""
                                $Member | Add-Member Noteproperty 'Disabled' ""

                                if($IsGroup) {
                                    $Member | Add-Member Noteproperty 'LastLogin' ""
                                }
                                else {
                                    try {
                                        $Member | Add-Member Noteproperty 'LastLogin' ( $_.GetType().InvokeMember('LastLogin', 'GetProperty', $Null, $_, $Null))
                                    }
                                    catch {
                                        $Member | Add-Member Noteproperty 'LastLogin' ""
                                    }
                                }
                                $Member | Add-Member Noteproperty 'PwdLastSet' ""
                                $Member | Add-Member Noteproperty 'PwdExpired' ""
                                $Member | Add-Member Noteproperty 'UserFlags' ""
                            }
                            else {
                                # repull this user object so we can ensure correct information
                                $LocalUser = $([ADSI] "WinNT://$AdsPath")

                                # translate the binary sid to a string
                                $Member | Add-Member Noteproperty 'SID' ((New-Object System.Security.Principal.SecurityIdentifier($LocalUser.objectSid.value,0)).Value)
                                $Member | Add-Member Noteproperty 'Description' ($LocalUser.Description[0])

                                if($IsGroup) {
                                    $Member | Add-Member Noteproperty 'PwdLastSet' ""
                                    $Member | Add-Member Noteproperty 'PwdExpired' ""
                                    $Member | Add-Member Noteproperty 'UserFlags' ""
                                    $Member | Add-Member Noteproperty 'Disabled' ""
                                    $Member | Add-Member Noteproperty 'LastLogin' ""
                                }
                                else {
                                    $Member | Add-Member Noteproperty 'PwdLastSet' ( (Get-Date).AddSeconds(-$LocalUser.PasswordAge[0]))
                                    $Member | Add-Member Noteproperty 'PwdExpired' ( $LocalUser.PasswordExpired[0] -eq '1')
                                    $Member | Add-Member Noteproperty 'UserFlags' ( $LocalUser.UserFlags[0] )
                                    # UAC flags of 0x2 mean the account is disabled
                                    $Member | Add-Member Noteproperty 'Disabled' $(($LocalUser.userFlags.value -band 2) -eq 2)
                                    try {
                                        $Member | Add-Member Noteproperty 'LastLogin' ( $LocalUser.LastLogin[0])
                                    }
                                    catch {
                                        $Member | Add-Member Noteproperty 'LastLogin' ""
                                    }
                                }
                            }
                            $Member.PSObject.TypeNames.Add('PowerView.LocalUser')
                            $Member

                            # if the result is a group domain object and we're recursing,
                            #   try to resolve all the group member results
                            if($Recurse -and $IsGroup) {
                                if($IsDomain) {
                                  $FQDN = $Name.split("/")[0]
                                  $GroupName = $Name.split("/")[1].trim()

                                  Get-ThisThingGroupMember -GroupName $GroupName -Domain $FQDN -FullData -Recurse | ForEach-Object {

                                      $Member = New-Object PSObject
                                      $Member | Add-Member Noteproperty 'ComputerName' "$FQDN/$($_.GroupName)"

                                      $MemberDN = $_.distinguishedName
                                      # extract the FQDN from the Distinguished Name
                                      $MemberDomain = $MemberDN.subString($MemberDN.IndexOf("DC=")) -replace 'DC=','' -replace ',','.'

                                      $MemberIsGroup = @('268435456','268435457','536870912','536870913') -contains $_.samaccounttype

                                      if ($_.samAccountName) {
                                          # forest users have the samAccountName set
                                          $MemberName = $_.samAccountName
                                      }
                                      else {
                                          try {
                                              # external trust users have a SID, so convert it
                                              try {
                                                  $MemberName = Convert-SidToName $_.cn
                                              }
                                              catch {
                                                  # if there's a problem contacting the domain to resolve the SID
                                                  $MemberName = $_.cn
                                              }
                                          }
                                          catch {
                                              Write-Debug "Error resolving SID : $_"
                                          }
                                      }

                                      $Member | Add-Member Noteproperty 'AccountName' "$MemberDomain/$MemberName"
                                      $Member | Add-Member Noteproperty 'SID' $_.objectsid
                                      $Member | Add-Member Noteproperty 'Description' $_.description
                                      $Member | Add-Member Noteproperty 'Disabled' $False
                                      $Member | Add-Member Noteproperty 'IsGroup' $MemberIsGroup
                                      $Member | Add-Member Noteproperty 'IsDomain' $True
                                      $Member | Add-Member Noteproperty 'LastLogin' ''
                                      $Member | Add-Member Noteproperty 'PwdLastSet' $_.pwdLastSet
                                      $Member | Add-Member Noteproperty 'PwdExpired' ''
                                      $Member | Add-Member Noteproperty 'UserFlags' $_.userAccountControl
                                      $Member.PSObject.TypeNames.Add('PowerView.LocalUser')
                                      $Member
                                  }
                              } else {
                                Get-ThisThingLocalGroup -ComputerName $Server -GroupName $ObjName -Recurse
                              }
                            }
                        }
                    }
                }
                catch {
                    Write-Warning "[!] Error: $_"
                }
            }
        }
    }
}

filter Get-MySMBShare {


    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [Alias('HostName')]
        [Object[]]
        [ValidateNotNullOrEmpty()]
        $ComputerName = 'localhost'
    )

    # extract the computer name from whatever object was passed on the pipeline
    $Computer = $ComputerName | Get-NameField

    # arguments for NetShareEnum
    $QueryLevel = 1
    $PtrInfo = [IntPtr]::Zero
    $EntriesRead = 0
    $TotalRead = 0
    $ResumeHandle = 0

    # get the share information
    $Result = $Netapi32::NetShareEnum($Computer, $QueryLevel, [ref]$PtrInfo, -1, [ref]$EntriesRead, [ref]$TotalRead, [ref]$ResumeHandle)

    # Locate the offset of the initial intPtr
    $Offset = $PtrInfo.ToInt64()

    # 0 = success
    if (($Result -eq 0) -and ($Offset -gt 0)) {

        # Work out how much to increment the pointer by finding out the size of the structure
        $Increment = $SHARE_INFO_1::GetSize()

        # parse all the result structures
        for ($i = 0; ($i -lt $EntriesRead); $i++) {
            # create a new int ptr at the given offset and cast the pointer as our result structure
            $NewIntPtr = New-Object System.Intptr -ArgumentList $Offset
            $Info = $NewIntPtr -as $SHARE_INFO_1

            # return all the sections of the structure
            $Shares = $Info | Select-Object *
            $Shares | Add-Member Noteproperty 'ComputerName' $Computer
            $Offset = $NewIntPtr.ToInt64()
            $Offset += $Increment
            
            # Get ip address of host
            $targethostname = $Shares.ComputerName
            $ComputerIpAddress = [System.Net.Dns]::GetHostAddresses("$targethostname") | select IPAddressToString -first 1 -ExpandProperty IPAddressToString
            
            $ShareObject = New-Object -TypeName PSObject
            $ShareObject | Add-Member NoteProperty "ComputerName" $Shares.ComputerName
            $ShareObject | Add-Member NoteProperty "IpAddress" $ComputerIpAddress
            $ShareObject | Add-Member NoteProperty "ShareName" $Shares.shi1_netname 
            $ShareObject | Add-Member NoteProperty "ShareDesc" $Shares.shi1_remark
            $ShareObject | Add-Member NoteProperty "Sharetype" $Shares.shi1_type

            $ComputerName = $Shares.ComputerName  
            $ShareName = $Shares.shi1_netname 
            $ShareType = $Shares.shi1_type
            $ShareDesc = $Shares.shi1_remark  

            # Check access
            try{
                $TargetPath = "\\$ComputerName\$ShareName"
                $Null = [IO.Directory]::GetFiles($TargetPath)                                   
                Write-Verbose "$Computer : ACCESSIBLE! - Share: \\$computerName\$ShareName  Desc: $ShareDesc Type:$ShareType"
                $ShareObject | Add-Member NoteProperty "ShareAccess" "Yes"    
                $ShareObject 
            }catch{
                Write-Verbose "$Computer : NOT ACCESSIBLE - Share: \\$computerName\$ShareName Desc: $ShareDesc Type:$ShareType"                
                $ShareObject | Add-Member NoteProperty "ShareAccess" "No" 
                $ShareObject
            }
        }

        # free up the result buffer
        $Null = $Netapi32::NetApiBufferFree($PtrInfo)
    }
    else {
        Write-Verbose "Error: $(([ComponentModel.Win32Exception] $Result).Message)"
    }
}

function Find-InterestingFile {
<#
    .SYNOPSIS

        This function recursively searches a given UNC path for files with
        specific keywords in the name (default of pass, sensitive, secret, admin,
        login and unattend*.xml). The output can be piped out to a csv with the
        -OutFile flag. By default, hidden files/folders are included in search results.

    .PARAMETER Path

        UNC/local path to recursively search.

    .PARAMETER Terms

        Terms to search for.

    .PARAMETER OfficeDocs

        Switch. Search for office documents (*.doc*, *.xls*, *.ppt*)

    .PARAMETER FreshEXEs

        Switch. Find .EXEs accessed within the last week.

    .PARAMETER LastAccessTime

        Only return files with a LastAccessTime greater than this date value.

    .PARAMETER LastWriteTime

        Only return files with a LastWriteTime greater than this date value.

    .PARAMETER CreationTime

        Only return files with a CreationTime greater than this date value.

    .PARAMETER ExcludeFolders

        Switch. Exclude folders from the search results.

    .PARAMETER ExcludeHidden

        Switch. Exclude hidden files and folders from the search results.

    .PARAMETER CheckWriteAccess

        Switch. Only returns files the current user has write access to.

    .PARAMETER OutFile

        Output results to a specified csv output file.

    .PARAMETER UsePSDrive

        Switch. Mount target remote path with temporary PSDrives.

    .OUTPUTS

        The full path, owner, lastaccess time, lastwrite time, and size for each found file.

    .EXAMPLE

        PS C:\> Find-InterestingFile -Path C:\Backup\
        
        Returns any files on the local path C:\Backup\ that have the default
        search term set in the title.

    .EXAMPLE

        PS C:\> Find-InterestingFile -Path \\WINDOWS7\Users\ -Terms salaries,email -OutFile out.csv
        
        Returns any files on the remote path \\WINDOWS7\Users\ that have 'salaries'
        or 'email' in the title, and writes the results out to a csv file
        named 'out.csv'

    .EXAMPLE

        PS C:\> Find-InterestingFile -Path \\WINDOWS7\Users\ -LastAccessTime (Get-Date).AddDays(-7)

        Returns any files on the remote path \\WINDOWS7\Users\ that have the default
        search term set in the title and were accessed within the last week.

    .LINK
        
        http://www.harmj0y.net/blog/redteaming/file-server-triage-on-red-team-engagements/
#>
    
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $Path = '.\',

        [Alias('Terms')]
        [String[]]
        $SearchTerms = @('pass', 'sensitive', 'admin', 'login', 'secret', 'unattend*.xml', '.vmdk', 'creds', 'credential', '.config'),

        [Switch]
        $OfficeDocs,

        [Switch]
        $FreshEXEs,

        [String]
        $LastAccessTime,

        [String]
        $LastWriteTime,

        [String]
        $CreationTime,

        [Switch]
        $ExcludeFolders,

        [Switch]
        $ExcludeHidden,

        [Switch]
        $CheckWriteAccess,

        [String]
        $OutFile,

        [Switch]
        $UsePSDrive
    )

    begin {

        $Path += if(!$Path.EndsWith('\')) {"\"}

        if ($Credential) {
            $UsePSDrive = $True
        }

        # append wildcards to the front and back of all search terms
        $SearchTerms = $SearchTerms | ForEach-Object { if($_ -notmatch '^\*.*\*$') {"*$($_)*"} else{$_} }

        # search just for office documents if specified
        if ($OfficeDocs) {
            $SearchTerms = @('*.doc', '*.docx', '*.xls', '*.xlsx', '*.ppt', '*.pptx')
        }

        # find .exe's accessed within the last 7 days
        if($FreshEXEs) {
            # get an access time limit of 7 days ago
            $LastAccessTime = (Get-Date).AddDays(-7).ToString('MM/dd/yyyy')
            $SearchTerms = '*.exe'
        }

        if($UsePSDrive) {
            # if we're PSDrives, create a temporary mount point

            $Parts = $Path.split('\')
            $FolderPath = $Parts[0..($Parts.length-2)] -join '\'
            $FilePath = $Parts[-1]

            $RandDrive = ("abcdefghijklmnopqrstuvwxyz".ToCharArray() | Get-Random -Count 7) -join ''
            
            Write-Verbose "Mounting path '$Path' using a temp PSDrive at $RandDrive"

            try {
                $Null = New-PSDrive -Name $RandDrive -PSProvider FileSystem -Root $FolderPath -ErrorAction Stop
            }
            catch {
                Write-Verbose "Error mounting path '$Path' : $_"
                return $Null
            }

            # so we can cd/dir the new drive
            $Path = "${RandDrive}:\${FilePath}"
        }
    }

    process {

        Write-Verbose "[*] Search path $Path"

        function Invoke-CheckWrite {
            # short helper to check is the current user can write to a file
            [CmdletBinding()]param([String]$Path)
            try {
                $Filetest = [IO.FILE]::OpenWrite($Path)
                $Filetest.Close()
                $True
            }
            catch {
                Write-Verbose -Message $Error[0]
                $False
            }
        }

        $SearchArgs =  @{
            'Path' = $Path
            'Recurse' = $True
            'Force' = $(-not $ExcludeHidden)
            'Include' = $SearchTerms
            'ErrorAction' = 'SilentlyContinue'
        }

        Get-ChildItem @SearchArgs | ForEach-Object {
            Write-Verbose $_
            # check if we're excluding folders
            if(!$ExcludeFolders -or !$_.PSIsContainer) {$_}
        } | ForEach-Object {
            if($LastAccessTime -or $LastWriteTime -or $CreationTime) {
                if($LastAccessTime -and ($_.LastAccessTime -gt $LastAccessTime)) {$_}
                elseif($LastWriteTime -and ($_.LastWriteTime -gt $LastWriteTime)) {$_}
                elseif($CreationTime -and ($_.CreationTime -gt $CreationTime)) {$_}
            }
            else {$_}
        } | ForEach-Object {
            # filter for write access (if applicable)
            if((-not $CheckWriteAccess) -or (Invoke-CheckWrite -Path $_.FullName)) {$_}
        } | Select-Object FullName,@{Name='Owner';Expression={(Get-Acl $_.FullName).Owner}},LastAccessTime,LastWriteTime,CreationTime,Length | ForEach-Object {
            # check if we're outputting to the pipeline or an output file
            if($OutFile) {Export-PowerViewCSV -InputObject $_ -OutFile $OutFile}
            else {$_}
        }
    }

    end {
        if($UsePSDrive -and $RandDrive) {
            Write-Verbose "Removing temp PSDrive $RandDrive"
            Get-PSDrive -Name $RandDrive -ErrorAction SilentlyContinue | Remove-PSDrive -Force
        }
    }
}


function Invoke-ThreadedFunction {
    # Helper used by any threaded host enumeration functions
    [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$True)]
        [String[]]
        $ComputerName,

        [Parameter(Position=1,Mandatory=$True)]
        [System.Management.Automation.ScriptBlock]
        $ScriptBlock,

        [Parameter(Position=2)]
        [Hashtable]
        $ScriptParameters,

        [Int]
        [ValidateRange(1,100)] 
        $Threads = 20,

        [Switch]
        $NoImports
    )

    begin {

        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }

        Write-Verbose "[*] Total number of hosts: $($ComputerName.count)"

        # Adapted from:
        #   http://powershell.org/wp/forums/topic/invpke-parallel-need-help-to-clone-the-current-runspace/
        $SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
        $SessionState.ApartmentState = [System.Threading.Thread]::CurrentThread.GetApartmentState()

        # import the current session state's variables and functions so the chained PowerView
        #   functionality can be used by the threaded blocks
        if(!$NoImports) {

            # grab all the current variables for this runspace
            $MyVars = Get-Variable -Scope 2

            # these Variables are added by Runspace.Open() Method and produce Stop errors if you add them twice
            $VorbiddenVars = @("?","args","ConsoleFileName","Error","ExecutionContext","false","HOME","Host","input","InputObject","MaximumAliasCount","MaximumDriveCount","MaximumErrorCount","MaximumFunctionCount","MaximumHistoryCount","MaximumVariableCount","MyInvocation","null","PID","PSBoundParameters","PSCommandPath","PSCulture","PSDefaultParameterValues","PSHOME","PSScriptRoot","PSUICulture","PSVersionTable","PWD","ShellId","SynchronizedHash","true")

            # Add Variables from Parent Scope (current runspace) into the InitialSessionState
            ForEach($Var in $MyVars) {
                if($VorbiddenVars -NotContains $Var.Name) {
                $SessionState.Variables.Add((New-Object -TypeName System.Management.Automation.Runspaces.SessionStateVariableEntry -ArgumentList $Var.name,$Var.Value,$Var.description,$Var.options,$Var.attributes))
                }
            }

            # Add Functions from current runspace to the InitialSessionState
            ForEach($Function in (Get-ChildItem Function:)) {
                $SessionState.Commands.Add((New-Object -TypeName System.Management.Automation.Runspaces.SessionStateFunctionEntry -ArgumentList $Function.Name, $Function.Definition))
            }
        }

        # threading adapted from
        # https://github.com/darkoperator/Posh-SecMod/blob/master/Discovery/Discovery.psm1#L407
        #   Thanks Carlos!

        # create a pool of maxThread runspaces
        $Pool = [runspacefactory]::CreateRunspacePool(1, $Threads, $SessionState, $Host)
        $Pool.Open()

        $method = $null
        ForEach ($m in [PowerShell].GetMethods() | Where-Object { $_.Name -eq "BeginInvoke" }) {
            $methodParameters = $m.GetParameters()
            if (($methodParameters.Count -eq 2) -and $methodParameters[0].Name -eq "input" -and $methodParameters[1].Name -eq "output") {
                $method = $m.MakeGenericMethod([Object], [Object])
                break
            }
        }

        $Jobs = @()
    }

    process {

        ForEach ($Computer in $ComputerName) {

            # make sure we get a server name
            if ($Computer -ne '') {
                # Write-Verbose "[*] Enumerating server $Computer ($($Counter+1) of $($ComputerName.count))"

                While ($($Pool.GetAvailableRunspaces()) -le 0) {
                    Start-Sleep -MilliSeconds 500
                }

                # create a "powershell pipeline runner"
                $p = [powershell]::create()

                $p.runspacepool = $Pool

                # add the script block + arguments
                $Null = $p.AddScript($ScriptBlock).AddParameter('ComputerName', $Computer)
                if($ScriptParameters) {
                    ForEach ($Param in $ScriptParameters.GetEnumerator()) {
                        $Null = $p.AddParameter($Param.Name, $Param.Value)
                    }
                }

                $o = New-Object Management.Automation.PSDataCollection[Object]

                $Jobs += @{
                    PS = $p
                    Output = $o
                    Result = $method.Invoke($p, @($null, [Management.Automation.PSDataCollection[Object]]$o))
                }
            }
        }
    }

    end {
        Write-Verbose "Waiting for threads to finish..."

        Do {
            ForEach ($Job in $Jobs) {
                $Job.Output.ReadAll()
            }
        } While (($Jobs | Where-Object { ! $_.Result.IsCompleted }).Count -gt 0)

        ForEach ($Job in $Jobs) {
            $Job.PS.Dispose()
        }

        $Pool.Dispose()
        Write-Verbose "All threads completed!"
    }
}



function Invoke-ShareFinder {

    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,

        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,

        [String]
        $ComputerFilter,

        [String]
        $ComputerADSpath,

        [Switch]
        $ExcludeStandard,

        [Switch]
        $ExcludePrint,

        [Switch]
        $ExcludeIPC,

        [Switch]
        $NoPing,

        [Switch]
        $CheckShareAccess,

        [Switch]
        $CheckAdmin,

        [UInt32]
        $Delay = 0,

        [Double]
        $Jitter = .3,

        [String]
        $Domain,

        [String]
        $DomainController,
 
        [Switch]
        $SearchForest,

        [ValidateRange(1,100)] 
        [Int]
        $Threads
    )

    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }

        # random object for delay
        $RandNo = New-Object System.Random

        Write-Verbose "[*] Running Invoke-ShareFinder with delay of $Delay"

        # figure out the shares we want to ignore
        [String[]] $ExcludedShares = @('')

        if ($ExcludePrint) {
            $ExcludedShares = $ExcludedShares + "PRINT$"
        }
        if ($ExcludeIPC) {
            $ExcludedShares = $ExcludedShares + "IPC$"
        }
        if ($ExcludeStandard) {
            $ExcludedShares = @('', "ADMIN$", "IPC$", "C$", "PRINT$")
        }

        # if we're using a host file list, read the targets in and add them to the target list
        if($ComputerFile) {
            $ComputerName = Get-Content -Path $ComputerFile
        }

        if(!$ComputerName) { 
            [array]$ComputerName = @()

            if($Domain) {
                $TargetDomains = @($Domain)
            }
            elseif($SearchForest) {
                # get ALL the domains in the forest to search
                $TargetDomains = Get-ThisThingForestDomain | ForEach-Object { $_.Name }
            }
            else {
                # use the local domain
                $TargetDomains = @( (Get-ThisThingDomain).name )
            }
                
            ForEach ($Domain in $TargetDomains) {
                Write-Verbose "[*] Querying domain $Domain for hosts"
                $ComputerName += Get-ThisThingComputer -Domain $Domain -DomainController $DomainController -Filter $ComputerFilter -ADSpath $ComputerADSpath
            }
        
            # remove any null target hosts, uniquify the list and shuffle it
            $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
            if($($ComputerName.count) -eq 0) {
                throw "No hosts found!"
            }
        }

        # script block that enumerates a server
        $HostEnumBlock = {
            param($ComputerName, $Ping, $CheckShareAccess, $ExcludedShares, $CheckAdmin)

            # optionally check if the server is up first
            $Up = $True
            if($Ping) {
                $Up = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
            }
            if($Up) {
                # get the shares for this host and check what we find
                $Shares = Get-MySMBShare -ComputerName $ComputerName
                ForEach ($Share in $Shares) {
                    Write-Verbose "[*] Server share: $Share"
                    $NetName = $Share.shi1_netname
                    $Remark = $Share.shi1_remark
                    $Path = '\\'+$ComputerName+'\'+$NetName

                    # make sure we get a real share name back
                    if (($NetName) -and ($NetName.trim() -ne '')) {
                        # if we're just checking for access to ADMIN$
                        if($CheckAdmin) {
                            if($NetName.ToUpper() -eq "ADMIN$") {
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    "\\$ComputerName\$NetName `t- $Remark"
                                }
                                catch {
                                    Write-Verbose "Error accessing path $Path : $_"
                                }
                            }
                        }
                        # skip this share if it's in the exclude list
                        elseif ($ExcludedShares -NotContains $NetName.ToUpper()) {
                            # see if we want to check access to this share
                            if($CheckShareAccess) {
                                # check if the user has access to this path
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    "\\$ComputerName\$NetName `t- $Remark"
                                }
                                catch {
                                    Write-Verbose "Error accessing path $Path : $_"
                                }
                            }
                            else {
                                "\\$ComputerName\$NetName `t- $Remark"
                            }
                        }
                    }
                }
            }
        }

    }

    process {

        if($Threads) {
            Write-Verbose "Using threading with threads = $Threads"

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $ScriptParams = @{
                'Ping' = $(-not $NoPing)
                'CheckShareAccess' = $CheckShareAccess
                'ExcludedShares' = $ExcludedShares
                'CheckAdmin' = $CheckAdmin
            }

            # kick off the threaded script block + arguments 
            Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $HostEnumBlock -ScriptParameters $ScriptParams -Threads $Threads
        }

        else {
            if(-not $NoPing -and ($ComputerName.count -ne 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose "[*] Total number of active hosts: $($ComputerName.count)"
            $Counter = 0

            ForEach ($Computer in $ComputerName) {

                $Counter = $Counter + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $RandNo.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose "[*] Enumerating server $Computer ($Counter of $($ComputerName.count))"
                Invoke-Command -ScriptBlock $HostEnumBlock -ArgumentList $Computer, $False, $CheckShareAccess, $ExcludedShares, $CheckAdmin
            }
        }
        
    }
}


function Invoke-FileFinder {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [Alias('Hosts')]
        [String[]]
        $ComputerName,

        [ValidateScript({Test-Path -Path $_ })]
        [Alias('HostList')]
        [String]
        $ComputerFile,

        [String]
        $ComputerFilter,

        [String]
        $ComputerADSpath,

        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $ShareList,

        [Switch]
        $OfficeDocs,

        [Switch]
        $FreshEXEs,

        [Alias('Terms')]
        [String[]]
        $SearchTerms, 

        [ValidateScript({Test-Path -Path $_ })]
        [String]
        $TermList,

        [String]
        $LastAccessTime,

        [String]
        $LastWriteTime,

        [String]
        $CreationTime,

        [Switch]
        $IncludeC,

        [Switch]
        $IncludeAdmin,

        [Switch]
        $ExcludeFolders,

        [Switch]
        $ExcludeHidden,

        [Switch]
        $CheckWriteAccess,

        [String]
        $OutFile,

        [Switch]
        $NoClobber,

        [Switch]
        $NoPing,

        [UInt32]
        $Delay = 0,

        [Double]
        $Jitter = .3,

        [String]
        $Domain,

        [String]
        $DomainController,
        
        [Switch]
        $SearchForest,

        [Switch]
        $SearchSYSVOL,

        [ValidateRange(1,100)] 
        [Int]
        $Threads,

        [Switch]
        $UsePSDrive
    )

    begin {
        if ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }

        # random object for delay
        $RandNo = New-Object System.Random

        Write-Verbose "[*] Running Invoke-FileFinder with delay of $Delay"

        $Shares = @()

        # figure out the shares we want to ignore
        [String[]] $ExcludedShares = @("C$", "ADMIN$")

        # see if we're specifically including any of the normally excluded sets
        if ($IncludeC) {
            if ($IncludeAdmin) {
                $ExcludedShares = @()
            }
            else {
                $ExcludedShares = @("ADMIN$")
            }
        }

        if ($IncludeAdmin) {
            if ($IncludeC) {
                $ExcludedShares = @()
            }
            else {
                $ExcludedShares = @("C$")
            }
        }

        # delete any existing output file if it already exists
        if(!$NoClobber) {
            if ($OutFile -and (Test-Path -Path $OutFile)) { Remove-Item -Path $OutFile }
        }

        # if there's a set of terms specified to search for
        if ($TermList) {
            ForEach ($Term in Get-Content -Path $TermList) {
                if (($Term -ne $Null) -and ($Term.trim() -ne '')) {
                    $SearchTerms += $Term
                }
            }
        }

        # if we're hard-passed a set of shares
        if($ShareList) {
            ForEach ($Item in Get-Content -Path $ShareList) {
                if (($Item -ne $Null) -and ($Item.trim() -ne '')) {
                    # exclude any "[tab]- commants", i.e. the output from Invoke-ShareFinder
                    $Share = $Item.Split("`t")[0]
                    $Shares += $Share
                }
            }
        }
        else {
            # if we're using a host file list, read the targets in and add them to the target list
            if($ComputerFile) {
                $ComputerName = Get-Content -Path $ComputerFile
            }

            if(!$ComputerName) {

                if($Domain) {
                    $TargetDomains = @($Domain)
                }
                elseif($SearchForest) {
                    # get ALL the domains in the forest to search
                    $TargetDomains = Get-ThisThingForestDomain | ForEach-Object { $_.Name }
                }
                else {
                    # use the local domain
                    $TargetDomains = @( (Get-ThisThingDomain).name )
                }

                if($SearchSYSVOL) {
                    ForEach ($Domain in $TargetDomains) {
                        $DCSearchPath = "\\$Domain\SYSVOL\"
                        Write-Verbose "[*] Adding share search path $DCSearchPath"
                        $Shares += $DCSearchPath
                    }
                    if(!$SearchTerms) {
                        # search for interesting scripts on SYSVOL
                        $SearchTerms = @('.vbs', '.bat', '.ps1')
                    }
                }
                else {
                    [array]$ComputerName = @()

                    ForEach ($Domain in $TargetDomains) {
                        Write-Verbose "[*] Querying domain $Domain for hosts"
                        $ComputerName += Get-ThisThingComputer -Filter $ComputerFilter -ADSpath $ComputerADSpath -Domain $Domain -DomainController $DomainController
                    }

                    # remove any null target hosts, uniquify the list and shuffle it
                    $ComputerName = $ComputerName | Where-Object { $_ } | Sort-Object -Unique | Sort-Object { Get-Random }
                    if($($ComputerName.Count) -eq 0) {
                        throw "No hosts found!"
                    }
                }
            }
        }

        # script block that enumerates shares and files on a server
        $HostEnumBlock = {
            param($ComputerName, $Ping, $ExcludedShares, $SearchTerms, $ExcludeFolders, $OfficeDocs, $ExcludeHidden, $FreshEXEs, $CheckWriteAccess, $OutFile, $UsePSDrive)

            Write-Verbose "ComputerName: $ComputerName"
            Write-Verbose "ExcludedShares: $ExcludedShares"
            $SearchShares = @()

            if($ComputerName.StartsWith("\\")) {
                # if a share is passed as the server
                $SearchShares += $ComputerName
            }
            else {
                # if we're enumerating the shares on the target server first
                $Up = $True
                if($Ping) {
                    $Up = Test-Connection -Count 1 -Quiet -ComputerName $ComputerName
                }
                if($Up) {
                    # get the shares for this host and display what we find
                    $Shares = Get-MySMBShare -ComputerName $ComputerName
                    ForEach ($Share in $Shares) {

                        $NetName = $Share.shi1_netname
                        $Path = '\\'+$ComputerName+'\'+$NetName

                        # make sure we get a real share name back
                        if (($NetName) -and ($NetName.trim() -ne '')) {

                            # skip this share if it's in the exclude list
                            if ($ExcludedShares -NotContains $NetName.ToUpper()) {
                                # check if the user has access to this path
                                try {
                                    $Null = [IO.Directory]::GetFiles($Path)
                                    $SearchShares += $Path
                                }
                                catch {
                                    Write-Verbose "[!] No access to $Path"
                                }
                            }
                        }
                    }
                }
            }

            ForEach($Share in $SearchShares) {
                $SearchArgs =  @{
                    'Path' = $Share
                    'SearchTerms' = $SearchTerms
                    'OfficeDocs' = $OfficeDocs
                    'FreshEXEs' = $FreshEXEs
                    'LastAccessTime' = $LastAccessTime
                    'LastWriteTime' = $LastWriteTime
                    'CreationTime' = $CreationTime
                    'ExcludeFolders' = $ExcludeFolders
                    'ExcludeHidden' = $ExcludeHidden
                    'CheckWriteAccess' = $CheckWriteAccess
                    'OutFile' = $OutFile
                    'UsePSDrive' = $UsePSDrive
                }

                Find-InterestingFile @SearchArgs
            }
        }
    }

    process {

        if($Threads) {
            Write-Verbose "Using threading with threads = $Threads"

            # if we're using threading, kick off the script block with Invoke-ThreadedFunction
            $ScriptParams = @{
                'Ping' = $(-not $NoPing)
                'ExcludedShares' = $ExcludedShares
                'SearchTerms' = $SearchTerms
                'ExcludeFolders' = $ExcludeFolders
                'OfficeDocs' = $OfficeDocs
                'ExcludeHidden' = $ExcludeHidden
                'FreshEXEs' = $FreshEXEs
                'CheckWriteAccess' = $CheckWriteAccess
                'OutFile' = $OutFile
                'UsePSDrive' = $UsePSDrive
            }

            # kick off the threaded script block + arguments 
            if($Shares) {
                # pass the shares as the hosts so the threaded function code doesn't have to be hacked up
                Invoke-ThreadedFunction -ComputerName $Shares -ScriptBlock $HostEnumBlock -ScriptParameters $ScriptParams -Threads $Threads
            }
            else {
                Invoke-ThreadedFunction -ComputerName $ComputerName -ScriptBlock $HostEnumBlock -ScriptParameters $ScriptParams -Threads $Threads
            }
        }

        else {
            if($Shares){
                $ComputerName = $Shares
            }
            elseif(-not $NoPing -and ($ComputerName.count -gt 1)) {
                # ping all hosts in parallel
                $Ping = {param($ComputerName) if(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop){$ComputerName}}
                $ComputerName = Invoke-ThreadedFunction -NoImports -ComputerName $ComputerName -ScriptBlock $Ping -Threads 100
            }

            Write-Verbose "[*] Total number of active hosts: $($ComputerName.count)"
            $Counter = 0

            $ComputerName | Where-Object {$_} | ForEach-Object {
                Write-Verbose "Computer: $_"
                $Counter = $Counter + 1

                # sleep for our semi-randomized interval
                Start-Sleep -Seconds $RandNo.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)

                Write-Verbose "[*] Enumerating server $_ ($Counter of $($ComputerName.count))"

                Invoke-Command -ScriptBlock $HostEnumBlock -ArgumentList $_, $False, $ExcludedShares, $SearchTerms, $ExcludeFolders, $OfficeDocs, $ExcludeHidden, $FreshEXEs, $CheckWriteAccess, $OutFile, $UsePSDrive                
            }
        }
    }
}


function Get-ThisThingDomainTrust {
    [CmdletBinding()]
    param(
        [Parameter(Position=0, ValueFromPipeline=$True)]
        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [Switch]
        $API,

        [Switch]
        $LDAP,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    begin {
        $TrustAttributes = @{
            [uint32]'0x00000001' = 'non_transitive'
            [uint32]'0x00000002' = 'uplevel_only'
            [uint32]'0x00000004' = 'quarantined_domain'
            [uint32]'0x00000008' = 'forest_transitive'
            [uint32]'0x00000010' = 'cross_organization'
            [uint32]'0x00000020' = 'within_forest'
            [uint32]'0x00000040' = 'treat_as_external'
            [uint32]'0x00000080' = 'trust_uses_rc4_encryption'
            [uint32]'0x00000100' = 'trust_uses_aes_keys'
            [uint32]'0x00000200' = 'cross_organization_no_tgt_delegation'
            [uint32]'0x00000400' = 'pim_trust'
        }
    }

    process {

        if(-not $Domain) {
            # if not domain is specified grab the current domain
            $SourceDomain = (Get-ThisThingDomain -Credential $Credential).Name
        }
        else {
            $SourceDomain = $Domain
        }

        if($LDAP -or $ADSPath) {

            $TrustSearcher = Get-DomainSearcher -Domain $SourceDomain -DomainController $DomainController -Credential $Credential -PageSize $PageSize -ADSpath $ADSpath

            $SourceSID = Get-DomainSID -Domain $SourceDomain -DomainController $DomainController

            if($TrustSearcher) {

                $TrustSearcher.Filter = '(objectClass=trustedDomain)'

                $Results = $TrustSearcher.FindAll()
                $Results | Where-Object {$_} | ForEach-Object {
                    $Props = $_.Properties
                    $DomainTrust = New-Object PSObject
                    
                    $TrustAttrib = @()
                    $TrustAttrib += $TrustAttributes.Keys | Where-Object { $Props.trustattributes[0] -band $_ } | ForEach-Object { $TrustAttributes[$_] }

                    $Direction = Switch ($Props.trustdirection) {
                        0 { 'Disabled' }
                        1 { 'Inbound' }
                        2 { 'Outbound' }
                        3 { 'Bidirectional' }
                    }
                    $ObjectGuid = New-Object Guid @(,$Props.objectguid[0])
                    $TargetSID = (New-Object System.Security.Principal.SecurityIdentifier($Props.securityidentifier[0],0)).Value
                    $DomainTrust | Add-Member Noteproperty 'SourceName' $SourceDomain
                    $DomainTrust | Add-Member Noteproperty 'SourceSID' $SourceSID
                    $DomainTrust | Add-Member Noteproperty 'TargetName' $Props.name[0]
                    $DomainTrust | Add-Member Noteproperty 'TargetSID' $TargetSID
                    $DomainTrust | Add-Member Noteproperty 'ObjectGuid' "{$ObjectGuid}"
                    $DomainTrust | Add-Member Noteproperty 'TrustType' $($TrustAttrib -join ',')
                    $DomainTrust | Add-Member Noteproperty 'TrustDirection' "$Direction"
                    $DomainTrust.PSObject.TypeNames.Add('PowerView.DomainTrustLDAP')
                    $DomainTrust
                }
                $Results.dispose()
                $TrustSearcher.dispose()
            }
        }
        elseif($API) {
            if(-not $DomainController) {
                $DomainController = Get-ThisThingDomainController -Credential $Credential -Domain $SourceDomain | Select-Object -First 1 | Select-Object -ExpandProperty Name
            }

            if($DomainController) {
                # arguments for DsEnumerateDomainTrusts
                $PtrInfo = [IntPtr]::Zero

                # 63 = DS_DOMAIN_IN_FOREST + DS_DOMAIN_DIRECT_OUTBOUND + DS_DOMAIN_TREE_ROOT + DS_DOMAIN_PRIMARY + DS_DOMAIN_NATIVE_MODE + DS_DOMAIN_DIRECT_INBOUND
                $Flags = 63
                $DomainCount = 0

                # get the trust information from the target server
                $Result = $Netapi32::DsEnumerateDomainTrusts($DomainController, $Flags, [ref]$PtrInfo, [ref]$DomainCount)

                # Locate the offset of the initial intPtr
                $Offset = $PtrInfo.ToInt64()

                # 0 = success
                if (($Result -eq 0) -and ($Offset -gt 0)) {

                    # Work out how much to increment the pointer by finding out the size of the structure
                    $Increment = $DS_DOMAIN_TRUSTS::GetSize()

                    # parse all the result structures
                    for ($i = 0; ($i -lt $DomainCount); $i++) {
                        # create a new int ptr at the given offset and cast the pointer as our result structure
                        $NewIntPtr = New-Object System.Intptr -ArgumentList $Offset
                        $Info = $NewIntPtr -as $DS_DOMAIN_TRUSTS

                        $Offset = $NewIntPtr.ToInt64()
                        $Offset += $Increment

                        $SidString = ""
                        $Result = $Advapi32::ConvertSidToStringSid($Info.DomainSid, [ref]$SidString);$LastError = [Runtime.InteropServices.Marshal]::GetLastWin32Error()

                        if($Result -eq 0) {
                            Write-Verbose "Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
                        }
                        else {
                            $DomainTrust = New-Object PSObject
                            $DomainTrust | Add-Member Noteproperty 'SourceDomain' $SourceDomain
                            $DomainTrust | Add-Member Noteproperty 'SourceDomainController' $DomainController
                            $DomainTrust | Add-Member Noteproperty 'NetbiosDomainName' $Info.NetbiosDomainName
                            $DomainTrust | Add-Member Noteproperty 'DnsDomainName' $Info.DnsDomainName
                            $DomainTrust | Add-Member Noteproperty 'Flags' $Info.Flags
                            $DomainTrust | Add-Member Noteproperty 'ParentIndex' $Info.ParentIndex
                            $DomainTrust | Add-Member Noteproperty 'TrustType' $Info.TrustType
                            $DomainTrust | Add-Member Noteproperty 'TrustAttributes' $Info.TrustAttributes
                            $DomainTrust | Add-Member Noteproperty 'DomainSid' $SidString
                            $DomainTrust | Add-Member Noteproperty 'DomainGuid' $Info.DomainGuid
                            $DomainTrust.PSObject.TypeNames.Add('PowerView.APIDomainTrust')
                            $DomainTrust
                        }
                    }
                    # free up the result buffer
                    $Null = $Netapi32::NetApiBufferFree($PtrInfo)
                }
                else {
                    Write-Verbose "Error: $(([ComponentModel.Win32Exception] $Result).Message)"
                }
            }
            else {
                Write-Verbose "Could not retrieve domain controller for $Domain"
            }
        }
        else {
            # if we're using direct domain connections through .NET
            $FoundDomain = Get-ThisThingDomain -Domain $Domain -Credential $Credential
            if($FoundDomain) {
                $FoundDomain.GetAllTrustRelationships() | ForEach-Object {
                    $_.PSObject.TypeNames.Add('PowerView.DomainTrust')
                    $_
                }
            }
        }
    }
}


function Get-ThisThingForestTrust {
    [CmdletBinding()]
    param(
        [Parameter(Position=0,ValueFromPipeline=$True)]
        [String]
        $Forest,

        [Management.Automation.PSCredential]
        $Credential
    )

    process {
        $FoundForest = Get-ThisThingForest -Forest $Forest -Credential $Credential

        if($FoundForest) {
            $FoundForest.GetAllTrustRelationships() | ForEach-Object {
                $_.PSObject.TypeNames.Add('PowerView.ForestTrust')
                $_
            }
        }
    }
}


function Find-ForeignUser {
    [CmdletBinding()]
    param(
        [String]
        $UserName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [Switch]
        $LDAP,

        [Switch]
        $Recurse,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    function Get-ForeignUser {
        # helper used to enumerate users who are in groups outside of their principal domain
        param(
            [String]
            $UserName,

            [String]
            $Domain,

            [String]
            $DomainController,

            [ValidateRange(1,10000)] 
            [Int]
            $PageSize = 200
        )

        if ($Domain) {
            # get the domain name into distinguished form
            $DistinguishedDomainName = "DC=" + $Domain -replace '\.',',DC='
        }
        else {
            $DistinguishedDomainName = [String] ([adsi]'').distinguishedname
            $Domain = $DistinguishedDomainName -replace 'DC=','' -replace ',','.'
        }

        Get-ThisThingUser -Domain $Domain -DomainController $DomainController -UserName $UserName -PageSize $PageSize -Filter '(memberof=*)' | ForEach-Object {
            ForEach ($Membership in $_.memberof) {
                $Index = $Membership.IndexOf("DC=")
                if($Index) {
                    
                    $GroupDomain = $($Membership.substring($Index)) -replace 'DC=','' -replace ',','.'
                    
                    if ($GroupDomain.CompareTo($Domain)) {
                        # if the group domain doesn't match the user domain, output
                        $GroupName = $Membership.split(",")[0].split("=")[1]
                        $ForeignUser = New-Object PSObject
                        $ForeignUser | Add-Member Noteproperty 'UserDomain' $Domain
                        $ForeignUser | Add-Member Noteproperty 'UserName' $_.samaccountname
                        $ForeignUser | Add-Member Noteproperty 'GroupDomain' $GroupDomain
                        $ForeignUser | Add-Member Noteproperty 'GroupName' $GroupName
                        $ForeignUser | Add-Member Noteproperty 'GroupDN' $Membership
                        $ForeignUser
                    }
                }
            }
        }
    }

    if ($Recurse) {
        # get all rechable domains in the trust mesh and uniquify them
        if($LDAP -or $DomainController) {
            $DomainTrusts = Invoke-MapDomainTrust -LDAP -DomainController $DomainController -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }
        else {
            $DomainTrusts = Invoke-MapDomainTrust -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }

        ForEach($DomainTrust in $DomainTrusts) {
            # get the trust groups for each domain in the trust mesh
            Write-Verbose "Enumerating trust groups in domain $DomainTrust"
            Get-ForeignUser -Domain $DomainTrust -UserName $UserName -PageSize $PageSize
        }
    }
    else {
        Get-ForeignUser -Domain $Domain -DomainController $DomainController -UserName $UserName -PageSize $PageSize
    }
}


function Find-ForeignGroup {

    [CmdletBinding()]
    param(
        [String]
        $GroupName = '*',

        [String]
        $Domain,

        [String]
        $DomainController,

        [Switch]
        $LDAP,

        [Switch]
        $Recurse,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    function Get-ForeignGroup {
        param(
            [String]
            $GroupName = '*',

            [String]
            $Domain,

            [String]
            $DomainController,

            [ValidateRange(1,10000)] 
            [Int]
            $PageSize = 200
        )

        if(-not $Domain) {
            $Domain = (Get-ThisThingDomain).Name
        }

        $DomainDN = "DC=$($Domain.Replace('.', ',DC='))"
        Write-Verbose "DomainDN: $DomainDN"

        # standard group names to ignore
        $ExcludeGroups = @("Users", "Domain Users", "Guests")

        # get all the groupnames for the given domain
        Get-ThisThingGroup -GroupName $GroupName -Filter '(member=*)' -Domain $Domain -DomainController $DomainController -FullData -PageSize $PageSize | Where-Object {
            # exclude common large groups
            -not ($ExcludeGroups -contains $_.samaccountname) } | ForEach-Object {
                
                $GroupName = $_.samAccountName

                $_.member | ForEach-Object {
                    # filter for foreign SIDs in the cn field for users in another domain,
                    #   or if the DN doesn't end with the proper DN for the queried domain  
                    if (($_ -match 'CN=S-1-5-21.*-.*') -or ($DomainDN -ne ($_.substring($_.IndexOf("DC="))))) {

                        $UserDomain = $_.subString($_.IndexOf("DC=")) -replace 'DC=','' -replace ',','.'
                        $UserName = $_.split(",")[0].split("=")[1]

                        $ForeignGroupUser = New-Object PSObject
                        $ForeignGroupUser | Add-Member Noteproperty 'GroupDomain' $Domain
                        $ForeignGroupUser | Add-Member Noteproperty 'GroupName' $GroupName
                        $ForeignGroupUser | Add-Member Noteproperty 'UserDomain' $UserDomain
                        $ForeignGroupUser | Add-Member Noteproperty 'UserName' $UserName
                        $ForeignGroupUser | Add-Member Noteproperty 'UserDN' $_
                        $ForeignGroupUser
                    }
                }
        }
    }

    if ($Recurse) {
        # get all rechable domains in the trust mesh and uniquify them
        if($LDAP -or $DomainController) {
            $DomainTrusts = Invoke-MapDomainTrust -LDAP -DomainController $DomainController -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }
        else {
            $DomainTrusts = Invoke-MapDomainTrust -PageSize $PageSize | ForEach-Object { $_.SourceDomain } | Sort-Object -Unique
        }

        ForEach($DomainTrust in $DomainTrusts) {
            # get the trust groups for each domain in the trust mesh
            Write-Verbose "Enumerating trust groups in domain $DomainTrust"
            Get-ForeignGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -PageSize $PageSize
        }
    }
    else {
        Get-ForeignGroup -GroupName $GroupName -Domain $Domain -DomainController $DomainController -PageSize $PageSize
    }
}


function Find-ManagedSecurityGroups {

    # Go through the list of security groups on the domain and identify those who have a manager
    Get-ThisThingGroup -FullData -Filter '(managedBy=*)' | Select-Object -Unique distinguishedName,managedBy,cn | ForEach-Object {

        # Retrieve the object that the managedBy DN refers to
        $group_manager = Get-ADObject -ADSPath $_.managedBy | Select-Object cn,distinguishedname,name,samaccounttype,samaccountname

        # Create a results object to store our findings
        $results_object = New-Object -TypeName PSObject -Property @{
            'GroupCN' = $_.cn
            'GroupDN' = $_.distinguishedname
            'ManagerCN' = $group_manager.cn
            'ManagerDN' = $group_manager.distinguishedName
            'ManagerSAN' = $group_manager.samaccountname
            'ManagerType' = ''
            'CanManagerWrite' = $FALSE
        }

        # Determine whether the manager is a user or a group
        if ($group_manager.samaccounttype -eq 0x10000000) {
            $results_object.ManagerType = 'Group'
        } elseif ($group_manager.samaccounttype -eq 0x30000000) {
            $results_object.ManagerType = 'User'
        }

        # Find the ACLs that relate to the ability to write to the group
        $xacl = Get-ObjectAcl -ADSPath $_.distinguishedname -Rights WriteMembers

        # Double-check that the manager
        if ($xacl.ObjectType -eq 'bf9679c0-0de6-11d0-a285-00aa003049e2' -and $xacl.AccessControlType -eq 'Allow' -and $xacl.IdentityReference.Value.Contains($group_manager.samaccountname)) {
            $results_object.CanManagerWrite = $TRUE
        }
        $results_object
    }
}


function Invoke-MapDomainTrust {
    [CmdletBinding()]
    param(
        [Switch]
        $LDAP,

        [String]
        $DomainController,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200,

        [Management.Automation.PSCredential]
        $Credential
    )

    # keep track of domains seen so we don't hit infinite recursion
    $SeenDomains = @{}

    # our domain status tracker
    $Domains = New-Object System.Collections.Stack

    # get the current domain and push it onto the stack
    $CurrentDomain = (Get-ThisThingDomain -Credential $Credential).Name
    $Domains.push($CurrentDomain)

    while($Domains.Count -ne 0) {

        $Domain = $Domains.Pop()

        # if we haven't seen this domain before
        if ($Domain -and ($Domain.Trim() -ne "") -and (-not $SeenDomains.ContainsKey($Domain))) {
            
            Write-Verbose "Enumerating trusts for domain '$Domain'"

            # mark it as seen in our list
            $Null = $SeenDomains.add($Domain, "")

            try {
                # get all the trusts for this domain
                if($LDAP -or $DomainController) {
                    $Trusts = Get-ThisThingDomainTrust -Domain $Domain -LDAP -DomainController $DomainController -PageSize $PageSize -Credential $Credential
                }
                else {
                    $Trusts = Get-ThisThingDomainTrust -Domain $Domain -PageSize $PageSize -Credential $Credential
                }

                if($Trusts -isnot [System.Array]) {
                    $Trusts = @($Trusts)
                }

                # get any forest trusts, if they exist
                if(-not ($LDAP -or $DomainController) ) {
                    $Trusts += Get-ThisThingForestTrust -Forest $Domain -Credential $Credential
                }

                if ($Trusts) {
                    if($Trusts -isnot [System.Array]) {
                        $Trusts = @($Trusts)
                    }

                    # enumerate each trust found
                    ForEach ($Trust in $Trusts) {
                        if($Trust.SourceName -and $Trust.TargetName) {
                            $SourceDomain = $Trust.SourceName
                            $TargetDomain = $Trust.TargetName
                            $TrustType = $Trust.TrustType
                            $TrustDirection = $Trust.TrustDirection
                            $ObjectType = $Trust.PSObject.TypeNames | Where-Object {$_ -match 'PowerView'} | Select-Object -First 1

                            # make sure we process the target
                            $Null = $Domains.Push($TargetDomain)

                            # build the nicely-parsable custom output object
                            $DomainTrust = New-Object PSObject
                            $DomainTrust | Add-Member Noteproperty 'SourceDomain' "$SourceDomain"
                            $DomainTrust | Add-Member Noteproperty 'SourceSID' $Trust.SourceSID
                            $DomainTrust | Add-Member Noteproperty 'TargetDomain' "$TargetDomain"
                            $DomainTrust | Add-Member Noteproperty 'TargetSID' $Trust.TargetSID
                            $DomainTrust | Add-Member Noteproperty 'TrustType' "$TrustType"
                            $DomainTrust | Add-Member Noteproperty 'TrustDirection' "$TrustDirection"
                            $DomainTrust.PSObject.TypeNames.Add($ObjectType)
                            $DomainTrust
                        }
                    }
                }
            }
            catch {
                Write-Verbose "[!] Error: $_"
            }
        }
    }
}

$Mod = New-InMemoryModule -ModuleName Win32

$FunctionDefinitions = @(
    (func netapi32 NetShareEnum ([Int]) @([String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (func netapi32 NetWkstaUserEnum ([Int]) @([String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (func netapi32 NetSessionEnum ([Int]) @([String], [String], [String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (func netapi32 NetLocalGroupGetMembers ([Int]) @([String], [String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (func netapi32 DsGetSiteName ([Int]) @([String], [IntPtr].MakeByRefType())),
    (func netapi32 DsEnumerateDomainTrusts ([Int]) @([String], [UInt32], [IntPtr].MakeByRefType(), [IntPtr].MakeByRefType())),
    (func netapi32 NetApiBufferFree ([Int]) @([IntPtr])),
    (func advapi32 ConvertSidToStringSid ([Int]) @([IntPtr], [String].MakeByRefType()) -SetLastError),
    (func advapi32 OpenSCManagerW ([IntPtr]) @([String], [String], [Int]) -SetLastError),
    (func advapi32 CloseServiceHandle ([Int]) @([IntPtr])),
    (func wtsapi32 WTSOpenServerEx ([IntPtr]) @([String])),
    (func wtsapi32 WTSEnumerateSessionsEx ([Int]) @([IntPtr], [Int32].MakeByRefType(), [Int], [IntPtr].MakeByRefType(), [Int32].MakeByRefType()) -SetLastError),
    (func wtsapi32 WTSQuerySessionInformation ([Int]) @([IntPtr], [Int], [Int], [IntPtr].MakeByRefType(), [Int32].MakeByRefType()) -SetLastError),
    (func wtsapi32 WTSFreeMemoryEx ([Int]) @([Int32], [IntPtr], [Int32])),
    (func wtsapi32 WTSFreeMemory ([Int]) @([IntPtr])),
    (func wtsapi32 WTSCloseServer ([Int]) @([IntPtr]))
)

# enum used by $WTS_SESSION_INFO_1 below
$WTSConnectState = psenum $Mod WTS_CONNECTSTATE_CLASS UInt16 @{
    Active       =    0
    Connected    =    1
    ConnectQuery =    2
    Shadow       =    3
    Disconnected =    4
    Idle         =    5
    Listen       =    6
    Reset        =    7
    Down         =    8
    Init         =    9
}

# the WTSEnumerateSessionsEx result structure
$WTS_SESSION_INFO_1 = struct $Mod WTS_SESSION_INFO_1 @{
    ExecEnvId = field 0 UInt32
    State = field 1 $WTSConnectState
    SessionId = field 2 UInt32
    pSessionName = field 3 String -MarshalAs @('LPWStr')
    pHostName = field 4 String -MarshalAs @('LPWStr')
    pUserName = field 5 String -MarshalAs @('LPWStr')
    pDomainName = field 6 String -MarshalAs @('LPWStr')
    pFarmName = field 7 String -MarshalAs @('LPWStr')
}

# the particular WTSQuerySessionInformation result structure
$WTS_CLIENT_ADDRESS = struct $mod WTS_CLIENT_ADDRESS @{
    AddressFamily = field 0 UInt32
    Address = field 1 Byte[] -MarshalAs @('ByValArray', 20)
}

# the NetShareEnum result structure
$SHARE_INFO_1 = struct $Mod SHARE_INFO_1 @{
    shi1_netname = field 0 String -MarshalAs @('LPWStr')
    shi1_type = field 1 UInt32
    shi1_remark = field 2 String -MarshalAs @('LPWStr')
}

# the NetWkstaUserEnum result structure
$WKSTA_USER_INFO_1 = struct $Mod WKSTA_USER_INFO_1 @{
    wkui1_username = field 0 String -MarshalAs @('LPWStr')
    wkui1_logon_domain = field 1 String -MarshalAs @('LPWStr')
    wkui1_oth_domains = field 2 String -MarshalAs @('LPWStr')
    wkui1_logon_server = field 3 String -MarshalAs @('LPWStr')
}

# the NetSessionEnum result structure
$SESSION_INFO_10 = struct $Mod SESSION_INFO_10 @{
    sesi10_cname = field 0 String -MarshalAs @('LPWStr')
    sesi10_username = field 1 String -MarshalAs @('LPWStr')
    sesi10_time = field 2 UInt32
    sesi10_idle_time = field 3 UInt32
}

# enum used by $LOCALGROUP_MEMBERS_INFO_2 below
$SID_NAME_USE = psenum $Mod SID_NAME_USE UInt16 @{
    SidTypeUser             = 1
    SidTypeGroup            = 2
    SidTypeDomain           = 3
    SidTypeAlias            = 4
    SidTypeWellKnownGroup   = 5
    SidTypeDeletedAccount   = 6
    SidTypeInvalid          = 7
    SidTypeUnknown          = 8
    SidTypeComputer         = 9
}

# the NetLocalGroupGetMembers result structure
$LOCALGROUP_MEMBERS_INFO_2 = struct $Mod LOCALGROUP_MEMBERS_INFO_2 @{
    lgrmi2_sid = field 0 IntPtr
    lgrmi2_sidusage = field 1 $SID_NAME_USE
    lgrmi2_domainandname = field 2 String -MarshalAs @('LPWStr')
}

# enums used in DS_DOMAIN_TRUSTS
$DsDomainFlag = psenum $Mod DsDomain.Flags UInt32 @{
    IN_FOREST       = 1
    DIRECT_OUTBOUND = 2
    TREE_ROOT       = 4
    PRIMARY         = 8
    NATIVE_MODE     = 16
    DIRECT_INBOUND  = 32
} -Bitfield
$DsDomainTrustType = psenum $Mod DsDomain.TrustType UInt32 @{
    DOWNLEVEL   = 1
    UPLEVEL     = 2
    MIT         = 3
    DCE         = 4
}
$DsDomainTrustAttributes = psenum $Mod DsDomain.TrustAttributes UInt32 @{
    NON_TRANSITIVE      = 1
    UPLEVEL_ONLY        = 2
    FILTER_SIDS         = 4
    FOREST_TRANSITIVE   = 8
    CROSS_ORGANIZATION  = 16
    WITHIN_FOREST       = 32
    TREAT_AS_EXTERNAL   = 64
}

# the DsEnumerateDomainTrusts result structure
$DS_DOMAIN_TRUSTS = struct $Mod DS_DOMAIN_TRUSTS @{
    NetbiosDomainName = field 0 String -MarshalAs @('LPWStr')
    DnsDomainName = field 1 String -MarshalAs @('LPWStr')
    Flags = field 2 $DsDomainFlag
    ParentIndex = field 3 UInt32
    TrustType = field 4 $DsDomainTrustType
    TrustAttributes = field 5 $DsDomainTrustAttributes
    DomainSid = field 6 IntPtr
    DomainGuid = field 7 Guid
}

$Types = $FunctionDefinitions | Add-Win32Type -Module $Mod -Namespace 'Win32'
$Netapi32 = $Types['netapi32']
$Advapi32 = $Types['advapi32']
$Wtsapi32 = $Types['wtsapi32']

function Invoke-Parallel
{
    [cmdletbinding(DefaultParameterSetName = 'ScriptBlock')]
    Param (
        [Parameter(Mandatory = $false,position = 0,ParameterSetName = 'ScriptBlock')]
        [System.Management.Automation.ScriptBlock]$ScriptBlock,

        [Parameter(Mandatory = $false,ParameterSetName = 'ScriptFile')]
        [ValidateScript({
                    Test-Path $_ -PathType leaf
        })]
        $ScriptFile,

        [Parameter(Mandatory = $true,ValueFromPipeline = $true)]
        [Alias('CN','__Server','IPAddress','Server','ComputerName')]
        [PSObject]$InputObject,

        [PSObject]$Parameter,

        [switch]$ImportSessionFunctions,

        [switch]$ImportVariables,

        [switch]$ImportModules,

        [int]$Throttle = 20,

        [int]$SleepTimer = 200,

        [int]$RunspaceTimeout = 0,

        [switch]$NoCloseOnTimeout = $false,

        [int]$MaxQueue,

        [validatescript({
                    Test-Path (Split-Path -Path $_ -Parent)
        })]
        [string]$LogFile = 'C:\temp\log.log',

        [switch] $Quiet = $false
    )

    Begin {

        #No max queue specified?  Estimate one.
        #We use the script scope to resolve an odd PowerShell 2 issue where MaxQueue isn't seen later in the function
        if( -not $PSBoundParameters.ContainsKey('MaxQueue') )
        {
            if($RunspaceTimeout -ne 0)
            {
                $script:MaxQueue = $Throttle
            }
            else
            {
                $script:MaxQueue = $Throttle * 3
            }
        }
        else
        {
            $script:MaxQueue = $MaxQueue
        }

        #If they want to import variables or modules, create a clean runspace, get loaded items, use those to exclude items
        if ($ImportVariables -or $ImportModules)
        {
            $StandardUserEnv = [powershell]::Create().addscript({
                    #Get modules and snapins in this clean runspace
                    $Modules = Get-Module | Select-Object -ExpandProperty Name
                    $Snapins = Get-PSSnapin | Select-Object -ExpandProperty Name

                    #Get variables in this clean runspace
                    #Called last to get vars like $? into session
                    $Variables = Get-Variable | Select-Object -ExpandProperty Name

                    #Return a hashtable where we can access each.
                    @{
                        Variables = $Variables
                        Modules   = $Modules
                        Snapins   = $Snapins
                    }
            }).invoke()[0]

            if ($ImportVariables)
            {
                #Exclude common parameters, bound parameters, and automatic variables
                Function _temp
                {
                    [cmdletbinding()] param()
                }
                $VariablesToExclude = @( (Get-Command _temp | Select-Object -ExpandProperty parameters).Keys + $PSBoundParameters.Keys + $StandardUserEnv.Variables )
                #Write-Verbose "Excluding variables $( ($VariablesToExclude | sort ) -join ", ")"

                # we don't use 'Get-Variable -Exclude', because it uses regexps.
                # One of the veriables that we pass is '$?'.
                # There could be other variables with such problems.
                # Scope 2 required if we move to a real module
                $UserVariables = @( Get-Variable | Where-Object -FilterScript {
                        -not ($VariablesToExclude -contains $_.Name)
                } )
                #Write-Verbose "Found variables to import: $( ($UserVariables | Select -expandproperty Name | Sort ) -join ", " | Out-String).`n"
            }

            if ($ImportModules)
            {
                $UserModules = @( Get-Module |
                    Where-Object -FilterScript {
                        $StandardUserEnv.Modules -notcontains $_.Name -and (Test-Path -Path $_.Path -ErrorAction SilentlyContinue)
                    } |
                Select-Object -ExpandProperty Path )
                $UserSnapins = @( Get-PSSnapin |
                    Select-Object -ExpandProperty Name |
                    Where-Object -FilterScript {
                        $StandardUserEnv.Snapins -notcontains $_
                } )
            }
        }

        #region functions

        Function Get-RunspaceData
        {
            [cmdletbinding()]
            param( [switch]$Wait )

            #loop through runspaces
            #if $wait is specified, keep looping until all complete
            Do
            {
                #set more to false for tracking completion
                $more = $false

                #Progress bar if we have inputobject count (bound parameter)
                if (-not $Quiet)
                {
                    Write-Progress  -Activity 'Running Query' -Status 'Starting threads'`
                    -CurrentOperation "$startedCount threads defined - $totalCount input objects - $script:completedCount input objects processed"`
                    -PercentComplete $( Try
                        {
                            $script:completedCount / $totalCount * 100
                        }
                        Catch
                        {
                            0
                        }
                    )
                }

                #run through each runspace.
                Foreach($runspace in $runspaces)
                {
                    #get the duration - inaccurate
                    $currentdate = Get-Date
                    $runtime = $currentdate - $runspace.startTime
                    $runMin = [math]::Round( $runtime.totalminutes ,2 )

                    #set up log object
                    $log = '' | Select-Object -Property Date, Action, Runtime, Status, Details
                    $log.Action = "Removing:'$($runspace.object)'"
                    $log.Date = $currentdate
                    $log.Runtime = "$runMin minutes"

                    #If runspace completed, end invoke, dispose, recycle, counter++
                    If ($runspace.Runspace.isCompleted)
                    {
                        $script:completedCount++

                        #check if there were errors
                        if($runspace.powershell.Streams.Error.Count -gt 0)
                        {
                            #set the logging info and move the file to completed
                            $log.status = 'CompletedWithErrors'
                            #Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                            foreach($ErrorRecord in $runspace.powershell.Streams.Error)
                            {
                                Write-Error -ErrorRecord $ErrorRecord
                            }
                        }
                        else
                        {
                            #add logging details and cleanup
                            $log.status = 'Completed'
                            #Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                        }

                        #everything is logged, clean up the runspace
                        $runspace.powershell.EndInvoke($runspace.Runspace)
                        $runspace.powershell.dispose()
                        $runspace.Runspace = $null
                        $runspace.powershell = $null
                    }

                    #If runtime exceeds max, dispose the runspace
                    ElseIf ( $RunspaceTimeout -ne 0 -and $runtime.totalseconds -gt $RunspaceTimeout)
                    {
                        $script:completedCount++
                        $timedOutTasks = $true

                        #add logging details and cleanup
                        $log.status = 'TimedOut'
                        #Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                        Write-Error -Message "Runspace timed out at $($runtime.totalseconds) seconds for the object:`n$($runspace.object | Out-String)"

                        #Depending on how it hangs, we could still get stuck here as dispose calls a synchronous method on the powershell instance
                        if (!$NoCloseOnTimeout)
                        {
                            $runspace.powershell.dispose()
                        }
                        $runspace.Runspace = $null
                        $runspace.powershell = $null
                        $completedCount++
                    }

                    #If runspace isn't null set more to true
                    ElseIf ($runspace.Runspace -ne $null )
                    {
                        $log = $null
                        $more = $true
                    }
                }

                #Clean out unused runspace jobs
                $temphash = $runspaces.clone()
                $temphash |
                Where-Object -FilterScript {
                    $_.runspace -eq $null
                } |
                ForEach-Object -Process {
                    $runspaces.remove($_)
                }

                #sleep for a bit if we will loop again
                if($PSBoundParameters['Wait'])
                {
                    Start-Sleep -Milliseconds $SleepTimer
                }

                #Loop again only if -wait parameter and there are more runspaces to process
            }
            while ($more -and $PSBoundParameters['Wait'])

            #End of runspace function
        }

        #endregion functions

        #region Init

        if($PSCmdlet.ParameterSetName -eq 'ScriptFile')
        {
            $ScriptBlock = [scriptblock]::Create( $(Get-Content $ScriptFile | Out-String) )
        }
        elseif($PSCmdlet.ParameterSetName -eq 'ScriptBlock')
        {
            #Start building parameter names for the param block
            [string[]]$ParamsToAdd = '$_'
            if( $PSBoundParameters.ContainsKey('Parameter') )
            {
                $ParamsToAdd += '$Parameter'
            }

            $UsingVariableData = $null


            # This code enables $Using support through the AST.
            # This is entirely from  Boe Prox, and his https://github.com/proxb/PoshRSJob module; all credit to Boe!

            if($PSVersionTable.PSVersion.Major -gt 2)
            {
                #Extract using references
                $UsingVariables = $ScriptBlock.ast.FindAll({
                        $args[0] -is [System.Management.Automation.Language.UsingExpressionAst]
                },$true)

                If ($UsingVariables)
                {
                    $List = New-Object -TypeName 'System.Collections.Generic.List`1[System.Management.Automation.Language.VariableExpressionAst]'
                    ForEach ($Ast in $UsingVariables)
                    {
                        [void]$List.Add($Ast.SubExpression)
                    }

                    $UsingVar = $UsingVariables |
                    Group-Object -Property SubExpression |
                    ForEach-Object -Process {
                        $_.Group |
                        Select-Object -First 1
                    }

                    #Extract the name, value, and create replacements for each
                    $UsingVariableData = ForEach ($Var in $UsingVar)
                    {
                        Try
                        {
                            $Value = Get-Variable -Name $Var.SubExpression.VariablePath.UserPath -ErrorAction Stop
                            [pscustomobject]@{
                                Name       = $Var.SubExpression.Extent.Text
                                Value      = $Value.Value
                                NewName    = ('$__using_{0}' -f $Var.SubExpression.VariablePath.UserPath)
                                NewVarName = ('__using_{0}' -f $Var.SubExpression.VariablePath.UserPath)
                            }
                        }
                        Catch
                        {
                            Write-Error -Message "$($Var.SubExpression.Extent.Text) is not a valid Using: variable!"
                        }
                    }
                    $ParamsToAdd += $UsingVariableData | Select-Object -ExpandProperty NewName -Unique

                    $NewParams = $UsingVariableData.NewName -join ', '
                    $Tuple = [Tuple]::Create($List, $NewParams)
                    $bindingFlags = [Reflection.BindingFlags]'Default,NonPublic,Instance'
                    $GetWithInputHandlingForInvokeCommandImpl = ($ScriptBlock.ast.gettype().GetMethod('GetWithInputHandlingForInvokeCommandImpl',$bindingFlags))

                    $StringScriptBlock = $GetWithInputHandlingForInvokeCommandImpl.Invoke($ScriptBlock.ast,@($Tuple))

                    $ScriptBlock = [scriptblock]::Create($StringScriptBlock)

                    #Write-Verbose $StringScriptBlock
                }
            }

            $ScriptBlock = $ExecutionContext.InvokeCommand.NewScriptBlock("param($($ParamsToAdd -Join ', '))`r`n" + $ScriptBlock.ToString())
        }
        else
        {
            Throw 'Must provide ScriptBlock or ScriptFile'
            Break
        }

        Write-Debug -Message "`$ScriptBlock: $($ScriptBlock | Out-String)"
        If (-not($SuppressVerbose)){
            Write-Verbose -Message 'Creating runspace pool and session states'
        }


        #If specified, add variables and modules/snapins to session state
        $sessionstate = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
        if ($ImportVariables)
        {
            if($UserVariables.count -gt 0)
            {
                foreach($Variable in $UserVariables)
                {
                    $sessionstate.Variables.Add( (New-Object -TypeName System.Management.Automation.Runspaces.SessionStateVariableEntry -ArgumentList $Variable.Name, $Variable.Value, $null) )
                }
            }
        }
        if ($ImportModules)
        {
            if($UserModules.count -gt 0)
            {
                foreach($ModulePath in $UserModules)
                {
                    $sessionstate.ImportPSModule($ModulePath)
                }
            }
            if($UserSnapins.count -gt 0)
            {
                foreach($PSSnapin in $UserSnapins)
                {
                    [void]$sessionstate.ImportPSSnapIn($PSSnapin, [ref]$null)
                }
            }
        }

        # --------------------------------------------------
        #region - Import Session Functions
        # --------------------------------------------------
        # Import functions from the current session into the RunspacePool sessionstate

        if($ImportSessionFunctions)
        {
            # Import all session functions into the runspace session state from the current one
            Get-ChildItem -Path Function:\ |
            Where-Object -FilterScript {
                $_.name -notlike '*:*'
            } |
            Select-Object -Property name -ExpandProperty name |
            ForEach-Object -Process {
                # Get the function code
                $Definition = Get-Content -Path "function:\$_" -ErrorAction Stop

                # Create a sessionstate function with the same name and code
                $SessionStateFunction = New-Object -TypeName System.Management.Automation.Runspaces.SessionStateFunctionEntry -ArgumentList "$_", $Definition

                # Add the function to the session state
                $sessionstate.Commands.Add($SessionStateFunction)
            }
        }
        #endregion

        #Create runspace pool
        $runspacepool = [runspacefactory]::CreateRunspacePool(1, $Throttle, $sessionstate, $Host)
        $runspacepool.Open()

        #Write-Verbose "Creating empty collection to hold runspace jobs"
        $Script:runspaces = New-Object -TypeName System.Collections.ArrayList

        #If inputObject is bound get a total count and set bound to true
        $bound = $PSBoundParameters.keys -contains 'InputObject'
        if(-not $bound)
        {
            [System.Collections.ArrayList]$allObjects = @()
        }

        <#
                #write initial log entry
                $log = "" | Select Date, Action, Runtime, Status, Details
                $log.Date = Get-Date
                $log.Action = "Batch processing started"
                $log.Runtime = $null
                $log.Status = "Started"
                $log.Details = $null
        #>
        $timedOutTasks = $false

        #endregion INIT
    }

    Process {

        #add piped objects to all objects or set all objects to bound input object parameter
        if($bound)
        {
            $allObjects = $InputObject
        }
        Else
        {
            [void]$allObjects.add( $InputObject )
        }
    }

    End {

        #Use Try/Finally to catch Ctrl+C and clean up.
        Try
        {
            #counts for progress
            $totalCount = $allObjects.count
            $script:completedCount = 0
            $startedCount = 0

            foreach($object in $allObjects)
            {
                #region add scripts to runspace pool

                #Create the powershell instance, set verbose if needed, supply the scriptblock and parameters
                $powershell = [powershell]::Create()

                if ($VerbosePreference -eq 'Continue')
                {
                    [void]$powershell.AddScript({
                            $VerbosePreference = 'Continue'
                    })
                }

                [void]$powershell.AddScript($ScriptBlock).AddArgument($object)

                if ($Parameter)
                {
                    [void]$powershell.AddArgument($Parameter)
                }

                # $Using support from Boe Prox
                if ($UsingVariableData)
                {
                    Foreach($UsingVariable in $UsingVariableData)
                    {
                        #Write-Verbose "Adding $($UsingVariable.Name) with value: $($UsingVariable.Value)"
                        [void]$powershell.AddArgument($UsingVariable.Value)
                    }
                }

                #Add the runspace into the powershell instance
                $powershell.RunspacePool = $runspacepool

                #Create a temporary collection for each runspace
                $temp = '' | Select-Object -Property PowerShell, StartTime, object, Runspace
                $temp.PowerShell = $powershell
                $temp.StartTime = Get-Date
                $temp.object = $object

                #Save the handle output when calling BeginInvoke() that will be used later to end the runspace
                $temp.Runspace = $powershell.BeginInvoke()
                $startedCount++

                #Add the temp tracking info to $runspaces collection
                #Write-Verbose ( "Adding {0} to collection at {1}" -f $temp.object, $temp.starttime.tostring() )
                $null = $runspaces.Add($temp)

                #loop through existing runspaces one time
                Get-RunspaceData

                #If we have more running than max queue (used to control timeout accuracy)
                #Script scope resolves odd PowerShell 2 issue
                $firstRun = $true
                while ($runspaces.count -ge $script:MaxQueue)
                {
                    #give verbose output
                    if($firstRun)
                    {
                        #Write-Verbose "$($runspaces.count) items running - exceeded $Script:MaxQueue limit."
                    }
                    $firstRun = $false

                    #run get-runspace data and sleep for a short while
                    Get-RunspaceData
                    Start-Sleep -Milliseconds $SleepTimer
                }

                #endregion add scripts to runspace pool
            }

            #Write-Verbose ( "Finish processing the remaining runspace jobs: {0}" -f ( @($runspaces | Where {$_.Runspace -ne $Null}).Count) )
            Get-RunspaceData -wait

            if (-not $Quiet)
            {
                Write-Progress -Activity 'Running Query' -Status 'Starting threads' -Completed
            }
        }
        Finally
        {
            #Close the runspace pool, unless we specified no close on timeout and something timed out
            if ( ($timedOutTasks -eq $false) -or ( ($timedOutTasks -eq $true) -and ($NoCloseOnTimeout -eq $false) ) )
            {
                If (-not($SuppressVerbose)){
                    Write-Verbose -Message 'Closing the runspace pool'
                }
                $runspacepool.close()
            }

            #collect garbage
            [gc]::Collect()
        }
    }
}

Function Invoke-Ping 
{
<#
.SYNOPSIS
    Ping or test connectivity to systems in parallel
    
.DESCRIPTION
    Ping or test connectivity to systems in parallel

    Default action will run a ping against systems
        If Quiet parameter is specified, we return an array of systems that responded
        If Detail parameter is specified, we test WSMan, RemoteReg, RPC, RDP and/or SMB

.PARAMETER ComputerName
    One or more computers to test

.PARAMETER Quiet
    If specified, only return addresses that responded to Test-Connection

.PARAMETER Detail
    Include one or more additional tests as specified:
        WSMan      via Test-WSMan
        RemoteReg  via Microsoft.Win32.RegistryKey
        RPC        via WMI
        RDP        via port 3389
        SMB        via \\ComputerName\C$
        *          All tests

.PARAMETER Timeout
    Time in seconds before we attempt to dispose an individual query.  Default is 20

.PARAMETER Throttle
    Throttle query to this many parallel runspaces.  Default is 100.

.PARAMETER NoCloseOnTimeout
    Do not dispose of timed out tasks or attempt to close the runspace if threads have timed out

    This will prevent the script from hanging in certain situations where threads become non-responsive, at the expense of leaking memory within the PowerShell host.

.EXAMPLE
    Invoke-Ping Server1, Server2, Server3 -Detail *

    # Check for WSMan, Remote Registry, Remote RPC, RDP, and SMB (via C$) connectivity against 3 machines

.EXAMPLE
    $Computers | Invoke-Ping

    # Ping computers in $Computers in parallel

.EXAMPLE
    $Responding = $Computers | Invoke-Ping -Quiet
    
    # Create a list of computers that successfully responded to Test-Connection

.LINK
    https://gallery.technet.microsoft.com/scriptcenter/Invoke-Ping-Test-in-b553242a

.FUNCTIONALITY
    Computers

#>
    [cmdletbinding(DefaultParameterSetName='Ping')]
    param(
        [Parameter( ValueFromPipeline=$true,
                    ValueFromPipelineByPropertyName=$true, 
                    Position=0)]
        [string[]]$ComputerName,
        
        [Parameter( ParameterSetName='Detail')]
        [validateset("*","WSMan","RemoteReg","RPC","RDP","SMB")]
        [string[]]$Detail,
        
        [Parameter(ParameterSetName='Ping')]
        [switch]$Quiet,
        
        [int]$Timeout = 20,
        
        [int]$Throttle = 100,

        [switch]$NoCloseOnTimeout
    )
    Begin
    {

        #http://gallery.technet.microsoft.com/Run-Parallel-Parallel-377fd430
        function Invoke-Parallel {
            [cmdletbinding(DefaultParameterSetName='ScriptBlock')]
            Param (   
                [Parameter(Mandatory=$false,position=0,ParameterSetName='ScriptBlock')]
                    [System.Management.Automation.ScriptBlock]$ScriptBlock,

                [Parameter(Mandatory=$false,ParameterSetName='ScriptFile')]
                [ValidateScript({test-path $_ -pathtype leaf})]
                    $ScriptFile,

                [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
                [Alias('CN','__Server','IPAddress','Server','ComputerName')]    
                    [PSObject]$InputObject,

                    [PSObject]$Parameter,

                    [switch]$ImportVariables,

                    [switch]$ImportModules,

                    [int]$Throttle = 20,

                    [int]$SleepTimer = 200,

                    [int]$RunspaceTimeout = 0,

			        [switch]$NoCloseOnTimeout = $false,

                    [int]$MaxQueue,

                [validatescript({Test-Path (Split-Path $_ -parent)})]
                    [string]$LogFile = "C:\temp\log.log",

			        [switch] $Quiet = $false
            )
    
            Begin {
                
                #No max queue specified?  Estimate one.
                #We use the script scope to resolve an odd PowerShell 2 issue where MaxQueue isn't seen later in the function
                if( -not $PSBoundParameters.ContainsKey('MaxQueue') )
                {
                    if($RunspaceTimeout -ne 0){ $script:MaxQueue = $Throttle }
                    else{ $script:MaxQueue = $Throttle * 3 }
                }
                else
                {
                    $script:MaxQueue = $MaxQueue
                }               

                #If they want to import variables or modules, create a clean runspace, get loaded items, use those to exclude items
                if ($ImportVariables -or $ImportModules)
                {
                    $StandardUserEnv = [powershell]::Create().addscript({

                        #Get modules and snapins in this clean runspace
                        $Modules = Get-Module | Select -ExpandProperty Name
                        $Snapins = Get-PSSnapin | Select -ExpandProperty Name

                        #Get variables in this clean runspace
                        #Called last to get vars like $? into session
                        $Variables = Get-Variable | Select -ExpandProperty Name
                
                        #Return a hashtable where we can access each.
                        @{
                            Variables = $Variables
                            Modules = $Modules
                            Snapins = $Snapins
                        }
                    }).invoke()[0]
            
                    if ($ImportVariables) {
                        #Exclude common parameters, bound parameters, and automatic variables
                        Function _temp {[cmdletbinding()] param() }
                        $VariablesToExclude = @( (Get-Command _temp | Select -ExpandProperty parameters).Keys + $PSBoundParameters.Keys + $StandardUserEnv.Variables )
                        Write-Verbose "Excluding variables $( ($VariablesToExclude | sort ) -join ", ")"

                        # we don't use 'Get-Variable -Exclude', because it uses regexps. 
                        # One of the veriables that we pass is '$?'. 
                        # There could be other variables with such problems.
                        # Scope 2 required if we move to a real module
                        $UserVariables = @( Get-Variable | Where { -not ($VariablesToExclude -contains $_.Name) } ) 
                        Write-Verbose "Found variables to import: $( ($UserVariables | Select -expandproperty Name | Sort ) -join ", " | Out-String).`n"

                    }

                    if ($ImportModules) 
                    {
                        $UserModules = @( Get-Module | Where {$StandardUserEnv.Modules -notcontains $_.Name -and (Test-Path $_.Path -ErrorAction SilentlyContinue)} | Select -ExpandProperty Path )
                        $UserSnapins = @( Get-PSSnapin | Select -ExpandProperty Name | Where {$StandardUserEnv.Snapins -notcontains $_ } ) 
                    }
                }

                #region functions
            
                    Function Get-RunspaceData {
                        [cmdletbinding()]
                        param( [switch]$Wait )

                        #loop through runspaces
                        #if $wait is specified, keep looping until all complete
                        Do {

                            #set more to false for tracking completion
                            $more = $false

                            #Progress bar if we have inputobject count (bound parameter)
                            if (-not $Quiet) {
						        Write-Progress  -Activity "Running Query" -Status "Starting threads"`
							        -CurrentOperation "$startedCount threads defined - $totalCount input objects - $script:completedCount input objects processed"`
							        -PercentComplete $( Try { $script:completedCount / $totalCount * 100 } Catch {0} )
					        }

                            #run through each runspace.           
                            Foreach($runspace in $runspaces) {
                    
                                #get the duration - inaccurate
                                $currentdate = Get-Date
                                $runtime = $currentdate - $runspace.startTime
                                $runMin = [math]::Round( $runtime.totalminutes ,2 )

                                #set up log object
                                $log = "" | select Date, Action, Runtime, Status, Details
                                $log.Action = "Removing:'$($runspace.object)'"
                                $log.Date = $currentdate
                                $log.Runtime = "$runMin minutes"

                                #If runspace completed, end invoke, dispose, recycle, counter++
                                If ($runspace.Runspace.isCompleted) {
                            
                                    $script:completedCount++
                        
                                    #check if there were errors
                                    if($runspace.powershell.Streams.Error.Count -gt 0) {
                                
                                        #set the logging info and move the file to completed
                                        $log.status = "CompletedWithErrors"
                                        Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                                        foreach($ErrorRecord in $runspace.powershell.Streams.Error) {
                                            Write-Error -ErrorRecord $ErrorRecord
                                        }
                                    }
                                    else {
                                
                                        #add logging details and cleanup
                                        $log.status = "Completed"
                                        Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                                    }

                                    #everything is logged, clean up the runspace
                                    $runspace.powershell.EndInvoke($runspace.Runspace)
                                    $runspace.powershell.dispose()
                                    $runspace.Runspace = $null
                                    $runspace.powershell = $null

                                }

                                #If runtime exceeds max, dispose the runspace
                                ElseIf ( $runspaceTimeout -ne 0 -and $runtime.totalseconds -gt $runspaceTimeout) {
                            
                                    $script:completedCount++
                                    $timedOutTasks = $true
                            
							        #add logging details and cleanup
                                    $log.status = "TimedOut"
                                    Write-Verbose ($log | ConvertTo-Csv -Delimiter ";" -NoTypeInformation)[1]
                                    Write-Error "Runspace timed out at $($runtime.totalseconds) seconds for the object:`n$($runspace.object | out-string)"

                                    #Depending on how it hangs, we could still get stuck here as dispose calls a synchronous method on the powershell instance
                                    if (!$noCloseOnTimeout) { $runspace.powershell.dispose() }
                                    $runspace.Runspace = $null
                                    $runspace.powershell = $null
                                    $completedCount++

                                }
                   
                                #If runspace isn't null set more to true  
                                ElseIf ($runspace.Runspace -ne $null ) {
                                    $log = $null
                                    $more = $true
                                }
                            }

                            #Clean out unused runspace jobs
                            $temphash = $runspaces.clone()
                            $temphash | Where { $_.runspace -eq $Null } | ForEach {
                                $Runspaces.remove($_)
                            }

                            #sleep for a bit if we will loop again
                            if($PSBoundParameters['Wait']){ Start-Sleep -milliseconds $SleepTimer }

                        #Loop again only if -wait parameter and there are more runspaces to process
                        } while ($more -and $PSBoundParameters['Wait'])
                
                    #End of runspace function
                    }

                #endregion functions
        
                #region Init

                    if($PSCmdlet.ParameterSetName -eq 'ScriptFile')
                    {
                        $ScriptBlock = [scriptblock]::Create( $(Get-Content $ScriptFile | out-string) )
                    }
                    elseif($PSCmdlet.ParameterSetName -eq 'ScriptBlock')
                    {
                        #Start building parameter names for the param block
                        [string[]]$ParamsToAdd = '$_'
                        if( $PSBoundParameters.ContainsKey('Parameter') )
                        {
                            $ParamsToAdd += '$Parameter'
                        }

                        $UsingVariableData = $Null
                

                        # This code enables $Using support through the AST.
                        # This is entirely from  Boe Prox, and his https://github.com/proxb/PoshRSJob module; all credit to Boe!
                
                        if($PSVersionTable.PSVersion.Major -gt 2)
                        {
                            #Extract using references
                            $UsingVariables = $ScriptBlock.ast.FindAll({$args[0] -is [System.Management.Automation.Language.UsingExpressionAst]},$True)    

                            If ($UsingVariables)
                            {
                                $List = New-Object 'System.Collections.Generic.List`1[System.Management.Automation.Language.VariableExpressionAst]'
                                ForEach ($Ast in $UsingVariables)
                                {
                                    [void]$list.Add($Ast.SubExpression)
                                }

                                $UsingVar = $UsingVariables | Group Parent | ForEach {$_.Group | Select -First 1}
        
                                #Extract the name, value, and create replacements for each
                                $UsingVariableData = ForEach ($Var in $UsingVar) {
                                    Try
                                    {
                                        $Value = Get-Variable -Name $Var.SubExpression.VariablePath.UserPath -ErrorAction Stop
                                        $NewName = ('$__using_{0}' -f $Var.SubExpression.VariablePath.UserPath)
                                        [pscustomobject]@{
                                            Name = $Var.SubExpression.Extent.Text
                                            Value = $Value.Value
                                            NewName = $NewName
                                            NewVarName = ('__using_{0}' -f $Var.SubExpression.VariablePath.UserPath)
                                        }
                                        $ParamsToAdd += $NewName
                                    }
                                    Catch
                                    {
                                        Write-Error "$($Var.SubExpression.Extent.Text) is not a valid Using: variable!"
                                    }
                                }
    
                                $NewParams = $UsingVariableData.NewName -join ', '
                                $Tuple = [Tuple]::Create($list, $NewParams)
                                $bindingFlags = [Reflection.BindingFlags]"Default,NonPublic,Instance"
                                $GetWithInputHandlingForInvokeCommandImpl = ($ScriptBlock.ast.gettype().GetMethod('GetWithInputHandlingForInvokeCommandImpl',$bindingFlags))
        
                                $StringScriptBlock = $GetWithInputHandlingForInvokeCommandImpl.Invoke($ScriptBlock.ast,@($Tuple))

                                $ScriptBlock = [scriptblock]::Create($StringScriptBlock)

                                Write-Verbose $StringScriptBlock
                            }
                        }
                
                        $ScriptBlock = $ExecutionContext.InvokeCommand.NewScriptBlock("param($($ParamsToAdd -Join ", "))`r`n" + $Scriptblock.ToString())
                    }
                    else
                    {
                        Throw "Must provide ScriptBlock or ScriptFile"; Break
                    }

                    Write-Debug "`$ScriptBlock: $($ScriptBlock | Out-String)"
                    Write-Verbose "Creating runspace pool and session states"

                    #If specified, add variables and modules/snapins to session state
                    $sessionstate = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
                    if ($ImportVariables)
                    {
                        if($UserVariables.count -gt 0)
                        {
                            foreach($Variable in $UserVariables)
                            {
                                $sessionstate.Variables.Add( (New-Object -TypeName System.Management.Automation.Runspaces.SessionStateVariableEntry -ArgumentList $Variable.Name, $Variable.Value, $null) )
                            }
                        }
                    }
                    if ($ImportModules)
                    {
                        if($UserModules.count -gt 0)
                        {
                            foreach($ModulePath in $UserModules)
                            {
                                $sessionstate.ImportPSModule($ModulePath)
                            }
                        }
                        if($UserSnapins.count -gt 0)
                        {
                            foreach($PSSnapin in $UserSnapins)
                            {
                                [void]$sessionstate.ImportPSSnapIn($PSSnapin, [ref]$null)
                            }
                        }
                    }

                    #Create runspace pool
                    $runspacepool = [runspacefactory]::CreateRunspacePool(1, $Throttle, $sessionstate, $Host)
                    $runspacepool.Open() 

                    Write-Verbose "Creating empty collection to hold runspace jobs"
                    $Script:runspaces = New-Object System.Collections.ArrayList        
        
                    #If inputObject is bound get a total count and set bound to true
                    $global:__bound = $false
                    $allObjects = @()
                    if( $PSBoundParameters.ContainsKey("inputObject") ){
                        $global:__bound = $true
                    }

                    #write initial log entry
                    $log = "" | Select Date, Action, Runtime, Status, Details
                        $log.Date = Get-Date
                        $log.Action = "Batch processing started"
                        $log.Runtime = $null
                        $log.Status = "Started"
                        $log.Details = $null

			        $timedOutTasks = $false

                #endregion INIT
            }

            Process {

                #add piped objects to all objects or set all objects to bound input object parameter
                if( -not $global:__bound ){
                    $allObjects += $inputObject
                }
                else{
                    $allObjects = $InputObject
                }
            }

            End {
        
                #Use Try/Finally to catch Ctrl+C and clean up.
                Try
                {
                    #counts for progress
                    $totalCount = $allObjects.count
                    $script:completedCount = 0
                    $startedCount = 0

                    foreach($object in $allObjects){
        
                        #region add scripts to runspace pool
                    
                            #Create the powershell instance, set verbose if needed, supply the scriptblock and parameters
                            $powershell = [powershell]::Create()
                    
                            if ($VerbosePreference -eq 'Continue')
                            {
                                [void]$PowerShell.AddScript({$VerbosePreference = 'Continue'})
                            }

                            [void]$PowerShell.AddScript($ScriptBlock).AddArgument($object)

                            if ($parameter)
                            {
                                [void]$PowerShell.AddArgument($parameter)
                            }

                            # $Using support from Boe Prox
                            if ($UsingVariableData)
                            {
                                Foreach($UsingVariable in $UsingVariableData) {
                                    Write-Verbose "Adding $($UsingVariable.Name) with value: $($UsingVariable.Value)"
                                    [void]$PowerShell.AddArgument($UsingVariable.Value)
                                }
                            }

                            #Add the runspace into the powershell instance
                            $powershell.RunspacePool = $runspacepool
    
                            #Create a temporary collection for each runspace
                            $temp = "" | Select-Object PowerShell, StartTime, object, Runspace
                            $temp.PowerShell = $powershell
                            $temp.StartTime = Get-Date
                            $temp.object = $object
    
                            #Save the handle output when calling BeginInvoke() that will be used later to end the runspace
                            $temp.Runspace = $powershell.BeginInvoke()
                            $startedCount++

                            #Add the temp tracking info to $runspaces collection
                            Write-Verbose ( "Adding {0} to collection at {1}" -f $temp.object, $temp.starttime.tostring() )
                            $runspaces.Add($temp) | Out-Null
            
                            #loop through existing runspaces one time
                            if($ShowRunpaceErrors){
                                Get-RunspaceData
                            }else{
                                Get-RunspaceData -ErrorAction SilentlyContinue
                            }

                            #If we have more running than max queue (used to control timeout accuracy)
                            #Script scope resolves odd PowerShell 2 issue
                            $firstRun = $true
                            while ($runspaces.count -ge $Script:MaxQueue) {

                                #give verbose output
                                if($firstRun){
                                    Write-Verbose "$($runspaces.count) items running - exceeded $Script:MaxQueue limit."
                                }
                                $firstRun = $false
                    
                                #run get-runspace data and sleep for a short while
                                Get-RunspaceData
                                Start-Sleep -Milliseconds $sleepTimer
                    
                            }

                        #endregion add scripts to runspace pool
                    }
                     
                    Write-Verbose ( "Finish processing the remaining runspace jobs: {0}" -f ( @($runspaces | Where {$_.Runspace -ne $Null}).Count) )
                    Get-RunspaceData -wait

                    if (-not $quiet) {
			            Write-Progress -Activity "Running Query" -Status "Starting threads" -Completed
		            }

                }
                Finally
                {
                    #Close the runspace pool, unless we specified no close on timeout and something timed out
                    if ( ($timedOutTasks -eq $false) -or ( ($timedOutTasks -eq $true) -and ($noCloseOnTimeout -eq $false) ) ) {
	                    Write-Verbose "Closing the runspace pool"
			            $runspacepool.close()
                    }

                    #collect garbage
                    [gc]::Collect()
                }       
            }
        }

        Write-Verbose "PSBoundParameters = $($PSBoundParameters | Out-String)"
        
        $bound = $PSBoundParameters.keys -contains "ComputerName"
        if(-not $bound)
        {
            [System.Collections.ArrayList]$AllComputers = @()
        }
    }
    Process
    {

        #Handle both pipeline and bound parameter.  We don't want to stream objects, defeats purpose of parallelizing work
        if($bound)
        {
            $AllComputers = $ComputerName
        }
        Else
        {
            foreach($Computer in $ComputerName)
            {
                $AllComputers.add($Computer) | Out-Null
            }
        }

    }
    End
    {

        #Built up the parameters and run everything in parallel
        $params = @($Detail, $Quiet)
        $splat = @{
            Throttle = $Throttle
            RunspaceTimeout = $Timeout
            InputObject = $AllComputers
            parameter = $params
        }
        if($NoCloseOnTimeout)
        {
            $splat.add('NoCloseOnTimeout',$True)
        }

        Invoke-Parallel @splat -ScriptBlock {
        
            $computer = $_.trim()
            $detail = $parameter[0]
            $quiet = $parameter[1]

            #They want detail, define and run test-server
            if($detail)
            {
                Try
                {
                    #Modification of jrich's Test-Server function: https://gallery.technet.microsoft.com/scriptcenter/Powershell-Test-Server-e0cdea9a
                    Function Test-Server{
                        [cmdletBinding()]
                        param(
	                        [parameter(
                                Mandatory=$true,
                                ValueFromPipeline=$true)]
	                        [string[]]$ComputerName,
                            [switch]$All,
                            [parameter(Mandatory=$false)]
	                        [switch]$CredSSP,
                            [switch]$RemoteReg,
                            [switch]$RDP,
                            [switch]$RPC,
                            [switch]$SMB,
                            [switch]$WSMAN,
                            [switch]$IPV6,
	                        [Management.Automation.PSCredential]$Credential
                        )
                            begin
                            {
	                            $total = Get-Date
	                            $results = @()
	                            if($credssp -and -not $Credential)
                                {
                                    Throw "Must supply Credentials with CredSSP test"
                                }

                                [string[]]$props = write-output Name, IP, Domain, Ping, WSMAN, CredSSP, RemoteReg, RPC, RDP, SMB

                                #Hash table to create PSObjects later, compatible with ps2...
                                $Hash = @{}
                                foreach($prop in $props)
                                {
                                    $Hash.Add($prop,$null)
                                }

                                function Test-Port{
                                    [cmdletbinding()]
                                    Param(
                                        [string]$srv,
                                        $port=135,
                                        $timeout=3000
                                    )
                                    $ErrorActionPreference = "SilentlyContinue"
                                    $tcpclient = new-Object system.Net.Sockets.TcpClient
                                    $iar = $tcpclient.BeginConnect($srv,$port,$null,$null)
                                    $wait = $iar.AsyncWaitHandle.WaitOne($timeout,$false)
                                    if(-not $wait)
                                    {
                                        $tcpclient.Close()
                                        Write-Verbose "Connection Timeout to $srv`:$port"
                                        $false
                                    }
                                    else
                                    {
                                        Try
                                        {
                                            $tcpclient.EndConnect($iar) | out-Null
                                            $true
                                        }
                                        Catch
                                        {
                                            write-verbose "Error for $srv`:$port`: $_"
                                            $false
                                        }
                                        $tcpclient.Close()
                                    }
                                }
                            }

                            process
                            {
                                foreach($name in $computername)
                                {
	                                $dt = $cdt= Get-Date
	                                Write-verbose "Testing: $Name"
	                                $failed = 0
	                                try{
	                                    $DNSEntity = [Net.Dns]::GetHostEntry($name)
	                                    $domain = ($DNSEntity.hostname).replace("$name.","")
	                                    $ips = $DNSEntity.AddressList | %{
                                            if(-not ( -not $IPV6 -and $_.AddressFamily -like "InterNetworkV6" ))
                                            {
                                                $_.IPAddressToString
                                            }
                                        }
	                                }
	                                catch
	                                {
		                                $rst = New-Object -TypeName PSObject -Property $Hash | Select -Property $props
		                                $rst.name = $name
		                                $results += $rst
		                                $failed = 1
	                                }
	                                Write-verbose "DNS:  $((New-TimeSpan $dt ($dt = get-date)).totalseconds)"
	                                if($failed -eq 0){
	                                    foreach($ip in $ips)
	                                    {
	    
		                                    $rst = New-Object -TypeName PSObject -Property $Hash | Select -Property $props
	                                        $rst.name = $name
		                                    $rst.ip = $ip
		                                    $rst.domain = $domain
		            
                                            if($RDP -or $All)
                                            {
                                                ####RDP Check (firewall may block rest so do before ping
		                                        try{
                                                    $socket = New-Object Net.Sockets.TcpClient($name, 3389) -ErrorAction stop
		                                            if($socket -eq $null)
		                                            {
			                                            $rst.RDP = $false
		                                            }
		                                            else
		                                            {
			                                            $rst.RDP = $true
			                                            $socket.close()
		                                            }
                                                }
                                                catch
                                                {
                                                    $rst.RDP = $false
                                                    Write-Verbose "Error testing RDP: $_"
                                                }
                                            }
		                                Write-verbose "RDP:  $((New-TimeSpan $dt ($dt = get-date)).totalseconds)"
                                        #########ping
	                                    if(test-connection $ip -count 2 -Quiet)
	                                    {
	                                        Write-verbose "PING:  $((New-TimeSpan $dt ($dt = get-date)).totalseconds)"
			                                $rst.ping = $true
			    
                                            if($WSMAN -or $All)
                                            {
                                                try{############wsman
				                                    Test-WSMan $ip -ErrorAction stop | Out-Null
				                                    $rst.WSMAN = $true
				                                }
			                                    catch
				                                {
                                                    $rst.WSMAN = $false
                                                    Write-Verbose "Error testing WSMAN: $_"
                                                }
				                                Write-verbose "WSMAN:  $((New-TimeSpan $dt ($dt = get-date)).totalseconds)"
			                                    if($rst.WSMAN -and $credssp) ########### credssp
			                                    {
				                                    try{
					                                    Test-WSMan $ip -Authentication Credssp -Credential $cred -ErrorAction stop
					                                    $rst.CredSSP = $true
					                                }
				                                    catch
					                                {
                                                        $rst.CredSSP = $false
                                                        Write-Verbose "Error testing CredSSP: $_"
                                                    }
				                                    Write-verbose "CredSSP:  $((New-TimeSpan $dt ($dt = get-date)).totalseconds)"
			                                    }
                                            }
                                            if($RemoteReg -or $All)
                                            {
			                                    try ########remote reg
			                                    {
				                                    [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $ip) | Out-Null
				                                    $rst.remotereg = $true
			                                    }
			                                    catch
				                                {
                                                    $rst.remotereg = $false
                                                    Write-Verbose "Error testing RemoteRegistry: $_"
                                                }
			                                    Write-verbose "remote reg:  $((New-TimeSpan $dt ($dt = get-date)).totalseconds)"
                                            }
                                            if($RPC -or $All)
                                            {
			                                    try ######### wmi
			                                    {	
				                                    $w = [wmi] ''
				                                    $w.psbase.options.timeout = 15000000
				                                    $w.path = "\\$Name\root\cimv2:Win32_ComputerSystem.Name='$Name'"
				                                    $w | select none | Out-Null
				                                    $rst.RPC = $true
			                                    }
			                                    catch
				                                {
                                                    $rst.rpc = $false
                                                    Write-Verbose "Error testing WMI/RPC: $_"
                                                }
			                                    Write-verbose "WMI/RPC:  $((New-TimeSpan $dt ($dt = get-date)).totalseconds)"
                                            }
                                            if($SMB -or $All)
                                            {

                                                #Use set location and resulting errors.  push and pop current location
                    	                        try ######### C$
			                                    {	
                                                    $path = "\\$name\c$"
				                                    Push-Location -Path $path -ErrorAction stop
				                                    $rst.SMB = $true
                                                    Pop-Location
			                                    }
			                                    catch
				                                {
                                                    $rst.SMB = $false
                                                    Write-Verbose "Error testing SMB: $_"
                                                }
			                                    Write-verbose "SMB:  $((New-TimeSpan $dt ($dt = get-date)).totalseconds)"

                                            }
	                                    }
		                                else
		                                {
			                                $rst.ping = $false
			                                $rst.wsman = $false
			                                $rst.credssp = $false
			                                $rst.remotereg = $false
			                                $rst.rpc = $false
                                            $rst.smb = $false
		                                }
		                                $results += $rst	
	                                }
                                }
	                            Write-Verbose "Time for $($Name): $((New-TimeSpan $cdt ($dt)).totalseconds)"
	                            Write-Verbose "----------------------------"
                                }
                            }
                            end
                            {
	                            Write-Verbose "Time for all: $((New-TimeSpan $total ($dt)).totalseconds)"
	                            Write-Verbose "----------------------------"
                                return $results
                            }
                        }
                    
                    #Build up parameters for Test-Server and run it
                        $TestServerParams = @{
                            ComputerName = $Computer
                            ErrorAction = "Stop"
                        }

                        if($detail -eq "*"){
                            $detail = "WSMan","RemoteReg","RPC","RDP","SMB" 
                        }

                        $detail | Select -Unique | Foreach-Object { $TestServerParams.add($_,$True) }
                        Test-Server @TestServerParams | Select -Property $( "Name", "IP", "Domain", "Ping" + $detail )
                }
                Catch
                {
                    Write-Warning "Error with Test-Server: $_"
                }
            }
            #We just want ping output
            else
            {
                Try
                {
                    #Pick out a few properties, add a status label.  If quiet output, just return the address
                    $result = $null
                    if( $result = @( Test-Connection -ComputerName $computer -Count 2 -erroraction Stop ) )
                    {
                        $Output = $result | Select -first 1 -Property Address,
                                                                      IPV4Address,
                                                                      IPV6Address,
                                                                      ResponseTime,
                                                                      @{ label = "STATUS"; expression = {"Responding"} }

                        if( $quiet )
                        {
                            $Output.address
                        }
                        else
                        {
                            $Output
                        }
                    }
                }
                Catch
                {
                    if(-not $quiet)
                    {
                        #Ping failed.  I'm likely making inappropriate assumptions here, let me know if this is the case : )
                        if($_ -match "No such host is known")
                        {
                            $status = "Unknown host"
                        }
                        elseif($_ -match "Error due to lack of resources")
                        {
                            $status = "No Response"
                        }
                        else
                        {
                            $status = "Error: $_"
                        }

                        "" | Select -Property @{ label = "Address"; expression = {$computer} },
                                              IPV4Address,
                                              IPV6Address,
                                              ResponseTime,
                                              @{ label = "STATUS"; expression = {$status} }
                    }
                }
            }
        }
    }
}


# ---------------------------------------------------
# Function: checksubnet
# Author: Luben Kirov
# Reference: http://www.gi-architects.co.uk/2016/02/powershell-check-if-ip-or-subnet-matchesfits/
# ---------------------------------------------------
# The function will check ip to ip, ip to subnet, subnet to ip or subnet to subnet belong to each other and return true or false and the direction of the check
#////////////////////////////////////////////////////////////////////////
function checkSubnet ([string]$addr1, [string]$addr2)
{
    # Separate the network address and lenght
    $network1, [int]$subnetlen1 = $addr1.Split('/')
    $network2, [int]$subnetlen2 = $addr2.Split('/')
 
 
    #Convert network address to binary
    [uint32] $unetwork1 = NetworkToBinary $network1
 
    [uint32] $unetwork2 = NetworkToBinary $network2
 
 
    #Check if subnet length exists and is less then 32(/32 is host, single ip so no calculation needed) if so convert to binary
    if($subnetlen1 -lt 32){
        [uint32] $mask1 = SubToBinary $subnetlen1
    }
 
    if($subnetlen2 -lt 32){
        [uint32] $mask2 = SubToBinary $subnetlen2
    }
 
    #Compare the results
    if($mask1 -and $mask2){
        # If both inputs are subnets check which is smaller and check if it belongs in the larger one
        if($mask1 -lt $mask2){
            return CheckSubnetToNetwork $unetwork1 $mask1 $unetwork2
        }else{
            return CheckNetworkToSubnet $unetwork2 $mask2 $unetwork1
        }
    }ElseIf($mask1){
        # If second input is address and first input is subnet check if it belongs
        return CheckSubnetToNetwork $unetwork1 $mask1 $unetwork2
    }ElseIf($mask2){
        # If first input is address and second input is subnet check if it belongs
        return CheckNetworkToSubnet $unetwork2 $mask2 $unetwork1
    }Else{
        # If both inputs are ip check if they match
        CheckNetworkToNetwork $unetwork1 $unetwork2
    }
}
 
function CheckNetworkToSubnet ([uint32]$un2, [uint32]$ma2, [uint32]$un1)
{
    $ReturnArray = "" | Select-Object -Property Condition,Direction
 
    if($un2 -eq ($ma2 -band $un1)){
        $ReturnArray.Condition = $True
        $ReturnArray.Direction = "Addr1ToAddr2"
        return $ReturnArray
    }else{
        $ReturnArray.Condition = $False
        $ReturnArray.Direction = "Addr1ToAddr2"
        return $ReturnArray
    }
}
 
function CheckSubnetToNetwork ([uint32]$un1, [uint32]$ma1, [uint32]$un2)
{
    $ReturnArray = "" | Select-Object -Property Condition,Direction
 
    if($un1 -eq ($ma1 -band $un2)){
        $ReturnArray.Condition = $True
        $ReturnArray.Direction = "Addr2ToAddr1"
        return $ReturnArray
    }else{
        $ReturnArray.Condition = $False
        $ReturnArray.Direction = "Addr2ToAddr1"
        return $ReturnArray
    }
}
 
function CheckNetworkToNetwork ([uint32]$un1, [uint32]$un2)
{
    $ReturnArray = "" | Select-Object -Property Condition,Direction
 
    if($un1 -eq $un2){
        $ReturnArray.Condition = $True
        $ReturnArray.Direction = "Addr1ToAddr2"
        return $ReturnArray
    }else{
        $ReturnArray.Condition = $False
        $ReturnArray.Direction = "Addr1ToAddr2"
        return $ReturnArray
    }
}
 
function SubToBinary ([int]$sub)
{
    return ((-bnot [uint32]0) -shl (32 - $sub))
}
 
function NetworkToBinary ($network)
{
    $a = [uint32[]]$network.split('.')
    return ($a[0] -shl 24) + ($a[1] -shl 16) + ($a[2] -shl 8) + $a[3]
}

# Function to parse AD domain from FQDN
function Get-ADDomainFromFQDN {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FQDN
    )

    # Split the FQDN by '.' and remove the first element (hostname)
    $parts = $FQDN.Split('.')
    $domainParts = $parts[1..($parts.Length - 1)]

    # Join the remaining parts to form the domain
    $domain = ($domainParts -join '.')
    return $domain
}
