#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......:
	Data Inicio ....: 15/09/2015
	Data Termino ...: 15/09/2015
	Vers�o .........: 002 -> Refatora��o do c�digo de verifica��o de resolu��o
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

#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\funcMudarResolucao.au3" ; N�O REMOVER ESTE INCLUDE
#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\funcGeraCPF_CNPJ.au3" ; Utilizar a fun��o f_geraCPF() ou f_geraCNPJ() para obter um n�mero aleat�rio valido

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Vers�o"

Local $v_textoTelaConsulta = "Usu�rios Do Sistema"
Local $v_numeroRandomico = Random(1, 500, 1)
Local $v_loginUsuario = "USR"
Local $iCodigoGrupo = 1
Local $iCodigoColaborador = 1

;V_Fim *************************************************** V_Fim


;------------------------------------
; 	  INICIO EXECU��O DO SCRIPT
;------------------------------------

;--> VERIFICA SE O SISTEMA A SER TESTADO EST� ABERTO
$v_telaSistemaAtiva = WinExists("" & $v_tituloTelaSistema)

If $v_telaSistemaAtiva == 0 Then

	MsgBox(48, "", "Space Guardian n�o foi localizado!")
	Exit

EndIf

f_verificaAlteraResolucao() ; Verifica a resolu��o atual da tela -> (fun��o no final do script)

f_mensagemPadrao() ; Exibe mensagem padr�o e informativa -> (fun��o no final do script)
;________________________________________________________________________________________________________________

;BlockInput(0)

WinActivate("" & $v_tituloTelaSistema)

If WinExists("", "" & $v_textoTelaConsulta) And WinActive("", "" & $v_textoTelaConsulta) Then

	f_cadastrarUsuario()

Else

	Send("!a")
	Send("u{DOWN}{ENTER}")
	WinWaitActive("", "" & $v_textoTelaConsulta)

	f_cadastrarUsuario()

EndIf

;BlockInput(0)

;------------------------------------
; 	  FIM EXECU��O DO SCRIPT
;------------------------------------

;--------------------------------------------------------
; 		VERIFICA SE A RESOLU��O DA TELA FOI ALTERA
;--------------------------------------------------------

f_voltaResolucaoAnterior()


;************************* FUN��ES *****************************

Func f_cadastrarUsuario()

	Send("{F2}")
	WinWaitActive("", " Cadastro de Usu�rios")

	$v_loginUsuario &= $v_numeroRandomico
	MouseClick("LEFT", 423, 200) ; Click no textbox de Login
	Opt("SendKeyDelay", 20)
	Send($v_loginUsuario & "{TAB}")
	Send($v_loginUsuario & "-Teste{TAB}" & $iCodigoGrupo & "{TAB}" & $iCodigoColaborador)

	Sleep(1000)
	MouseClick("LEFT", 565, 450) ; Click no textbox de Senha
	Send("1{TAB}1{TAB}")

	Opt("SendKeyDelay", 30)
	Opt("MouseClickDelay", 30)
	MouseClick("LEFT", 502, 168) ; Click na aba de Filiais
	Send("{DOWN}{SPACE}")

	MouseClick("LEFT", 1000, 169) ; Click na aba de NFL
	Send("{TAB}1{TAB}")

	MouseClick("LEFT", 867, 580, 2) ; Click no bot�o Gravar
	WinWaitActive("", $v_textoTelaConsulta)
	MouseClick("LEFT", 411, 273) ; Click na coluna Login da tela de consulta
	Send($v_loginUsuario & "{ENTER}")
	Exit

EndFunc   ;==>f_cadastrarUsuario


Func f_mensagemPadrao()

	;------------------------------------
	; 			MENSAGEM PADR�O
	;------------------------------------
	$v_msgInicial = MsgBox(65, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			"Cadastrar Usu�rio" & @CR & @CR & _
			"OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
