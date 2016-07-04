#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Incluir cadastro de Vendedor no Guardian
	Data Inicio ....: 10/09/2015
	Data Termino ...: 10/09/2015
	Versão .........: 003 - 16/12/2015 -> Refatoração do código de verificação de resolução
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
Local Const $sTextoTelaDeConcultaVendedor = "Vendedores"

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

;--> Acessa tela de Consulta de Vendedor
Send("!c")
Send("v")
Send("{ENTER}")

WinWaitActive("", $sTextoTelaDeConcultaVendedor)

;--> Acessa tela de Inclusão Cadastro de Vendedor
Send("{F2}")
WinWaitActive("", "Cadastro de Vendedores")
MouseClick("LEFT", 512, 170, 2)
Send("^c")
Opt("SendKeyDelay", 20)
Send("{TAB}{RIGHT}")
Send("{SPACE}{TAB}")
Send("^v" & " - Vendedor Teste")
Send("{TAB 2}" & f_geraCPF())
MouseClick("LEFT", 460, 338, 3)
Send("2{ENTER}")

;--> Informa os dados do Endereço
Send("^b")
MouseClick("LEFT", 730, 252)
Send("Rua Teste")

;--> Informa os dados Relativo à Venda
Send("^e")

; IMPLEMENTAÇÂO CRIADA PARA TRATAMENTO
; DO MESSANGEBOX DO ERRO Unknown member TXT_CLBESCOLARID.
Sleep("1000")
If(WinExists("Atenção (10)")) Then
	Send("{ENTER}{TAB 5}")
ElseIf(WinExists("Program Error")) Then
	Send("i")
EndIf
; FIM TRATAMENTO DE ERRO

Send("{SPACE}")
Send("{DOWN}")
Send("{SPACE}")

;--> Grava e Pesquisa
MouseClick("LEFT", 849, 575)

Sleep(3000)

If WinExists("", $sTextoTelaDeConcultaVendedor) And WinActive("", $sTextoTelaDeConcultaVendedor) Then
	MouseClick("LEFT", 393, 265)
	Send("^v{ENTER}")
Else
	MsgBox(48,"","Cadastro não foi salvo, verifique!")
	Exit
EndIf


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
			"Incluir Cadastro de Vendedor" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!" & @CR & _
			"* Utilizar o Banco de Dados DEPSANTAROSA")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
