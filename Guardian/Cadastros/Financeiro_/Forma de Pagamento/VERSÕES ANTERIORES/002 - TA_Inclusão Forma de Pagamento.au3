#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Inclus�o de forma de pagamento com c�digo randomico
	Data Inicio ....: 15/09/2015
	Data Termino ...: 15/09/2015
	Vers�o .........: 002 -> Refatora��o do c�digo de verifica��o de resolu��o
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)				; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente ap�s uma opera��o bem-sucedida com janela.
;Opt("MouseClickDelay", 10)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o bot�o � mantido pressionado antes da libera��o.
;Opt("MouseClickDragDelay", 250)	; Altera o tamanho da pausa breve no in�cio e no final de uma opera��o arrastar do mouse.
Opt("SendKeyDelay", 100)			; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla � mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ; N�O REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a fun��o f_geraCPF() ou f_geraCNPJ() para obter um n�mero aleat�rio valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Vers�o"

Local $v_codigoRandom = Random(0, 999, 1)
Local $v_codigoFormaPagto = 0
Local $v_receitaPadraoCodigo = 86
Local $v_despesaPadraoCodigo = 205
Local $sTextoTelaFormaPagto = "Formas De Pagamento"

;V_Fim *************************************************** V_Fim




;------------------------------------
; 	  INICIO EXECU��O DO SCRIPT
;------------------------------------

;--> VERIFICA SE O SISTEMA A SER TESTADO EST� ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If ($v_telaSistemaAtiva == 0) Then

	MsgBox(48, "", "Space Guardian n�o foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolu��o atual da tela -> (fun��o no final do script)

f_mensagemPadrao() ; Exibe mensagem padr�o e informativa -> (fun��o no final do script)
;________________________________________________________________________________________________________________

WinActivate("" & $v_tituloTelaSistema)

If (WinExists("", $sTextoTelaFormaPagto) And WinActive("", $sTextoTelaFormaPagto)) Then

	f_incluirCadastroFormaPagto()

Else

	Send("!c")
	Send("ff{LEFT}f{ENTER}")
	WinWaitActive("", $sTextoTelaFormaPagto)

	f_incluirCadastroFormaPagto()

EndIf



;------------------------------------
; 	  FIM EXECU��O DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLU��O DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUN��ES *****************************

Func f_incluirCadastroFormaPagto()

	Send("{F2}")
	WinWaitActive("", "Cadastro de Formas de Pagamento")

	$v_codigoFormaPagto = $v_codigoRandom
	Opt("SendKeyDelay", 30) ;--> Altera o Delay do comando SEND
	Send($v_codigoFormaPagto & "{TAB}")
	Send($v_codigoFormaPagto & "-Forma Pagto Teste{TAB 2}")
	Send("3{TAB}" & $v_receitaPadraoCodigo & "{TAB 2}" & $v_despesaPadraoCodigo & "{TAB}")

	MouseClick("LEFT", 473, 362)
	Send("1{TAB 2}numero{TAB}10{TAB}9999999999")
	MouseClick("LEFT", 488, 566)
	;MouseClick("LEFT", 488, 580)
	;MouseClick("LEFT", 513, 340)
	MouseClick("LEFT", 517, 329)
	Send("{DOWN}{SPACE}")
	Send("{TAB 2}{SPACE}")
	Send("{TAB}{SPACE}")
	Send("{TAB}{SPACE}")
	Send("{TAB}{SPACE}")
	Send("{TAB 10}{SPACE}")

	MouseClick("LEFT", 848, 657)

	if (WinExists("", $sTextoTelaFormaPagto) And WinActive("", $sTextoTelaFormaPagto)) Then
		MouseClick("LEFT", 383, 272)
		Send($v_codigoFormaPagto & "{ENTER}")
	EndIf

EndFunc   ;==>f_incluirCadastroFormaPagto


Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADR�O
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Incluir Forma de Pagamento" & @CR & @CR & _
			"OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!" & @CR & _
			"* Utilizar a base de dados da empresa DEP. SANTA ROSA")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
