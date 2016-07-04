;#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\Guardian\ConstantesBotoes.au3"
;#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\Guardian\ConstantesBotoes.au3"
#include <StringConstants.au3>

;$str = StringReplace(@ScriptDir, "\Guardian", "")
$str = StringSplit(@ScriptDir, "\", $STR_ENTIRESPLIT)
;$str = $StringReplace("aaa", "aa", "b")
;ConsoleWrite(@ScriptDir) 

;For $vElement In $str

;	ConsoleWrite($vElement & @CRLF)

;Next
Func GetPastaBase()
	
	$str = StringSplit(@ScriptDir, "\", $STR_ENTIRESPLIT)
	$sPastaBase = ""

	For $i = 1 To UBound($str) Step +1

		$sPastaBase &= $str[$i] & "\"

		If ( $str[$i] == "Testes-Automatizados" ) Then	
			ExitLoop	
		EndIf

	Next	
	return  $sPastaBase

EndFunc

ConsoleWrite(GetPastaBase()) 