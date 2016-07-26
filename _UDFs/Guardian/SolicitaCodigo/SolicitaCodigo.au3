#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o - UDF
	Descri��o ......: UDF com fun��es para solicitar codigos
	Data Inicio ....: 26/07/2016
	Data Termino ...: ~
	Vers�o .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once

#include "Abstract\AbstractSolicitaCodigo.au3"
#include <MsgBoxConstants.au3>

#EndRegion ### INCLUDES / OPS

#cs FUN��ES DA UDF ================================================================================================================
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

#Region ### FUN��ES

Func SolicitaCodigoFornecedor()
	
	$vCodigo = SolicitaCodigo("INFORME UM C�DIGO DE FORNECEDOR ..: ")
	Return $vCodigo

EndFunc

Func SolicitaCodigoComprador()

	$vCodigo = SolicitaCodigo("INFORME UM C�DIGO DE COMPRADOR ..:")
	Return $vCodigo

EndFunc 

Func SolicitaCodigoTransportador()

	$vCodigo = SolicitaCodigo("INFORME UM C�DIGO DE TRANSPORTADOR ..:")
	Return $vCodigo

EndFunc 

Func SolicitaNaturezaOperacao()
	
	$vCodigo = SolicitaCodigo("INFORME UMA NATUREZA DE OPERA��O ..:")
	Return $vCodigo

EndFunc

Func SolicitaCodigoProduto()
	
	$vCodigo = SolicitaCodigo("INFORME UM C�DIGO DE PRODUTO ..:")
	Return $vCodigo

EndFunc

#EndRegion ### FUN��ES
