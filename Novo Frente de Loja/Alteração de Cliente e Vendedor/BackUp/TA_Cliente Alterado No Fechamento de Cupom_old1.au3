#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Efetuar a alteração do cliente no fechamento do cupom no sistema NFL.
	Data Inicio ....: 04/08/2015
	Data Termino ...: 04/08/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)
;Opt("WinWaitDelay", 1000)

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3"

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "FXML teste com eclipse"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

$v_codigoCliente = 9
$v_codigoProduto = 85242
$v_valorPago = "500,00"

;V_Fim *************************************************** V_Fim




;------------------------------------
; 	  INICIO EXECUÇÃO DO SCRIPT
;------------------------------------

; VERIFICA SE O SISTEMA A SER TESTADO ESTÁ ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox(48, "", "NFL não foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função no final do script)

f_mensagemPadrao() ; Exibe mensagem padrão e informativa -> (função no final do script)
;________________________________________________________________________________________________________________

WinActivate("" & $v_tituloTelaSistema)
WinSetState("" & $v_tituloTelaSistema,"", @SW_RESTORE)

For $v_contadorLoopFor = 1 To 5 Step +1

	Send($v_codigoProduto & "{ENTER}")
	Sleep(1000)

Next

Sleep(2000)
Send("{F4}")
Sleep(3000)

Send("^{TAB}")
Sleep(1000)
MouseClick("Left", 353, 134, 2)
Send($v_codigoCliente & "{TAB}")
MouseClick("Left", 705, 64)

Sleep(1000)
MouseClick("Left", 373, 319)
Sleep(1000)
Send("{ENTER}" & $v_valorPago & "{ENTER}")
Sleep(1000)
Send("{ENTER}")
Sleep(3000)

If $v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela Then

	f_voltaResolucaoAnterior()

EndIf

If WinExists("Emu") Then

	WinSetState("" & $v_tituloTelaSistema, "", @SW_MINIMIZE)
	WinActivate("Emu")
	Exit

Else

	Exit

EndIf

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
			"Alterar Cliente no Fechamento do Cupom")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
