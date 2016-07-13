#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......:
	Data Inicio ....: 10/05/2016
	Data Termino ...: 10/05/2016
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

Local Const $iColunaNumeroEixoX = 353
Local Const $iColunaNumeroEixoY = 283

Local Const $iBotaoConfirmarEixoX = 894
Local Const $iBotaoConfirmarEixoY = 646

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF Validacoes.au3

VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Alteração de Ordem de Compra", "* Efetuar a incluisão de mais itens na ordem de compra.") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

AbreComprasOrdemDeCompra()

$iCodigoOrdemDeCompra = GetSolicitaCodigo("INFORME UM CÓDIGO DE ORD. DE COMPRA.:")

MouseClick("LEFT", $iColunaNumeroEixoX, $iColunaNumeroEixoY)

Send($iCodigoOrdemDeCompra & "{ENTER}")
Sleep(500)

Send("{F3}")

WinWaitActive("", $TEXTO_ORDEM_DE_COMPRA)

; Acessa aba de itens
Send("^b")

IncluirProdutoOrdemDeCompra(2)

; Clique no botão confirmar
MouseClick("LEFT", $iBotaoConfirmarEixoX, $iBotaoConfirmarEixoY)

TelaAtualizaPrecoExiste()

; [TESTE]
$iResultadoWinActive = WinActive("", $TEXTO_ORDEM_DE_COMPRA)
_Assert($iResultadoWinActive <> 0, false)

VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES
