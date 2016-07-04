#cs ===============================================================================================================================
	Típo de Script .: Script de Função
	Descrição ......: UDF Para efetuar a alteração da resolução do computador
	Data Inicio ....: 23/07/2015
	Data Termino ...: 23/07/2015
	Versão .........: 002 --> 09/12/2015
	Autor(s) .......: Ronildo (Exemplo Copiado do Forum AutoIt Brasil)
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

#include-once

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

; Variaveis incluidas na versão 002 da UDF e Refatoração do código --> 09/12/2015

Local Const $iLarguraTela = 1366
Local Const $iAlturaTela = 768
Local Const $iLarguraTelaAtual = @DesktopWidth
Local Const $iAlturaTelaAtual = @DesktopHeight

;V_Fim *************************************************** V_Fim


;************************* FUNÇÕES *****************************

Func _ChangeEscreenRes($I_Width = @DesktopWidth, $I_Height = @DesktopHeight, $I_BitSpp = @DesktopDepth, $I_RefreshRate = @DesktopRefresh)

	Local Const $DM_PELSWIDTH = 524288
	Local Const $DM_PELSHEIGHT = 1048576
	Local Const $DM_BITSPERPEL = 262144
	Local Const $DM_DISPLAYFREQUENCY = 4194304
	Local Const $CDS_TEST = 2
	Local Const $CDS_UPDATEREGISTRY = 1
	Local Const $DISP_CHANGE_RESTART = 1
	Local Const $DISP_CHANGE_SUCCESSFUL = 0
	Local Const $HWND_BROADCAST = 65535
	Local Const $WM_DISPLAYCHANGE = 126

	If $I_Width = "" Or $I_Width = -1 Then $I_Width = @DesktopWidth
	If $I_Height = "" Or $I_Height = -1 Then $I_Height = @DesktopHeight
	If $I_BitSpp = "" Or $I_BitSpp = -1 Then $I_BitSpp = @DesktopDepth
	If $I_RefreshRate = "" Or $I_RefreshRate = -1 Then $I_RefreshRate = @DesktopRefresh
	Local $DevMode = DllStructCreate("byte[32];int[10];byte[32];int[6]")
	Local $B = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "long", 0, "ptr", DllStructGetPtr($DevMode))
	If @error Then
		$B = 0
		SetError(1)
		Return $B
	Else
		$B = $B[0]
	EndIf
	If $B <> 0 Then
		DllStructSetData($DevMode, 2, BitOR($DM_PELSWIDTH, $DM_PELSHEIGHT, $DM_BITSPERPEL, $DM_DISPLAYFREQUENCY), 5)
		DllStructSetData($DevMode, 4, $I_Width, 2)
		DllStructSetData($DevMode, 4, $I_Height, 3)
		DllStructSetData($DevMode, 4, $I_BitSpp, 1)
		DllStructSetData($DevMode, 4, $I_RefreshRate, 5)
		$B = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DevMode), "int", $CDS_TEST)
		If @error Then
			$B = -1
		Else
			$B = $B[0]
		EndIf
		Select
			Case $B = $DISP_CHANGE_RESTART
				$DevMode = ""
				Return 2
			Case $B = $DISP_CHANGE_SUCCESSFUL
				DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DevMode), "int", $CDS_UPDATEREGISTRY)
				DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_DISPLAYCHANGE, "int", $I_BitSpp, "int", $I_Height * 2 ^ 16 + $I_Width)
				$DevMode = ""
				Return 1
			Case Else
				$DevMode = ""
				SetError(1)
				Return $B
		EndSelect
	EndIf
EndFunc   ;==>_ChangeEscreenRes


;*******************************************************
; Alterações da versão 002 da UDF --> Data 09/12/2015
;*******************************************************

Func VerificaAlteraResolucao()

	;------------------------------------
	; VERIFICA E ALTERA RESOLUÇÃO DA TELA
	;------------------------------------
	If $iLarguraTelaAtual <> $iLarguraTela Or $iAlturaTelaAtual <> $iAlturaTela Then

		MsgBox(48, "ALERTA! - (" & $iLarguraTelaAtual & " x " & $iAlturaTelaAtual & ")", "RESOLUÇÃO INCOMPATIVEL PARA" & @CR & _
				"EXECUÇÃO DA ROTINA AUTOMATIZADA! " & @CR & @CR & _
				"RESOLUÇÃO NECESSÁRIO PARA " & @CR & _
				"EFETUAR OS TESTE: " & $iLarguraTela & " x " & $iAlturaTela)

		Local $iMensagemAlteraResolucao = MsgBox(36, "", "Deseja alterar a resolução?")

		If $iMensagemAlteraResolucao == 6 Then

			_ChangeEscreenRes($iLarguraTela, $iAlturaTela)

			;----------------------------------------------------
			; Verifica se a alteração da resolução foi realizada
			;----------------------------------------------------
			If (@DesktopWidth <> $iLarguraTela And @DesktopHeight <> $iAlturaTela) Then

				MsgBox(16, "", "A resolução " & $iLarguraTela & " x " & $iAlturaTela & " NÃO e suportada pelo seu monitor" & @CR & @CR & _
						"A EXECUÇÃO DO SCRIPT SERÁ ENCERRADA!")
				Exit

			EndIf

		Else
			MsgBox(48, "", "SCRIPT FINALZADO!", 10)
			Exit
		EndIf

	EndIf

EndFunc   ;==>VerificaAlteraResolucao


Func VoltaResolucaoAnterior()

	If ($iLarguraTelaAtual <> $iLarguraTela Or $iAlturaTelaAtual <> $iAlturaTela) Then

		_ChangeEscreenRes($iLarguraTelaAtual, $iAlturaTelaAtual)

	EndIf
EndFunc   ;==>VoltaResolucaoAnterior

;***************************************************************
