#cs ===============================================================================================================================
	Típo de Script .: (Script de Função - UDF, Script Execução de Teste)
	Descrição ......:
	Data Inicio ....:
	Data Termino ...:
	Versão .........: 001
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
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" 		; Utilizar a função f_geraCPF() ou f_geraCNPJ() para obter um número aleatório valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

Local $v_codigoRandom = Random(0,999, 1)
Local $v_codigoFormaPagto = 0

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

If WinExists("", "Formas De Pagamento") Then

	Send("{ESC}{ENTER}")
	MouseClick("LEFT", 650, 320)
	Sleep(500)

EndIf

	Send("!c")
	Send("ff{LEFT}f{ENTER}")
	WinWaitActive("", "Formas De Pagamento")





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

Func f_incluirCadastroFormaPagto()

	Send("{F2}")
WinWaitActive("", "Cadastro de Formas de Pagamento")

$v_codigoFormaPagto = $v_codigoRandom
Opt("SendKeyDelay", 30) ;--> Altera o Delay do comando SEND
Send($v_codigoFormaPagto & "{TAB}")
Send($v_codigoFormaPagto & "-Forma Pagto Teste{TAB 2}")
Send("3{TAB}86{TAB 2}118{TAB}")

MouseClick("LEFT", 478, 375)
Send("1{TAB 2}numero{TAB}10{TAB}9999999999")
MouseClick("LEFT", 488, 580)
MouseClick("LEFT", 513, 340)
Send("{DOWN}{SPACE}")
Send("{TAB 2}{SPACE}")
Send("{TAB}{SPACE}")
Send("{TAB}{SPACE}")
Send("{TAB}{SPACE}")
Send("{TAB 10}{SPACE}")

MouseClick("LEFT", 848, 642)
MouseClick("LEFT", 383, 272)
Send($v_codigoFormaPagto & "{ENTER}")

EndFunc

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
			"Incluir Orçamento" & @CR & "BUG no preço de oferta com prazo diferente do permitido" _
			 & @CR & @CR & "OBS.:" & @CR & _
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
