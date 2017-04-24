#cs ===============================================================================================================================
    Típo de Script .: Script de Função - UDF
    Descrição ......: UDF Abstract com funções comuns para validações no Space Guardian
    Data Inicio ....: 12/05/2016
    Data Termino ...: ~
    Versão .........: 002
    Autor(s) .......: Ronildo
    Obs.............: Adicionado parametro de titulo 10/02/2017
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("WinWaitDelay", 50)

#include-once

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
    =
    =   TelaExiste($sTituloTela, $sTextoTela, $sSendKey = "{ENTER}", $iSleepDelay = 200)
    =
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func TelaExiste($sTituloTela, $sTextoTela, $sSendKey = "{ENTER}", $iSleepDelay = 200)

    Sleep($iSleepDelay)    
    $iResultado = WinExists($sTituloTela, $sTextoTela)

    If ($iResultado) Then
        WinActivate($sTituloTela, $sTextoTela)
        Send($sSendKey)
        Return True
    EndIf

    Return False

EndFunc   ;==>TelaExiste

#EndRegion ### FUNÇÕES
