param(
			[string]$path,
			[string]$logFile
		)
		function getLogs{
		
			Get-ChildItem -Path $path -Recurse -Force | get-acl| Get-ItemProperty | Out-File $logFile
			
	}
	getLogs