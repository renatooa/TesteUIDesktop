#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Efetuar a impressão de todos os modelos do Relatório de DAV
	Data Inicio ....: 05/12/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 200) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

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
Local $iLoopModelo7 = 2

;;; VARIAVEIS COM EIXO X, Y UTILIZADAS NA FUNÇÃO MouseClick()
Local Const $iMaximixarReportEixoX = 569
Local Const $iMaximixarReportEixoY = 61

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ;;; Função da UDF Validacoes.au3

VerificaAlteraResolucao() ;;; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Impressão do Relatório de DAV com todos os modelos") ;;; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

AbreVendasRelatoriosRelDAV()

;;; Realiza pesquisa de ordem de compra por periodo
MouseClick("LEFT", 460, 189, 3)
Send("01" & (@MON - 2) & @YEAR & "{TAB}" & @MDAY & @MON & @YEAR)

;;; Loop para imprimir os modelos disponiveis
For $iContador = 5 To $iQtdeModelos Step +1

	;;;[DEBUG]
	ConsoleWrite("*************** LOOP * " & $iContador & " ***************" & @CRLF)
	ConsoleWrite("1 - ModeloAtual -> " & $iModeloAtual & @CRLF)

	If ($iContador == 26 And $iModeloAtual == 27) Then
		ExitLoop
	EndIf

	If ( $iModeloAtual == 6) Then
		$iContador = 5
	EndIf

	$iModeloAtual = ($iModeloAtual <= $iContador) ? $iContador : $iModeloAtual + 1

	;;;[DEBUG]
	ConsoleWrite("Contador -> " & $iContador & @CRLF)
	ConsoleWrite("2 - ModeloAtual -> " & $iModeloAtual & @CRLF)
	ConsoleWrite("1 - QtdeModelos -> " & $iQtdeModelos & @CRLF)

	Send("^b") ;CTRL + B

	;$sTituloTelaReport = "Report Designer - frxpedsaidamod" & $iContador
	$sTituloTelaReport = "Report Designer - frxpedsaidamod" & $iModeloAtual

	Switch ($iModeloAtual)
		Case 1
			;;; Ação realizada se for o Modelo 1
			Send("{ENTER}")

		Case 2
			;;; Ação realizada se for o Modelo 2
			ImprimirModelo($iContador, "{TAB 2}")

		Case 5
			;;; Ação realizada se a variavel $iModeloAtual for == 5.
			ImprimirModelo($iContador, "{TAB 2}")
			TelaDesejaFecharSessaoExiste("{ENTER}{LEFT}{ENTER}")

		Case 7
			;;; Ação realizada se for o Modelo 7
			For $i = 1 To $iLoopModelo7 Step +1
				
				Switch ($i)
					Case 1
						ImprimirModelo($iContador, "{TAB}{RIGHT}{SPACE}{TAB}")
						RelatorioImprimiu()
					Case 2
						Send("^b") ;CTRL + B
						ImprimirModelo($iContador, "{TAB}{RIGHT 2}{SPACE}{TAB}")
						RelatorioImprimiu()
				EndSwitch
				
			Next			
			$iModeloAtual = 7					

		Case 12
			;;; Ação realizada se for o Modelo 12
			ImprimirModelo($iContador, "{TAB 2}")

		Case 20
			;;; Ação realizada se for o Modelo 20
			ImprimirModelo($iContador, "{TAB 2}")

		Case 27
			;;; Ação realizada se for o Modelo 27
			ImprimirModelo($iContador, "{TAB 2}")

		Case Else
			;;; Ação realizada demais modelos
			ImprimirModelo($iContador, "{TAB}")
			TelaDesejaFecharSessaoExiste("{ENTER}{LEFT}{ENTER}")
	EndSwitch

	If ( TelaInformacoesNaoEncontradasExiste()) Then
		ContinueLoop
	EndIf

	If($iModeloAtual <> 7) Then
		RelatorioImprimiu()
	EndIf

Next


;;; [ASSERT]
$iResultadoWinActive = WinActive("", $TEXTO_RELATORIO_DAV)
_Assert($iResultadoWinActive <> 0, False)

VoltaResolucaoAnterior() ;;; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES

Func ImprimirModelo($iNumeroModelo, $sSendTab, $sSendSpace = "SPACE")

	$sCliquesParaBaixo = "DOWN " & $iNumeroModelo - 1
	Send("{TAB 3}")
	Send("{" & $sCliquesParaBaixo & "}{" & $sSendSpace & "}" & $sSendTab & "{ENTER}")

EndFunc   ;==>ImprimirModelo

Func RelatorioImprimiu()

	$iResultadoWinOpcaoImpressao = WinWaitActive("", "Opções de Impressão")
	If ($iResultadoWinOpcaoImpressao) Then
		Send("{TAB 2}{ENTER}")
	EndIf

	$bValida = True
	While ($bValida)
		
		QualModeloFoiImpresso()

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
		MsgBox($MB_ICONINFORMATION, "MODELO", "[" & StringUpper($sTituloTelaReport) & "] impresso com sucesso.", 1)
		WinActivate($sTituloTelaReport)
		Send("{ESC}")
		Sleep(300)
	EndIf

	;Return

EndFunc   ;==>RelatorioImprimiu

;;; Verifica qual modelo foi impresso e altera as variaveis:
;;; $iModeloAtual - $iQtdeModelos - $sTituloTelaReport.
;;; Função necessária pois o RadioButton do modelo 5 no Guardian fica Bloqueado.
;;; Desta forma a ação de TAB a partir do modelo 4 vai para o modelo 6 ou 7.
Func QualModeloFoiImpresso()
	
	While (Not WinActive("", $sTituloTelaReport))

		$iModeloAtual = $iModeloAtual + 1
		$iQtdeModelos = $iQtdeModelos - 1
		$sTituloTelaReport = "Report Designer - frxpedsaidamod" & $iModeloAtual

		;;; [DEBUG]
		ConsoleWrite("3 - ModeloAtual -> " & $iModeloAtual & @CRLF)
		ConsoleWrite("2 - QtdeModelos(-) -> " & $iQtdeModelos & @CRLF)

	WEnd

	If ( $iModeloAtual == 7 ) Then	
		$iModeloAtual = 6	
	EndIf

EndFunc

#EndRegion ### FUNÇÕES
