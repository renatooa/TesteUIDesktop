#cs ===============================================================================================================================
	Típo de Script .: Script de Includes
	Descrição ......: Arquivo para importar UDF's referente ao Guardian
	Data Inicio ....: 12/05/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ###	INCLUDES

	#include-once
	
	#include "Guardian\Constantes\ConstantesBotoesGuardian.au3"
	#include "Guardian\Constantes\ConstantesTextosGuardian.au3"
	#include "Guardian\IncluirProdutos.au3"
	#include "Guardian\ValidacoesGuardian.au3"
	#include "Guardian\SolicitaCodigo\SolicitaCodigo.au3"

	#Region ### INCLUDES DE OPÇÕES DE MENU

		#include "Guardian\OpcoesMenuCadastros.au3"
		#include "Guardian\OpcoesMenuCompras.au3"
		#include "Guardian\OpcoesMenuVendas.au3"
		
	#EndRegion ### INCLUDES DE OPÇÕES DE MENU

	#Region ### INCLUDES DE MANIPULAÇÃO DE BANDO DE DADOS

		#include "Guardian\ManipulaDadosBD.au3"

	#EndRegion ### INCLUDES DE MANIPULAÇÃO DE BANDO DE DADOS

#EndRegion ###	INCLUDES