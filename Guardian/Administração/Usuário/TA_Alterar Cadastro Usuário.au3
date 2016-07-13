#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......:
	Data Inicio ....: 14/10/2015
	Data Termino ...: 14/10/2015
	Versão .........: 002 -> Refatoração do código de verificação de resolução
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

#include "D:\Testes-Automatizados\TesteUIDesktop\_temp\func\funcMudarResolucao.au3" ; NÃO REMOVER ESTE INCLUDE
#include "D:\Testes-Automatizados\TesteUIDesktop\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a função f_geraCPF() ou f_geraCNPJ() para obter um número aleatório valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"

Local $v_textoTelaConsulta = "Usuários Do Sistema"
Local $v_numeroRandomico = Random(1, 500, 1)
Local $v_numeroUsuario = 0

;V_Fim *************************************************** V_Fim


;------------------------------------
; 	  INICIO EXECUÇÃO DO SCRIPT
;------------------------------------

;--> VERIFICA SE O SISTEMA A SER TESTADO ESTÁ ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox(48, "", "Space Guardian não foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função no final do script)

f_mensagemPadrao() ; Exibe mensagem padrão e informativa -> (função no final do script)
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
; 	  FIM EXECUÇÃO DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLUÇÃO DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUNÇÕES *****************************

Func f_alterarCadastroUsuario()

	MouseClick("LEFT", 407, 272)
	$v_loginUsuario = InputBox("Login do Usuário(Alteração)", "INFORME UM LOGIN DE USUÁRIO! ..:", "", "", 300, 140)

	If @error Then

		MsgBox(48, "", "O Script será finalizado!")
		Exit

	EndIf

	BlockInput(1)

	Opt("SendKeyDelay", 20)
	Send($v_loginUsuario & "{ENTER}{F3}")
	WinWaitActive("", " Cadastro de Usuários")

	MouseClick("LEFT", 586, 227) ;--> Foco no textbox Nome
	Send("{END}_ALTERADO")

	MouseClick("LEFT", 865, 580) ;--> Click no botão Gravar
	Sleep(500)

	If (WinExists("Informação", "Selecione pelo menos uma filial")) Then

		WinActivate("Informação", "Selecione pelo menos uma filial")
		Send("{ENTER}")

		MouseClick("LEFT", 486, 167) ;--> Click na aba Filiais
		Sleep(300)
		MouseClick("LEFT", 367, 236) ;--> Marca checkbox
		MouseClick("LEFT", 865, 580) ;--> Click no botão Gravar

	EndIf

	BlockInput(0)

	Exit

EndFunc   ;==>f_cadastrarUsuario


Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADRÃO
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Alterar Cadastro de Usuário" & @CR & @CR & _
			"OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
