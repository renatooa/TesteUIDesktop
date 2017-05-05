#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Altera��o de Forma de Pagamento
	Data Inicio ....: 15/09/2015
	Data Termino ...: 15/09/2015
;~ 	Vers�o .........: 002 -> Refatora��o do c�digo de verifica��o de resolu��o
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente ap�s uma opera��o bem-sucedida com janela.
;Opt("MouseClickDelay", 10)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o bot�o � mantido pressionado antes da libera��o.
;Opt("MouseClickDragDelay", 250)		; Altera o tamanho da pausa breve no in�cio e no final de uma opera��o arrastar do mouse.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla � mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\funcMudarResolucao.au3" ; N�O REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a fun��o f_geraCPF() ou f_geraCNPJ() para obter um n�mero aleat�rio valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Vers�o"

Local $v_textoTelaCadastro = "Formas De Pagamento"

;V_Fim *************************************************** V_Fim




;------------------------------------
; 	  INICIO EXECU��O DO SCRIPT
;------------------------------------

;--> VERIFICA SE O SISTEMA A SER TESTADO EST� ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox(48, "", "Space Guardian n�o foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolu��o atual da tela -> (fun��o no final do script)

f_mensagemPadrao() ; Exibe mensagem padr�o e informativa -> (fun��o no final do script)
;________________________________________________________________________________________________________________


WinActivate("" & $v_tituloTelaSistema)

If WinExists("", "" & $v_textoTelaCadastro) And WinActive("", "Formas De Pagamento") Then

	f_alteraCadastroFormaPgto()

Else

	Send("!c")
	Send("ff{LEFT}f{ENTER}")
	WinWaitActive("", "" & $v_textoTelaCadastro)

	f_alteraCadastroFormaPgto()

EndIf


;------------------------------------
; 	  FIM EXECU��O DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLU��O DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUN��ES *****************************
Func f_alteraCadastroFormaPgto()

	MouseClick("LEFT", 383, 272)
	$v_codigoFormaPagto = InputBox("C�digo da Forma Pagto(Altera��o)", "INFORME UM C�DIGO DE FORMA DE PAGAMENTO! ..:", "", "", 300, 140)

	If @error Then

		MsgBox(48, "", "O Script ser� finalizado!")
		Exit

	EndIf

	Opt("SendKeyDelay", 20)
	Send($v_codigoFormaPagto & "{ENTER}{F3}")

	WinWaitActive("", "Cadastro de Formas de Pagamento")
	MouseClick("LEFT", 453, 110, 3)
	Send($v_codigoFormaPagto & "-Forma Pagto Teste_Alterada{TAB}")

	MouseClick("LEFT", 848, 657)

EndFunc   ;==>f_alteraCadastroFormaPgto


Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADR�O
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Alterar Forma de Pagamento" & @CR & @CR & _
			"OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
