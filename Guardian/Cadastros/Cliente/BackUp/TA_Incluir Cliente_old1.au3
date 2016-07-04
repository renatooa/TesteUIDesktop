#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Incluir cadastro de Cliente no Guardian
	Data Inicio ....: 01/09/2015
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)
;Opt("WinWaitDelay", 1000)

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" 		;NÃO REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" 		; Utilizar a função f_geraCPF ou f_geraCNPJ para obter um número aleatório valido

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

Local $v_codigoCliente = ""

Local $v_tituloTelaCodigoJaCadastrado = "Codigo já cadastrado"
Local $v_textoTelaCadastradoCliente = "Cadastro de Clientes"

;V_Fim *************************************************** V_Fim




;------------------------------------
; 	  INICIO EXECUÇÃO DO SCRIPT
;------------------------------------

; VERIFICA SE O SISTEMA A SER TESTADO ESTÁ ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox(48, "", "Space Guardian não foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função no final do script)

f_mensagemPadrao() ; Exibe mensagem padrão e informativa -> (função no final do script)
;________________________________________________________________________________________________________________


WinActivate("" & $v_tituloTelaSistema)

Send("!c")
Sleep(500)
Send("{ENTER}")

WinWaitActive("", "Clientes")

Send("{F2}")
WinWaitActive("", "" & $v_textoTelaCadastradoCliente)
MouseClick("LEFT", 447, 113, 2)
Sleep(500)
;$v_codigoCliente =
Send("^c")
Sleep(500)
Send("{TAB}")

#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes Automatizados\_temp\form\frmTipoPessoa.kxf
$frmTipoPessoa = GUICreate("", 330, 111, 516, 98, $WS_POPUP, $WS_EX_TOPMOST)
GUISetBkColor(0xA6CAF0)
$btnPessoaFisica = GUICtrlCreateButton("Fisíca", 53, 46, 93, 41)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$btnPessoaJuridica = GUICtrlCreateButton(" Jurídica", 184, 46, 93, 41)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label1 = GUICtrlCreateLabel("Selecione o tipo de Pessoa para o Cadastro!", 11, 14, 316, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $btnPessoaJuridica
			GUISetState(@SW_HIDE)
			WinActivate("","" & $v_textoTelaCadastradoCliente)
			Sleep(500)
			Send("{SPACE}")
			Sleep(500)
			Send("" & f_geraCNPJ())
			Sleep(500)
			Send("{TAB}")
			WinWaitActive("Atenção
			Send("{ENTER}")
			ExitLoop

		Case $btnPessoaFisica
			GUISetState(@SW_HIDE)
			WinActivate("","" & $v_textoTelaCadastradoCliente)
			Sleep(500)
			Send("{RIGHT}")
			Sleep(500)
			Send("{SPACE}")
			Sleep(500)
			Send(""& f_geraCPF())
			Sleep(500)
			Send("{TAB}")
			ExitLoop

		Case $GUI_EVENT_CLOSE
			;Exit

	EndSwitch
WEnd

Sleep(500)
Send("^v" & " - Cliente Incluso - TESTE NFL")
Send("{TAB 6}")

#cs
$v_telaCodigoJaCadastrado = WinExists("" & $v_tituloTelaCodigoJaCadastrado)

While ($v_telaCodigoJaCadastrado == 1)

	WinActivate("" & $v_tituloTelaCodigoJaCadastrado)

	Send("{ENTER}")
	MouseClick("LEFT", 485, 170, 3)

	Send("" & $v_codigoCliente + 1)
	Send("{TAB}")
	Sleep(100)
	$v_telaCodigoJaCadastrado = WinExists("" & $v_tituloTelaCodigoJaCadastrado)

	$v_codigoCliente += 1

WEnd


Send("{RIGHT}")
Sleep(500)
Send("{SPACE}")
Sleep(500)

MouseClick("LEFT", 582, 197)
Sleep(500)

Send($v_codigoCliente & " - Vendedor Incluso - TESTE NFL")
Sleep(500)
MouseClick("LEFT", 461, 337, 3)
Send("2{ENTER}")
Sleep(500)
Send("^b")
Sleep(500)
MouseClick("LEFT", 730, 252)
Send("Rua")
Sleep(500)
Send("^e")
Sleep(500)
Send("{SPACE}")
MouseClick("LEFT", 492, 255)

Sleep(500)
MouseClick("LEFT", 852, 577)
#ce

;------------------------------------
; 	  FIM EXECUÇÃO DO SCRIPT
;------------------------------------




;************************* FUNÇÕES *****************************

Func f_voltaResolucaoAnterior()

	_ChangeEscreenRes($v_larguraTela, $v_alturaTela)

EndFunc   ;==>f_voltaResolucaoAnterior


Func f_verificaAlteraResolucao()

	;------------------------------------
	; VERIFICA E ALTERA RESOLUÇÃO DA TELA
	;------------------------------------
	If $v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela Then

		MsgBox(48, "ALERTA! - (" & $v_larguraTela & " x " & $v_alturaTela & ")", "RESOLUÇÃO INCOMPATIVEL PARA" & @CR & _
				"EXECUÇÃO DA ROTINA AUTOMATIZADA! " & @CR & @CR & _
				"RESOLUÇÃO NECESSÁRIO PARA " & @CR & _
				"EFETUAR OS TESTE: " & $v_CCSlarguraTela & " x " & $v_CCSalturaTela)

		Local $v_mensagemAlteraResolucao = MsgBox(36, "", "Deseja alterar a resolução?")
		If $v_mensagemAlteraResolucao == 6 Then

			_ChangeEscreenRes($v_CCSlarguraTela, $v_CCSalturaTela)

			;----------------------------------------------------
			; Verifica se a alteração da resolução foi realizada
			;----------------------------------------------------
			If ($v_larguraTela == $v_CCSlarguraTela And $v_alturaTela == $v_CCSalturaTela) Or ($v_larguraTela <> $v_CCSlarguraTela And $v_alturaTela <> $v_CCSalturaTela) Then

				MsgBox(16, "", "A resolução " & $v_CCSlarguraTela & " x " & $v_CCSalturaTela & " NÃO e suportada pelo seu monitor" & @CR & @CR & _
						"A EXECUÇÃO DO SCRIPT SERÁ ENCERRADA!")
				Exit

			EndIf

		Else
			MsgBox(48, "", "SCRIPT FINALZADO!")
			Exit
		EndIf

	EndIf

EndFunc   ;==>f_verificaAlteraResolucao


Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADRÃO
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Incluir Cadastro de Vendedor" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa está aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
