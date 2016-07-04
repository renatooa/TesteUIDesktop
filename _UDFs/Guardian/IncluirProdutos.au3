#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......:
	Data Inicio ....: 11/05/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.

#include-once
#include <Debug.au3>
#include <MsgBoxConstants.au3>
#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPS

#cs FUNÇÕES DA UDF ================================================================================================================
=
=	IncluirProdutoOrdemDeCompra($iQtdeDeProdutos)
=	IncluirProdutoEspelhoDeEntrada($iCodigoProduto, $sCustoProduto)
=
#ce ===============================================================================================================================

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS



#Region ### FUNÇÕES

Func IncluirProdutoOrdemDeCompra($iQtdeDeProdutos)

	Local Const $iCampoQtdeEixoX = 443
	Local Const $iCampoQtdeEixoY = 271

	Local Const $iCampoCustoPadraoAtualEixoX = 918
	Local Const $iCampoCustoPadraoAtualEixoY = 344

	Local Const $iCampoPrecoUnitarioEixoX = 585
	Local Const $iCampoPrecoUnitarioEixoY = 271

	Local Const $iBotaoGravarItemEixoX = 1021
	Local Const $iBotaoGravarItemEixoY = 569

	Local Const $iBotaoIncluirItemEixoX = 1021
	Local Const $iBotaoIncluirItemEixoY = 465

	Local Const $iBotaoCancelarItemEixoX = 1021
	Local Const $iBotaoCancelarItemEixoY = 602

	For $i = 1 To $iQtdeDeProdutos Step +1
		
		Do

			MouseClick("LEFT", $iBotaoIncluirItemEixoX, $iBotaoIncluirItemEixoY)
			
			$iCodigoProduto = GetSolicitaCodigo("INFORME UM CÓDIGO DE PRODUTO ..:")
			Send($iCodigoProduto & "{TAB}")

			$bResultadoCodigoNaoCadastrado = TelaCodigoNaoCadastradoExiste() ; Função da UDF ValidacoesGuardian.au3
			$bResultadoProdutoBloqueado = TelaProdutoBloqueadoExiste() ; Função da UDF ValidacoesGuardian.au3

			If ($bResultadoCodigoNaoCadastrado Or $bResultadoProdutoBloqueado) Then
				
				Send("^a{DEL}")
				MouseClick("LEFT", $iBotaoCancelarItemEixoX, $iBotaoCancelarItemEixoY)
				
			EndIf
			
		Until Not ($bResultadoCodigoNaoCadastrado Or $bResultadoProdutoBloqueado)

		; Clique no campo Quantidade
		MouseClick("LEFT", $iCampoQtdeEixoX, $iCampoQtdeEixoY, 3)
		Send("1{TAB}")
		; Clique no campo Custo Padrão Atual para selecionar é copiar custo
		MouseClick("LEFT", $iCampoCustoPadraoAtualEixoX, $iCampoCustoPadraoAtualEixoY, 3)
		Send("^c")
		; Clique no campo Preço Unitário
		MouseClick("LEFT", $iCampoPrecoUnitarioEixoX, $iCampoPrecoUnitarioEixoY, 3)
		Send("^v{TAB}")
		; Clique no Botão Gravar
		MouseClick("LEFT", $iBotaoGravarItemEixoX, $iBotaoGravarItemEixoY)

		$bResultadoInformarCampo = TelaCampoDeveSerInformadoExiste() ; Função da UDF ValidacoesGuardian.au3

		If ($bResultadoInformarCampo) Then
			
			MouseClick("LEFT", $iBotaoCancelarItemEixoX, $iBotaoCancelarItemEixoY)
			$i -= 1
			
		EndIf

	Next

EndFunc   ;==>IncluirProdutoOrdemDeCompra

Func IncluirProdutoEspelhoDeEntrada($iCodigoProduto, $sCustoProduto)

	Local Const $iCampoQtdeEixoX = 594 
	Local Const $iCampoQtdeEixoY = 299

	Local Const $iBotaoGravarItemEixoX = 1021
	Local Const $iBotaoGravarItemEixoY = 555

	Local Const $iBotaoIncluirItemEixoX = 1021
	Local Const $iBotaoIncluirItemEixoY = 485

	Local Const $iBotaoCancelarItemEixoX = 1021
	Local Const $iBotaoCancelarItemEixoY = 580

	;For $i = 1 To $iQtdeDeProdutos Step +1
		
		Do

			MouseClick("LEFT", $iBotaoIncluirItemEixoX, $iBotaoIncluirItemEixoY)
			
			;$iCodigoProduto = GetSolicitaCodigo("INFORME UM CÓDIGO DE PRODUTO ..:")
			Send($iCodigoProduto & "{TAB}")

			$bResultadoCodigoNaoCadastrado = TelaCodigoNaoCadastradoExiste() ; Função da UDF ValidacoesGuardian.au3
			$bResultadoProdutoBloqueado = TelaProdutoBloqueadoExiste() ; Função da UDF ValidacoesGuardian.au3

			If ($bResultadoCodigoNaoCadastrado Or $bResultadoProdutoBloqueado) Then
				
				Send("^a{DEL}")
				MouseClick("LEFT", $iBotaoCancelarItemEixoX, $iBotaoCancelarItemEixoY)
				
			EndIf
			
		Until Not ($bResultadoCodigoNaoCadastrado Or $bResultadoProdutoBloqueado)

		; Clique no campo Quantidade
		MouseClick("LEFT", $iCampoQtdeEixoX, $iCampoQtdeEixoY, 3)
		Send("1{ENTER}")
		Send($sCustoProduto & "{ENTER}")
		
		; Clique no Botão Gravar
		MouseClick("LEFT", $iBotaoGravarItemEixoX, $iBotaoGravarItemEixoY)

		#cs ===============================================================================================================================
			$bResultadoInformarCampo = TelaCampoDeveSerInformadoExiste() ; Função da UDF ValidacoesGuardian.au3

			If ($bResultadoInformarCampo) Then
				
				MouseClick("LEFT", $iBotaoCancelarItemEixoX, $iBotaoCancelarItemEixoY)
				$i -= 1
				
			EndIf			
		#ce ===============================================================================================================================

	;Next

EndFunc

#EndRegion ### FUNÇÕES
