#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Alterar cadastro de Vendedor no Guardian
	Data Inicio ....: 10/09/2015
	Data Termino ...: 10/09/2015
	Vers�o .........: 003 - 16/12/2015  -> Refatora��o do c�digo de verifica��o de resolu��o
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

#include <MsgBoxConstants.au3>
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ; N�O REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a fun��o f_geraCPF ou f_geraCNPJ para obter um n�mero aleat�rio valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Vers�o"

Local $v_codigoVendedor = ""
Local $v_textoTelaLogradouro = "Campo Obrigat�rio n�o preenchido ! Campo: LOGRADOURO"

;V_Fim *************************************************** V_Fim



;------------------------------------
; 	  INICIO EXECU��O DO SCRIPT
;------------------------------------

; VERIFICA SE O SISTEMA A SER TESTADO EST� ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox($MB_ICONWARNING, "", "Space Guardian n�o foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolu��o atual da tela -> (fun��o no final do script)

f_mensagemPadrao() ; Exibe mensagem padr�o e informativa -> (fun��o no final do script)
;________________________________________________________________________________________________________________


WinActivate("" & $v_tituloTelaSistema)

;--> Acessa tela de Consulta de Vendedor
Send("!c")
Send("v")
Send("{ENTER}")
WinWaitActive("", "Vendedores")
MouseClick("LEFT", 386, 272)
MouseClick("LEFT", 480, 238, 3)

;--> Solicita C�digo de Vendedor
While ($v_codigoVendedor == "")

	$v_codigoVendedor = InputBox("C�digo do Vendedor(Altera��o)", "INFORME UM C�DIGO DE VENDEDOR! ..:", "", "", 260, 130)

	If @error Then

		MsgBox($MB_ICONWARNING, "", "Script ser� finalizado!")
		Exit

	ElseIf ($v_codigoVendedor == "") Then

		MsgBox(4096, "", "Informe um c�digo!")

	EndIf

WEnd

Opt("SendKeyDelay", 20)
;--> Acessa tela de Altera��o Cadastro de Vendedor
Send("" & $v_codigoVendedor & "{ENTER}{F3}")
WinWaitActive("", "Cadastro de Vendedores")

MouseClick("LEFT", 754, 197, 3)
Send($v_codigoVendedor & " - Vendedor TESTE_alterado")
MouseClick("LEFT", 855, 577)

;--> Verifica se a tela de Logradouro n�o preenchido existe
If WinExists("", "" & $v_textoTelaLogradouro) Then

	WinWaitActive("", "" & $v_textoTelaLogradouro)
	Send("{ENTER}")
	Send("rua teste_alterada")
	MouseClick("LEFT", 855, 577)

EndIf


;------------------------------------
; 	  FIM EXECU��O DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLU��O DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUN��ES *****************************

Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADR�O
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Alterar Cadastro de Vendedor" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
