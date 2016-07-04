#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Incluir cadastro de Cliente no Guardian
	Data Inicio ....: 01/09/2015
	Data Termino ...: 03/09/2015
	Versão .........: 002
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
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a função f_geraCPF() ou f_geraCNPJ() para obter um número aleatório valido

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"
;Local Const $v_CCSlarguraTela = 1366
;Local Const $v_CCSalturaTela = 768
;Local $v_larguraTela = @DesktopWidth
;Local $v_alturaTela = @DesktopHeight

Local $v_codigoCliente = ""

Local $v_textoTelaCadastradoCliente = "Cadastro de Clientes"
Local $v_numeroEndereco = Random(1, 999, 1)

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

;--> Acessa a tela de Inclusão Cadastro de Cliente
Send("{F2}")
WinWaitActive("", "" & $v_textoTelaCadastradoCliente)
MouseClick("LEFT", 447, 113, 2)
Send("^c")
Send("{TAB}")

;******************************************************
;-->			 DEFINIÇÕES DO FORM
;******************************************************
#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes Automatizados\_temp\form\frmTipoPessoa.kxf
$frmTipoPessoa = GUICreate("", 330, 111, 516, 98, BitOR($WS_SIZEBOX, $WS_THICKFRAME, $WS_SYSMENU, $WS_POPUP), $WS_EX_TOPMOST)
GUISetBkColor(0xA6CAF0)
$btnPessoaFisica = GUICtrlCreateButton("Fisíca", 53, 46, 93, 41)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$btnPessoaJuridica = GUICtrlCreateButton(" Jurídica", 184, 46, 93, 41)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label1 = GUICtrlCreateLabel("Selecione o tipo de Pessoa para o Cadastro!", 11, 14, 316, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $btnPessoaJuridica
			GUISetState(@SW_HIDE)
			WinActivate("", "" & $v_textoTelaCadastradoCliente)
			Opt("SendKeyDelay", 5) ; Altera o tempo padrão do SendKey
			Send("{SPACE}" & f_geraCNPJ() & "{TAB}")
			WinWaitActive("Atenção")
			Send("{ENTER}")
			ExitLoop

		Case $btnPessoaFisica
			GUISetState(@SW_HIDE)
			WinActivate("", "" & $v_textoTelaCadastradoCliente)
			Send("{RIGHT}{SPACE}")
			Opt("SendKeyDelay", 5) ; Altera o tempo padrão do SendKey
			Send("" & f_geraCPF() & "{TAB}")
			ExitLoop

		Case $GUI_EVENT_CLOSE
			;Exit

	EndSwitch
WEnd
;********************************************************************
;-->			** FIM ** DEFINIÇÕES DO FORM
;********************************************************************

Send("^v" & " - Cliente TESTE{TAB 6}")
Opt("SendKeyDelay", 500) ; Retorna o tempo padrão do SendKey

;--> Informa os dados do Endereço
Sleep(500)
Send("^b{ENTER}")
Opt("SendKeyDelay", 40) ; Altera o tempo padrão do SendKey
Send("32315120" & "{ENTER 3}")
Sleep(300)
Send($v_numeroEndereco)
MouseClick("LEFT", 845, 328, 3)
Send("1{TAB 5}")
Send("^v")
Send("@email.com{TAB}{ENTER}")

;--> Informa os dados das Regras
Sleep(500)
Send("^f")
MouseClick("LEFT", 313, 231)
MouseClick("LEFT", 458, 450, 4)
Send("1")
MouseClick("LEFT", 443, 478, 3)
Send("BL{TAB}")
MouseClick("LEFT", 314, 442)
Send("{ENTER 2}BL{ENTER 2}")

;--> Informa os dados de Logistica
Sleep(500)
Send("^g")
Send("1{ENTER}2{ENTER 2}1{TAB}")

; Adicionado na versão 002 do script

MouseClick("LEFT", 355, 333)

;--> Informa os dados de Financeiro
Sleep(500)
Send("^h")
Send("{TAB 2}9000{ENTER}")
MouseClick("LEFT", 856, 635)

;--> Pesquisa o cliente cadastrado

WinWaitActive("", "Clientes")
MouseClick("LEFT", 341, 282)
Send("^v{ENTER}")
Exit

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
			"Incluir Cadastro de Cliente" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		_ChangeEscreenRes($v_larguraTela, $v_alturaTela)
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
