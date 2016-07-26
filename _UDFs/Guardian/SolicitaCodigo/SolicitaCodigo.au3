#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF com funções para solicitar codigos
	Data Inicio ....: 26/07/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once

#include "Abstract\AbstractSolicitaCodigo.au3"
#include <MsgBoxConstants.au3>

#EndRegion ### INCLUDES / OPS

#cs FUNÇÕES DA UDF ================================================================================================================
=
=	SolicitaCodigoFornecedor()
=	SolicitaCodigoComprador()
=	SolicitaCodigoTransportador()
=	SolicitaNaturezaOperacao()
=	SolicitaCodigoProduto()
=
#ce ===============================================================================================================================

#Region ### VARIAVEIS

#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func SolicitaCodigoFornecedor()
	
	$vCodigo = SolicitaCodigo("INFORME UM CÓDIGO DE FORNECEDOR ..: ")
	Return $vCodigo

EndFunc

Func SolicitaCodigoComprador()

	$vCodigo = SolicitaCodigo("INFORME UM CÓDIGO DE COMPRADOR ..:")
	Return $vCodigo

EndFunc 

Func SolicitaCodigoTransportador()

	$vCodigo = SolicitaCodigo("INFORME UM CÓDIGO DE TRANSPORTADOR ..:")
	Return $vCodigo

EndFunc 

Func SolicitaNaturezaOperacao()
	
	$vCodigo = SolicitaCodigo("INFORME UMA NATUREZA DE OPERAÇÃO ..:")
	Return $vCodigo

EndFunc

Func SolicitaCodigoProduto()
	
	$vCodigo = SolicitaCodigo("INFORME UM CÓDIGO DE PRODUTO ..:")
	Return $vCodigo

EndFunc

#EndRegion ### FUNÇÕES
