#cs ===============================================================================================================================
    Típo de Script .: Script Execução de Teste
    Descrição ......: Efetuar a impressão de todos os modelos do Relatório de Saída de Produtos
    Data Inicio ....: 04/05/2017
    Data Termino ...: ~
    Versão .........: 001
    Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPT'S

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.

Local $_iSendKeyDelay = 200
Opt("SendKeyDelay", $_iSendKeyDelay) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

#include <Debug.au3>
#include <MsgBoxConstants.au3>

#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPT'S

#Region ### VARIAVEIS
#cs ===============================================================================================================================
    $sTituloDaTelaPrincipalDoSistema -> Informar o valor obtido pelo Autoit Window Info do campo 'title'.
    $sNomeDoSistema -> Nome do sistema a ser testado pelo script.
#ce ===============================================================================================================================
Local Const $sTituloDaTelaPrincipalDoSistema = $TITULO_TELA_PRINCIPAL_GUARDIAN
Local Const $sNomeDoSistema = $NOME_SPACE_GUARDIAN

Local Const $sInicioTituloTelaReport = "Report Designer - frxsaidaprodutomod"
Local $sTituloTelaReport
Local $iModeloAtual = 5
Local $iQtdeModelos = 17

;;; VARIAVEIS COM EIXO X, Y UTILIZADAS NA FUNÇÃO MouseClick()
Local Const $iDataEmissaoEixoX = 421
Local Const $iDataEmissaoEixoY = 174
Local Const $iMaximixarReportEixoX = 569
Local Const $iMaximixarReportEixoY = 61
Local Const $iAbaOptModEixoX = 421
Local Const $iAbaOptModEixoY = 121

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ;;; Função da UDF Validacoes.au3

VerificaAlteraResolucao() ;;; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Impressão do Relatório de Saída de Produtos com todos os modelos") ;;; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

AbreVendasRelatoriosRelSaidaProdutos()

;;; Realiza pesquisa de Saída de Produtos por periodo
;~ MouseClick("LEFT", $iDataEmissaoEixoX, $iDataEmissaoEixoY, 3)
;~ Local $_iMesInicio = ( @MON >= 12 ) ? (@MON - 2) : 0 & (@MON - 2)
;~ Send("01" & $_iMesInicio & @YEAR & "{TAB}" & @MDAY & @MON & @YEAR)

;;; Loop para imprimir os modelos disponiveis ($iQtdeModelos)
For $iContador = 5 To $iQtdeModelos Step +1
    ;;;[DEBUG]
    ConsoleWrite("*************** LOOP * " & $iContador & " ***************" & @CRLF)
    ConsoleWrite("1 - ModeloAtual -> " & $iModeloAtual & @CRLF)

    If ($iContador == 16 And $iModeloAtual == 17) Then
		ExitLoop
	EndIf

    $iModeloAtual = ($iModeloAtual <= $iContador) ? $iContador : $iModeloAtual + 1

    ;;;[DEBUG]
    ConsoleWrite("Contador -> " & $iContador & @CRLF)
    ConsoleWrite("2 - ModeloAtual -> " & $iModeloAtual & @CRLF)
    ConsoleWrite("1 - QtdeModelos -> " & $iQtdeModelos & @CRLF)

    If ($iModeloAtual == 14 And $iModeloAtual > $iContador) Then
    	$iContador = $iModeloAtual - 2
    EndIf

    _AcessaAbaOpcoesModelos()

    $sTituloTelaReport = $sInicioTituloTelaReport & $iModeloAtual

    ;;;[DEBUG]
    ConsoleWrite("Switch - Contador -> " & $iContador & @CRLF)
    ConsoleWrite("Switch - ModeloAtual -> " & $iModeloAtual & @CRLF)
    Switch ($iModeloAtual)
        Case 1
            ;;; Ação realizada se for o Modelo 1
            Send("{TAB 3}{ENTER}")

        Case 3
            ;;; Ação realizada se for o Modelo 3
            For $i = 1 To 2 Step +1                
                Switch ($i)
                    Case 1
                        _ImprimirModelo($iContador, "{TAB 3}")
                        _RelatorioImprimiu()
                    Case 2
                        _AcessaAbaOpcoesModelos()
                        _ImprimirModelo($iContador, "{TAB}{DOWN}{SPACE}{TAB 2}")
                        _RelatorioImprimiu()
                EndSwitch                
            Next

        Case 14
            ;;; Ação realizada se for o Modelo 14
            For $i = 1 To 2 Step +1                
                Switch ($i)
                    Case 1
                        _ImprimirModelo($iContador, "{TAB 3}")
                        _RelatorioMatricialImprimiu()
                    Case 2
                        _AcessaAbaOpcoesModelos()
                        _ImprimirModelo($iContador, "{TAB}{RIGHT}{SPACE}{TAB 2}")
                        _RelatorioMatricialImprimiu()
                EndSwitch                
            Next

        Case 15 To 17
            ;;; Ação realizada se for o Modelo 15, 16, 17
            _ImprimirModelo($iContador, "{TAB 3}")

        Case Else
            If ($iModeloAtual == 5 Or $iModeloAtual == 6 Or $iModeloAtual == 7) Then
                MouseClick("LEFT", $iAbaOptModEixoX, $iAbaOptModEixoY)
            EndIf

            ;;; Ação realizada demais modelos
            _ImprimirModelo($iContador, "{TAB 2}")
            TelaDesejaFecharSessaoExiste()
    EndSwitch

    If ( TelaInformacoesNaoEncontradasExiste() ) Then
        ContinueLoop
    EndIf

    If Not ($iModeloAtual == 3 Or $iModeloAtual == 14) Then
        _RelatorioImprimiu()
    EndIf
Next


;;; [ASSERT]
$iResultadoWinActive = WinActive("", $TEXTO_RELATORIO_SAIDA_PRODUTO)
_Assert($iResultadoWinActive <> 0, False)

VoltaResolucaoAnterior() ;;; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)

#EndRegion ### EXECUÇÃO DO SCRIPT


#Region ### FUNÇÕES

Func _AcessaAbaOpcoesModelos()

    Send("^b") ;CTRL + B

EndFunc   ;==>_AcessaAbaOpcoesModelos

Func _ImprimirModelo($iNumeroModelo, $sSendTab, $sSendSpace = "SPACE")

    $sCliquesParaBaixo = "DOWN " & $iNumeroModelo
    Opt("SendKeyDelay", 100) ;;; Diminui o delay da função de Send() para selecionar o modelo mais rápido.
    Send("{" & $sCliquesParaBaixo & "}{" & $sSendSpace & "}" & $sSendTab & "{ENTER}")
    Opt("SendKeyDelay", $_iSendKeyDelay) ;;; Volta o delay ao normal

EndFunc   ;==>_ImprimirModelo

Func _RelatorioImprimiu()

    Local $_sTextoTelaOpcaoImpressao = "Opções de Impressão"

    $iResultadoWinOpcaoImpressao = WinWaitActive("", $_sTextoTelaOpcaoImpressao)
    If ($iResultadoWinOpcaoImpressao) Then
        Send("{TAB 2}{ENTER}")
    EndIf

    $iResultado = _QualModeloFoiImpresso()

    If ($iResultado) Then
        MsgBox($MB_ICONINFORMATION, "MODELO", "[" & StringUpper($sTituloTelaReport) & "] impresso com sucesso.", 1)
        WinActivate($sTituloTelaReport)
        Send("{ESC}")
        Sleep(300)
    EndIf

EndFunc   ;==>_RelatorioImprimiu

Func _RelatorioMatricialImprimiu()

    Local $_sTextoTelaImprimir = "Imprimir"

    $iResultadoWinImprimir = WinWaitActive("", $_sTextoTelaImprimir)
    If ($iResultadoWinImprimir) Then
        Send("{ENTER}")
    EndIf

    Const $sTituloTelaReportMatricial = "Visualizador de impressão"
    $iResultado = WinWaitActive("", $sTituloTelaReportMatricial)

    If ($iResultado) Then
        MsgBox($MB_ICONINFORMATION, "MODELO", "[MODELO 14] impresso com sucesso.", 1)
        WinActivate("", $sTituloTelaReportMatricial)
        Send("{ESC}")
        Sleep(300)
        TelaDesejaAbandonarExiste()
    EndIf

EndFunc   ;==>_RelatorioMatricialImprimiu

;;; Verifica qual modelo foi impresso e altera as variaveis:
;;; $iModeloAtual - $iQtdeModelos - $sTituloTelaReport.
;;; Função necessária pois o RadioButton do modelo 5 no Guardian fica Bloqueado.
;;; Desta forma a ação de TAB a partir do modelo 4 vai para o modelo 6 ou 7.
;;;
;;; Retorno --->> Resutldado da função WinActivate().
Func _QualModeloFoiImpresso()

    $bBooleano = true
    While ($bBooleano)
        
        While (Not WinActive("", $sTituloTelaReport))

            $iModeloAtual = $iModeloAtual + 1
            $iQtdeModelos = $iQtdeModelos - 1
            $sTituloTelaReport = $sInicioTituloTelaReport & $iModeloAtual

            ;;; [DEBUG]
            ConsoleWrite("3 - ModeloAtual -> " & $iModeloAtual & @CRLF)
            ConsoleWrite("2 - QtdeModelos(-) -> " & $iQtdeModelos & @CRLF)

        WEnd

        WinWaitActive("", $sTituloTelaReport)
        $iResultadoWinReport = WinActivate($sTituloTelaReport)
        Sleep(300)

        If ($iResultadoWinReport) Then
            $bBooleano = False
        Else
            MouseClick("LEFT", $iMaximixarReportEixoX, $iMaximixarReportEixoY)
        EndIf
    WEnd

    Return $iResultadoWinReport

EndFunc   ;==>_QualModeloFoiImpresso

#EndRegion ### FUNÇÕES