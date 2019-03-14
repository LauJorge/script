param(
			[string]$path
		)
		function fileRemove{	
			Remove-Item –path $path –recurse 
	}
fileRemove