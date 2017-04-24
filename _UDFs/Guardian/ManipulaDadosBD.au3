#cs ===============================================================================================================================
    Típo de Script .: Script de Função - UDF
    Descrição ......: UDF com funções para manipulação do banco de dados do Guardian.
    Data Inicio ....: 21/07/2016
    Data Termino ...: ~
    Versão .........: 002
    Autor(s) .......: Ronildo
    Obs.............: Abstraido o tratamento para recuperar valores de um unico campo da tabela (_GetArrayValoresUmCampo). 09/02/2017
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once

#include <Array.au3>
#include <StringConstants.au3>
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
    =
    =   GetArrayCodigoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost, $sCodigoFilialSelect = "1")
    =   GetArrayCodigoEPrecoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost, $sCodigoFilialSelect = "1")
    =   GetDataBasesInArray($sUsername, $sPassword, $sHost)
    =   GetDataBasesInString($sUsername, $sPassword, $sHost)
    =   GetArrayCodigoLayouts($sUsername, $sPassword, $sDatabase, $sHost, $sModeloLayout = "'PV'",$sCodigoFilialSelect = "1")
    =
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func GetArrayCodigoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost, $sCodigoFilialSelect = "1")

    $sSelect = "SELECT pro_codigo FROM produto " _
             & "INNER JOIN  produtofilial ON pro_codigo = pfi_procodigo AND pro_filcodigo = pfi_filcodigo " _
             & "INNER JOIN localprod ON pfi_procodigo = lpd_procodigo AND lpd_filcodigo = pfi_filcodigo " _
             & "INNER JOIN produtopreco ON lpd_procodigo = ppr_procodigo AND lpd_filcodigo = ppr_filcodigo " _
             & "INNER JOIN unidadepro ON unp_procodigo = ppr_procodigo AND unp_filcodigo = ppr_filcodigo " _
             & "WHERE pro_filcodigo = " & $sCodigoFilialSelect & " AND pro_ativo = 1 " _
             & "AND pfi_estoque > pfi_estpenentre " _
             & "AND lpd_estfisico > lpd_estpenentre " _
             & "AND pfi_inativo = 0 AND pfi_libvenda = 1 " _
             & "AND unp_libvenda = 1 AND unp_padvenda = 1 " _
             & "AND ppr_precovenda > 0 AND ppr_prbcodigo = 1 " _
             & "AND unp_fraciona = 0 AND unp_fracminima = 0 " _
             & "AND unp_qminvenda IN (0, 1)" _
             & "GROUP BY pro_codigo;"
             ; & "AND lpd_lcecodigo = 1001 " _

    $aCodigosProdutos = _GetArrayValoresUmCampo($sUsername, $sPassword, $sDatabase, $sHost, $sSelect, "pro_codigo")

    Return $aCodigosProdutos

EndFunc   ;==>GetArrayCodigoProdutosParaVenda

#cs
    Retornar uma array de string com o código do produto e o preço separados por ponto e virgula (;)
#ce
Func GetArrayCodigoEPrecoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost, $sCodigoFilialSelect = "1")

    $sCodigoEPrecoProduto = ""
    $oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)

    $sSelect = "SELECT pro_codigo, ppr_precovenda FROM produto " _
             & "INNER JOIN  produtofilial ON pro_codigo = pfi_procodigo AND pro_filcodigo = pfi_filcodigo " _
             & "INNER JOIN localprod ON pfi_procodigo = lpd_procodigo AND lpd_filcodigo = pfi_filcodigo " _
             & "INNER JOIN produtopreco ON lpd_procodigo = ppr_procodigo AND lpd_filcodigo = ppr_filcodigo " _
             & "INNER JOIN unidadepro ON unp_procodigo = lpd_procodigo " _
             & "WHERE pro_filcodigo = " & $sCodigoFilialSelect & " AND pro_ativo = 1 " _
             & "AND pfi_estpenconfi = 0 AND pfi_estpenentra = 0 AND pfi_estpenentre = 0 " _
             & "AND lpd_estpenconfi = 0 AND lpd_estpenentra = 0 AND lpd_estpenentre = 0 " _
             & "AND pfi_estoque > 10 AND pfi_libvenda = 1 " _
             & "AND lpd_estfisico > 10 AND ppr_precovenda <> 0 " _
             & "AND ppr_prbcodigo = 1 AND pfi_inativo = 0 " _
             & "AND unp_fraciona = 0 AND unp_fracminima = 0 " _             
             & "AND unp_qminvenda IN (0, 1)" _
             & "GROUP BY pro_codigo;"

    $oResultQuery = _Query($oMySqlConn, $sSelect)

    If (IsObj($oResultQuery)) Then
        With $oResultQuery
            While Not .EOF
                $sCodigoEPrecoProduto &= .Fields("pro_codigo").Value & ";" & .Fields("ppr_precovenda").Value & "|"
                .MoveNext
            WEnd
        EndWith
    EndIf

    _MySQLEnd($oMySqlConn)

    #cs
        StringReplace remove ultimo Pipe para não gerar indice com
        valor em branco ao fazer o StringSplit
    #ce
    $sCodigoEPrecoProduto = StringReplace($sCodigoEPrecoProduto, "|", "", -1)
    $aCodigoEPrecoProdutos = StringSplit($sCodigoEPrecoProduto, "|", $STR_NOCOUNT)

    _ArrayShuffle($aCodigoEPrecoProdutos)

    Return $aCodigoEPrecoProdutos

EndFunc   ;==>GetArrayCodigoEPrecoProdutosParaVenda

Func GetDataBasesInArray($sUsername, $sPassword, $sHost)

    Local Const $sDatabase = ""
    $oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)
    $aDataBases = _GetDBNames($oMySqlConn)
    _MySQLEnd($oMySqlConn)

    Return $aDataBases

EndFunc   ;==>GetDataBasesInArray

Func GetDataBasesInString($sUsername, $sPassword, $sHost)

    $sDataBases = ""
    $aDataBases = GetDataBasesInArray($sUsername, $sPassword, $sHost)

    For $sDatabase In $aDataBases
        If (VarGetType($sDatabase) == "String") Then
            $sDataBases = $sDataBases & $sDatabase & "|"
        EndIf
    Next

    Return $sDataBases

EndFunc   ;==>GetDataBasesInString

Func GetArrayCodigoLayouts($sUsername, $sPassword, $sDatabase, $sHost, $sModeloLayout = "'PV'", $sCodigoFilialSelect = "1")

    $sSelect = "SELECT lay_codigo FROM layoutrelat " _
             & "WHERE lay_modelo = " & $sModeloLayout _
             & " AND lay_filcodigo IN (0, " & $sCodigoFilialSelect & ")" _
             & " AND lay_tipoimpress = 'M'" _
             & " ORDER BY lay_codigo;"
             ; & " GROUP BY lay_namereport" _
             ; & " AND lay_namereport like 'relpd%'" _             
             ; & " AND lay_codigo <> 63" _
             ; & " AND lay_sql like '%pedidos%'" _

    $aCodigoLayouts = _GetArrayValoresUmCampo($sUsername, $sPassword, $sDatabase, $sHost, $sSelect, "lay_codigo", False)

    Return $aCodigoLayouts

EndFunc   ;==>GetArrayCodigoLayouts

; Func Update($sTabela, $aCamposValores, $sWhereArgs)

;     $oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)

;     _MySQLUpdate($oMySqlConn, $sTabela, $aCamposValores, $sWhereArgs)

;     _MySQLEnd($oMySqlConn)

; EndFunc   ;==>Update

#cs ===============================================================================================================================
                           ↓↓↓↓↓ FUNÇÕES PRIVADAS ↓↓↓↓↓
#ce ===============================================================================================================================

Func _GetArrayValoresUmCampo($sUsername, $sPassword, $sDatabase, $sHost, $sSelect, $sCampo, $bArrayShuffle = True)

    $ValorDoCampo = ""
    $oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)
    $oResultQuery = _Query($oMySqlConn, $sSelect)

    If (IsObj($oResultQuery)) Then
        With $oResultQuery
            While Not .EOF
                $ValorDoCampo &= .Fields($sCampo).Value & "|"
                .MoveNext
            WEnd
        EndWith
    EndIf

    _MySQLEnd($oMySqlConn)

    #cs
        StringReplace remove ultimo Pipe para não gerar indice com
        valor em branco ao fazer o StringSplit
    #ce
    $ValorDoCampo = StringReplace($ValorDoCampo, "|", "", -1)
    $aValoresDoCampo = StringSplit($ValorDoCampo, "|", $STR_NOCOUNT)

    If ($bArrayShuffle) Then
        _ArrayShuffle($aValoresDoCampo)
    EndIf

    Return $aValoresDoCampo

EndFunc   ;==>_GetArrayValoresUmCampo

#cs ===============================================================================================================================
                           ↑↑↑↑↑ FUNÇÕES PRIVADAS ↑↑↑↑↑
#ce ===============================================================================================================================

#EndRegion ### FUNÇÕES

#Region TESTE

; _ArrayDisplay(GetArrayCodigoProdutosParaVenda("rooteste", "@teste123", "madsol", "localhost"))
; _ArrayDisplay(GetArrayCodigoEPrecoProdutosParaVenda("rooteste", "@teste123", "madsol", "localhost"))
; _ArrayDisplay(GetDataBasesInArray("rooteste", "@teste123", "localhost"))
; ConsoleWrite(GetDataBasesInString("rooteste", "@teste123", "localhost"))
; _ArrayDisplay(GetArrayCodigoLayouts("rooteste", "@teste123", "madsol", "localhost"))

; ; *** Test function _MySQLUpdate ***
; $var1 = "nat_laycodigos|" & 3
; $var2 = "nat_layprevenda|" & 3
; $var3 = "nat_layorcam|" & 3
; $var4 = "nat_laypedpar|" & 3
; Local $aCamposValores[] = [$var1, $var2, $var3, $var4]
; Local $sWhereArgs = "nat_codigo = 'VI'"
            
; Update("natoper", $aCamposValores, $sWhereArgs)
; ; *************************************************************************

#EndRegion TESTE