#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Testar a inclusão e gravação de uma ordem de compra com 5 itens
	Data Inicio ....: 27/04/2016
	Data Termino ...: 28/04/2016
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 30) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

#include <Debug.au3>
#include <Date.au3>
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

Local Const $iCodigoCondicaoPagamento = 1

; VARIAVEIS COM EIXO X, Y UTILIZADAS NA FUNÇÃO MouseClick()
Local Const $iBotaoConfirmarEixoX = 894
Local Const $iBotaoConfirmarEixoY = 646

Local Const $iCampoPeriodoInicialEixoX = 398
Local Const $iCampoPeriodoInicialEixoY = 226
;----
Local Const $sDataAtual = StringReplace(_NowDate(), "/", "")

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF Validacoes.au3

VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Inclusão de Ordem de Compra") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

AbreComprasOrdemDeCompra()

ClickBotaoIncluir()

Do

	$iCodigoFornecedor = SolicitaCodigoFornecedor()
	Send($iCodigoFornecedor & "{ENTER}")

Until (Not TelaCodigoNaoCadastradoExiste())

Do

	$iCodigoComprador = SolicitaCodigoComprador()
	Send($iCodigoComprador & "{ENTER 2}")

Until (Not TelaCodigoNaoCadastradoExiste())

; Informa data de Previsão de Entrega
Send($sDataAtual)
Send("{TAB}")

#cs ===============================================================================================================================
	Do

		$iCodigoTransportador = SolicitaCodigoTransportador()
		Send($iCodigoTransportador & "{TAB}")

	Until (Not TelaCodigoNaoCadastradoExiste())
#ce ===============================================================================================================================

Send("{TAB 3}" & $iCodigoCondicaoPagamento)
; Acessa aba de itens
Send("^b")

IncluirProdutoOrdemDeCompra(2)

; Clique no botão confirmar
MouseClick("LEFT", $iBotaoConfirmarEixoX, $iBotaoConfirmarEixoY)

TelaAtualizaPrecoExiste()

; Consulta ordens de compra do dia atual
$iResultadoWinActive = WinActive("", $TEXTO_ORDEM_DE_COMPRA)
If ($iResultadoWinActive) Then
	
	MouseClick("LEFT", $iCampoPeriodoInicialEixoX, $iCampoPeriodoInicialEixoY, 3)
	Send($sDataAtual & "{TAB}")
	Send("^a" & $sDataAtual)
	Send("{TAB 5}{ENTER}")

EndIf

; [TEST]
_Assert($iResultadoWinActive <> 0, false)

VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES