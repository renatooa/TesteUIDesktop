#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Alterar cadastro de Cliente no Guardian
	Data Inicio ....: 03/09/2015
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)				; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)		; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.
Opt("SendKeyDelay", 100)			; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ;NÃO REMOVER ESTE INCLUDE

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

Local $v_codigoCliente = ""

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

;--> Acessa a tela de Consulta de Cliente
Send("!c")
Send("{ENTER}")
WinWaitActive("", "Clientes")
MouseClick("LEFT", 343, 282)

While ($v_codigoCliente == "")

$v_codigoCliente = InputBox("Código do Cliente(Alteração)", "INFORME UM CÓDIGO DE CLIENTE! ..:","","", 260, 130)

	If @error Then

		MsgBox(48,"","Script será encerrado!")
		Exit
	ElseIf ($v_codigoCliente == "") Then

		MsgBox(0,"","Informe um código!")

	EndIf

WEnd

;--> Acessa a tela de Alteração Cadastro de Cliente
Opt("SendKeyDelay", 10) 							; Altera o tempo padrão do SendKey
Send($v_codigoCliente & "{ENTER}{F3}")
WinWaitActive("", "" & $v_textoTelaCadastradoCliente)
MouseClick("LEFT", 397, 140, 3)
Send($v_codigoCliente & " - Cliente Incluso - TESTE NFL_alterado")
MouseClick("LEFT", 857, 635)


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
			"Alterar Cadastro de Vendedor" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa está aberto!" & @CR & _
			"* Utilizar o Banco de Dados _NFLSUPDEV")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
