function AssertAcls{
if(Compare-Object -ReferenceObject $(Get-Acl $fileA| Select-Object -expand Access) -DifferenceObject $(Get-Acl $fileB| Select-Object -expand Access)){"ACLs are different"}Else {"ACLs are the same"}
}

$file1 = $args[0] 
$file2 = $args[1]

AssertAcls $file1 $file2

