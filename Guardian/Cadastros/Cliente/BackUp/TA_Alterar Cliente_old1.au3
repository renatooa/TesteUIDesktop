#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Alterar cadastro de Cliente no Guardian
	Data Inicio ....: 03/09/2015
	Data Termino ...:
	Vers�o .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)				; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente ap�s uma opera��o bem-sucedida com janela.
;Opt("MouseClickDelay", 10)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o bot�o � mantido pressionado antes da libera��o.
;Opt("MouseClickDragDelay", 250)		; Altera o tamanho da pausa breve no in�cio e no final de uma opera��o arrastar do mouse.
Opt("SendKeyDelay", 100)			; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla � mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ;N�O REMOVER ESTE INCLUDE

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Vers�o"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

Local $v_codigoCliente = ""

Local $v_textoTelaCadastradoCliente = "Cadastro de Clientes"

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

;--> Acessa a tela de Consulta de Cliente
Send("!c")
Send("{ENTER}")
WinWaitActive("", "Clientes")
MouseClick("LEFT", 343, 282)

While ($v_codigoCliente == "")

$v_codigoCliente = InputBox("C�digo do Cliente(Altera��o)", "INFORME UM C�DIGO DE CLIENTE! ..:","","", 260, 130)

	If @error Then

		MsgBox(48,"","Script ser� encerrado!")
		Exit
	ElseIf ($v_codigoCliente == "") Then

		MsgBox(0,"","Informe um c�digo!")

	EndIf

WEnd

;--> Acessa a tela de Altera��o Cadastro de Cliente
Opt("SendKeyDelay", 10) 							; Altera o tempo padr�o do SendKey
Send($v_codigoCliente & "{ENTER}{F3}")
WinWaitActive("", "" & $v_textoTelaCadastradoCliente)
MouseClick("LEFT", 397, 140, 3)
Send($v_codigoCliente & " - Cliente Incluso - TESTE NFL_alterado")
MouseClick("LEFT", 857, 635)


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
			"Alterar Cadastro de Vendedor" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa est� aberto!" & @CR & _
			"* Utilizar o Banco de Dados _NFLSUPDEV")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
