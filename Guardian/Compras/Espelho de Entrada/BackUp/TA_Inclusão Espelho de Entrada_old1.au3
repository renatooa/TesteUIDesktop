#cs ===============================================================================================================================
	Típo de Script .: (Script de Função - UDF, Script Execução de Teste, Script de Constantes, Script de Includes)
	Descrição ......:
	Data Inicio ....:
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1)             ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100)            ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

;#include-once
#include <Debug.au3>
#include <Date.au3>
#include <MsgBoxConstants.au3>

#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\IncludesAuxiliares.au3"
#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#cs ===============================================================================================================================
	$sTituloDaTelaPrincipalDoSistema -> Informar o valor obtido pelo Autoit Window Info do campo 'title'.
	$sNomeDoSistema -> Nome do sistema a ser testado pelo script.
#ce ===============================================================================================================================
Local Const $sTituloDaTelaPrincipalDoSistema = $TITULO_TELA_PRINCIPAL_GUARDIAN
Local Const $sNomeDoSistema = $NOME_SPACE_GUARDIAN

Local Const $sValorTotalEspelho = "1,70"
Local Const $sValorTotalMercadoria = "1,70"
Local Const $sModeloFiscal = "01"
Local Const $iCodigoProduto = 36
Local Const $sCustoProduto = "1,70"

; VARIAVEIS COM EIXO X, Y UTILIZADAS NA FUNÇÃO MouseClick()
Local Const $iBotaoConfirmarEixoX = 878
Local Const $iBotaoConfirmarEixoY = 636
;----
Local Const $sDataAtual = StringReplace(_NowDate(), "/", "")

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF SistemaExiste.au3

VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Inclusão de Espelho de Entrada", "Sem Nota Fiscal") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

AbreComprasEspelhoDeEntrada()

Send($BTN_INCLUIR)

WinWaitActive('', "Espelho da Entrada")

Do
	
	$sCodigoNaturezaDeOperacao = GetSolicitaNaturezaOperacao()
	Send($sCodigoNaturezaDeOperacao & "{TAB}")

Until (Not(TelaCodigoNaoCadastradoExiste() Or TelaNatOperNaoPermitidaExiste()))

Send("{TAB}" & $sValorTotalEspelho)
Send("{ENTER 5}")

Send($sModeloFiscal & "{TAB 2}")

Do

	$iCodigoFornecedor = GetSolicitaCodigo("INFORME UM CÓDIGO DE FORNECEDOR ..: ")
	Send($iCodigoFornecedor & "{TAB}")

Until (Not TelaCodigoNaoCadastradoExiste())

Send("{TAB}")

Do

	$iCodigoComprador = GetSolicitaCodigo("INFORME UM CÓDIGO DE COMPRADOR ..: ")
	Send($iCodigoComprador & "{TAB}")

Until (Not TelaCodigoNaoCadastradoExiste())

Send("{TAB 2}" & $sValorTotalMercadoria)
Send("{ENTER}")

Send("^d")

IncluirProdutoEspelhoDeEntrada($iCodigoProduto, $sCustoProduto)

TelaCodigoReferenciaProdFornecExiste()

MouseClick("LEFT", $iBotaoConfirmarEixoX, $iBotaoConfirmarEixoY)

Sleep(500)
TelaOpcoesImpressaoExiste()
Sleep(500)
TelaDesejaImprimirExiste()
Sleep(500)
TelaDesejaImprimirExiste()


If ( WinWaitActive("", $TEXTO_ESPELHO_DE_ENTRADA) ) Then

	Send("{TAB 3}" & $sDataAtual)
	Send("{TAB}" & $sDataAtual & "{TAB 3}{ENTER}")

	MsgBox($MB_ICONINFORMATION, "Assertion has passed", "Script Finalizado com sucesso.")

Else	
	MsgBox($MB_ICONWARNING, "Assertion has failed", "Script NÃO finalizado corretamente!")
EndIf


VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES