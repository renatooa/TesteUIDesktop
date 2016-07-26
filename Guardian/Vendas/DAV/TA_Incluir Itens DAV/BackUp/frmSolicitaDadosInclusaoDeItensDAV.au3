#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesGuardian.au3"
#include <GuiComboBox.au3>

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=D:\Testes-Automatizados\TesteUIDesktop\_temp\form\frmSolicitaDadosInclusaoDeItensDAV - Copia.kxf
$frmSolicitaCodigo = GUICreate("Solicita Código", 322, 219, -1, -1, BitOR($WS_SYSMENU,$WS_POPUP,$DS_MODALFRAME), BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetBkColor(0xC0DCC0)
$GroupBox1 = GUICtrlCreateGroup("", 8, 1, 305, 177)
$lblUserDB = GUICtrlCreateLabel("User DB.:", 24, 56, 59, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$txtUserDB = GUICtrlCreateInput("root", 96, 48, 65, 21)
$lblQtdeProdutos = GUICtrlCreateLabel("Quantidade de Itens para inclusão.:", 24, 23, 207, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$txtUpDownQtdeProdutos = GUICtrlCreateInput("1", 232, 16, 66, 21)
GUICtrlSetLimit(-1, 5)
$updQtdeProduto = GUICtrlCreateUpdown($txtUpDownQtdeProdutos)
GUICtrlSetLimit(-1, 1000, 1)
$lblSenhaDB = GUICtrlCreateLabel("Senha DB.:", 24, 119, 69, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$lblHostDB = GUICtrlCreateLabel("Host DB.:", 24, 87, 59, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$cbxHostDB = GUICtrlCreateCombo("", 96, 80, 81, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "localhost|192.168.0.6|192.168.0.14", "localhost")
$cbxSenhaDB = GUICtrlCreateCombo("", 96, 113, 129, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "@k*********123|@s****************123", "@k*********123")
$cbxDataBase = GUICtrlCreateCombo("dental", 96, 142, 81, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$lblDataBase = GUICtrlCreateLabel("DataBase.:", 23, 149, 67, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$btnOK = GUICtrlCreateButton("&OK", 158, 186, 75, 25)
$btnCancelar = GUICtrlCreateButton("&Cancelar", 238, 186, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $btnCancelar
			Exit

		Case $cbxHostDB
			GUICtrlSetState( $cbxHostDB, $GUI_DISABLE)

		Case $cbxSenhaDB
			$sUsername = GUICtrlRead($txtUserDB)

			$iIndexResult = _GUICtrlComboBox_GetCurSel($cbxSenhaDB)
			If ( $iIndexResult == 0 ) Then
				$sPassword = "@kalunga123"
			Else
				$sPassword = "@senharootmysql123"			
			EndIf

			$sHost = _GUICtrlComboBox_GetEditText($cbxHostDB)

			$sString = ""
			GUICtrlSetData($cbxDataBase, $sString)

			$aDataBases = GetDataBases($sUsername, $sPassword, $sHost)

			For $vElement In GetDataBases($sUsername, $sPassword, $sHost)
				If ( VarGetType($vElement) == "String" ) Then
					$sString = $sString & $vElement & "|"			
				EndIf	
			Next

			GUICtrlSetData($cbxDataBase, $sString, "dental")
			GUICtrlSetState( $cbxSenhaDB, $GUI_DISABLE)

		Case $btnOK
			GUISetState(@SW_HIDE)
			Exit
			
	EndSwitch
WEnd
