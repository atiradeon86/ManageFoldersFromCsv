Function ManageFoldersFromCsv {

#Import Example ---> Import-Module -force .\folders.ps1

<#

.SYNOPSIS
  Manage Folder Structure -> based on custom CSV File
.DESCRIPTION
  Create or Remove Folder Structure -> based on custom CSV File
.PARAMETER cmd
  Create -> Create Folder Structure
  Remove -> Remove Folder Structure
.PARAMETER InitialPath
  InitialPath -> Set Initial Path
.NOTES
  Version:        0.02 ALPHA
  Author:         Ati
  Creation Date:  2022.08.03
.EXAMPLE
  ManageFoldersFromCsv -cmd Create
.EXAMPLE
  ManageFoldersFromCsv -cmd Create -InitialPath C:\Example
.EXAMPLE
  ManageFoldersFromCsv -cmd Remove
.EXAMPLE
  ManageFoldersFromCsv -cmd Remove -InitialPath C:\Example
#>

#-----------------------------------------------------------[Parameters]-----------------------------------------------------------

[CmdletBinding()]
param (

    [Parameter(Mandatory=$true,
    HelpMessage="Create, Remove")] 
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


    if ($cmd -eq "Remove") {
        $folderList | ForEach-Object {
            $actual_folder = $_.Name
            if ($InitialPath -ne "") {
                $actual_folder = Join-Path -Path "$InitialPath" -ChildPath "$actual_folder"
                Write-Host $actual_folder
            } 
            Remove-Item -Recurse -Path $actual_folder  
        }
        
    }  elseif ($cmd -eq "Create") {

    $folderList | ForEach-Object {
        $actual_folder = $_.Name
        if ($InitialPath -ne "") {
            $actual_folder = Join-Path -Path "$InitialPath" -ChildPath "$actual_folder"
            Write-Host $actual_folder
        } 
        New-Item -Path $actual_folder  -ItemType Directory
    }
}    


}

#-----------------------------------------------------------[Finish up]------------------------------------------------------------

END {


}

}
