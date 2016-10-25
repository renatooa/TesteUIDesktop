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
             & "WHERE pro_filcodigo = " & $sCodigoFilialSelect & " AND pro_ativo = 1 " _
             & "AND pfi_estpenconfi = 0 AND pfi_estpenentra = 0 AND pfi_estpenentre = 0 " _
             & "AND lpd_estpenconfi = 0 AND lpd_estpenentra = 0 AND lpd_estpenentre = 0 " _
             & "AND pfi_estoque > 20 AND pfi_libvenda = 1 " _
             & "AND lpd_estfisico > 20 AND ppr_precovenda <> 0 " _
             & "AND ppr_prbcodigo = 1 AND pfi_inativo = 0 " _
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
    ;_ArrayDisplay(GetArrayCodigoProdutosParaVenda("root", "@kalunga123", "_sgdmsupdev", "localhost"))
    ;_ArrayDisplay(GetDataBases("root", "@kalunga123", "localhost"))
    ;ConsoleWrite(GetStringDataBases("root", "@kalunga123", "localhost"))
; ENDTESTE