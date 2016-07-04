#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: BUG => Altera��o N�o e gravada conforme o procedimento que ser� realizado por est� rotina.
	Data Inicio ....: 10/08/2015
	Data Termino ...: 10/08/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)
;Opt("WinWaitDelay", 1000)

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ;N�O REMOVER ESTE INCLUDE

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Vers�o"
Local Const $v_textoTelaFornecedor = "Fornecedores"
Local Const $v_textoTelaCadFornecedor = "Cadastro de Fornecedores"
Local Const $v_textoTelaCadTransportador = "Cadastro de Transportadoras"
Local Const $v_textoTelaTransportador = "Transportadoras"
Local Const $v_tituloTelaConfirmacao = "Confirma��o"
Local Const $v_codigoFornecedor = "869"
Local Const $v_codigoTransportador = "670"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

;V_Fim *************************************************** V_Fim




;------------------------------------
; 	  INICIO EXECU��O DO SCRIPT
;------------------------------------

; VERIFICA SE O SISTEMA A SER TESTADO EST� ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox(48, "", "Space Guardian n�o foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolu��o atual da tela -> (fun��o no final do script)

f_mensagemPadrao() ; Exibe mensagem padr�o e informativa -> (fun��o no final do script)
;________________________________________________________________________________________________________________


WinActivate("" & $v_tituloTelaSistema)
Sleep(1000)

; Abre tela de cadastro de fornecedor
Send("!c")
Sleep(1000)
Send("f")
Sleep(500)
Send("{Enter}")
WinWaitActive("", "" & $v_textoTelaFornecedor)

; Ordena por c�digo e efetua a pesquisa
MouseClick("left", 345, 228)
Sleep(1000)
Send($v_codigoFornecedor & "{ENTER}")
Send("{F3}")


; Verifica se registro est� travado
Sleep(1000)
$v_registroTravado = WinExists("Registro")
If $v_registroTravado == 1 Then

	MsgBox(48, "Registro Travado", "Destrave o registro e execute a rotina novamente!")

	Send("{ESC}")
	WinWaitActive("" & $v_tituloTelaConfirmacao)
	Send("{ENTER}")
	MouseClick("left", 665, 352)

	Exit

EndIf

; Acessa a aba de Dados Adicionais cadastro de fornecedor e abre a tela de transportador
WinWaitActive("", "" & $v_textoTelaCadFornecedor)
Send("^f")
Sleep(1000)
MouseClick("left", 523, 461)
WinWaitActive("", "" & $v_textoTelaTransportador)

MouseClick("left", 340, 227)
Sleep(1000)
Send($v_codigoTransportador & "{ENTER}")

; Abre tela de altera��o de transportador
Send("{F3}")
WinWaitActive("", "" & $v_textoTelaCadTransportador)
Sleep(2000)
MouseClick("left", 877, 622)
Sleep(1000)
Send("{ESC}")
WinWaitActive("" & $v_tituloTelaConfirmacao)
Send("{ENTER}")
Sleep(1000)

; Informar codigo do transportador alterado e tenta gravar ou cancelar o registro do fornecedor
Send($v_codigoTransportador & "{TAB}")
Sleep(2000)
MouseClick("left", 877, 617, 4)
Sleep(1000)
MouseClick("left", 990, 617)
Sleep(1000)
Send("s")



;------------------------------------
; 	  FIM EXECU��O DO SCRIPT
;------------------------------------




;************************* FUN��ES *****************************

Func f_voltaResolucaoAnterior()

	_ChangeEscreenRes($v_larguraTela, $v_alturaTela)

EndFunc   ;==>f_voltaResolucaoAnterior


Func f_verificaAlteraResolucao()

	;------------------------------------
	; VERIFICA E ALTERA RESOLU��O DA TELA
	;------------------------------------
	If $v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela Then

		MsgBox(48, "ALERTA! - (" & $v_larguraTela & " x " & $v_alturaTela & ")", "RESOLU��O INCOMPATIVEL PARA" & @CR & _
				"EXECU��O DA ROTINA AUTOMATIZADA! " & @CR & @CR & _
				"RESOLU��O NECESS�RIO PARA " & @CR & _
				"EFETUAR OS TESTE: " & $v_CCSlarguraTela & " x " & $v_CCSalturaTela)

		Local $v_mensagemAlteraResolucao = MsgBox(36, "", "Deseja alterar a resolu��o?")
		If $v_mensagemAlteraResolucao == 6 Then

			_ChangeEscreenRes($v_CCSlarguraTela, $v_CCSalturaTela)

			;----------------------------------------------------
			; Verifica se a altera��o da resolu��o foi realizada
			;----------------------------------------------------
			If ($v_larguraTela == $v_CCSlarguraTela And $v_alturaTela == $v_CCSalturaTela) Or ($v_larguraTela <> $v_CCSlarguraTela And $v_alturaTela <> $v_CCSalturaTela) Then

				MsgBox(16, "", "A resolu��o " & $v_CCSlarguraTela & " x " & $v_CCSalturaTela & " N�O e suportada pelo seu monitor" & @CR & @CR & _
						"A EXECU��O DO SCRIPT SER� ENCERRADA!")
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
	; 			MENSAGEM PADR�O
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Inclus�o de Transportador padr�o para Fornecedor" & @CR & "BUG => Altera��o N�o e gravada conforme o procedimento que ser� realizado por est� rotina." _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O SPACE GUARDIAN PRECISA EST� ABERTO!" & @CR & _
			"* Utilizar a base de dados da empresa VITORINO")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
