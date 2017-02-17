#include <Array.au3>

Local $arr[1][2]

$arr[0][0] = "campo0"
$arr[0][1] = "valor0-1"
;$arr[0][2] = "valor0-2"
; $arr[1][0] = "campo1"
; $arr[1][1] = "valor1-1"
; $arr[1][2] = "valor1-2"

;ConsoleWrite((UBound($arr, $UBOUND_ROWS) - 1))
ConsoleWrite((UBound($arr, $UBOUND_COLUMNS) - 1))


; For $r = 0 To (UBound($arr, $UBOUND_ROWS) - 1)  Step +1

; 	For $c = 0 To (UBound($arr, $UBOUND_COLUMNS) - 1) Step +1
	
; 		ConsoleWrite($r & " - " & $c & @CRLF) 
; 		ConsoleWrite($arr[$r][$c] & @CRLF)
	
; 	Next

; Next


_ArrayDisplay($arr)