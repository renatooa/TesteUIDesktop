#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......:
	Data Inicio ....:
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES / OPS

#include-once
#include <MsgBoxConstants.au3>

#EndRegion ###	INCLUDES / OPS

#Region ### VARIAVEIS


#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema, $sTextoDaTelaPrincipalDoSistema = "")

	$iSistemaAtivo = WinExists($sTituloDaTelaPrincipalDoSistema, $sTextoDaTelaPrincipalDoSistema)

	If $iSistemaAtivo == 0 Then

		MsgBox($MB_ICONWARNING, "Alerta", $sNomeDoSistema & " não foi localizado!")
		Exit

	EndIf

EndFunc   ;==>VerificaSistemaEstaAberto

#EndRegion ### FUNÇÕES
