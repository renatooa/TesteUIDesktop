#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o - UDF
	Descri��o ......:
	Data Inicio ....:
	Data Termino ...:
	Vers�o .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES / OPS

#include-once
#include <MsgBoxConstants.au3>

#EndRegion ###	INCLUDES / OPS

#Region ### VARIAVEIS


#EndRegion ### VARIAVEIS

#Region ### FUN��ES

Func VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema, $sTextoDaTelaPrincipalDoSistema = "")

	$iSistemaAtivo = WinExists($sTituloDaTelaPrincipalDoSistema, $sTextoDaTelaPrincipalDoSistema)

	If $iSistemaAtivo == 0 Then

		MsgBox($MB_ICONWARNING, "Alerta", $sNomeDoSistema & " n�o foi localizado!")
		Exit

	EndIf

EndFunc   ;==>VerificaSistemaEstaAberto

#EndRegion ### FUN��ES
