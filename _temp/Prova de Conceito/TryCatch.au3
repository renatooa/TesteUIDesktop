#include <Date.au3>
#include <MsgBoxConstants.au3>

While Not @error  ; TRY

Global $matriz[] = [10, "A"]

;$matriz[0] = 1
;$matriz[1] = 2

$msg = MsgBox(0,"2",""& $matriz[0] &" - "& $matriz[1] & " -- " & @ScriptName)
MsgBox($MB_SYSTEMMODAL, "", "Todays date/Time: " & _NowDate())


$result = $matriz[0] * $matriz[1]

If $msg == 1 Then
	Exit
EndIf

WEnd

If @error Then ; CATCH

	MsgBox(0,"","TESTE ERRO!!!")

EndIf





