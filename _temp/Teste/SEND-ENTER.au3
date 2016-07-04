$variable = true

While ( $variable )
	
	WinActivate("Error.")
	Sleep(200)
	$variable = ( WinExists("Error.") <> 0) ? true : false
	Send("{ENTER}")

WEnd