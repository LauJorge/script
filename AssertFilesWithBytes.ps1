function AssertFilesWithBytes {
	param(
     [string]$Filepath1,
     [string]$Filepath2
     )
     if ((Get-FileHash $Filepath1).Hash -eq (Get-FileHash $Filepath2).Hash) {
         Write-Host 'Files Match' -ForegroundColor Green
     } else {
         Write-Host 'Files do not match' -ForegroundColor Red
     }
 }
 
$file1 = $args[0] 
$file2 = $args[1]

AssertFilesWithBytes $file1 $file2