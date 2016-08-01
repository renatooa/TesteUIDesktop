#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: 
	Data Inicio ....: 27/07/2016
	Data Termino ...: 27/07/2016
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once
Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
    =
    =   GetHorasAtualEmSegundos()
    =
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func GetHorasAtualEmSegundos()

    $iHourToSeconds = @HOUR * 3600
    $iMinutesToSeconds = @MIN * 60
    Return $iHourToSeconds + $iMinutesToSeconds + @SEC

EndFunc

#EndRegion ### FUNÇÕES