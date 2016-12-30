#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Efetuar a impressão de todos os modelos de ordem de compra
	Data Inicio ....: 28/04/2016
	Data Termino ...: 28/04/2016
	Data Ajuste ...: 02/12/2016
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

Local $sTituloTelaReport = "Report Designer - frxordemcompra"
Local $sTextoTelaDeModelos = "Modelo de Ordem de Compra"
Local $iModelo2 = 1
Local $iModelo8 = 1

; VARIAVEIS COM EIXO X, Y UTILIZADAS NA FUNÇÃO MouseClick()
Local Const $iMaximixarReportEixoX = 569
Local Const $iMaximixarReportEixoY = 61

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF Validacoes.au3

VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Impressão de Ordem de Compra com todos os modelos") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

AbreComprasOrdemDeCompra()

; Realiza pesquisa de ordem de compra por periodo
Send("{TAB 3}01012000{TAB}" & @MDAY & @MON & @YEAR) 
Send("{TAB 5}{ENTER}")

; Loop para imprimir os modelos disponiveis
For $iContador = 1 To 10 Step +1

	If ( $iModelo2 == 2 ) Then
		$iContador = $iModelo2	
	EndIf

	If ( $iModelo8 == 8 ) Then
		$iContador = $iModelo8	
	EndIf

	If ( $iContador <> 1 ) Then
		$sTituloTelaReport = "Report Designer - frxordemcompra" & $iContador	
	EndIf

	ClickBotaoImprimir()
	
	$iResultadoWinModelos = WinWaitActive("", $sTextoTelaDeModelos)

	If ($iResultadoWinModelos) Then		

		Switch ($iContador)
			Case 1
				; Ação realizada se for o Modelo 1
				Send("{TAB}{ENTER}")
			Case 2
				; Ação realizada se for o Modelo 2
				Switch ($iModelo2)
					Case 1
						ImprimirModelo($iContador, "TAB")
						$iModelo2 = 2					
					Case 2
						ImprimirModelo($iContador, "TAB", "SPACE 2")
						$sTituloTelaReport = "Report Designer - frxordemcompra" & $iContador & "b"
						$iModelo2 = 0					
				EndSwitch
			Case 8
				; Ação realizada se for o Modelo 8				
				Switch ($iModelo8)
					Case 1
						ImprimirModelo($iContador, "TAB")
						$iModelo8 = 8					
					Case 8
						ImprimirModelo($iContador, "TAB", "SPACE 2")
						$iModelo8 = 0					
				EndSwitch
			Case Else
				; Ação realizada demais modelos
				ImprimirModelo($iContador, "TAB")
		EndSwitch

		$bValida = True
		While ($bValida)
			$iResultadoWinReport = WinActivate($sTituloTelaReport)
			Sleep(100)

			If ($iResultadoWinReport) Then
				$bValida = False
			Else
				MouseClick("LEFT", $iMaximixarReportEixoX, $iMaximixarReportEixoY)
			EndIf
		WEnd

		If ($iResultadoWinReport) Then		
			;MsgBox($MB_ICONINFORMATION, "MODELO " & $iContador, "Modelo " & $iContador & " impresso com sucesso.", 2)
			MsgBox($MB_ICONINFORMATION, "MODELO", "["& StringUpper($sTituloTelaReport) & "] impresso com sucesso.", 2)
			WinActivate($sTituloTelaReport)
			Send("{ESC}")
			Sleep(300)
		EndIf
	Else
		MsgBox($MB_ICONWARNING, "Falha", "Falha na execusão do script!" & @CRLF _
				 & " Tela de seleção de modelos não localizada!")
		ExitLoop
	EndIf

Next

; [TESTE]
$iResultadoWinActive = WinActive("", $TEXTO_ORDEM_DE_COMPRA)
_Assert($iResultadoWinActive <> 0, false)

VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES

Func ImprimirModelo($iNumeroModelo, $sSendTab, $sSendSpace = "SPACE")

	$sCliquesParaBaixo = "DOWN " & $iNumeroModelo - 1
	Send("{" & $sCliquesParaBaixo & "}{" & $sSendSpace & "}{" & $sSendTab & "}{ENTER}")

EndFunc

#EndRegion ### FUNÇÕES