#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......:
	Data Inicio ....: 15/09/2015
	Data Termino ...: 15/09/2015
	Versão .........: 001
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

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ; NÃO REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a função f_geraCPF() ou f_geraCNPJ() para obter um número aleatório valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"
;Local Const $v_CCSlarguraTela = 1366
;Local Const $v_CCSalturaTela = 768
;Local $v_larguraTela = @DesktopWidth
;Local $v_alturaTela = @DesktopHeight

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

	f_cadastrarUsuario()

Else

	Send("!a")
	Send("u{DOWN}{ENTER}")
	WinWaitActive("", "" & $v_textoTelaConsulta)

	f_cadastrarUsuario()

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

Func f_cadastrarUsuario()

	Send("{F2}")
	WinWaitActive("", " Cadastro de Usuários")

	$v_numeroUsuario = $v_numeroRandomico
	MouseClick("LEFT", 425, 199)
	Opt("SendKeyDelay", 20)
	Send("usr" & $v_numeroUsuario & "{TAB}")
	Send($v_numeroUsuario & "-Usuario Teste{TAB}1{TAB}1{TAB 7}")
	Send("1{TAB}1{TAB}")

	MouseClick("LEFT", 501, 168)
	Send("{DOWN}{SPACE}")

	MouseClick("LEFT", 868, 579)
	WinWaitActive("", "" & $v_textoTelaConsulta)
	MouseClick("LEFT", 411, 273)
	Send("usr" & $v_numeroUsuario & "{ENTER}")
	Exit

EndFunc   ;==>f_cadastrarUsuario

#cs
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
#ce

Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADRÃO
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Cadastrar Usuário" & @CR & @CR & _
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
