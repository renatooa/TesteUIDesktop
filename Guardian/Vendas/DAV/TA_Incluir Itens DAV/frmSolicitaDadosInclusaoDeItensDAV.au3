#cs ===============================================================================================================================
    Típo de Script .: Script de View - Formulário KodaForm
    Descrição ......: Formulário de Solicitação de Dados para Inclusão de Itens no
    Data Inicio ....: 26/07/2016
    Data Termino ...: 26/07/2016
    Versão .........: 001
    Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS

Global $txtUpDownQtdeProdutos = ""
Global $txtUserDB = ""
Global $cbxHostDB = ""
Global $cbxSenhaDB = ""
Global $cbxDataBase = ""
Global $btnOK = ""
Global $btnCancelar = ""

#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func FrmSolicitaDadosInclusaoDeItensDAV()

	#Region ### START Koda GUI section ### Form=D:\Testes-Automatizados\TesteUIDesktop\_temp\form\frmSolicitaDadosInclusaoDeItensDAV.kxf
	$frmSolicitaDadosInclusaoDeItensDAV = GUICreate("Solicita Dados Inclusao de Itens DAV", 322, 219, -1, -1, BitOR($WS_SYSMENU,$WS_POPUP,$DS_MODALFRAME), BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
	GUISetBkColor(0xC0DCC0)
	$GroupBox1 = GUICtrlCreateGroup("", 8, 1, 305, 177)
	$txtUpDownQtdeProdutos = GUICtrlCreateInput("1", 232, 16, 66, 21)
	GUICtrlSetLimit(-1, 5)
	$updQtdeProduto = GUICtrlCreateUpdown($txtUpDownQtdeProdutos)
	GUICtrlSetLimit(-1, 1000, 1)
	$lblUserDB = GUICtrlCreateLabel("User DB.:", 24, 56, 59, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$txtUserDB = GUICtrlCreateInput("root", 96, 48, 65, 21)
	$lblQtdeProdutos = GUICtrlCreateLabel("Quantidade de Itens para inclusão.:", 24, 23, 207, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")	
	$lblHostDB = GUICtrlCreateLabel("Host DB.:", 24, 87, 59, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$cbxHostDB = GUICtrlCreateCombo("", 96, 80, 81, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "localhost|192.168.0.6|192.168.0.14", "localhost")
	$lblSenhaDB = GUICtrlCreateLabel("Senha DB.:", 24, 119, 69, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$cbxSenhaDB = GUICtrlCreateCombo("", 96, 113, 129, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "@k*********123|@s****************123", "@k*********123")
	GUICtrlSetTip(-1, "Selecione uma senha para carregar os databases!")
	$cbxDataBase = GUICtrlCreateCombo("", 96, 142, 81, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetState(-1, $GUI_DISABLE)
	$lblDataBase = GUICtrlCreateLabel("DataBase.:", 23, 149, 67, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$btnOK = GUICtrlCreateButton("&OK", 158, 186, 75, 25)
	$btnCancelar = GUICtrlCreateButton("&Cancelar", 238, 186, 75, 25)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

EndFunc

Func GetStringDataBases($sUsername, $sPassword, $sHost)

	$sString = ""
	GUICtrlSetData($cbxDataBase, $sString)

	$aDataBases = GetDataBases($sUsername, $sPassword, $sHost)

	For $vElement In GetDataBases($sUsername, $sPassword, $sHost)
		If (VarGetType($vElement) == "String") Then
			$sString = $sString & $vElement & "|"
		EndIf
	Next

	Return $sString

EndFunc   ;==>GetStringDataBases

#EndRegion ### FUNÇÕES