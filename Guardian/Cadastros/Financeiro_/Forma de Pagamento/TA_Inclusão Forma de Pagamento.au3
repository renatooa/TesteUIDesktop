#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Inclusão de forma de pagamento com código randomico
	Data Inicio ....: 15/09/2015
	Data Termino ...: 15/09/2015
	Versão .........: 003 -> 30/03/2016 - Ajuste de coordenadas X e Y e melhoria de tratamentos do código.
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)				; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)	; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.
Opt("SendKeyDelay", 100)			; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include <MsgBoxConstants.au3>
#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\funcMudarResolucao.au3" ; NÃO REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a função f_geraCPF() ou f_geraCNPJ() para obter um número aleatório valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"

Local $v_codigoRandom = Random(0, 999, 1)
Local $v_codigoFormaPagto = 0
Local $v_receitaPadraoCodigo = 86
Local $v_despesaPadraoCodigo = 205
Local $sTextoTelaFormaPagto = "Formas De Pagamento"

;V_Fim *************************************************** V_Fim




;------------------------------------
; 	  INICIO EXECUÇÃO DO SCRIPT
;------------------------------------

;--> VERIFICA SE O SISTEMA A SER TESTADO ESTÁ ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If ($v_telaSistemaAtiva == 0) Then

	MsgBox(48, "", "Space Guardian não foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função no final do script)

f_mensagemPadrao() ; Exibe mensagem padrão e informativa -> (função no final do script)
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
; 	  FIM EXECUÇÃO DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLUÇÃO DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUNÇÕES *****************************

Func f_incluirCadastroFormaPagto()

	Send("{F2}")
	WinWaitActive("", "Cadastro de Formas de Pagamento")

	$v_codigoFormaPagto = $v_codigoRandom
	Opt("SendKeyDelay", 30) ;--> Altera o Delay do comando SEND
	Send($v_codigoFormaPagto & "{TAB}")
	Send($v_codigoFormaPagto & "-Forma Pagto Teste{TAB 2}")
	Send("3{TAB}" & $v_receitaPadraoCodigo & "{TAB 2}" & $v_despesaPadraoCodigo & "{TAB}")

	MouseClick("LEFT", 473, 388)
	Send("1{TAB 2}numero{TAB}10{TAB}9999999999")
	MouseClick("LEFT", 492, 595) ;--> Seleciona o tipo de numeração
	MouseClick("LEFT", 482, 357) ;--> Acessa a aba de parametros
	Send("{DOWN}{SPACE}")
	Send("{TAB 2}{SPACE}")
	Send("{TAB}{SPACE}")
	Send("{TAB}{SPACE}")
	Send("{TAB}{SPACE}")
	Send("{TAB 10}{SPACE}")

	MouseClick("LEFT", 848, 657) ;--> Clique no botão Gravar

	; Verifica se a tela de consulta existe e está ativa,
	; Se true, consulta a forma de pagamento gravada
	if (WinExists("", $sTextoTelaFormaPagto) And WinActive("", $sTextoTelaFormaPagto)) Then
		MouseClick("LEFT", 383, 272)
		Send($v_codigoFormaPagto & "{ENTER}")
	EndIf

EndFunc   ;==>f_incluirCadastroFormaPagto


Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADRÃO
	;------------------------------------
	$v_msgInicial = MsgBox($MB_OKCANCEL + $MB_ICONINFORMATION, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
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
