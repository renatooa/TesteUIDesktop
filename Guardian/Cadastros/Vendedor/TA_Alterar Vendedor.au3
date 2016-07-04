#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Alterar cadastro de Vendedor no Guardian
	Data Inicio ....: 10/09/2015
	Data Termino ...: 10/09/2015
	Versão .........: 003 - 16/12/2015  -> Refatoração do código de verificação de resolução
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

#include <MsgBoxConstants.au3>
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ; NÃO REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a função f_geraCPF ou f_geraCNPJ para obter um número aleatório valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"

Local $v_codigoVendedor = ""
Local $v_textoTelaLogradouro = "Campo Obrigatório não preenchido ! Campo: LOGRADOURO"

;V_Fim *************************************************** V_Fim



;------------------------------------
; 	  INICIO EXECUÇÃO DO SCRIPT
;------------------------------------

; VERIFICA SE O SISTEMA A SER TESTADO ESTÁ ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox($MB_ICONWARNING, "", "Space Guardian não foi localizado!")
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
WinWaitActive("", "Vendedores")
MouseClick("LEFT", 386, 272)
MouseClick("LEFT", 480, 238, 3)

;--> Solicita Código de Vendedor
While ($v_codigoVendedor == "")

	$v_codigoVendedor = InputBox("Código do Vendedor(Alteração)", "INFORME UM CÓDIGO DE VENDEDOR! ..:", "", "", 260, 130)

	If @error Then

		MsgBox($MB_ICONWARNING, "", "Script será finalizado!")
		Exit

	ElseIf ($v_codigoVendedor == "") Then

		MsgBox(4096, "", "Informe um código!")

	EndIf

WEnd

Opt("SendKeyDelay", 20)
;--> Acessa tela de Alteração Cadastro de Vendedor
Send("" & $v_codigoVendedor & "{ENTER}{F3}")
WinWaitActive("", "Cadastro de Vendedores")

MouseClick("LEFT", 754, 197, 3)
Send($v_codigoVendedor & " - Vendedor TESTE_alterado")
MouseClick("LEFT", 855, 577)

;--> Verifica se a tela de Logradouro não preenchido existe
If WinExists("", "" & $v_textoTelaLogradouro) Then

	WinWaitActive("", "" & $v_textoTelaLogradouro)
	Send("{ENTER}")
	Send("rua teste_alterada")
	MouseClick("LEFT", 855, 577)

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
			"Alterar Cadastro de Vendedor" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
