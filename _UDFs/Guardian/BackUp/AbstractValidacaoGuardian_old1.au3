#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o - UDF
	Descri��o ......: UDF Abstract com fun��es comuns para valida��es no Space Guardian
	Data Inicio ....: 12/05/2016
	Data Termino ...: ~
	Vers�o .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES / OPS

Opt("TrayIconDebug", 1)             ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100)            ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.

#include-once

#EndRegion ###	INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#Region ### FUN��ES
 
Func TelaExiste($sTextoTela, $sSendKey = "{ENTER}", $iSleepDelay = 200)
	
	Sleep($iSleepDelay)
	$iResultado = WinExists("", $sTextoTela)
	
	If ( $iResultado ) Then
		WinActivate("", $sTextoTela)
		Send($sSendKey)
		return true
	Else
		return false	
	EndIf

EndFunc

#EndRegion ### FUN��ES