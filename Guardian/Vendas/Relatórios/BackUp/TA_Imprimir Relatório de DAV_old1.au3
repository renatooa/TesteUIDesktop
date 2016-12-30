#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Efetuar a impress�o de todos os modelos do Relat�rio de DAV
	Data Inicio ....: 05/12/2016
	Data Termino ...: ~
	Vers�o .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 200) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla � mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente ap�s uma opera��o bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o bot�o � mantido pressionado antes da libera��o.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no in�cio e no final de uma opera��o arrastar do mouse.

#include <Debug.au3>
#include <MsgBoxConstants.au3>

#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#cs ===============================================================================================================================
	$sTituloDaTelaPrincipalDoSistema -> Informar o valor obtido pelo Autoit Window Info do campo 'title'.
	$sNomeDoSistema -> Nome do sistema a ser testado pelo script.
#ce ===============================================================================================================================
Local Const $sTituloDaTelaPrincipalDoSistema = $TITULO_TELA_PRINCIPAL_GUARDIAN
Local Const $sNomeDoSistema = $NOME_SPACE_GUARDIAN

Local $sTituloTelaReport
Local $iModeloAtual = 1
Local $iQtdeModelos = 27
Local $iLoopModelo7 = 3

;;; VARIAVEIS COM EIXO X, Y UTILIZADAS NA FUN��O MouseClick()
Local Const $iMaximixarReportEixoX = 569
Local Const $iMaximixarReportEixoY = 61

#EndRegion ### VARIAVEIS

#Region ### EXECU��O DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ;;; Fun��o da UDF Validacoes.au3

VerificaAlteraResolucao() ;;; Verifica a resolu��o atual da tela -> (fun��o da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Impress�o do Relat�rio de DAV com todos os modelos") ;;; Exibe mensagem informativa -> (fun��o na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

AbreVendasRelatoriosRelDAV()

;;; Realiza pesquisa de ordem de compra por periodo
;Send("{TAB 2}01" & @MON - 2 & @YEAR & "{TAB}" & @MDAY & @MON & @YEAR)

;;; Loop para imprimir os modelos disponiveis
For $iContador = 1 To $iQtdeModelos Step +1

	;;;[DEBUG]
	ConsoleWrite("*************** LOOP * " & $iContador & " ***************" & @CRLF)
	ConsoleWrite("1 - ModeloAtual -> " & $iModeloAtual & @CRLF)

	If ( $iContador == 26 And $iModeloAtual == 27 ) Then
		ExitLoop
	EndIf

	$iModeloAtual = ( $iModeloAtual <= $iContador ) ? $iContador : $iModeloAtual + 1

	; If ( $iLoopModelo7 == 2 Or $iLoopModelo7 == 3) Then
	; 	$iContador = 5
	; EndIf

	;;;[DEBUG]
	ConsoleWrite("Contador -> " & $iContador & @CRLF)
	ConsoleWrite("2 - ModeloAtual -> " & $iModeloAtual & @CRLF)
	ConsoleWrite("1 - QtdeModelos -> " & $iQtdeModelos & @CRLF)

	Send("^b") ;CTRL + B

	;$sTituloTelaReport = "Report Designer - frxpedsaidamod" & $iContador
	$sTituloTelaReport = "Report Designer - frxpedsaidamod" & $iModeloAtual

	Switch ($iModeloAtual)
		Case 1
			;;; A��o realizada se for o Modelo 1
			Send("{ENTER}")

		Case 2
			;;; A��o realizada se for o Modelo 2
			ImprimirModelo($iContador, "{TAB 2}")

		Case 5
			;;; A��o realizada se a variavel $iModeloAtual for == 5.
			;;; Valida��o necess�ria pois o RadioButton do modelo 5 no Guardian fica Bloqueado.
			;;; Desta forma a a��o de TAB a partir do modelo 4 vai para o modelo 6 ou 7.
			ImprimirModelo($iContador, "{TAB 2}")
			TelaDesejaFecharSessaoExiste("{ENTER}{LEFT}{ENTER}")

		Case 7
			;;; A��o realizada se for o Modelo 7
			For $i = 1 To $iLoopModelo7 Step +1
			
				Switch ($i)
					Case 1
						ImprimirModelo($iContador, "{TAB 2}")
						RelatorioImprimiu()
					Case 2
						ImprimirModelo($iContador, "{TAB}{RIGHT}{SPACE}{TAB}")
						RelatorioImprimiu()
					Case 3
						ImprimirModelo($iContador, "{TAB}{RIGHT 2}{SPACE}{TAB}")
						RelatorioImprimiu()
				EndSwitch			
			
			Next

		Case 12
			;;; A��o realizada se for o Modelo 12
			ImprimirModelo($iContador, "{TAB 2}")

		Case 20
			;;; A��o realizada se for o Modelo 20
			ImprimirModelo($iContador, "{TAB 2}")

		Case 27
			;;; A��o realizada se for o Modelo 27
			ImprimirModelo($iContador, "{TAB 2}")

		Case Else
			;;; A��o realizada demais modelos
			ImprimirModelo($iContador, "{TAB}")
			TelaDesejaFecharSessaoExiste("{ENTER}{LEFT}{ENTER}")
	EndSwitch

	RelatorioImprimiu()

	; If ( TelaInformacoesNaoEncontradasExiste() ) Then
	; 	ContinueLoop
	; EndIf

	; $iResultadoWinOpcaoImpressao = WinWaitActive("", "Op��es de Impress�o")
	; If ( $iResultadoWinOpcaoImpressao ) Then
	; 	Send("{TAB 2}{ENTER}")
	; EndIf

	; $bValida = True
	; While ($bValida)

	; 	;$iModeloAtual = $iContador
	; 	While (Not WinActive("", $sTituloTelaReport) )

	; 		$iModeloAtual = $iModeloAtual + 1
	; 		$iQtdeModelos = $iQtdeModelos - 1
	; 		$sTituloTelaReport = "Report Designer - frxpedsaidamod" & $iModeloAtual

	; 		;[DEBUG]
	; 		ConsoleWrite("3 - ModeloAtual -> " & $iModeloAtual & @CRLF)
	; 		ConsoleWrite("2 - QtdeModelos(--) -> " & $iQtdeModelos & @CRLF)

	; 	WEnd

	; 	WinWaitActive("", $sTituloTelaReport)
	; 	$iResultadoWinReport = WinActivate($sTituloTelaReport)
	; 	Sleep(300)

	; 	If ($iResultadoWinReport) Then
	; 		$bValida = False
	; 	Else
	; 		MouseClick("LEFT", $iMaximixarReportEixoX, $iMaximixarReportEixoY)
	; 	EndIf
	; WEnd

	; If ($iResultadoWinReport) Then
	; 	MsgBox($MB_ICONINFORMATION, "MODELO", "["& StringUpper($sTituloTelaReport) & "] impresso com sucesso.", 1)
	; 	WinActivate($sTituloTelaReport)
	; 	Send("{ESC}")
	; 	Sleep(300)
	; EndIf

Next


;;; [ASSERT]
$iResultadoWinActive = WinActive("", $TEXTO_RELATORIO_DAV)
_Assert($iResultadoWinActive <> 0, false)

VoltaResolucaoAnterior() ;;; Altera a resolu��o do monitor caso a mesma tenha sido modificada no inicio do script -> (fun��o da UDF MudarResolucao.au3)

#EndRegion ### EXECU��O DO SCRIPT

#Region ### FUN��ES

Func ImprimirModelo($iNumeroModelo, $sSendTab, $sSendSpace = "SPACE")

	$sCliquesParaBaixo = "DOWN " & $iNumeroModelo - 1
	Send("{TAB 3}")
	Send("{" & $sCliquesParaBaixo & "}{" & $sSendSpace & "}" & $sSendTab & "{ENTER}")

EndFunc

Func RelatorioImprimiu()

	If ( TelaInformacoesNaoEncontradasExiste() ) Then
		ContinueLoop
	EndIf

	$iResultadoWinOpcaoImpressao = WinWaitActive("", "Op��es de Impress�o")
	If ( $iResultadoWinOpcaoImpressao ) Then
		Send("{TAB 2}{ENTER}")
	EndIf

	$bValida = True
	While ($bValida)

		;$iModeloAtual = $iContador
		While (Not WinActive("", $sTituloTelaReport) )

			$iModeloAtual = $iModeloAtual + 1
			$iQtdeModelos = $iQtdeModelos - 1
			$sTituloTelaReport = "Report Designer - frxpedsaidamod" & $iModeloAtual

			;[DEBUG]
			ConsoleWrite("3 - ModeloAtual -> " & $iModeloAtual & @CRLF)
			ConsoleWrite("2 - QtdeModelos(--) -> " & $iQtdeModelos & @CRLF)

		WEnd

		WinWaitActive("", $sTituloTelaReport)
		$iResultadoWinReport = WinActivate($sTituloTelaReport)
		Sleep(300)

		If ($iResultadoWinReport) Then
			$bValida = False
		Else
			MouseClick("LEFT", $iMaximixarReportEixoX, $iMaximixarReportEixoY)
		EndIf
	WEnd

	If ($iResultadoWinReport) Then
		MsgBox($MB_ICONINFORMATION, "MODELO", "["& StringUpper($sTituloTelaReport) & "] impresso com sucesso.", 1)
		WinActivate($sTituloTelaReport)
		Send("{ESC}")
		Sleep(300)
	EndIf

EndFunc

#EndRegion ### FUN��ES