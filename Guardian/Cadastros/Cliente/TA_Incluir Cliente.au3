#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Incluir cadastro de Cliente no Guardian
	Data Inicio ....: 01/09/2015
	Data Termino ...: 03/09/2015
	Vers�o .........: 003  16/12/2015  -> Refatora��o do c�digo de verifica��o de resolu��o
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente ap�s uma opera��o bem-sucedida com janela.
;Opt("MouseClickDelay", 10)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o bot�o � mantido pressionado antes da libera��o.
;Opt("MouseClickDragDelay", 250)		; Altera o tamanho da pausa breve no in�cio e no final de uma opera��o arrastar do mouse.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla � mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Testes-Automatizados\TesteUIDesktop\_temp\func\funcMudarResolucao.au3" ;N�O REMOVER ESTE INCLUDE
#include "D:\Testes-Automatizados\TesteUIDesktop\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a fun��o f_geraCPF() ou f_geraCNPJ() para obter um n�mero aleat�rio valido

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Vers�o"

Local $v_codigoCliente = ""

Local $v_textoTelaCadastradoCliente = "Cadastro de Clientes"
Local $v_numeroEndereco = Random(1, 999, 1)

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

;BlockInput(1)

WinActivate("" & $v_tituloTelaSistema)

;--> Acessa a tela de Consulta de Cliente
Send("!c")
Send("{ENTER}")
WinWaitActive("", "Clientes")

;--> Acessa a tela de Inclus�o Cadastro de Cliente
Send("{F2}")
WinWaitActive("", "" & $v_textoTelaCadastradoCliente)
MouseClick("LEFT", 447, 113, 2)
Send("^c")
Send("{TAB}")

;BlockInput(0)
;******************************************************
;-->			 DEFINI��ES DO FORM
;******************************************************
#Region
#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes Automatizados\_temp\form\frmTipoPessoa.kxf
$frmTipoPessoa = GUICreate("", 330, 111, 516, 98, BitOR($WS_SIZEBOX, $WS_THICKFRAME, $WS_SYSMENU, $WS_POPUP), $WS_EX_TOPMOST)
GUISetBkColor(0xA6CAF0)
$btnPessoaFisica = GUICtrlCreateButton("Fis�ca", 53, 46, 93, 41)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$btnPessoaJuridica = GUICtrlCreateButton(" Jur�dica", 184, 46, 93, 41)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Label1 = GUICtrlCreateLabel("Selecione o tipo de Pessoa para o Cadastro!", 11, 14, 316, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $btnPessoaJuridica
			;BlockInput(1)
			GUISetState(@SW_HIDE)
			WinActivate("", "" & $v_textoTelaCadastradoCliente)
			Opt("SendKeyDelay", 5) ; Altera o tempo padr�o do SendKey
			Send("{SPACE}" & f_geraCNPJ() & "{TAB}")
			WinWaitActive("Aten��o")
			Send("{ENTER}")
			ExitLoop

		Case $btnPessoaFisica
			;BlockInput(1)
			GUISetState(@SW_HIDE)
			WinActivate("", "" & $v_textoTelaCadastradoCliente)
			Send("{RIGHT}{SPACE}")
			Opt("SendKeyDelay", 5) ; Altera o tempo padr�o do SendKey
			Send("" & f_geraCPF() & "{TAB}")
			ExitLoop

		Case $GUI_EVENT_CLOSE
			;Exit

	EndSwitch
WEnd
#EndRegion
;********************************************************************
;-->			** FIM ** DEFINI��ES DO FORM
;********************************************************************

Send("^v" & " - Cliente TESTE{TAB 9}")
Opt("SendKeyDelay", 500) ; Retorna o tempo padr�o do SendKey

;--> Informa os dados do Endere�o
Sleep(500)
Send("^b{ENTER}")
Opt("SendKeyDelay", 40) ; Altera o tempo padr�o do SendKey
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

; Adicionado na vers�o 002 do script

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

;BlockInput(0)
Exit

;------------------------------------
; 	  FIM EXECU��O DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLU��O DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUN��ES *****************************

Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADR�O
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Incluir Cadastro de Cliente" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
