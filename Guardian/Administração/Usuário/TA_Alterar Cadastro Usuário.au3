#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......:
	Data Inicio ....: 14/10/2015
	Data Termino ...: 14/10/2015
	Vers�o .........: 002 -> Refatora��o do c�digo de verifica��o de resolu��o
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

Local $v_textoTelaConsulta = "Usu�rios Do Sistema"
Local $v_numeroRandomico = Random(1, 500, 1)
Local $v_numeroUsuario = 0

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

If WinExists("", "" & $v_textoTelaConsulta) And WinActive("", "" & $v_textoTelaConsulta) Then

	f_alterarCadastroUsuario()

Else

	Send("!a")
	Send("u{DOWN}{ENTER}")
	WinWaitActive("", "" & $v_textoTelaConsulta)

	f_alterarCadastroUsuario()

EndIf



;------------------------------------
; 	  FIM EXECU��O DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLU��O DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUN��ES *****************************

Func f_alterarCadastroUsuario()

	MouseClick("LEFT", 407, 272)
	$v_loginUsuario = InputBox("Login do Usu�rio(Altera��o)", "INFORME UM LOGIN DE USU�RIO! ..:", "", "", 300, 140)

	If @error Then

		MsgBox(48, "", "O Script ser� finalizado!")
		Exit

	EndIf

	BlockInput(1)

	Opt("SendKeyDelay", 20)
	Send($v_loginUsuario & "{ENTER}{F3}")
	WinWaitActive("", " Cadastro de Usu�rios")

	MouseClick("LEFT", 586, 227) ;--> Foco no textbox Nome
	Send("{END}_ALTERADO")

	MouseClick("LEFT", 865, 580) ;--> Click no bot�o Gravar
	Sleep(500)

	If (WinExists("Informa��o", "Selecione pelo menos uma filial")) Then

		WinActivate("Informa��o", "Selecione pelo menos uma filial")
		Send("{ENTER}")

		MouseClick("LEFT", 486, 167) ;--> Click na aba Filiais
		Sleep(300)
		MouseClick("LEFT", 367, 236) ;--> Marca checkbox
		MouseClick("LEFT", 865, 580) ;--> Click no bot�o Gravar

	EndIf

	BlockInput(0)

	Exit

EndFunc   ;==>f_cadastrarUsuario


Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADR�O
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Alterar Cadastro de Usu�rio" & @CR & @CR & _
			"OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
