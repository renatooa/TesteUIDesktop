#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF para gerar CPF e CNPJ de forma aleatória
	Data Inicio ....: 01/09/2015
	Data Termino ...: 02/09/2015
	Versão .........: 002
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)
#include-once
#include <StringConstants.au3>
#include <Array.au3>

;			 -----------  FIM INCLUDES / OPS ----------


;************************* FUNÇÕES *****************************

Func GerarCPF($bPontos = False)

	Local $aNoveDigitos[9]
	Local $iSomaDigitosCpf = 0
	Local $iCpfPrimeiroDigito = 0
	Local $iCpfSegundoDigito = 0
	Local $sCpfDigito = ""
	Local $sNumeroCPF = ""

	;----------------------------------------------
	; 				PRIMEIRO DIGITO CPF
	;----------------------------------------------

	$iSomaDigitosCpf = GetSomaNoveDigitosCPF($aNoveDigitos)

	$iCpfPrimeiroDigito = GetDigitoVerificador($iSomaDigitosCpf)

	;----------------------------------------------
	; 				SEGUNDO DIGITO CPF
	;----------------------------------------------	

	$iSomaDigitosCpf = GetSomaNoveDigitosCPF($aNoveDigitos)

	; Soma o decimo digito.
	$iSomaDigitosCpf += ($iCpfPrimeiroDigito * 2)

	$iCpfSegundoDigito = GetDigitoVerificador($iSomaDigitosCpf)

	;----------------------------------------------

	For $i = 0 To 8 Step +1
	
		$sCpfDigito = $aNoveDigitos[$i]
		$sNumeroCPF = $sNumeroCPF & $sCpfDigito
	
	Next

	$sNumeroCPF = $sNumeroCPF & $iCpfPrimeiroDigito & $iCpfSegundoDigito

	;ConsoleWrite($sNumeroCPF)

	; 27/10/2016 - v002
	; Validação adicionada para gerar CPF com pontuação
	If ($bPontos) Then

		$n = StringSplit($sNumeroCPF, "", $STR_NOCOUNT)
		$numeroCPFComPontuacao = _
				  $n[0] & $n[1] & $n[2] & "." & _
				  $n[3] & $n[4] & $n[5] & "." & _
				  $n[6] & $n[7] & $n[8] & "-" & _
				  $n[9] & $n[10]

		ClipPut($numeroCPFComPontuacao)
		Return $numeroCPFComPontuacao

	Else

		ClipPut($sNumeroCPF) ; Adicionado 19/07/2016 - v002
		Return $sNumeroCPF

	EndIf

EndFunc   ;==>GerarCPF


;**************************************************************************************************************************


Func GerarCNPJ($bPontos = False)

	Local $aDozeDigitos[12]
	Local $iSomaDigitosCnpj = 0
	Local $iCnpjPrimeiroDigito = 0
	Local $iCnpjSegundoDigito = 0
	Local $iCnpjDigito = ""
	Local $sNumeroCNPJ = ""


	;----------------------------------------------
	; 				PRIMEIRO DIGITO CNPJ
	;----------------------------------------------

	$iSomaDigitosCnpj = GetSomaDozeDigitosCNPJ($aDozeDigitos)

	$iCnpjPrimeiroDigito = GetDigitoVerificador($iSomaDigitosCnpj)

	;----------------------------------------------
	; 				SEGUNDO DIGITO CNPJ
	;----------------------------------------------

	$iSomaDigitosCnpj = GetSomaDozeDigitosCNPJ($aDozeDigitos)

	$iSomaDigitosCnpj += ($iCnpjPrimeiroDigito * 2)

	$iCnpjSegundoDigito = GetDigitoVerificador($iSomaDigitosCnpj)

	;----------------------------------------------

	For $i = 0 To 11 Step +1
	
		$iCnpjDigito = $aDozeDigitos[$i]
		$sNumeroCNPJ = $sNumeroCNPJ & $iCnpjDigito
	
	Next

	$sNumeroCNPJ = $sNumeroCNPJ & $iCnpjPrimeiroDigito & $iCnpjSegundoDigito

	; 27/10/2016 - v002
	; Validação adicionada para gerar CNPJ com pontuação
	If ($bPontos) Then

		$n = StringSplit($sNumeroCNPJ, "", $STR_NOCOUNT)
		$numeroCNPJComPontuacao = _
				$n[0] & $n[1] & "." & $n[2] & $n[3] & $n[4] & "." & $n[5] & $n[6] & $n[7] _
				 & "/" & $n[8] & $n[9] & $n[10] & $n[11] & "-" & $n[12] & $n[13]

		ClipPut($numeroCNPJComPontuacao)
		Return $numeroCNPJComPontuacao
		
	Else

		ClipPut($sNumeroCNPJ) ; Adicionado 19/07/2016 - v002
		Return $sNumeroCNPJ
		
	EndIf

EndFunc   ;==>GerarCNPJ

#Region ### FUNÇÕES PRIVADAS

Func GetDigitoVerificador($iSomaDigitos)

	$iRestoDivisao = Mod($iSomaDigitos, 11)

	If ($iRestoDivisao < 2) Then
		$iSomaDigitos = 0
		Return $iSomaDigitos
	Else
		$iSomaDigitos = 0
		Return (11 - $iRestoDivisao)
	EndIf

EndFunc

; Caso o array passado como parametro esteja vazio 
; será gerado os nove digitos do CPF aleatoriamente
Func GetSomaNoveDigitosCPF(ByRef $aNoveDigitos)

	Local Const $oPrimeiroItemArray = $aNoveDigitos[0]	
	Local $iIndiceArrayNoveDigitos = 0
	Local $iSomaDigitosCpf = 0

	$iPeso = ($oPrimeiroItemArray == "") ? 10 : 11

	While ($iIndiceArrayNoveDigitos <= 8 And $iPeso > 1)

		If ( $oPrimeiroItemArray == "" ) Then

			$iCpfDigitoAleatorio = Random(0, 9, 1)
			$aNoveDigitos[$iIndiceArrayNoveDigitos] = $iCpfDigitoAleatorio			
		
		EndIf		

		$iSomaDigitosCpf += $aNoveDigitos[$iIndiceArrayNoveDigitos] * $iPeso

		$iIndiceArrayNoveDigitos += 1
		$iPeso -= 1

	WEnd

	Return $iSomaDigitosCpf

EndFunc

; Caso o array passado como parametro esteja vazio 
; será gerado os doze digitos do CNPJ aleatoriamente
Func GetSomaDozeDigitosCNPJ(ByRef $aDozeDigitos)

	Local Const $oPrimeiroItemArray = $aDozeDigitos[0]	
	Local $iIndiceArrayDozeDigitos = 0
	Local $iSomaDigitosCnpj = 0

	$iPeso = ($oPrimeiroItemArray == "") ? 5 : 6

	While ($iIndiceArrayDozeDigitos <= 11 And $iPeso > 1)

		If ( $oPrimeiroItemArray == "" ) Then
		
			$iCnpjDigitoAleatorio = Random(0, 9, 1)

			; 27/10/2016 - v002
			; Validação adicionada para gerar CNPJ com "mil" contra
			If ($iIndiceArrayDozeDigitos < 8) Then
				$aDozeDigitos[$iIndiceArrayDozeDigitos] = $iCnpjDigitoAleatorio
			Else
				$iFilial = Random(1, 5, 1)
				$aDozeDigitos[$iIndiceArrayDozeDigitos] = ($iIndiceArrayDozeDigitos <> 11) ? 0 : $iFilial
			EndIf			
		
		EndIf

		$iSomaDigitosCnpj += $aDozeDigitos[$iIndiceArrayDozeDigitos] * $iPeso

		$iIndiceArrayDozeDigitos += 1

		If ($iPeso > 2) Then

			$iPeso -= 1

		ElseIf ($iPeso == 2) Then

			$iPeso = 10
			$iPeso -= 1

		EndIf

	WEnd

	Return $iSomaDigitosCnpjht

EndFunc

#EndRegion ### FUNÇÕES PRIVADAS

;F_Fim *************************************************** F_Fim

;[TESTE]
; ConsoleWrite(GerarCPF() & @CRLF)
; ConsoleWrite(GerarCPF(true) & @CRLF)

; ConsoleWrite(GerarCNPJ() & @CRLF)
; ConsoleWrite(GerarCNPJ(true) & @CRLF)