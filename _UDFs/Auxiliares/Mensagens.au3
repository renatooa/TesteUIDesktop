#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF para conter mensagens genericas
	Data Inicio ....: 07/04/2016
	Data Termino ...: 07/04/2016
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once
#include "..\IncludesAuxiliares.au3"
#include <MsgBoxConstants.au3>

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#EndRegion ### INCLUDES / OPS

#cs FUNÇÕES DA UDF ================================================================================================================
=
=	ExibeMensagemPadrao($sTestesExecutados, $sInformacoesAdicionais = "")
=	GetSolicitaCodigo($sTextoMensagem = "INFORME UM CÓDIGO DE...")
=	GetSolicitaNaturezaOperacao($sTextoMensagem = "informe uma natureza de operação")
=
#ce ===============================================================================================================================

#Region ### VARIAVEIS

#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func ExibeMensagemPadrao($sTestesExecutados, $sInformacoesAdicionais = "")

	Local Const $sMensagemExibida = "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			$sTestesExecutados & @CR & _
			$sInformacoesAdicionais & @CR & _
			"---------------------------------------" & @CR & _
			"Pressione CTRL+SHIFT+Q para " & @CR & _
			"finalizar o teste a qualquer momento"

	; Exibe MsgBox
	$iBotaoClicado = MsgBox($MB_ICONINFORMATION + $MB_OKCANCEL, "Rotina de Teste Automatizado", $sMensagemExibida)

	If $iBotaoClicado == $IDCANCEL Then

		VoltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>ExibeMensagemPadrao

#cs ===============================================================================================================================
	Função ExibeInputBoxSolicitaCodigo() retornar o código digitado no InputBox, se o mesmo for uma string de inteiro
	ce ===============================================================================================================================
	Func ExibeInputBoxSolicitaCodigo($sTextoInputBox, $iLarguraInputbox = 260, $iAlturaInputBox = 130)

	Local $bValida = true

	While ($bValida)

	$iCodigo = InputBox("Solicita Código", $sTextoInputBox, "", "", $iLarguraInputbox, $iAlturaInputBox)

	If @error Then

	MsgBox($MB_ICONWARNING, "", "Script será finalizado!")
	Exit

	ElseIf ($iCodigo == "" Or Not StringIsInt($iCodigo)) Then

	MsgBox($MB_SYSTEMMODAL, "", "Informe um código válido!")
	$iCodigo = ""

	Else

	$bValida = false
	return $iCodigo

	EndIf

	WEnd

	EndFunc
#ce

Func GetSolicitaCodigo($sTextoMensagem = "INFORME UM CÓDIGO DE...")
	
	#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes-Automatizados\_temp\form\frmSolicitaCodigo.kxf
	$frmSolicitaCodigo = GUICreate("Solicita Código", 330, 134, -1, -1, BitOR($WS_SYSMENU, $WS_POPUP, $DS_MODALFRAME), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
	GUISetBkColor(0xC0DCC0)
	$GroupBox1 = GUICtrlCreateGroup("", 8, 1, 312, 89)
	$lblTexto = GUICtrlCreateLabel(StringUpper($sTextoMensagem), 24, 24, 280, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$txtCodigo = GUICtrlCreateInput("", 24, 48, 65, 21)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$btnOK = GUICtrlCreateButton("&OK", 150, 99, 75, 25)
	$btnCancelar = GUICtrlCreateButton("&Cancelar", 229, 100, 75, 25)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	$bValida = True

	While ($bValida)
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit

			Case $btnOK
				$iCodigo = GUICtrlRead($txtCodigo)
				GUISetState(@SW_HIDE)

				If ($iCodigo == "" Or Not StringIsInt($iCodigo)) Then

					MsgBox($MB_ICONWARNING, "", "Informe um código válido!")
					$iCodigo = ""
					GUISetState(@SW_SHOW)

				Else

					$bValida = False
					Return $iCodigo

				EndIf

			Case $btnCancelar
				GUISetState(@SW_HIDE)
				MsgBox($MB_ICONWARNING, "", "O script será finalizado!")
				Exit
				
		EndSwitch
	WEnd

EndFunc   ;==>GetSolicitaCodigo

Func GetSolicitaNaturezaOperacao($sTextoMensagem = "informe uma natureza de operação")
	
	#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes-Automatizados\_temp\form\frmSolicitaCodigo.kxf
	$frmSolicitaCodigo = GUICreate("Solicita Natureza de Operação", 330, 134, -1, -1, BitOR($WS_SYSMENU, $WS_POPUP, $DS_MODALFRAME), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
	GUISetBkColor(0xC0DCC0)
	$GroupBox1 = GUICtrlCreateGroup("", 8, 1, 312, 89)
	$lblTexto = GUICtrlCreateLabel(StringUpper($sTextoMensagem), 24, 24, 280, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$txtCodigo = GUICtrlCreateInput("", 24, 48, 65, 21)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$btnOK = GUICtrlCreateButton("&OK", 150, 99, 75, 25)
	$btnCancelar = GUICtrlCreateButton("&Cancelar", 229, 100, 75, 25)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	$bValida = True

	While ($bValida)
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit

			Case $btnOK
				$iCodigo = GUICtrlRead($txtCodigo)
				GUISetState(@SW_HIDE)

				If ($iCodigo == "" Or StringIsInt($iCodigo)) Then

					MsgBox($MB_ICONWARNING, "", "Informe uma natureza de operação válida!")
					$iCodigo = ""
					GUISetState(@SW_SHOW)

				Else

					$bValida = False
					Return $iCodigo

				EndIf

			Case $btnCancelar
				GUISetState(@SW_HIDE)
				MsgBox($MB_ICONWARNING, "", "O script será finalizado!")
				Exit
				
		EndSwitch
	WEnd

EndFunc   ;==>GetSolicitaNaturezaOperacao

#EndRegion ### FUNÇÕES
