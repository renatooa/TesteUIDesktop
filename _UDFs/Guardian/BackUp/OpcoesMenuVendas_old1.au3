#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF para acesso as opções do Menu de Vendas do Space Guardian
	Data Inicio ....: 26/04/2016
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES / OPS

#include-once

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.

#EndRegion ###	INCLUDES / OPS

#Region ### VARIAVEIS

Local Const $sAtalhoExpandirMenuVendas = "!v"

#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func AbreVendasDAV()
	
	Send($sAtalhoExpandirMenuVendas)
	Send("{ENTER}")
	WinActive("", "Consulta de Pedidos - Documento Auxiliar de vendas")

EndFunc

Func AbreVendasDevolucaoDeVenda()

	Send($sAtalhoExpandirMenuVendas)
	Send("D{ENTER}")
	WinActive("", "Consulta de Pedidos - Devoluções de vendas")

EndFunc

Func AbreVendasOutrasSaidas()

	Send($sAtalhoExpandirMenuVendas)
	Send("O{ENTER}")
	WinActive("", "Consulta de Pedidos - Outras Saidas")

EndFunc

#Region ***** FATURAMENTO *****

Func AbreVendasFaturamentoIndividual()

	Send($sAtalhoExpandirMenuVendas)
	Send("F{ENTER}")
	WinActive("", "Consulta Notas Fiscais de Saída")

EndFunc

Func AbreVendasFaturamentoPorCarga()

	Send($sAtalhoExpandirMenuVendas)
	Send("FF{ENTER}")
	WinActive("", "Notas / Carga")

EndFunc

#EndRegion

#EndRegion ### FUNÇÕES
