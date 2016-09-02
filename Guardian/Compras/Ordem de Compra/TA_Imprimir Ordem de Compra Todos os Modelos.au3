#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Efetuar a impressão de todos os modelos de ordem de compra
	Data Inicio ....: 28/04/2016
	Data Termino ...: 28/04/2016
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

#include <Debug.au3>
#include <MsgBoxConstants.au3>

#include "..\..\..\_UDFs\IncludesAuxiliares.au3"
#include "..\..\..\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#cs ===============================================================================================================================
	$sTituloDaTelaPrincipalDoSistema -> Informar o valor obtido pelo Autoit Window Info do campo 'title'.
	$sNomeDoSistema -> Nome do sistema a ser testado pelo script.
#ce ===============================================================================================================================
Local Const $sTituloDaTelaPrincipalDoSistema = $TITULO_TELA_PRINCIPAL_GUARDIAN
Local Const $sNomeDoSistema = $NOME_SPACE_GUARDIAN

Local $sTituloTelaReport = "Report Designer - frxordemcompra.frx"
Local $sTextoTelaDeModelos = "Modelo de Ordem de Compra"

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
Send("{TAB 3}01012000{TAB}0112" & @YEAR)
Send("{TAB 5}{ENTER}")

; Loop para imprimir os modelos disponiveis
For $iContador = 1 To 10 Step +1

	Send($BTN_IMPRIMIR)
	$iResultadoWinModelos = WinWaitActive("", $sTextoTelaDeModelos)

	If ($iResultadoWinModelos) Then

		If ($iContador == 1) Then
			Send("{TAB}{ENTER}")
		Else
			$sCliquesParaBaixo = "DOWN " & $iContador - 1

			Send("{" & $sCliquesParaBaixo & "}{SPACE}{TAB}{ENTER}")
			$sTituloTelaReport = "Report Designer - frxordemcompra" & $iContador & ".frx"
		EndIf

		$bValida = True
		While ($bValida)

			$iResultadoWinReport = WinActivate($sTituloTelaReport)

			If ($iResultadoWinReport) Then
				$bValida = False
			Else
				MouseClick("LEFT", $iMaximixarReportEixoX, $iMaximixarReportEixoY)
			EndIf

		WEnd

		If ($iResultadoWinReport) Then
			MsgBox($MB_ICONINFORMATION, "MODELO " & $iContador, "Modelo " & $iContador & " impresso com sucesso.", 2)
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
#EndRegion ### FUNÇÕES
