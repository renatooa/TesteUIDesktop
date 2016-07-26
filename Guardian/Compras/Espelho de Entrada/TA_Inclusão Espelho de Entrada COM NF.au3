#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......:
	Data Inicio ....: 13/05/2016
	Data Termino ...: 13/05/2016
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

;#include-once
#include <Debug.au3>
#include <Date.au3>
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

Local Const $sValorTotalEspelho = "1,70"
Local Const $sValorTotalMercadoria = "1,70"
Local Const $sModeloFiscal = "01"
Local Const $iCodigoProduto = 36
Local Const $sCustoProduto = "1,70"

Local Const $sBaseDeICMS = "1,70"
Local Const $sValorICMS = "0,31"

Local Const $sDataAtual = StringReplace(_NowDate(), "/", "")

Local Const $vSerieNF = "TST";
Local $iNumeroNF = Random(1000, 10000, 1)

Local Const $sCFOP = "1.102"

; VARIAVEIS COM EIXO X, Y UTILIZADAS NA FUNÇÃO MouseClick()
Local Const $iBotaoConfirmarEixoX = 854
Local Const $iBotaoConfirmarEixoY = 636

Local Const $iBotaoAlterarEixoX = 1048
Local Const $iBotaoAlterarEixoY = 510 

Local Const $iCampoCFOPEixoX = 912
Local Const $iCampoCFOPEixoY = 252 

Local Const $iBotaoGravarEixoX = 1048
Local Const $iBotaoGravarEixoY = 557

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF Validacoes.au3

VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Inclusão de Espelho de Entrada COM Nota Fiscal", "* UTILIZAR BANCO DE DADOS DA ARCOS") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

AbreComprasEspelhoDeEntrada()

Send($BTN_INCLUIR)

WinWaitActive('', "Espelho da Entrada")

Do
	
	$sCodigoNaturezaDeOperacao = SolicitaNaturezaOperacao()
	Send($sCodigoNaturezaDeOperacao & "{TAB}")

Until (Not (TelaCodigoNaoCadastradoExiste() Or TelaNatOperNaoPermitidaExiste()))

Send("{TAB}" & $sValorTotalEspelho & "{ENTER}")

; Dados de Nota Fiscal
Send($vSerieNF & "{ENTER}")
Send($iNumeroNF & "{ENTER}")

Send($sDataAtual & "{ENTER}")
Send($sDataAtual & "{ENTER}")
; ----

Send($sModeloFiscal & "{TAB 2}")

Do

	$iCodigoFornecedor = SolicitaCodigoFornecedor()
	Send($iCodigoFornecedor & "{TAB}")

Until (Not TelaCodigoNaoCadastradoExiste())

Send("{TAB}")

Do

	$iCodigoComprador = SolicitaCodigoComprador()
	Send($iCodigoComprador & "{TAB}")

Until (Not TelaCodigoNaoCadastradoExiste())

; Informar valores na Aba Totais / Valores
Send("{TAB 3}" & $sValorTotalMercadoria)
Send("{ENTER}")
Send($sBaseDeICMS & "{ENTER}")
Send($sValorICMS & "{ENTER}")

Send("^d")

IncluirProdutoEspelhoDeEntrada($iCodigoProduto, $sCustoProduto)

Do

	TelaCodigoReferenciaProdFornecExiste()

	MouseClick("LEFT", $iBotaoConfirmarEixoX, $iBotaoConfirmarEixoY)

	$bResultadoTelaCFOPNaoLiberadoExiste = TelaCfopNaoLiberadoExiste()
	If ( $bResultadoTelaCFOPNaoLiberadoExiste ) Then
	
		MouseClick("LEFT", $iBotaoAlterarEixoX, $iBotaoAlterarEixoY)
		MouseClick("LEFT", $iCampoCFOPEixoX, $iCampoCFOPEixoY, 3)

		Send($sCFOP)
		
	EndIf	

	Do
		MouseClick("LEFT", $iBotaoGravarEixoX, $iBotaoGravarEixoY)
		$bResultadoTelaCFOPDiferente = TelaCfopDiferenteNatOperExiste()
	Until ( Not $bResultadoTelaCFOPDiferente )	

Until (Not $bResultadoTelaCFOPNaoLiberadoExiste )

Sleep(500)
TelaDesejaGerarNFExiste()
Sleep(500)
TelaOpcoesImpressaoExiste()

For $i = 1 To 2 Step +1

	Sleep(1000)
	TelaDesejaImprimirExiste()

Next

; [VALIDAÇÃO] CLASS:guardian19c000000; 
$iResultadoWinActive = WinActive("[INSTANCE:1]", $TEXTO_ESPELHO_DE_ENTRADA)
If ($iResultadoWinActive) Then

	Send("{TAB 3}" & $sDataAtual)
	Send("{TAB}" & $sDataAtual & "{TAB 3}{ENTER}")

EndIf

_Assert($iResultadoWinActive <> 0, false)

VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES