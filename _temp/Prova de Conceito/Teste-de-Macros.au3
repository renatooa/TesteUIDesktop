
Send("{LCtrl}{lAlt}{del}")

$result = myDiv(5, 0)

$txt = @LogonDomain

Beep(500, 1000)

If @error Then
    MsgBox(4096,"Erro" , "Divisão por Zero - " & @error &@CR&@CR& @ScriptDir _
													    &@CR&@CR& @WorkingDir _
													    &@CR&@CR& @AutoItExe _
													    &@CR&@CR& @DesktopWidth _
														)

   MsgBox(0,"teste",$txt)
Else
   MsgBox(4096, "Resultado", $result &" - "& @error &"  " & @DesktopHeight&"  " & $txt)
EndIf
Exit



Func myDiv($dividend, $divisor)
    If $dividend = 0 And $divisor = 0 Then
   SetError(2) ;forma indeterminada 0/0
    ElseIf $divisor = 0 Then
SetError(1) ; simples divisão por zero
    EndIf
    Return $dividend / $divisor
EndFunc
