#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Efetuar a inclus�o de cadastro de produto no Space Guardian
	Data Inicio ....: 10/09/2015
	Data Termino ...:
	Vers�o .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)				; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente ap�s uma opera��o bem-sucedida com janela.
Opt("MouseClickDelay", 20)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o bot�o � mantido pressionado antes da libera��o.
;Opt("MouseClickDragDelay", 250)		; Altera o tamanho da pausa breve no in�cio e no final de uma opera��o arrastar do mouse.
Opt("SendKeyDelay", 100)			; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla � mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" 		; N�O REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" 		; Utilizar a fun��o f_geraCPF ou f_geraCNPJ para obter um n�mero aleat�rio valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Vers�o"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

Local $v_textoTelaConsultaProduto = "Tabela De Produtos"
Local $v_codigoDeBarras = Random(1000000000, 9999999999, 1)

;V_Fim *************************************************** V_Fim




;------------------------------------
; 	  INICIO EXECU��O DO SCRIPT
;------------------------------------

; VERIFICA SE O SISTEMA A SER TESTADO EST� ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox(48, "", "Space Guardian n�o foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolu��o atual da tela -> (fun��o no final do script)

f_mensagemPadrao() ; Exibe mensagem padr�o e informativa -> (fun��o no final do script)
;________________________________________________________________________________________________________________

WinActivate("" & $v_tituloTelaSistema)

;--> Acessa a tela de Consulta de Produto
Send("!c")
Send("p{ENTER}")
WinWaitActive("", "" & $v_textoTelaConsultaProduto)

;--> Acessa a tela de Inclus�o Cadastro de Produto
Send("{F2}")
WinWaitActive("","Cadastro de Produtos")
MouseClick("LEFT", 458, 147, 2)
Send("^c{TAB}")
Opt("SendKeyDelay", 20) ;--> Altera o Delay do comando SEND
Send("^v" & "-Produto Teste")
Send("{TAB}Produto-" & "^v")
MouseClick("LEFT", 658, 239, 3)
Send("1{TAB}1{TAB}")
MouseClick("LEFT", 425, 369, 3)
Send("1{TAB 5}00{TAB}")
MouseClick("LEFT", 757, 555)

;--> Informa os dados da Unidade
Send("^b{ENTER}")
Send("UN{TAB}Unidade{TAB}1")
;MouseClick("LEFT", 805, 238)
Send("{TAB 2}1{TAB}1{TAB}")
MouseClick("LEFT", 485, 285)
Sleep(200)
Send("{TAB}{SPACE}")
Sleep(200)
Send("{TAB}{SPACE}")
Sleep(200)
Send("{TAB}{SPACE}")
MouseClick("LEFT", 1022, 502)

;--> Gera C�digo de Barras
Send("^d{ENTER}")
Send("UN{TAB}1{TAB}" & $v_codigoDeBarras)
MouseClick("LEFT", 1015, 380)


;--> Informa os dados de Impostos
Send("^g")

If WinExists("Aten��o") Then
	Send("{ENTER}")
EndIf ;----> IF CRIADO DEVIDO UM ERRO AO ACESSAR A ABA DE IMPOSTOS UTILIZANDO O ATALHO

MouseClick("LEFT", 468, 257)
Send("2{TAB 2}")
Send("{F1}{TAB 3}{ENTER 2}")
MouseClick("LEFT", 617, 550)

;--> Grava e Pesquisa o Produto
Send("1{ENTER 2}")
Sleep(1000)

If WinExists("","Campo Obrigat�rio n�o preenchido ! Campo: C�digo") Then

	$v_codigoProduto = InputBox("C�digo do Produto", "INFORME UM C�DIGO PARA O PRODUTO! ..:", "", "", 260, 140)

	If @error Then
		Exit
	EndIf

	WinActivate("","Campo Obrigat�rio n�o preenchido ! Campo: C�digo")
	Send("{ENTER}" & $v_codigoProduto & "{TAB}")

	$v_codigoJaCadastrado = WinExists("Informa��o")

		While ($v_codigoJaCadastrado == 1)
			WinWaitActive("Informa��o")
			WinActivate("Informa��o")
			Send("{ENTER}")
			;$v_codigoProduto = $v_codigoProduto + 1
			MouseClick("LEFT", 430, 147, 3)
			$v_codigoProduto = InputBox("C�digo do Produto", "INFORME OUTRO C�DIGO PARA O PRODUTO! ..:", "", "", 260, 140)
			Send(""& $v_codigoProduto)
			Send("{TAB}")
			Sleep(500)
			$v_codigoJaCadastrado = WinExists("Informa��o")

		WEnd

	Send("^+{RIGHT}")
	Send($v_codigoProduto & "{TAB}")
	Send("{END}^+{LEFT}")
	Send($v_codigoProduto & "")

	MouseClick("LEFT", 886, 600)
	f_telaManutecaoEstoque()
	WinWaitActive("","" & $v_textoTelaConsultaProduto)
	MouseClick("LEFT", 397, 260)
	Send($v_codigoProduto & "{ENTER}")

Else

f_telaManutecaoEstoque()
WinWaitActive("","" & $v_textoTelaConsultaProduto)
MouseClick("LEFT", 397, 260)
Send("^v{ENTER}")

EndIf


;------------------------------------
; 	  FIM EXECU��O DO SCRIPT
;------------------------------------


;--------------------------------------------------------
; 		VERIFICA SE A RESOLU��O DA TELA FOI ALTERA
;--------------------------------------------------------
If ($v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela) Then

	_ChangeEscreenRes($v_larguraTela, $v_alturaTela)

EndIf


;************************* FUN��ES *****************************

Func f_telaManutecaoEstoque()

	If (WinExists("", "Manuten��o de Endere�os de Estoque")) Then

		WinActivate("","Manuten��o de Endere�os de Estoque")
		Send("{ESC}{ENTER}")

	EndIf

EndFunc

Func f_verificaAlteraResolucao()

	;------------------------------------
	; VERIFICA E ALTERA RESOLU��O DA TELA
	;------------------------------------
	If $v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela Then

		MsgBox(48, "ALERTA! - (" & $v_larguraTela & " x " & $v_alturaTela & ")", "RESOLU��O INCOMPATIVEL PARA" & @CR & _
				"EXECU��O DA ROTINA AUTOMATIZADA! " & @CR & @CR & _
				"RESOLU��O NECESS�RIO PARA " & @CR & _
				"EFETUAR OS TESTE: " & $v_CCSlarguraTela & " x " & $v_CCSalturaTela)

		Local $v_mensagemAlteraResolucao = MsgBox(36, "", "Deseja alterar a resolu��o?")
		If $v_mensagemAlteraResolucao == 6 Then

			_ChangeEscreenRes($v_CCSlarguraTela, $v_CCSalturaTela)

			;----------------------------------------------------
			; Verifica se a altera��o da resolu��o foi realizada
			;----------------------------------------------------
			If ($v_larguraTela == $v_CCSlarguraTela And $v_alturaTela == $v_CCSalturaTela) Or ($v_larguraTela <> $v_CCSlarguraTela And $v_alturaTela <> $v_CCSalturaTela) Then

				MsgBox(16, "", "A resolu��o " & $v_CCSlarguraTela & " x " & $v_CCSalturaTela & " N�O e suportada pelo seu monitor" & @CR & @CR & _
						"A EXECU��O DO SCRIPT SER� ENCERRADA!")
				Exit

			EndIf

		Else
			MsgBox(48, "", "SCRIPT FINALZADO!")
			Exit
		EndIf

	EndIf

EndFunc   ;==>f_verificaAlteraResolucao


Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADR�O
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Incluir Cadastro de Produto" & @CR & @CR & _
			"OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!" & @CR & _
			"* Utilizar a base de dados da empresa XXXXXX")

	If $v_msgInicial == 2 Then

		If ($v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela) Then

			_ChangeEscreenRes($v_larguraTela, $v_alturaTela)

		EndIf

		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
