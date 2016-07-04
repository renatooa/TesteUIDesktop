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

#cs FUNÇÕES DA UDF ================================================================================================================
=	
=	TelaCodigoNaoCadastradoExiste()
=	TelaProdutoBloqueadoExiste()
=	TelaCampoDeveSerInformadoExiste()
=	TelaNatOperNaoPermitidaExiste()
=	TelaCfopDiferenteNatOperExiste()
=	TelaCfopNaoLiberadoExiste()
=	TelaOpcoesImpressaoExiste()
=	TelaDesejaImprimirExiste()
=	TelaAtualizaPrecoExiste()
=	TelaDesejaGerarNFExiste($sSimOuNao = "s")
=
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func TelaCodigoNaoCadastradoExiste()
	
	;Local Const $sTextoTelaCodigoNao = "Código não cadastrado"
	Local Const $sTextoTelaCodigoNao = "Código não"

	Return TelaExiste($sTextoTelaCodigoNao)

EndFunc   ;==>TelaCodigoNaoCadastradoExiste

Func TelaProdutoBloqueadoExiste()
	
	Local Const $sTextoTelaProdutoBloqueado = "Produto bloqueado"

	Return TelaExiste($sTextoTelaProdutoBloqueado)

EndFunc   ;==>TelaProdutoBloqueadoExiste

Func TelaCampoDeveSerInformadoExiste()
	
	Local Const $sTextoTelaCampoObrigatorio = "O campo deve ser informado"

	Return TelaExiste($sTextoTelaCampoObrigatorio)

EndFunc   ;==>TelaCampoDeveSerInformadoExiste

Func TelaNatOperNaoPermitidaExiste()
	
	;"Natureza de Operações não permite lançamento de espelho."
	Local Const $sTextoTelaNatOperNaoPermite = "Natureza de Operações não permite"

	Return TelaExiste($sTextoTelaNatOperNaoPermite)

EndFunc   ;==>TelaNatOperNaoPermitidaExiste

Func TelaCfopDiferenteNatOperExiste()
	
	Local Const $sTextoTelaCodigoFiscalDiferente = "Código fiscal diferente do configurado na Natureza de Operações."

	Return TelaExiste($sTextoTelaCodigoFiscalDiferente)

EndFunc   ;==>TelaCfopDiferenteNatOperExiste

Func TelaCfopNaoLiberadoExiste()
	
	Local Const $sTextoTelaCfopNaoLiberado = " NATOP: COM não liberada para o CFOP"

	Return TelaExiste($sTextoTelaCfopNaoLiberado)

EndFunc   ;==>TelaCfopNaoLiberadoExiste

Func TelaCodigoReferenciaProdFornecExiste()
	
	Local Const $sTextoTelaCodigoReferenciaFornecedor = "Código de Referência do produto no Fornecedor"

	Return TelaExiste($sTextoTelaCodigoReferenciaFornecedor, "{TAB 3}{ENTER}")

EndFunc   ;==>TelaCodigoReferenciaProdFornecExiste

Func TelaOpcoesImpressaoExiste()
	
	Local Const $TextoTelaOpcoesImpressaoExiste = "Opções de Impressão"

	Return TelaExiste($TextoTelaOpcoesImpressaoExiste, "{TAB 3}{ENTER}")

EndFunc   ;==>TelaOpcoesImpressaoExiste

Func TelaDesejaImprimirExiste()
	
	Local Const $TextoTelaDesejaImprimir = "Deseja imprimir"

	Return TelaExiste($TextoTelaDesejaImprimir, "n")

EndFunc   ;==>TelaDesejaImprimirExiste

Func TelaAtualizaPrecoExiste()
	
	Local Const $TextoTelaAtualizaPreco = "Atualiza Preços"

	Return TelaExiste($TextoTelaAtualizaPreco, "n")

EndFunc
 
Func TelaDesejaGerarNFExiste($sSimOuNao = "s")
	
	Local Const $TextoTelaDesejaGerarNF = "Deseja Gerar NF"

	Return TelaExiste($TextoTelaDesejaGerarNF, $sSimOuNao)

EndFunc

#EndRegion ### FUNÇÕES
