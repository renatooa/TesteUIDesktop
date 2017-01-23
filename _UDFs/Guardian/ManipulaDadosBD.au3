#cs ===============================================================================================================================
    Típo de Script .: Script de Função - UDF
    Descrição ......:
    Data Inicio ....: 21/07/2016
    Data Termino ...: ~
    Versão .........: 001
    Autor(s) .......: Ronildo
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
    =
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func GetArrayCodigoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost, $sCodigoFilialSelect = "1")

    $sCodigosProdutos = ""
    $oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)    

    $sSelect = "SELECT pro_codigo FROM produto " _
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
             & "AND unp_qminvenda <= 1 " _
             & "GROUP BY pro_codigo;"

    $oResultQuery = _Query($oMySqlConn, $sSelect)

    If (IsObj($oResultQuery)) Then
        With $oResultQuery
            While Not .EOF
                $sCodigosProdutos &= .Fields("pro_codigo").Value & "|"
                .MoveNext                
            WEnd            
        EndWith
    EndIf
    
    _MySQLEnd($oMySqlConn)

    #cs
        StringReplace remove ultimo Pipe para não gerar indice com 
        valor em branco ao fazer o StringSplit
    #ce
    $sCodigosProdutos = StringReplace($sCodigosProdutos, "|", "", -1)
    $aCodigosProdutos = StringSplit($sCodigosProdutos, "|", $STR_NOCOUNT)
    _ArrayShuffle($aCodigosProdutos) 

    Return $aCodigosProdutos

EndFunc   ;==>GetArrayCodigoProdutosParaVenda


#cs
    Retornar uma array de string com o código do produto e o preço separados por ponto e virgula (;)
#ce
Func GetArrayCodigoEPrecoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost, $sCodigoFilialSelect = "1")

    $sCodigoPrecoProduto = ""
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
             & "AND unp_qminvenda <= 1 " _
             & "GROUP BY pro_codigo;"

    $oResultQuery = _Query($oMySqlConn, $sSelect)

    If (IsObj($oResultQuery)) Then
        With $oResultQuery
            While Not .EOF
                $sCodigoPrecoProduto &= .Fields("pro_codigo").Value & ";" & .Fields("ppr_precovenda").Value & "|"
                .MoveNext            
            WEnd            
        EndWith
    EndIf
    
    _MySQLEnd($oMySqlConn)

    #cs
        StringReplace remove ultimo Pipe para não gerar indice com 
        valor em branco ao fazer o StringSplit
    #ce
    $sCodigoPrecoProduto = StringReplace($sCodigoPrecoProduto, "|", "", -1)
    $aCodigoPrecoProduto = StringSplit($sCodigoPrecoProduto, "|", $STR_NOCOUNT)

    _ArrayShuffle($aCodigoPrecoProduto) 

    Return $aCodigoPrecoProduto

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

    For $sDataBase In $aDataBases
        If (VarGetType($sDataBase) == "String") Then
            $sDataBases = $sDataBases & $sDataBase & "|"
        EndIf
    Next

    Return $sDataBases

EndFunc   ;==>GetDataBasesInString

#EndRegion ### FUNÇÕES

; TESTE    
    ;_ArrayDisplay(GetArrayCodigoProdutosParaVenda("rooteste", "@teste123", "madsol", "localhost"))
    ;_ArrayDisplay(GetArrayCodigoEPrecoProdutosParaVenda("rooteste", "@teste123", "madsol", "localhost"))
    ;_ArrayDisplay(GetDataBases("rooteste", "@teste123", "localhost"))
    ;ConsoleWrite(GetStringDataBases("rooteste", "@teste123", "localhost"))
; ENDTESTE