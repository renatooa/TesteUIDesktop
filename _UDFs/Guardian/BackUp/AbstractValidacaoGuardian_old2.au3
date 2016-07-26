#cs ===============================================================================================================================
    Típo de Script .: Script de Função - UDF
    Descrição ......: UDF Abstract com funções comuns para validações no Space Guardian
    Data Inicio ....: 12/05/2016
    Data Termino ...: ~
    Versão .........: 001
    Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.

#include-once

#EndRegion ###  INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
=   
=   TelaExiste($sTextoTela, $sSendKey = "{ENTER}", $iSleepDelay = 200)
=
#ce ===============================================================================================================================

#Region ### FUNÇÕES

Func TelaExiste($sTextoTela, $sSendKey = "{ENTER}", $iSleepDelay = 200)
    
    Sleep($iSleepDelay)
    $iResultado = WinExists("", $sTextoTela)
    
    If ($iResultado) Then
        WinActivate("", $sTextoTela)
        Send($sSendKey)
        Return True
    Else
        Return False
    EndIf

EndFunc   ;==>TelaExiste

#EndRegion ### FUNÇÕES
