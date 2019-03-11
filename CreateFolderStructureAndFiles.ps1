   <#
    This script needs to receive as a parameter the path of the JSON file
    The script reads the JSON and create a folder structure based on the JSON content
    JSON file should have the following structure
    {  
    "structure":{  
      "directory":{  
         "name":"dir",
         "number":1,
         "permission":{  
            "FileSystemAccessRights":"Modify",
            "InheritanceFlags":"ContainerInherit, ObjectInherit",
            "PropagationFlags":"None",
            "AccessControl":"Allow",
            "IdentityReference":"Administrator"
         }
      },
      "subdirectory":{  
         "name":"subdir",
         "number":2,
         "permission":{  
            "FileSystemAccessRights":"Modify",
            "InheritanceFlags":"ContainerInherit, ObjectInherit",
            "PropagationFlags":"None",
            "AccessControl":"Allow",
            "IdentityReference":"Administrator"
         }
      },
      "file":{  
         "name":"file",
         "number":1,
         "maxSize":20000000,
         "permission":{  
            "FileSystemAccessRights":"Modify",
            "AccessControl":"Allow",
            "IdentityReference":"Administrator"
         }
      }
    }
    }
    Attributes:
    number: number of items that you want to create
    #>
    param (
        [string]$jsonPath
    )
    $jsonfile = Get-Content -Raw -Path $jsonPath
    $date = $(get-date -f MM-dd-yyyy_HH_mm_ss)
    $path= (Get-Location).path
    $ErrorOccured = $false
    function CreateFolderStructure(){
    #Read JSON 
    $structure = ConvertFrom-Json -InputObject $jsonfile
    #Get Permissions from the JSON
    $dirPermission=$structure.structure.directory.permission
    $subdirPermission= $structure.structure.subdirectory.permission
    $filePersmission=$structure.structure.file.permission
    for ($dire=0; $dire -lt $structure.structure.directory.number; $dire++) {
            
        $ParentName=$path + "\" + $structure.structure.directory.name+ $((Get-Random 1000000).tostring()) + $date
        New-Item "$ParentName" -ItemType Directory;    
        
        setPermissions $ParentName $dirPermission $False
                    
        for ($subDirectory=0; $subDirectory -lt $structure.structure.subdirectory.number; $subDirectory++) {
        
            $ChildName=$structure.structure.subdirectory.name + $((Get-Random 1000000).tostring()) + $date
            $ChildFullPath= "$ParentName\$ChildName"
            New-Item -ItemType Directory -Path $ChildFullPath -Force
            setPermissions $ChildFullPath $subdirPermission $False
            createFiles $ChildFullPath
        }        
    }
    }
    function setPermissions($FullPath, $permission, $isFile){
    $IdentityReference=$permission.IdentityReference
    $FileSystemAccessRights=$permission.FileSystemAccessRights
    $InheritanceFlags=$permission.InheritanceFlags
    $PropagationFlags=$permission.PropagationFlags
    $AccessControl=$permission.AccessControl
    #If you want to set permissions to Directories and subdirectories $isFile is false
    if($isFile -eq $False){
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(@($IdentityReference), @($FileSystemAccessRights),@($InheritanceFlags),@($PropagationFlags), @($AccessControl))
                    }
    else {
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(@($IdentityReference), @($FileSystemAccessRights), @($AccessControl))
        }
    $acl = Get-Acl -Path $FullPath
    $acl.SetAccessRule($rule)
    $acl | Set-Acl -Path $FullPath
    }
    function createFiles($ChildFullPath){
    for($file=0; $file -lt $structure.structure.file.number;  $file++) {    
            
        $fileName= $structure.structure.file.name + $((Get-Random 1000000).tostring()) + $date
        $maxSize= $file.maxSize
        $fileFullPath= "$ChildFullPath\$fileName"
        $randomSize= Get-Random -Maximum $maxSize -Minimum 1000000
        
        #Files will we created considering as a maximum size the value passed from the JSON
        fsutil file createnew $fileFullPath $randomSize
        setPermissions $fileFullPath $filePersmission $True
    }
    }
    CreateFolderStructure