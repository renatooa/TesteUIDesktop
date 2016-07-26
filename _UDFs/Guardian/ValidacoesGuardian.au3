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
#include "Abstract\AbstractValidacaoGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
    =
    =   TelaCodigoNaoCadastradoExiste()
    =   TelaProdutoBloqueadoExiste()
    =   TelaCampoDeveSerInformadoExiste()
    =   TelaNatOperNaoPermitidaExiste()
    =   TelaCfopDiferenteNatOperExiste()
    =   TelaCfopNaoLiberadoExiste()
    =   TelaOpcoesImpressaoExiste()
    =   TelaDesejaImprimirExiste()
    =   TelaAtualizaPrecoExiste()
    =   TelaDesejaGerarNFExiste($sSimOuNao = "s")
    =   TelaProdutoEmOfertaExiste($sSimOuNao = "n")
    =   TelaPrecoZeradoExiste()
    =   TelaProdutoJaCadastradoNoPedidoExiste()
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

EndFunc   ;==>TelaAtualizaPrecoExiste

Func TelaDesejaGerarNFExiste($sSimOuNao = "s")
    
    Local Const $TextoTelaDesejaGerarNF = "Deseja Gerar NF"

    Return TelaExiste($TextoTelaDesejaGerarNF, $sSimOuNao)

EndFunc   ;==>TelaDesejaGerarNFExiste

Func TelaProdutoEmOfertaExiste($sSimOuNao = "n")
    
    Local Const $TextoTelaProdutoEmOferta = "Produto em Oferta"

    Return TelaExiste($TextoTelaProdutoEmOferta, $sSimOuNao)

EndFunc   ;==>TelaProdutoEmOfertaExiste

Func TelaPrecoZeradoExiste()
    
    Local Const $TextoTelaPrecoZerado = "Preço zerado"

    Return TelaExiste($TextoTelaPrecoZerado)

EndFunc   ;==>TelaPrecoZeradoExiste

Func TelaProdutoJaCadastradoNoPedidoExiste()
    
    Local Const $TextoTelaProdutoJaCadastradoNoPedido = "Este Produto já está cadatrado no Pedido"

    Return TelaExiste($TextoTelaProdutoJaCadastradoNoPedido)

EndFunc   ;==>TelaPrecoZeradoExiste

Func TelaVendaAbaixoEstoqueMinimoExiste()
    
    Local Const $TextoTelaVendaAbaixoEstoqueMinimoExiste = "Venda abaixo do Estoque Minimo"

    Return TelaExiste($TextoTelaVendaAbaixoEstoqueMinimoExiste)

EndFunc   ;==>TelaVendaAbaixoEstoqueMinimoExiste

Func TelaNumeroMaximoDeItensExiste()
    
    Local Const $TextoTelaNumeroMaximoDeItensExiste = "Número máximo de Itens Atingido"

    Return TelaExiste($TextoTelaNumeroMaximoDeItensExiste)

EndFunc   ;==>TelaNumeroMaximoDeItensExiste

#EndRegion ### FUNÇÕES
