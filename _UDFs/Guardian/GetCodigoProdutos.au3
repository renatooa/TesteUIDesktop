#cs ===============================================================================================================================
	Típo de Script .: (Script de Função - UDF, Script Execução de Teste, Script de Constantes, Script de Includes)
	Descrição ......:
	Data Inicio ....:
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1)             ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100)            ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

;#include-once
#include <Debug.au3>
#include <Date.au3>
#include <MsgBoxConstants.au3>

#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS

$sUsername = "root"
$sPassword = "@kalunga123"
$sDatabase = "dental"

$str = ""
$resultado = ""

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

GetArrayCodigoProdutosParaVenda()


#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES


Func GetArrayCodigoProdutosParaVenda()

	$mySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase)

	$select = "Select pro_codigo From produto"

	$resultado = _Query($mySqlConn, $select)

	if(IsObj($resultado)) Then

		With $resultado
			While Not .EOF
				$str = $str & .Fields("pro_codigo").Value & "|"
				.MoveNext
			WEnd
		EndWith

	EndIf

	; TESTE
	$aStr = StringSplit($str, "|")
	$str = ""	
	For $i = 1 To 10 Step +1
		$str = $str & $aStr[$i]	& @CR	
	Next
	ConsoleWrite("TOTAL DE PRODUTOS -> " & $aStr[0] & @CR & $str)
	; EndTeste

	Return $aStr

EndFunc

#EndRegion ### FUNÇÕES