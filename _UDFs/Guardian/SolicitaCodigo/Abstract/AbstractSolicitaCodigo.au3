#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF Abstract com funções comuns para solicitar codigos.
	Data Inicio ....: 26/07/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES / OPS

#include-once


#include "..\frmSolicitaCodigo.au3"
#include <MsgBoxConstants.au3>

#EndRegion ###	INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
=	
=	SolicitaCodigo($sTextoMensagem = "INFORME UM CÓDIGO DE...", $sMsgCodigoValido = "Informe um código válido!")
=
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func SolicitaCodigo($sTextoMensagem = "INFORME UM CÓDIGO DE...", $sMsgCodigoValido = "Informe um código válido!")
	
	FrmSolicitaCodigo($sTextoMensagem)

	$bValida = True

	While ($bValida)
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $btnCancelar
				GUISetState(@SW_HIDE)
				MsgBox($MB_ICONWARNING, "", "O script será finalizado!", 5)
				Exit

			Case $btnOK
				$iCodigo = GUICtrlRead($txtCodigo)
				GUISetState(@SW_HIDE)

				If ($iCodigo == "") Then

					MsgBox($MB_ICONWARNING, "", $sMsgCodigoValido)
					$iCodigo = ""
					GUISetState(@SW_SHOW)

				Else

					$bValida = False					
					Return $iCodigo

				EndIf

		EndSwitch
	WEnd

EndFunc   ;==>SolicitaCodigo

#EndRegion ### FUNÇÕES