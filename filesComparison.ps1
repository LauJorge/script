param(
			[string]$fileA,
			[string]$fileB
		)
		function fileComparation{	
			if(Compare-Object -ReferenceObject $(Get-Content $fileA) -DifferenceObject $(Get-Content $fileB))
				{
				Write-host 'Files are different'
				Compare-Object -ReferenceObject $(Get-Content $fileA) -DifferenceObject $(Get-Content $fileB)
				
				}
				else{
				Write-host 'Files are Equals'
				}
	}
	fileComparation