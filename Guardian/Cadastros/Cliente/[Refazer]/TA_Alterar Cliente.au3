#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Alterar cadastro de Cliente no Guardian
	Data Inicio ....: 03/09/2015
	Data Termino ...: 08/09/2015
	Versão .........: 002 - 16/12/2015  -> Refatoração do código de verificação de resolução
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)		; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ;NÃO REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a função f_geraCPF ou f_geraCNPJ para obter um número aleatório valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"

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

	$v_codigoCliente = InputBox("Código do Cliente(Alteração)", "INFORME UM CÓDIGO DE CLIENTE! ..:", "", "", 260, 130)

	If @error Then

		MsgBox(48, "", "Script será finalizado!")
		Exit
	ElseIf ($v_codigoCliente == "") Then

		MsgBox(4096, "", "Informe um código!")

	EndIf

WEnd

;--> Acessa a tela de Alteração Cadastro de Cliente
Opt("SendKeyDelay", 10) ; Altera o tempo padrão do SendKey
Send($v_codigoCliente & "{ENTER}{F3}")
WinWaitActive("", "" & $v_textoTelaCadastradoCliente)
MouseClick("LEFT", 397, 140, 3)
Send($v_codigoCliente & " - Cliente TESTE_alterado")

;--> Altera condição de pagamento e adiciona não condições permitidas
Send("^f")
MouseClick("LEFT", 313, 227)
MouseClick("LEFT", 445, 450, 4)
Send("3{TAB}")
MouseClick("LEFT", 315, 332)
MouseClick("LEFT", 995, 252)
Send("3{ENTER 2}")

;-- Grava Alteração
MouseClick("LEFT", 857, 635)
Exit

;------------------------------------
; 	  FIM EXECUÇÃO DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLUÇÃO DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUNÇÕES *****************************

Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADRÃO
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Alterar Cadastro de Cliente" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
