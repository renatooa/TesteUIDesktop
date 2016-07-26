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
    =   GetArrayCodigoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost)
    =   GetDataBases($sUsername, $sPassword, $sHost, $sDatabase = "")
    =
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func GetArrayCodigoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost)

    $sCodigosProdutos = ""

    $oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)

    $sSelect = "SELECT pro_codigo FROM produto " _
             & "INNER JOIN  produtofilial ON pro_codigo = pfi_procodigo " _
             & "INNER JOIN localprod ON pfi_procodigo = lpd_procodigo " _
             & "INNER JOIN produtopreco ON lpd_procodigo = ppr_procodigo " _
             & "WHERE pro_filcodigo = 1 AND pro_ativo = 1 " _
             & "AND pfi_estoque > 20 AND pfi_libvenda = 1 " _
             & "AND lpd_estfisico > 20 AND ppr_precovenda <> 0 " _
             & "AND ppr_prbcodigo = 1 AND pfi_inativo = 0 " _
             & "GROUP BY pro_codigo;"

    $oResultQuery = _Query($oMySqlConn, $sSelect)    

    If (IsObj($oResultQuery)) Then

        With $oResultQuery
            While Not .EOF
                $sCodigosProdutos = $sCodigosProdutos & .Fields("pro_codigo").Value & "|"
                .MoveNext
            WEnd
        EndWith

    EndIf    

    _MySQLEnd($oMySqlConn)

    $aCodigosProdutos = StringSplit($sCodigosProdutos, "|", $STR_NOCOUNT)
    _ArrayShuffle($aCodigosProdutos)

    Return $aCodigosProdutos

EndFunc   ;==>GetArrayCodigoProdutosParaVenda

Func GetDataBases($sUsername, $sPassword, $sHost, $sDatabase = "")

    $oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)
    $aDataBases = _GetDBNames($oMySqlConn)
    _MySQLEnd($oMySqlConn)

    Return $aDataBases

EndFunc   ;==>GetDataBases

#EndRegion ### FUNÇÕES

; TESTE
    ;_ArrayDisplay(GetArrayCodigoProdutosParaVenda("root", "@kalunga123", "dental", "localhost"))
    ;_ArrayDisplay(GetDataBases("root", "@kalunga123", "localhost"))
; EndTeste
