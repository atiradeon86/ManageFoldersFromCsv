Function ManageFoldersFromCsv {

<#
.SYNOPSIS
  Manage Folder Structure based on CSV File
.DESCRIPTION
  Create or Delete Folder Structure based on custom CSV File
.PARAMETER cmd
  Create -> Create Folder Structure
  Delete -> Delete Folder Structure
.PARAMETER InitialPath
  InitialPath -> Set Initial Directory
.NOTES
  Version:        0.01 ALPHA
  Author:         Ati
  Creation Date:  <Date>
.EXAMPLE
  ManageFoldersFromCsv -cmd Create
.EXAMPLE
  ManageFoldersFromCsv -cmd Delete
#>

#-----------------------------------------------------------[Parameters]-----------------------------------------------------------

[CmdletBinding()]
param (

    [Parameter(Mandatory=$true,
    HelpMessage="Create, Delete")] 
    [string]$cmd,

    [Parameter(Mandatory=$false,
    HelpMessage="InitialPath ")] 
    [string]$InitialPath

)

#----------------------------------------------------------[Declarations]----------------------------------------------------------

BEGIN { 


$csvFile = "users.csv"
    $CsvFile = "folders.csv"
    $folderList = Import-Csv $CsvFile
    
}

#-----------------------------------------------------------[Process]------------------------------------------------------------

PROCESS {


    if ($cmd -eq "Delete") {
        $folderList | ForEach-Object {
            $actual_folder = $_.Name
            Remove-Item -Recurse -Path .\$actual_folder  
        }
        
    }  elseif ($cmd -eq "Create") {

    $folderList | ForEach-Object {
        $actual_folder = $_.Name
        New-Item -Path .\$actual_folder  -ItemType Directory
    }
}    


}

#-----------------------------------------------------------[Finish up]------------------------------------------------------------

END {


}

}
