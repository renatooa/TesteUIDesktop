#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o - UDF
	Descri��o ......: UDF para conter mensagens genericas
	Data Inicio ....: 07/04/2016
	Data Termino ...: 07/04/2016
	Vers�o .........: 001
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

#cs FUN��ES DA UDF ================================================================================================================
=
=	ExibeMensagemPadrao($sTestesExecutados, $sInformacoesAdicionais = "")
=	GetSolicitaCodigo($sTextoMensagem = "INFORME UM C�DIGO DE...")
=	GetSolicitaNaturezaOperacao($sTextoMensagem = "informe uma natureza de opera��o")
=
#ce ===============================================================================================================================

#Region ### VARIAVEIS

#EndRegion ### VARIAVEIS

#Region ### FUN��ES

Func ExibeMensagemPadrao($sTestesExecutados, $sInformacoesAdicionais = "")

	Local Const $sMensagemExibida = "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
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
	Fun��o ExibeInputBoxSolicitaCodigo() retornar o c�digo digitado no InputBox, se o mesmo for uma string de inteiro
	ce ===============================================================================================================================
	Func ExibeInputBoxSolicitaCodigo($sTextoInputBox, $iLarguraInputbox = 260, $iAlturaInputBox = 130)

	Local $bValida = true

	While ($bValida)

	$iCodigo = InputBox("Solicita C�digo", $sTextoInputBox, "", "", $iLarguraInputbox, $iAlturaInputBox)

	If @error Then

	MsgBox($MB_ICONWARNING, "", "Script ser� finalizado!")
	Exit

	ElseIf ($iCodigo == "" Or Not StringIsInt($iCodigo)) Then

	MsgBox($MB_SYSTEMMODAL, "", "Informe um c�digo v�lido!")
	$iCodigo = ""

	Else

	$bValida = false
	return $iCodigo

	EndIf

	WEnd

	EndFunc
#ce

Func GetSolicitaCodigo($sTextoMensagem = "INFORME UM C�DIGO DE...")
	
	#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes-Automatizados\_temp\form\frmSolicitaCodigo.kxf
	$frmSolicitaCodigo = GUICreate("Solicita C�digo", 330, 134, -1, -1, BitOR($WS_SYSMENU, $WS_POPUP, $DS_MODALFRAME), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
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

					MsgBox($MB_ICONWARNING, "", "Informe um c�digo v�lido!")
					$iCodigo = ""
					GUISetState(@SW_SHOW)

				Else

					$bValida = False
					Return $iCodigo

				EndIf

			Case $btnCancelar
				GUISetState(@SW_HIDE)
				MsgBox($MB_ICONWARNING, "", "O script ser� finalizado!")
				Exit
				
		EndSwitch
	WEnd

EndFunc   ;==>GetSolicitaCodigo

Func GetSolicitaNaturezaOperacao($sTextoMensagem = "informe uma natureza de opera��o")
	
	#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes-Automatizados\_temp\form\frmSolicitaCodigo.kxf
	$frmSolicitaCodigo = GUICreate("Solicita Natureza de Opera��o", 330, 134, -1, -1, BitOR($WS_SYSMENU, $WS_POPUP, $DS_MODALFRAME), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
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

					MsgBox($MB_ICONWARNING, "", "Informe uma natureza de opera��o v�lida!")
					$iCodigo = ""
					GUISetState(@SW_SHOW)

				Else

					$bValida = False
					Return $iCodigo

				EndIf

			Case $btnCancelar
				GUISetState(@SW_HIDE)
				MsgBox($MB_ICONWARNING, "", "O script ser� finalizado!")
				Exit
				
		EndSwitch
	WEnd

EndFunc   ;==>GetSolicitaNaturezaOperacao

#EndRegion ### FUN��ES
