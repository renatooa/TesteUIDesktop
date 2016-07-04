#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Este Script testa a inclusão e gravação de DAV no Space Guardian
	Data Inicio ....: 18/05/2015
	Data Termino ...: 18/05/2015
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

;************************* VARIAVEIS ***************************

;***************************************************************

MsgBox(0, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
		"Inclusão e Gravação de DAV" & @CR & @CR & "OBS.: O Space Guardian precisa está aberto!")

f_abrirTelaInclusaoDAV()

#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes Automatizados\_temp\form\frmDadosInclusaoDAV.kxf
$frmIncluirDAV = GUICreate("Inclusão de DAV", 367, 263, 582, 128)
$lblNatOper = GUICtrlCreateLabel("Natureza de Operação :", 64, 82, 147, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$lblCodigoCliente = GUICtrlCreateLabel("Código de Cliente :", 64, 114, 117, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$lblCodigoProduto = GUICtrlCreateLabel("Código do Produto :", 64, 146, 123, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$lblQtdeProduto = GUICtrlCreateLabel("Quantidade :", 64, 178, 80, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$btnOk = GUICtrlCreateButton("OK", 139, 224, 75, 25)
GUICtrlSetCursor (-1, 0)
$grpTexto = GUICtrlCreateGroup("", 7, 5, 353, 57)
$lblTexto = GUICtrlCreateLabel("Informe os Dados para Inclusão do DAV", 20, 26, 328, 24)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$txtNatOper = GUICtrlCreateInput("", 218, 80, 81, 24)
GUICtrlSetLimit(-1, 3)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$txtCodCliente = GUICtrlCreateInput("", 219, 121, 81, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NOHIDESEL,$ES_NUMBER))
GUICtrlSetLimit(-1, 100)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$txtCodProd = GUICtrlCreateInput("", 220, 146, 81, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 50)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$txtQtdeProd = GUICtrlCreateInput("", 213, 178, 49, 24, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 50)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg

	Case $btnOk

MouseClick("left", 391, 135, 2)
Sleep(1000)



Sleep(1000)
;Send("{enter 2}")

Send("{ENTER 3}8943{ENTER 9}9991")
Sleep(1000)
Send("{ENTER 4}1{ENTER 4}")
Sleep(1000)
Send("{TAB 10}")
Sleep(500)
Send("{ENTER}{TAB 3}{ENTER}")
WinWaitActive("Atenção", "")
Send("{ENTER}")
WinWaitActive("Space Guardian - Versão", "")
Send("{ESC}")
WinWaitActive("Confirmação", "")
Send("{LEFT}{ENTER}")
;Sleep(3000)
;Send("{ESC}{TAB}{ENTER}")


		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd




;************************* FUNÇÕES *****************************

Func f_informarNaturezaOperacao()

	Local $v_codigoNaturezaOperacao = InputBox("Natureza de Operação", "Informe o código da natureza de operação!")

EndFunc   ;==>f_informarNaturezaOperacao

;***************************************************************
