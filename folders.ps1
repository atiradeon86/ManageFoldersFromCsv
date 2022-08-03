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
  Version:        0.3 Beta
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

    #Remove
    if ($cmd -eq "Remove") {

        $folderList | ForEach-Object {
          
            $CurrentFolder = $_.Name
            #InitialPath parameter check
            if ($InitialPath -ne "") {
                #If InitialPath paramter -> Join
                $CurrentFolder = Join-Path -Path "$InitialPath" -ChildPath "$CurrentFolder"
            } 
            Remove-Item -Recurse -Path $CurrentFolder  
        }
        
    }  
    #Create
    elseif ($cmd -eq "Create") {

    $folderList | ForEach-Object {
        $CurrentFolder = $_.Name
        #InitialPath parameter check
        if ($InitialPath -ne "") {
            #If InitialPath paramter -> Join 
            $CurrentFolder = Join-Path -Path "$InitialPath" -ChildPath "$CurrentFolder"
        } 
        New-Item -Path $CurrentFolder  -ItemType Directory
    }
   }    

}

#-----------------------------------------------------------[Finish up]------------------------------------------------------------

END {


}

}
