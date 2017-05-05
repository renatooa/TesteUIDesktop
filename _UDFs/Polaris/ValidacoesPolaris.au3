#cs ===============================================================================================================================
    Típo de Script .: Script de Função - UDF
    Descrição ......: UDF com funções para validações de existência de mensagens de alertas e/ou informativas do Polaris.
    Data Inicio ....: 05/05/2017
    Data Termino ...: ~
    Versão .........: 001
    Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
    =
    =   TelaErroExiste() ;Return 1 ou 0
    =
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func TelaErroExiste()
	
    $iResultado = WinExists("Erro")
	If ($iResultado) Then		
		Send("{ENTER}")		
	EndIf

    Return $iResultado

EndFunc   ;==>TelaErroExiste

#EndRegion ### FUNÇÕES
