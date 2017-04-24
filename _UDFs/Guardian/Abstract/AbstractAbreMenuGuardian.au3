#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF Abstract com funções comuns para acesso as opções de menus do Space Guardian
	Data Inicio ....: 12/05/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES / OPS

#include-once

#EndRegion ###	INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
=	
=	AbreMenu($sAtalhoExpandir, $sTeclaDeAtalho, $sTeclaDeAcao, $sTextoWinActive)
=
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func AbreMenu($sAtalhoExpandir, $sTeclaDeAtalho, $sTeclaDeAcao, $sTextoWinActive)

	Send($sAtalhoExpandir)
	Send($sTeclaDeAtalho & $sTeclaDeAcao)
	WinActive("", $sTextoWinActive)

EndFunc   ;==>AbreMenu

#EndRegion ### FUNÇÕES
