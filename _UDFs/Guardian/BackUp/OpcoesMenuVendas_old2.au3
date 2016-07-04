#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF para acesso as opções do Menu de Vendas do Space Guardian
	Data Inicio ....: 26/04/2016
	Data Termino ...: 26/04/2016
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES / OPS

#include-once

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.

#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\IncludesGuardian.au3"
#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\Guardian\AbstractAbreMenuGuardian.au3"

#EndRegion ###	INCLUDES / OPS

#Region ### VARIAVEIS

Local Const $sAtalhoExpandirMenuVendas = "!v"

#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func AbreVendasDAV()

	AbreMenu($sAtalhoExpandirMenuVendas, "", "{ENTER}", $TEXTO_DAV)

EndFunc   ;==>AbreVendasDAV

Func AbreVendasDevolucaoDeVenda()
	
	AbreMenu($sAtalhoExpandirMenuVendas, "D", "{ENTER}", $TEXTO_DEVOLUCAO_VENDA)

EndFunc   ;==>AbreVendasDevolucaoDeVenda

Func AbreVendasOutrasSaidas()

	AbreMenu($sAtalhoExpandirMenuVendas, "O", "{ENTER}", $TEXTO_OUTRAS_SAIDAS)

EndFunc   ;==>AbreVendasOutrasSaidas

#Region ***** FATURAMENTO *****

Func AbreVendasFaturamentoIndividual()

	AbreMenu($sAtalhoExpandirMenuVendas, "F", "{ENTER}", $TEXTO_FATURAMENTO_INDIVIDUAL)
EndFunc   ;==>AbreVendasFaturamentoIndividual

Func AbreVendasFaturamentoPorCarga()

	AbreMenu($sAtalhoExpandirMenuVendas, "FF", "{ENTER}", $TEXTO_FATURAMENTO_CARGA)

EndFunc   ;==>AbreVendasFaturamentoPorCarga

#EndRegion ***** FATURAMENTO *****

Func AbreVendasSparacaoDePedido()

	AbreMenu($sAtalhoExpandirMenuVendas, "S", "{ENTER}", $TEXTO_SEPARACAO_PEDIDOS)

EndFunc

Func AbreVendasOrcamento()

	AbreMenu($sAtalhoExpandirMenuVendas, "OO", "{ENTER}", $TEXTO_ORCAMENTO_VENDA)

EndFunc

#EndRegion ### FUNÇÕES