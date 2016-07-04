#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Efetuar a inclusão de cadastro de produto no Space Guardian
	Data Inicio ....: 10/09/2015
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
Opt("MouseClickDelay", 20) ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)		; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ; NÃO REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a função f_geraCPF ou f_geraCNPJ para obter um número aleatório valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

Local $v_textoTelaConsultaProduto = "Tabela De Produtos"
Local $v_codigoDeBarras = Random(1000000000, 9999999999, 1)

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

;--> Acessa a tela de Consulta de Produto
Send("!c")
Send("p{ENTER}")
WinWaitActive("", "" & $v_textoTelaConsultaProduto)

;--> Acessa a tela de Inclusão Cadastro de Produto
Send("{F2}")
WinWaitActive("", "Cadastro de Produtos")
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
Send("{TAB 2}1{TAB}1{TAB}")
MouseClick("LEFT", 485, 285)
Sleep(200)
Send("{TAB}{SPACE}")
Sleep(200)
Send("{TAB}{SPACE}")
Sleep(200)
Send("{TAB}{SPACE}")
MouseClick("LEFT", 1022, 502)

;--> Gera Código de Barras
Send("^d{ENTER}")
Send("UN{TAB}1{TAB}" & $v_codigoDeBarras)
MouseClick("LEFT", 1015, 380)


;--> Informa os dados de Impostos
Send("^g")

Sleep(500)
If WinExists("Atenção") Then
	Send("{ENTER}")
EndIf ;----> IF CRIADO DEVIDO UM ERRO AO ACESSAR A ABA DE IMPOSTOS UTILIZANDO O ATALHO

MouseClick("LEFT", 468, 257)
Send("2{TAB 2}")
Send("{F1}{TAB 3}{ENTER 2}")
MouseClick("LEFT", 617, 550)

;--> Grava o Produto
Send("1{ENTER 2}")
Sleep(1000)

;--> Se o código do produto não for gerado automáticamente no Guardian o mesmo e solicitado ao tentar gravar o registro
If WinExists("Informação", "Campo Obrigatório não preenchido ! Campo: Código") Then

	$v_codigoProduto = InputBox("Código do Produto", "INFORME UM CÓDIGO PARA O PRODUTO! ..:", "", "", 260, 140)

	If @error Then

		MsgBox(48,"","O Script será finalizado!")
		Exit

	Else

		WinActivate("Informação", "Campo Obrigatório não preenchido ! Campo: Código")
		Send("{ENTER}" & $v_codigoProduto & "{TAB}")

		$v_codigoJaCadastrado = WinExists("Informação")

		While ($v_codigoJaCadastrado == 1)

			WinWaitActive("Informação")
			WinActivate("Informação")
			Send("{ENTER}")
			MouseClick("LEFT", 430, 147, 3)
			$v_codigoProduto = InputBox("Código do Produto", "INFORME OUTRO CÓDIGO PARA O PRODUTO! ..:", "", "", 260, 140)

				If @error Then

					MsgBox(48,"","O Script será finalizado!")
					Exit

				EndIf

			Send("" & $v_codigoProduto)
			Send("{TAB}")
			Sleep(500)
			$v_codigoJaCadastrado = WinExists("Informação")

		WEnd

		;--> Corrigi a Descrição do Produto adicionando o Código que foi informado manualmente
		Send("^+{RIGHT}")
		Send($v_codigoProduto & "{TAB}")
		Send("{END}^+{LEFT}")
		Send($v_codigoProduto & "")

		;--> Grava o Produto, verifica se a Tela de Manuteção de Estoque Existe e Pesquisa o Produto na tela de consulta
		MouseClick("LEFT", 886, 600)
		f_telaManutecaoEstoque()
		WinWaitActive("", "" & $v_textoTelaConsultaProduto)
		MouseClick("LEFT", 397, 260)
		Send($v_codigoProduto & "{ENTER}")

	EndIf
Else

	;--> Verifica se a Tela de Manuteção de Estoque Existe e Pesquisa o Produto na tela de consulta
	f_telaManutecaoEstoque()
	WinWaitActive("", "" & $v_textoTelaConsultaProduto)
	MouseClick("LEFT", 397, 260)
	Send("^v{ENTER}")
	Exit

EndIf


;------------------------------------
; 	  FIM EXECUÇÃO DO SCRIPT
;------------------------------------


;--------------------------------------------------------
; 		VERIFICA SE A RESOLUÇÃO DA TELA FOI ALTERA
;--------------------------------------------------------
If ($v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela) Then

	_ChangeEscreenRes($v_larguraTela, $v_alturaTela)

EndIf


;************************* FUNÇÕES *****************************

Func f_telaManutecaoEstoque()

	If WinExists("", "Manutenção de Endereços de Estoque") Then

		Sleep(1000)
		If WinActive("", "Manutenção de Endereços de Estoque") Then

			Send("{ESC}{ENTER}")

		EndIf
	EndIf

EndFunc   ;==>f_telaManutecaoEstoque

Func f_verificaAlteraResolucao()

	;------------------------------------
	; VERIFICA E ALTERA RESOLUÇÃO DA TELA
	;------------------------------------
	If $v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela Then

		MsgBox(48, "ALERTA! - (" & $v_larguraTela & " x " & $v_alturaTela & ")", "RESOLUÇÃO INCOMPATIVEL PARA" & @CR & _
				"EXECUÇÃO DA ROTINA AUTOMATIZADA! " & @CR & @CR & _
				"RESOLUÇÃO NECESSÁRIO PARA " & @CR & _
				"EFETUAR OS TESTE: " & $v_CCSlarguraTela & " x " & $v_CCSalturaTela)

		Local $v_mensagemAlteraResolucao = MsgBox(36, "", "Deseja alterar a resolução?")
		If $v_mensagemAlteraResolucao == 6 Then

			_ChangeEscreenRes($v_CCSlarguraTela, $v_CCSalturaTela)

			;----------------------------------------------------
			; Verifica se a alteração da resolução foi realizada
			;----------------------------------------------------
			If ($v_larguraTela == $v_CCSlarguraTela And $v_alturaTela == $v_CCSalturaTela) Or ($v_larguraTela <> $v_CCSlarguraTela And $v_alturaTela <> $v_CCSalturaTela) Then

				MsgBox(16, "", "A resolução " & $v_CCSlarguraTela & " x " & $v_CCSalturaTela & " NÃO e suportada pelo seu monitor" & @CR & @CR & _
						"A EXECUÇÃO DO SCRIPT SERÁ ENCERRADA!")
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
	; 			MENSAGEM PADRÃO
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
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
