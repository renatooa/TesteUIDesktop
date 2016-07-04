#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o - UDF
	Descri��o ......: UDF para acesso as op��es do Menu de Compras do Space Guardian
	Data Inicio ....: 18/04/2016
	Data Termino ...: 26/04/2016
	Vers�o .........: 001
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

Local Const $sAtalhoExpandirMenuCompras = "!c{RIGHT}"

#EndRegion ### VARIAVEIS

#Region ### FUN��ES

Func AbreComprasRequisicaoDeCompra()

	AbreMenu($sAtalhoExpandirMenuCompras, "R", "{ENTER}", $TEXTO_REQUISICAO_DE_COMPRA)

EndFunc

Func AbreComprasOrdemDeCompra()

	AbreMenu($sAtalhoExpandirMenuCompras, "O", "{ENTER}", $TEXTO_ORDEM_DE_COMPRA)

EndFunc

Func AbreComprasManutencaoOrdemDeCompra()

	AbreMenu($sAtalhoExpandirMenuCompras, "M", "{ENTER}", $TEXTO_MANUTENCAO_DE_COMPRA)

EndFunc

Func AbreComprasChegadaDeMercardoria()

	AbreMenu($sAtalhoExpandirMenuCompras, "CC", "{ENTER}", $TEXTO_CHEGADA_DE_MERCADORIA)

EndFunc

Func AbreComprasRecebimentoDaMercadoria()

	AbreMenu($sAtalhoExpandirMenuCompras, "RR", "{ENTER}", $TEXTO_RECEBIMENTO_DE_MERCADORIA)

EndFunc

Func AbreComprasConferenciaDeRecebimento()

	AbreMenu($sAtalhoExpandirMenuCompras, "CCC", "{ENTER}", $TEXTO_CONFERENCIA_DE_MERCADORIA)

EndFunc

Func AbreComprasControleRecebimentoDeMercadoria()

	AbreMenu($sAtalhoExpandirMenuCompras, "CCCC", "{ENTER}", $TEXTO_CONTROLE_RECEBIMENTO_DE_MERCADORIA)

EndFunc

Func AbreComprasEspelhoDeEntrada()

	AbreMenu($sAtalhoExpandirMenuCompras, "E", "{ENTER}", $TEXTO_ESPELHO_DE_ENTRADA)

EndFunc

#EndRegion ### FUN��ES