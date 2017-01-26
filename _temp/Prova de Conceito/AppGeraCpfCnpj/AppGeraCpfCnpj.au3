#include <MsgBoxConstants.au3>
#include "D:\Testes-Automatizados\TesteUIDesktop\_ARQUIVOS\helpers\UDF_Msgbox\_Msgbox.au3"
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\Auxiliares\GerarCPF_CNPJ.au3"

#include <GuiComboBox.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=D:\Testes-Automatizados\TesteUIDesktop\_temp\form\frmMetroGeraCpfCnpj.kxf
$Form1 = GUICreate("frmMetroGeraCpfCnpj", 339, 224, -1, -1, BitOR($WS_SYSMENU,$WS_POPUP,$DS_MODALFRAME), BitOR($WS_EX_APPWINDOW, $WS_EX_TOOLWINDOW, 0))
GUISetFont(11, 400, 0, "Segoe UI")
GUISetBkColor(0x475577)
GUICtrlSetDefColor(0xFFFFFF)
$lblByRNS = GUICtrlCreateLabel("By RNS", 310, 212, 50, 24)
GUICtrlSetFont(-1, 6, 800, 0, "Segoe UI")
$lblTitle = GUICtrlCreateLabel("Gerador de CPF e CNPJ", 55, 38, 235, 32)
GUICtrlSetFont(-1, 15, 800, 0, "Segoe UI Semibold")
$lblPrompt = GUICtrlCreateLabel("Selecione a opção desejada :", 33, 129, 197, 24)
$cbxCpfCnpj = GUICtrlCreateCombo("", 241, 119, 70, 25)
GUICtrlSetData(-1, "CPF|CNPJ", "CPF")
$btnGerar = GUICtrlCreateButton("GERAR", 17, 167, 307, 45)
GUICtrlSetCursor (-1, 0)
GUICtrlSetFont(-1, 15, 400, 0, "Segoe UI")
GUICtrlSetBkColor(-1, 0x28324E)
$lblHeader = GUICtrlCreateLabel("", 0, 0, 292, 35)
GUICtrlSetBkColor(-1, 0x28324E)
$lblFechar = GUICtrlCreateLabel("X", 292, 0, 47, 35, $SS_CENTER)
GUICtrlSetFont(-1, 16, 800, 0, "Segoe UI")
GUICtrlSetBkColor(-1, 0x28324E)
GUICtrlSetCursor (-1, 0)
$lblGerarPontuacao = GUICtrlCreateLabel("Gerar com pontuação?", 32, 89, 155, 24)
$rbtSim = GUICtrlCreateRadio("SIM", 196, 91, 49, 17)
$rbtNao = GUICtrlCreateRadio("NÃO", 249, 91, 57, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $lblFechar
			Exit

		Case $btnGerar
			$indexItemSelecionado = _GUICtrlComboBox_GetCurSel($cbxCpfCnpj)
			$textoItemSelecionado = _GUICtrlComboBox_GetEditText($cbxCpfCnpj)
			$radio =GUICtrlRead($rbtSim)
			$pontos = ($radio == $GUI_CHECKED) ? true : false

			Switch ($indexItemSelecionado)
				Case 0
					GerarCPF($pontos)

				Case 1
					GerarCNPJ($pontos)

				Case Else
					If (Not @error) Then
						_MsgBox($MB_ICONERROR, "ALERTA", "OPÇÃO INVÁLIDA!", 2000)
						$result = 3
					EndIf
			EndSwitch

			If ($indexItemSelecionado > -1) Then
				_MsgBox($MB_ICONINFORMATION, $textoItemSelecionado & " GERADO", "COPIADO PARA A ÁREA DE TRANSFERÊNCIA!" & @CR & @CR & _
						"(" & ClipGet() & ")", 1000)
				;Exit
			EndIf

	EndSwitch
WEnd