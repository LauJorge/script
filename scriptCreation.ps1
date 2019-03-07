


#json file needs to be in the same path of the powershell script
$jsonfile = Get-Content -Raw -Path "jsonStructure.json"

$path= (Get-Location).path
$date = $(get-date -f MM-dd-yyyy_HH_mm_ss)

$ErrorOccured = $false

			Write-Host -ForegroundColor Green "
			----------------------------
			`n
			JSON fileee: "$jsonfile"
			`n
			----------------------------
			"
function CreateFolderStructure(){


$structure = ConvertFrom-Json -InputObject $jsonfile

	foreach ($dire in $structure.structure) {
		
		
		$ParentName=$path + "\" + $dire.folderName + $date
		New-Item "$ParentName" -ItemType Directory;	
		setPermissions $ParentName
		
	
		if ($dire.files.Count -gt 0) {
			createFiles $dire.files $ParentName
		}

			
		foreach ($subDirectory in $dire.subFolders) {
		
			$ChildName=$subDirectory.folderName + "-" +$date
			$ChildFullPath= "$ParentName\$ChildName"
			
			Write-Host -ForegroundColor Green "
			----------------------------
			`n
			JSON STRUCTURE: "$ChildFullPath"
			`n
			----------------------------
			"
			
			New-Item -ItemType Directory -Path $ChildFullPath -Force
			setPermissions($ChildFullPath)
			createFiles $subDirectory.files  $ChildFullPath
		}
		
	}
}
function setPermissions($FullPath){
$permission = $directory.permission
$permission = 'Administrator', 'Modify', 'ContainerInherit, ObjectInherit', 'None', 'Allow'
$rule=New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $permission
$acl = Get-Acl -Path $FullPath
$acl.SetAccessRule($rule)
$acl | Set-Acl -Path $FullPath

}


function createFiles($arrayOffiles, $ChildFullPath){
	if($arrayOfFiles.Count -gt 0)	
	{
	
	
	foreach ($file in $arrayOfFiles) {
	

		
		$fileName= $file.fileName + "-" + $date
		$fileFullPath= "$ChildFullPath\$fileName"
		
		Write-Host -ForegroundColor Green "
		----------------------------
		`n
		File path: "$fileFullPath"
		`n
		----------------------------
		"
		
		Copy-Item -Path "testImage.jpg" -Destination $fileFullPath
	}
	}
}

CreateFolderStructure
