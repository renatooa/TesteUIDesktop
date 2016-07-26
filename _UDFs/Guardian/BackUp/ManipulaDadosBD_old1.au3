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

#include <StringConstants.au3>
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
=	
=	GetArrayCodigoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost)
=	GetDataBases($sUsername, $sPassword, $sHost, $sDatabase = "")
=
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func GetArrayCodigoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost)

	$sCodigosProdutos = ""

	$oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)

	$sSelect = "select pro_codigo from produto " _
			& "inner join  produtofilial on pro_codigo = pfi_procodigo " _
			& "inner join localprod on pfi_procodigo = lpd_procodigo " _
			& "inner join produtopreco on lpd_procodigo = ppr_procodigo " _
			& "where pro_filcodigo = 1 and pro_ativo = 1 " _
			& "and pfi_estoque > 20 and pfi_libvenda = 1 " _
			& "and lpd_estfisico > 20 and ppr_precovenda <> 0 " _
			& "group by pro_codigo"

	$oResultQuery = _Query($oMySqlConn, $sSelect)

	if(IsObj($oResultQuery)) Then

		With $oResultQuery
			While Not .EOF
				$sCodigosProdutos = $sCodigosProdutos & .Fields("pro_codigo").Value & "|"
				.MoveNext
			WEnd
		EndWith

	EndIf

	$aCodigosProdutos = StringSplit($sCodigosProdutos, "|", $STR_NOCOUNT)

	Return $aCodigosProdutos

EndFunc

Func GetDataBases($sUsername, $sPassword, $sHost, $sDatabase = "")

	Local $oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost
)	Return _GetDBNames($oMySqlConn)

EndFunc

#EndRegion ### FUNÇÕES

; TESTE
	;GetArrayCodigoProdutosParaVenda("root", "@kalunga123", "dental", "localhost")
	;ConsoleWrite(" *** " & UBound(GetArrayCodigoProdutosParaVenda()) - 1 & " *** " & @CR)
	;For $vElement In GetArrayCodigoProdutosParaVenda()
	;	ConsoleWrite($vElement & " | ")		
	;Next

	;For $vElement In GetDataBases("root", "@kalunga123", "localhost")	
	;	ConsoleWrite($vElement)	
	;Next
; EndTeste