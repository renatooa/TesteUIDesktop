#cs ===============================================================================================================================
	T�po de Script .: (Script de Fun��o, Script Execu��o de Teste)
	Descri��o ......:
	Data Inicio ....: 18/05/2015
	Data Termino ...:
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcBotoesTelaDAV.au3"

;			 -----------  FIM INCLUDES  ----------

#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes Automatizados\_temp\form\frmDadosAlteracaoDAV.kxf
$frmIncluirDAV = GUICreate("Inclus�o de DAV", 367, 179, 582, 128, -1, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
$lblQtdeProduto = GUICtrlCreateLabel("Quantidade do Produto :", 78, 98, 149, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$btnOk = GUICtrlCreateButton("OK", 152, 136, 75, 25)
GUICtrlSetCursor (-1, 0)
$grpTexto = GUICtrlCreateGroup("", 7, 5, 353, 57)
$lblTexto = GUICtrlCreateLabel("Informe os Dados para Altera��o do DAV", 20, 26, 337, 24)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$txtQtdeProd = GUICtrlCreateInput("", 234, 96, 49, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 50)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg

	Case $btnOk

		 MsgBox(0, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
		"Altera��o e Grava��o de DAV" & @CR & @CR & "OBS.: O Space Guardian precisa est� aberto!")

		 f_abrirTelaAlteracaoComItemDAV()

		 MouseClick("left", 314, 354, 2)
		 MouseClick("left", 1007, 417, 1)
		 Send($txtQtdeProd & "{ENTER 3}")
		 WinWaitActive("Confirma��o")
		 Send("{ENTER}")
		 MouseClick("left", 899, 618, 1)

		 Exit
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd





