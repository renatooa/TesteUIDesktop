#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o - UDF
	Descri��o ......: UDF Abstract com fun��es comuns para acesso as op��es de menus do Space Guardian
	Data Inicio ....: 12/05/2016
	Data Termino ...: ~
	Vers�o .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES / OPS

#include-once

#EndRegion ###	INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#Region ### FUN��ES

Func AbreMenu($sAtalhoExpandir, $sTeclaDeAtalho, $sTeclaDeAcao, $sTextoWinActive)

	Send($sAtalhoExpandir)
	Send($sTeclaDeAtalho & $sTeclaDeAcao)
	WinActive("", $sTextoWinActive)

EndFunc

#EndRegion ### FUN��ES