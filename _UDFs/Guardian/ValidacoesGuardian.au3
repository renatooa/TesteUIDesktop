#cs ===============================================================================================================================
    Típo de Script .: Script de Função - UDF
    Descrição ......: UDF com funções para validações de existência de mensagens de alertas e/ou informativas do Guardian.
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
    =   TelaDesejaGerarNFExiste($sSimOuNao = "S")
    =   TelaProdutoEmOfertaExiste($sSimOuNao = "N")
    =   TelaPrecoZeradoExiste()
    =   TelaProdutoJaCadastradoNoPedidoExiste()
    =   TelaVendaAbaixoEstoqueMinimoExiste()
    =   TelaNumeroMaximoDeItensExiste()
    =   TelaProdutoNaoPossuiImagemExiste()
    =   TelaLimiteCreditoAtingidoExiste()
    =   TelaImagemDoProdutoExiste()
    =   TelaDescricaoDeProdutoDAVExiste()
    =   TelaDesejaFecharSessaoExiste($sSimOuNao = "N")
    =   TelaInformacoesNaoEncontradasExiste()
    =   TelaRegistroSendoUsadoExiste()
    =   TelaVendaNaoPermitidaExiste()
    =   TelaAcaoAposGravarDAVExiste($iDuracaoSleep = 1000)
    =   TelaQuantidadeMenorMinimaExiste()
    =   TelaGravacaoConcluidaExiste($iDuracaoSleep = 500)
    =   TelaIDispatchExceptionExiste($iDuracaoSleep = 1000)
    =   TelaExcecaoExiste($iDuracaoSleep = 1000)
    =   TelaProdutoInexistenteExite($iDuracaoSleep = 500)
    =
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func TelaCodigoNaoCadastradoExiste()
    
    ;Local Const $sTextoTelaCodigoNao = "Código não cadastrado"
    Local Const $sTextoTelaCodigoNao = "Código não"

    Return TelaExiste("", $sTextoTelaCodigoNao)

EndFunc   ;==>TelaCodigoNaoCadastradoExiste

Func TelaProdutoBloqueadoExiste()
    
    Local Const $sTextoTelaProdutoBloqueado = "Produto bloqueado"

    Return TelaExiste("", $sTextoTelaProdutoBloqueado)

EndFunc   ;==>TelaProdutoBloqueadoExiste

Func TelaCampoDeveSerInformadoExiste()
    
    Local Const $sTextoTelaCampoObrigatorio = "O campo deve ser informado"

    Return TelaExiste("", $sTextoTelaCampoObrigatorio)

EndFunc   ;==>TelaCampoDeveSerInformadoExiste

Func TelaNatOperNaoPermitidaExiste()
    
    ;"Natureza de Operações não permite lançamento de espelho."
    Local Const $sTextoTelaNatOperNaoPermite = "Natureza de Operações não permite"

    Return TelaExiste("", $sTextoTelaNatOperNaoPermite)

EndFunc   ;==>TelaNatOperNaoPermitidaExiste

Func TelaCfopDiferenteNatOperExiste()
    
    Local Const $sTextoTelaCodigoFiscalDiferente = "Código fiscal diferente do configurado na Natureza de Operações."

    Return TelaExiste("", $sTextoTelaCodigoFiscalDiferente)

EndFunc   ;==>TelaCfopDiferenteNatOperExiste

Func TelaCfopNaoLiberadoExiste()
    
    Local Const $sTextoTelaCfopNaoLiberado = " NATOP: COM não liberada para o CFOP"

    Return TelaExiste("", $sTextoTelaCfopNaoLiberado)

EndFunc   ;==>TelaCfopNaoLiberadoExiste

Func TelaCodigoReferenciaProdFornecExiste()
    
    Local Const $sTextoTelaCodigoReferenciaFornecedor = "Código de Referência do produto no Fornecedor"

    Return TelaExiste("", $sTextoTelaCodigoReferenciaFornecedor, "{TAB 3}{ENTER}")

EndFunc   ;==>TelaCodigoReferenciaProdFornecExiste

Func TelaOpcoesImpressaoExiste()
    
    Local Const $TextoTelaOpcoesImpressaoExiste = "Opções de Impressão"

    Return TelaExiste("", $TextoTelaOpcoesImpressaoExiste, "{TAB 3}{ENTER}")

EndFunc   ;==>TelaOpcoesImpressaoExiste

Func TelaDesejaImprimirExiste()
    
    Local Const $TextoTelaDesejaImprimir = "Deseja imprimir"

    Return TelaExiste("", $TextoTelaDesejaImprimir, "N")

EndFunc   ;==>TelaDesejaImprimirExiste

Func TelaAtualizaPrecoExiste()
    
    Local Const $TextoTelaAtualizaPreco = "Atualiza Preços"

    Return TelaExiste("", $TextoTelaAtualizaPreco, "N")

EndFunc   ;==>TelaAtualizaPrecoExiste

Func TelaDesejaGerarNFExiste($sSimOuNao = "S")
    
    Local Const $TextoTelaDesejaGerarNF = "Deseja Gerar NF"

    Return TelaExiste("", $TextoTelaDesejaGerarNF, $sSimOuNao)

EndFunc   ;==>TelaDesejaGerarNFExiste

Func TelaProdutoEmOfertaExiste($sSimOuNao = "N")
    
    Local Const $TextoTelaProdutoEmOferta = "Produto em Oferta"

    Return TelaExiste("", $TextoTelaProdutoEmOferta, $sSimOuNao)

EndFunc   ;==>TelaProdutoEmOfertaExiste

Func TelaPrecoZeradoExiste()
    
    Local Const $TextoTelaPrecoZerado = "Preço zerado"

    Return TelaExiste("", $TextoTelaPrecoZerado)

EndFunc   ;==>TelaPrecoZeradoExiste

Func TelaProdutoJaCadastradoNoPedidoExiste()
    
    Local Const $TextoTelaProdutoJaCadastradoNoPedido = "Este Produto já está cadatrado no Pedido"

    Return TelaExiste("", $TextoTelaProdutoJaCadastradoNoPedido)

EndFunc   ;==>TelaPrecoZeradoExiste

Func TelaVendaAbaixoEstoqueMinimoExiste()
    
    Local Const $TextoTelaVendaAbaixoEstoqueMinimo = "Venda abaixo do Estoque Minimo"

    Return TelaExiste("", $TextoTelaVendaAbaixoEstoqueMinimo)

EndFunc   ;==>TelaVendaAbaixoEstoqueMinimoExiste

Func TelaNumeroMaximoDeItensExiste()
    
    Local Const $TextoTelaNumeroMaximoDeItens = "Número máximo de Itens Atingido"

    Return TelaExiste("", $TextoTelaNumeroMaximoDeItens)

EndFunc   ;==>TelaNumeroMaximoDeItensExiste

Func TelaProdutoNaoPossuiImagemExiste()
    
    Local Const $TextoTelaProdutoNaoPossuiImagem = "Produto não possui Imagem"

    Return TelaExiste("", $TextoTelaProdutoNaoPossuiImagem)

EndFunc   ;==>TelaProdutoNaoPossuiImagemExiste

Func TelaLimiteCreditoAtingidoExiste()
    
    Local Const $TextoTelaLimiteCreditoAtingido = "Limite de crédito atingido. Verifique"

    Return TelaExiste("", $TextoTelaLimiteCreditoAtingido)

EndFunc   ;==>TelaLimiteCreditoAtingidoExiste

Func TelaImagemDoProdutoExiste()
    
    Local Const $TextoTelaImagemDoProduto = "Imagem do Produto"

    Return TelaExiste("", $TextoTelaImagemDoProduto)

EndFunc   ;==>TelaImagemDoProdutoExiste

Func TelaDescricaoDeProdutoDAVExiste()
    
    Local Const $TextoTelaDescricaoDeProdutoDAV = "Descrição de Produto para Documento Auxilia de Venda"

    Return TelaExiste("", $TextoTelaDescricaoDeProdutoDAV, "{TAB 5}{ENTER}")

EndFunc   ;==>TelaDescricaoDeProdutoDAVExiste

Func TelaDesejaFecharSessaoExiste($sSimOuNao = "N")
    
    Local Const $TextoTelaDesejaFecharSessao = "Deseja fechar a sessão"
    
    If ( $sSimOuNao <> "N" ) Then
        While (WinWaitNotActive("", $TextoTelaDesejaFecharSessao))    
            Sleep(1000)
            Send("{ESC}")

            ;WinWait(title, "[text]", [timeout])  ;WinActive("", $TextoTelaDesejaFecharSessao)
            If (WinActive("", $TextoTelaDesejaFecharSessao)) Then            
                ExitLoop         
            EndIf            
        WEnd
    EndIf   

    Return TelaExiste("", $TextoTelaDesejaFecharSessao, $sSimOuNao)

EndFunc   ;==>TelaDesejaFecharSessaoExiste

Func TelaInformacoesNaoEncontradasExiste()
    
    ;Local Const $TextoTelaDescricaoDeProdutoDAV = "Informações não encontradas para impressão do relatório."
    Local Const $TextoTelaInformacoesNaoEncontradas = "Informações não encontradas"

    Return TelaExiste("", $TextoTelaInformacoesNaoEncontradas)

EndFunc   ;==>TelaInformacoesNaoEncontradasExiste

Func TelaRegistroSendoUsadoExiste()

    Local Const $TituloTelaRegistroSendoUsado = "Registro sendo usado por outro usuário"

    Return TelaExiste($TituloTelaRegistroSendoUsado, "")

EndFunc   ;==>TelaRegistroSendoUsadoExiste

Func TelaVendaNaoPermitidaExiste()

    Local Const $TituloTelaVendaNaoPermitida = "Venda Não Permitida"

    Return TelaExiste($TituloTelaVendaNaoPermitida, "")

EndFunc   ;==>TelaVendaNaoPermitidaExiste

Func TelaAcaoAposGravarDAVExiste($iDuracaoSleep = 1000)

    Local Const $TextoTelaAcaoAposGravarDAV = "Ação"

    Return TelaExiste("", $TextoTelaAcaoAposGravarDAV, "{ESC}", $iDuracaoSleep)

EndFunc   ;==>TelaAcaoAposGravarDAVExiste

Func TelaQuantidadeMenorMinimaExiste()

    Local Const $TextoTelaQtdeMenoMinimaDAV = "Quantidade menor que a Mínima permitida para o Produto"

    Return TelaExiste("", $TextoTelaQtdeMenoMinimaDAV)

EndFunc   ;==>TelaQuantidadeMenorMinimaExiste 

Func TelaGravacaoConcluidaExiste($iDuracaoSleep = 500)

    Local Const $TextoTelaGravacaoConcluidDAV = "Gravação Concluída com êxito."

    Return TelaExiste("", $TextoTelaGravacaoConcluidDAV, "{ENTER}", $iDuracaoSleep)

EndFunc   ;==>TelaGravacaoConcluidaExiste 

Func TelaIDispatchExceptionExiste($iDuracaoSleep = 1000)

    Local Const $TextoTelaIDispatchException = "OLE IDispatch exception code"

    Return TelaExiste("", $TextoTelaIDispatchException, "{ENTER}", $iDuracaoSleep)

EndFunc   ;==>TelaIDispatchExceptionExiste 

Func TelaExcecaoExiste($iDuracaoSleep = 1000)

    ;Local Const $TextoTelaExcecao = "Exceção - Código"
    Local Const $TextoTelaExcecao = "Exceção"

    Return TelaExiste("", $TextoTelaExcecao, "O", $iDuracaoSleep)

EndFunc   ;==>TelaExcecaoExiste

Func TelaProdutoInexistenteExite($iDuracaoSleep = 500)

    Local Const $TextoTelaProdutoInexistente = "Produto Inexistente no local selecionado"

    Return TelaExiste("", $TextoTelaProdutoInexistente, "{ENTER}", $iDuracaoSleep)

EndFunc   ;==>TelaProdutoInexistenteExite 

Func TelaDesejaAbandonarExiste($sSimOuNao = "S")
    
    Local Const $TextoTelaDesejaAbandonar = "Deseja Abandonar"

    Return TelaExiste("", $TextoTelaDesejaAbandonar, $sSimOuNao)

EndFunc   ;==>TelaDesejaAbandonarExiste

#EndRegion ### FUNÇÕES
