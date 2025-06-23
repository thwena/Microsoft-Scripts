#Jonathan Swena
#7/14/2022
#INSTRUCTIONS

#Connect-ExchangeOnline
$Username = #Put email address for connection here.
$PWord = ConvertTo-SecureString -String <#place the password here withing quotes#> -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $PWord
Connect-ExchangeOnline -Credential $Credential 
#Connect-IPPSSession -Credential $Credential


#CSV Files Location
$CSVPath = #location of the csv file for updating the distribution groups.

#OptOut File
$DGP2OptOut = #used specifically for people who opted out of one of the distribution group2 since that group is driven by list for group1

#Volunteers
$Volunteer = #special list that gets updated manually instead of automatically.

$Term = #defining which list to grab incase of delayed update.

#DistributionGroup
$DGP1 = "DGP1Name"
$DGP2 = "DGP2Name"
$DGP3 = "DGP3Name"
$DGP4 = "DGP4Name"
$DGP5 =  "DGP5Name"
$DGP6 = "DGP6Name"
$DGP7 = "DGP7Name"
$DGP8 = "DGP8Name"
$DGP9 = "DGP9Name"
$DGP10 = "DGP10Name"

#CSV File Location
$DGP1CSV = Get-Item -Path "$CSVPath\*DGP1Name*$(get-date -f yyyy-MM-dd).csv"
$DGP2CSV = Get-Item -Path "$CSVPath\*DGP2Name*$(get-date -f yyyy-MM-dd).csv"
$DGP3CSV = Get-Item -Path "$CSVPath\*DGP3Name*$(get-date -f yyyy-MM-dd).csv"
$DGP4CSV = Get-Item -Path "$CSVPath\*DGP4Name*$(get-date -f yyyy-MM-dd).csv"
$DGP5CSV = Get-Item -Path "$CSVPath\*DGP5Name*$(get-date -f yyyy-MM-dd).csv"
$DGP6CSV = Get-Item -Path "$CSVPath\*DGP6Name*$(get-date -f yyyy-MM-dd).csv"
$DGP7CSV = Get-Item -Path "$CSVPath\*DGP7*$(get-date -f yyyy-MM-dd).csv"
$DGP8CSV = Get-Item -Path "$CSVPath\*DGP8*$(get-date -f yyyy-MM-dd).csv"
$DGP9CSV = Get-Item -Path "$CSVPath\*DGP9Name*$(get-date -f yyyy-MM-dd).csv"
$DGP10CSV = Get-Item -Path "$CSVPath\*DGP10Name*$(get-date -f yyyy-MM-dd).csv"

#logFiles Add means added, Rm is removed
$FileLocation = #log file location goes here
$DGP1Add = "$FileLocation\Added $DGP1 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP1Rm = "$FileLocation\Removed $DGP1 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP2Add = "$FileLocation\Added $DGP2 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP2Rm = "$FileLocation\Removed $DGP2 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP3Add = "$FileLocation\Added $DGP3 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP3Rm = "$FileLocation\Removed $DGP3 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP4Add = "$FileLocation\Added $DGP4 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP4Rm = "$FileLocation\Removed $DGP4 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP5Add = "$FileLocation\Added $DGP5 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP5Rm = "$FileLocation\Removed $DGP5 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP6Add = "$FileLocation\Added $DGP6 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP6Rm = "$FileLocation\Removed $DGP6 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP7Add = "$FileLocation\Added $DGP7 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP7Rm = "$FileLocation\Removed $DGP7 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP8Add = "$FileLocation\Added $DGP8 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP8Rm = "$FileLocation\Removed $DGP8 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP9Add = "$FileLocation\Added $DGP9 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP9Rm = "$FileLocation\Removed $DGP9 $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

$DGP10Add = "$FileLocation\Added $DGP10Name $(get-date -f yyyy-MM-dd_hh_mm_ss).log"
$DGP10Rm = "$FileLocation\Removed $DGP10Name $(get-date -f yyyy-MM-dd_hh_mm_ss).log"

#Creates Log files
Out-File $DGP1Add
Out-File $DGP1Rm
Out-File $DGP2Add
Out-File $DGP2Rm
Out-File $DGP3Add
Out-File $DGP3Rm
Out-File $DGP4Add
Out-File $DGP4Rm 
Out-File $DGP5Add
Out-File $DGP5Rm
Out-File $DGP6Add
Out-File $DGP6Rm

Out-File $DGP7Add
Out-File $DGP7Rm
Out-File $DGP8Add
Out-File $DGP8Rm

Out-File $DGP9Add
Out-File $DGP9Rm

Out-File $DGP10Add
Out-File $DGP10Rm


#ALSO DOES DGP2 AT THE MOMENT
#DGP1Name Group
if(Test-Path "$CSVPath\*DGP1Name*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP1NameCurrentList = Get-DistributionGroupMember -Identity $DGP1 -ResultSize Unlimited
    $DGP1NameCurrentList = $DGP1NameCurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP1NameCurrentList = $DGP1NameCurrentList | ForEach{$_+<# Email Domain for comaprison #>}
    

    #Gets Users from CSV
    $DGP1NameCSVList = import-csv $DGP1CSV

    #Isolates Email Address from Title
    $DGP1NameCSVList = $DGP1NameCSVList | ForEach{$_."x_emails.int_email"}

    #If Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP1NameCurrentList | ForEach {
        if($DGP1NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP1 -Member $_ -Confirm:$False
            Add-Content $DGP1Rm $_
            Remove-DistributionGroupMember -Identity $DGP2 -Member $_ -Confirm:$False
            Add-Content $DGP2Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP1NameCSVList | ForEach{
        if($DGP1NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP1 -Member $_ -Confirm:$False
            Add-Content $DGP1Add $_
            Add-DistributionGroupMember -Identity $DGP2 -Member $_ -Confirm:$False
            Add-Content $DGP2Add $_
        }
    }

    #Adds users back into classified
    #Gets Current Users
    #Gets Current Users
    $DGP2NameCurrentList = Get-DistributionGroupMember -Identity $DGP2
    $DGP2NameCurrentList = $DGP2NameCurrentList | ForEach{$_.Alias}

    #Adds <# Email domain for comparison #> to usernames
    $DGP2NameCurrentList = $DGP2NameCurrentList | ForEach{$_+<# Email Domain for comparison #>}
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP1NameCSVList | ForEach{
        if($DGP2NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP2 -Member $_ -Confirm:$False
            Add-Content $DGP2Add $_
        }
    }




    Rename-Item -Path $DGP1CSV -NewName "DGP1NameDone $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"
} else {
     Send-MailMessage -SMTPServer <#Put email server here for email notifications#> -To <#Put who the email is being sent to here#> -From <#Who to appear to be from#> -Subject "DGP1Name Distribution Group" -Body "csv for DGP1 is missing"
}



<#DGP2Name Group
if(Test-Path "$CSVPath\*DGP2Name*$Term*.csv"){
    #Gets Current Users
    $DGP2NameCurrentList = Get-DistributionGroupMember -Identity $DGP2
    $DGP2NameCurrentList = $DGP2NameCurrentList | ForEach{$_.Alias}

    #Adds Email domain for comparison to usernames
    $DGP2NameCurrentList = $DGP2NameCurrentList | ForEach{$_+"Email Domain for comparison"}

    #Gets Users from CSV
    $DGP2NameCSVList = import-csv $DGP2CSV

    #Isolates Email Address from Title
    $DGP2NameCSVList = $DGP2NameCSVList | ForEach{$_."x_emails.int_email"}

    #Iff Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP2NameCurrentList | ForEach {
        if($DGP2NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP2 -Member $_ -Confirm:$False
            Add-Content $DGP2Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP2NameCSVList | ForEach{
        if($DGP2NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP2 -Member $_ -Confirm:$False
            Add-Content $DGP2Add $_
        }
    }
    Rename-Item -Path $DGP2CSV -NewName "DGP2NameDone $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"
}
#>

#Remove OptOut
#

$OptOut = import-csv $DGP2OptOut
$OptOut = $OptOut | ForEach {$_.Email}
$OptOut | ForEach {
    Remove-DistributionGroupMember -Identity $DGP2 -Member $_ -Confirm:$False
    Add-Content $DGP2Rm $_
}
#>

#DGP3Name
if(Test-Path "$CSVPath\*DGP3Name*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP3NameCurrentList = Get-DistributionGroupMember -Identity $DGP3 -ResultSize Unlimited
    $DGP3NameCurrentList = $DGP3NameCurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP3NameCurrentList = $DGP3NameCurrentList | ForEach{$_+<# Email domain for comparison #>}
    

    #Gets Users from CSV
    $DGP3NameCSVList = import-csv $DGP3CSV

    #Isolates Email Address from Title
    $DGP3NameCSVList = $DGP3NameCSVList | ForEach{$_."x_emails.int_email"}

    #Iff Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP3NameCurrentList | ForEach {
        if($DGP3NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP3 -Member $_ -Confirm:$False
            Add-Content $DGP3Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP3NameCSVList | ForEach{
        if($DGP3NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP3 -Member $_ -Confirm:$False
            Add-Content $DGP3Add $_
        }
    }
    <# this force adds someone to distribution group that is not in the csv can be done for all groups
    Add-DistributionGroupMember -Identity $DGP6 -Member [Email here] -Confirm:$False
    #>
    Rename-Item -Path $DGP3CSV -NewName "DGP3NameDone $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"
} else {
    Send-MailMessage -SMTPServer <# email server responsible for sending email #> -To <# email address to receive alerts #> -From <# email address to be sent from #> -Subject "DGP3Name Distribution Group" -Body "csv for the DGP3Name distribution group is missing"
}

#Allstudents
if(Test-Path "$CSVPath\*DGP4Name*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP4NameCurrentList = Get-DistributionGroupMember -Identity $DGP4 -ResultSize Unlimited
    $DGP4NameCurrentList = $DGP4NameCurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP4NameCurrentList = $DGP4NameCurrentList | ForEach{$_+<# Email domain for comparison #>}
    

    #Gets Users from CSV
    $DGP4NameCSVList = import-csv $DGP4CSV

    #Isolates Email Address from Title
    $DGP4NameCSVList = $DGP4NameCSVList | ForEach{$_.email}

    #Iff Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP4NameCurrentList | ForEach {
        if($DGP4NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP4 -Member $_ -Confirm:$False
            Add-Content $DGP4Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP4NameCSVList | ForEach{
        if($DGP4NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP4 -Member $_ -Confirm:$False
            Add-Content $DGP4Add $_
        }
    }
    
    

    Rename-Item -Path $DGP4CSV -NewName "DGP4NameDone $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"
} else {
    Send-MailMessage -SMTPServer <# email server responsible for sending email #> -To <# email address to receive alerts #> -From <# email address to be sent from #> -Subject "DGP4Name Distribution Group" -Body "csv for the DGP4Name distribution group is missing"
}

#Online Students
if(Test-Path "$CSVPath\*DGP5Name*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP5NameCurrentList = Get-DistributionGroupMember -Identity $DGP5 -ResultSize Unlimited
    $DGP5NameCurrentList = $DGP5NameCurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP5NameCurrentList = $DGP5NameCurrentList | ForEach{$_+<# Email domain for comparison #>}
    

    #Gets Users from CSV
    $DGP5NameCSVList = import-csv $DGP5CSV

    #Isolates Email Address from Title
    $DGP5NameCSVList = $DGP5NameCSVList | ForEach{$_.email}

    #Iff Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP5NameCurrentList | ForEach {
        if($DGP5NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP5 -Member $_ -Confirm:$False
            Add-Content $DGP5Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP5NameCSVList | ForEach{
        if($DGP5NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP5 -Member $_ -Confirm:$False
            Add-Content $DGP5Add $_
        }
    }
    
    

    Rename-Item -Path $DGP5CSV -NewName "DGP5NameDone $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"
} else {
    Send-MailMessage -SMTPServer <# email server responsible for sending email #> -To <# email address to receive alerts #> -From <# email address to be sent from #> -Subject "DGP5Name Distribution Group" -Body "csv for the DGP5Name distribution group is missing"
}

#DGP6Name
if(Test-Path "$CSVPath\*DGP6Name*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP6NameCurrentList = Get-DistributionGroupMember -Identity $DGP6 -ResultSize Unlimited
    $DGP6NameCurrentList = $DGP6NameCurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP6NameCurrentList = $DGP6NameCurrentList | ForEach{$_+<# Email domain for comparison #>}
    

    #Gets Users from CSV
    $DGP6NameCSVList = import-csv $DGP6CSV

    #Isolates Email Address from Title
    $DGP6NameCSVList = $DGP6NameCSVList | ForEach{$_."x_emails.int_email"}

    #Iff Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP6NameCurrentList | ForEach {
        if($DGP6NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP6 -Member $_ -Confirm:$False
            Add-Content $DGP6Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP6NameCSVList | ForEach{
        if($DGP6NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP6 -Member $_ -Confirm:$False
            Add-Content $DGP6Add $_
        }
    }
    Rename-Item -Path $DGP6CSV -NewName "DGP6NameDone $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"


} else {
    Send-MailMessage -SMTPServer <# email server responsible for sending email #> -To <# email address to receive alerts #> -From <# email address to be sent from #> -Subject "DGP6Name Distribution Group" -Body "csv for the DGP6Name distribution group is missing"
}

#DGP7
if(Test-Path "$CSVPath\*DGP7*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP7NameCurrentList = Get-DistributionGroupMember -Identity $DGP7 -ResultSize Unlimited
    $DGP7NameCurrentList = $DGP7NameCurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP7NameCurrentList = $DGP7NameCurrentList | ForEach{$_+<# Email domain for comparison #>}
    

    #Gets Users from CSV
    $DGP7NameCSVList = import-csv $DGP7CSV

    #Isolates Email Address from Title
    $DGP7NameCSVList = $DGP7NameCSVList | ForEach{$_."x_emails.int_email"}

    #Iff Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP7NameCurrentList | ForEach {
        if($DGP7NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP7 -Member $_ -Confirm:$False
            Add-Content $DGP7Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP7NameCSVList | ForEach{
        if($DGP7NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP7 -Member $_ -Confirm:$False
            Add-Content $DGP7Add $_
        }
    }
    Rename-Item -Path $DGP7CSV -NewName "DGP7NameDone $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"


} else {
    Send-MailMessage -SMTPServer <# email server responsible for sending email #> -To <# email address to receive alerts #> -From <# email address to be sent from #> -Subject "DGP7 Distribution Group" -Body "csv for the DGP7 distribution group is missing"
}

#DGP8
if(Test-Path "$CSVPath\*DGP8*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP8NameCurrentList = Get-DistributionGroupMember -Identity $DGP8 -ResultSize Unlimited
    $DGP8NameCurrentList = $DGP8NameCurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP8NameCurrentList = $DGP8NameCurrentList | ForEach{$_+<# Email domain for comparison #>}
    

    #Gets Users from CSV
    $DGP8NameCSVList = import-csv $DGP8CSV

    #Isolates Email Address from Title
    $DGP8NameCSVList = $DGP8NameCSVList | ForEach{$_."x_emails.int_email"}

    #Iff Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP8NameCurrentList | ForEach {
        if($DGP8NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP8 -Member $_ -Confirm:$False
            Add-Content $DGP8Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP8NameCSVList | ForEach{
        if($DGP8NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP8 -Member $_ -Confirm:$False
            Add-Content $DGP8Add $_
        }
    }
    Rename-Item -Path $DGP8CSV -NewName "DGP8NameDone $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"

    
    

} else {
    Send-MailMessage -SMTPServer <# email server responsible for sending email #> -To <# email address to receive alerts #> -From <# email address to be sent from #> -Subject "DGP8 Distribution Group" -Body "csv for the DGP8Name distribution group is missing"
}


#DGP9Name
if(Test-Path "$CSVPath\*DGP9Name*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP9NameCurrentList = Get-DistributionGroupMember -Identity $DGP9 -ResultSize Unlimited
    $DGP9NameCurrentList = $DGP9NameCurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP9NameCurrentList = $DGP9NameCurrentList | ForEach{$_+<# Email domain for comparison #>}
    

    #Gets Users from CSV
    $DGP9NameCSVList = import-csv $DGP9CSV

    #Isolates Email Address from Title
    $DGP9NameCSVList = $DGP9NameCSVList | ForEach{$_.email}

    #If Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP9NameCurrentList | ForEach {
        if($DGP9NameCSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP9 -Member $_ -Confirm:$False
            Add-Content $DGP9Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP9NameCSVList | ForEach{
        if($DGP9NameCurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP9 -Member $_ -Confirm:$False
            Add-Content $DGP9Add $_
        }
    }
    Rename-Item -Path $DGP9CSV -NewName "DGP9Name Done $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"

    
    

} else {
    Send-MailMessage -SMTPServer <# email server responsible for sending email #> -To <# email address to receive alerts #> -From <# email address to be sent from #> -Subject "DGP9Name Distribution Group" -Body "csv for the DGP9Name distribution group is missing"
}



$Volunteers = import-csv $Volunteer
$Volunteers = $Volunteers | ForEach {$_.Email}
$Volunteers | ForEach {
    Add-DistributionGroupMember -Identity $DGP1 -Member $_ -Confirm:$False
    Add-DistributionGroupMember -Identity $DGP2 -Member $_ -Confirm:$False
    Add-DistributionGroupMember -Identity $DGP6 -Member $_ -Confirm:$False
    Add-DistributionGroupMember -Identity $DGP7 -Member $_ -Confirm:$False
    Add-Content $DGP1Add $_
    Add-Content $DGP2Add $_
    Add-Content $DGP6Add $_
    Add-Content $DGP7Add $_
}

#DGP10Name
if(Test-Path "$CSVPath\*DGP10Name*$(get-date -f yyyy-MM-dd).csv"){
    #Gets Current Users
    $DGP10CurrentList = Get-DistributionGroupMember -Identity $DGP10Name -ResultSize Unlimited
    $DGP10CurrentList = $DGP10CurrentList | ForEach{$_.Alias}
    
    #Adds <# Email domain for comparison #> to usernames
    $DGP10CurrentList = $DGP10CurrentList | ForEach{$_+<# Email domain for comparison #>}
    

    #Gets Users from CSV
    $DGP10CSVList = import-csv $DGP10CSV

    #Isolates Email Address from Title
    $DGP10CSVList = $DGP10CSVList | ForEach{$_.<#field in csv needed#>}

    #Iff Current group Member isnt in the new list
    #they get removed form Distribution List
    $DGP10CurrentList | ForEach {
        if($DGP10CSVList -notcontains $_){
            Remove-DistributionGroupMember -Identity $DGP10Name -Member $_ -Confirm:$False
            Add-Content $DGP10Rm $_
        }
    }
    #Add User from CSV if they aren't already in the Distribution Group
    $DGP10CSVList | ForEach{
        if($DGP10CurrentList -notcontains $_){
            Add-DistributionGroupMember -Identity $DGP10Name -Member $_ -Confirm:$False
            Add-Content $DGP10Add $_
        }
    }

    Rename-Item -Path $DGP10CSV -NewName "DGP10Done $(get-date -f yyyy-MM-dd_hh_mm_ss).csv"
} else {
    Send-MailMessage -SMTPServer <# email server responsible for sending email #> -To <# email address to receive alerts #> -From <# email address to be sent from #> -Subject "DGP10Name Distribution Group" -Body "csv for the DGP10Name distribution group is missing"
}
#>
#Deleting any file in the CSV folder if older than 30 days.
Get-ChildItem –Path  $CSVPath –Recurse | Where-Object { $_.CreationTime –lt (Get-Date).AddDays(-30) } | Remove-Item

disconnect-exchangeonline -Confirm:$false