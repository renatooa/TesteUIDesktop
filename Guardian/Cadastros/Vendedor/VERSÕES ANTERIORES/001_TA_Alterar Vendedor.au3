#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Alterar cadastro de Vendedor no Guardian
	Data Inicio ....: 01/09/2015
	Data Termino ...: 01/09/2015
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)				; Debug na caixa de dica do icone da bandeja.
;Opt("WinWaitDelay", 200)			; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)			; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)		; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)		; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.
;Opt("SendKeyDelay", 300)			; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)			; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3" ;NÃO REMOVER ESTE INCLUDE

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

Local Const $v_tituloTelaSistema = "Space Guardian - Versão"
Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768
Local $v_larguraTela = @DesktopWidth
Local $v_alturaTela = @DesktopHeight

Local $v_codigoVendedor = ""

Local $v_tituloTelaCodigoJaCadastrado = "Codigo já cadastrado"

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

Send("!c")
Sleep(1000)
Send("v")
Sleep(1000)
Send("{ENTER}")

WinWaitActive("", "Vendedores")

MouseClick("LEFT", 386, 272)
MouseClick("LEFT", 480, 238, 3)

While ($v_codigoVendedor == "")

$v_codigoVendedor = InputBox("Código do Vendedor(Alteração)", "INFORME UM CÓDIGO DE VENDEDOR! ..:","","", 260, 130)

	If @error Then

		MsgBox(48,"","Script será finalizado!")
		Exit
	ElseIf ($v_codigoVendedor == "") Then

		MsgBox(4096,"","Informe um código!")

	EndIf

WEnd

Send("" & $v_codigoVendedor & "{ENTER}")
Send("{F3}")
WinWaitActive("", "Cadastro de Vendedores")

MouseClick("LEFT", 754, 197, 3)

Send($v_codigoVendedor & " - Vendedor Incluso - TESTE NFL_alterado")

MouseClick("LEFT", 855, 577)
Sleep(1000)
;$v_textoTelaCampoSemValor = WinExists("", "Campo Obrigatório não preenchido ! Campo: LOGRADOURO")

If WinExists("Informação", "LOGRADOURO") Then

	WinWaitActive("Informação", "LOGRADOURO")
	Send("{ENTER}")
	Sleep(500)
	MouseClick("LEFT", 730, 252)
	Send("rua alterada")
	Sleep(500)
	MouseClick("LEFT", 855, 577)

EndIf

;***********************************************************************************
If ($v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_CCSalturaTela) Then
	f_voltaResolucaoAnterior()
EndIf
;***********************************************************************************

;------------------------------------
; 	  FIM EXECUÇÃO DO SCRIPT
;------------------------------------




;************************* FUNÇÕES *****************************

Func f_voltaResolucaoAnterior()

	_ChangeEscreenRes($v_larguraTela, $v_alturaTela)

EndFunc   ;==>f_voltaResolucaoAnterior


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
			"Alterar Cadastro de Vendedor" _
			 & @CR & @CR & "OBS.:" & @CR & _
			"* O Space Guardian precisa estar aberto!")

	If $v_msgInicial == 2 Then

		f_voltaResolucaoAnterior
		Exit

	EndIf

EndFunc   ;==>f_mensagemPadrao

;F_Fim *************************************************** F_Fim
