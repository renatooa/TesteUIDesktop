#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......:
	Data Inicio ....: 18/04/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once
#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\Guardian\AbstractValidacaoGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func TelaCodigoNaoCadastradoExiste()
	
	;Local Const $sTextoTelaCodigoNao = "Código não cadastrado"
	Local Const $sTextoTelaCodigoNao = "Código não"

	return TelaExiste($sTextoTelaCodigoNao)

EndFunc

Func TelaProdutoBloqueadoExiste()
	
	Local Const $sTextoTelaProdutoBloqueado = "Produto bloqueado"

	return TelaExiste($sTextoTelaProdutoBloqueado)

EndFunc

Func TelaCampoDeveSerInformadoExiste()
	
	Local Const $sTextoTelaCampoObrigatorio = "O campo deve ser informado"

	return TelaExiste($sTextoTelaCampoObrigatorio)

EndFunc

Func TelaNatOperNaoPermitidaExiste()
	
	;"Natureza de Operações não permite lançamento de espelho."
	Local Const $sTextoTelaNatOperNaoPermite = "Natureza de Operações não permite"

	return TelaExiste($sTextoTelaNatOperNaoPermite)

EndFunc

Func TelaCfopDiferenteNatOperExiste()
	
	Local Const $sTextoTelaCodigoFiscalDiferente = "Código fiscal diferente do configurado na Natureza de Operações."

	return TelaExiste($sTextoTelaCodigoFiscalDiferente)

EndFunc

Func TelaCfopNaoLiberadoExiste()
	
	Local Const $sTextoTelaCfopNaoLiberado = " NATOP: COM não liberada para o CFOP"

	return TelaExiste($sTextoTelaCfopNaoLiberado)

EndFunc

Func TelaCodigoReferenciaProdFornecExiste()
	
	Local Const $sTextoTelaCodigoReferenciaFornecedor = "Código de Referência do produto no Fornecedor"

	return TelaExiste($sTextoTelaCodigoReferenciaFornecedor, "{TAB 3}{ENTER}")

EndFunc

Func TelaOpcoesImpressaoExiste()
	
	Local Const $TextoTelaOpcoesImpressaoExiste = "Opções de Impressão"

	return TelaExiste($TextoTelaOpcoesImpressaoExiste, "{TAB 3}{ENTER}")

EndFunc

Func TelaDesejaImprimirExiste()
	
	Local Const $TextoTelaDesejaImprimir = "Deseja imprimir"

	return TelaExiste($TextoTelaDesejaImprimir, "n")

EndFunc

#EndRegion ### FUNÇÕES 