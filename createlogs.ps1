<#
	.SYPNOPSIS
		This function creates logs files and a
		container folder
			.PARAMETER parent_path
				This parameter indicates the location of the generated files
        
			.PARAMETER get_logs_from
				This parameter indicates the location of the requested folder
        structure
#>

[CmdletBinding()]
param (
        [string]$parent_path,
        [string]$get_logs_from
 )

function get_logs{
    $parent_path = 'C:\AutomationLogs'
    $get_logs_from = '\\?\C:\inject'
	$general_logs = "GeneralLogs.txt"
    $hash_logs ="HashLogs.txt"
    $acl_logs = "PermissionsLogs.txt"

    mkdir $parent_path
    cd $parent_path
    Set-ItemProperty 'HKLM:\System\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -value 1
    cd $get_logs_from
    Set-ItemProperty 'HKLM:\System\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -value 1
    
    Get-ChildItem -LiteralPath $get_logs_from -Recurse -Force | Select-Object -Property * -ExcludeProperty CreationTime, CreationTimeUtc | Out-File $parent_path\$general_logs
    Get-ChildItem -LiteralPath $get_logs_from  -Recurse -Force | Get-FileHash | Out-File $parent_path\$hash_logs
    Get-ChildItem -LiteralPath $get_logs_from  -Recurse -Force | Get-ACL | Out-File $parent_path\$acl_logs
}

get_logs
