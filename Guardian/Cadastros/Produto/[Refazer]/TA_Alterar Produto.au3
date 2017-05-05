#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Realizar a alteração do cadastro de um produto
	Data Inicio ....: 11/09/2015
	Data Termino ...: 11/09/2015
	Versão .........: 002 - 16/12/2015 -> Refatoração do código de verificação de resolução
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

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" 		; NÃO REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" 		; Utilizar a função f_geraCPF ou f_geraCNPJ para obter um número aleatório valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"

Local $v_textoTelaConsultaProduto = "Tabela De Produtos"

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

BlockInput(1)

WinActivate("" & $v_tituloTelaSistema)

;--> Acessa a tela de Consulta de Produto
Send("!c")
Send("p{ENTER}")
WinWaitActive("", "" & $v_textoTelaConsultaProduto)

;--> Acessa a tela de Inclusão Cadastro de Produto
MouseClick("LEFT",395, 260) ; Click na coluna de Código na tela de Consulta

BlockInput(0)

$v_codigoProduto = InputBox("Código do Produto(Alteração)", "INFORME UM CÓDIGO DE PRODUTO! ..:", "", "", 260, 140)

If @error Then

	MsgBox(48, "", "O Script será finalizado!")
	Exit

EndIf

BlockInput(1)

MouseClick("LEFT", 588, 203, 3) ; Foco no textbox de Busca
Opt("SendKeyDelay", 20) ;--> Altera o Delay do comando SEND
Send($v_codigoProduto & "{ENTER}{F3}")
WinWaitActive("", "Cadastro de Produtos")
MouseClick("LEFT", 600, 123, 3) ; Foco no textbox de Descrição
Send($v_codigoProduto & "-Produto Teste_alterado{TAB}")
MouseClick("LEFT", 427, 150, 3) ; Foco no textbox Desc. Resumida
Send("Prod_alterado-" & $v_codigoProduto)
MouseClick("LEFT", 886, 621)
Exit

BlockInput(0)

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
			"Alterar Cadastro de Produto"& @CR & @CR & _
			"OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
