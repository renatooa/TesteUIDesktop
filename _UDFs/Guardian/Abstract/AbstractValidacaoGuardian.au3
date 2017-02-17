#cs ===============================================================================================================================
    T�po de Script .: Script de Fun��o - UDF
    Descri��o ......: UDF Abstract com fun��es comuns para valida��es no Space Guardian
    Data Inicio ....: 12/05/2016
    Data Termino ...: ~
    Vers�o .........: 002
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

#cs FUN��ES DA UDF ================================================================================================================
    =
    =   TelaExiste($sTituloTela, $sTextoTela, $sSendKey = "{ENTER}", $iSleepDelay = 200)
    =
#ce ===============================================================================================================================

#Region ### FUN��ES

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

#EndRegion ### FUN��ES
