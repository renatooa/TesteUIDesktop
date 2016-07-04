#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF para gerar CPF e CNPJ de forma aleatória
	Data Inicio ....: 01/09/2015
	Data Termino ...: 02/09/2015
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES / OPS ----------

Opt("TrayIconDebug", 1)
#include-once

;			 -----------  FIM INCLUDES / OPS ----------

;************************* VARIAVEIS ***************************

;-----------------
; VARIAVEIS CPF
;-----------------

Global $v_arrayResultadoNoveDigitos[9]
Global $v_arrayNoveDigitos[9]

Global $v_resultadoDecimoDigito = 0
Global $v_indiceArrayNoveDigitos = 0
Global $v_indiceArrayNoveDigitos2 = 0

Global $v_cpfSoma1 = 0
Global $v_cpfSoma2 = 0
Global $v_cpfPrimeiroDigito = 0
Global $v_cpfSegundoDigito = 0
Global $v_cpfDigito = ""
Global $v_numeroCPF = ""
Global $i_cpf = 0

;-----------------
; VARIAVEIS CNPJ
;-----------------
Global $v_arrayResultadoDozeDigitos[12]
Global $v_arrayDozeDigitos[12]

Global $v_resultadoDecimoTerceiroDigito = 0
Global $v_indicearrayDozeDigitos = 0
Global $v_indicearrayDozeDigitos2 = 0

Global $v_cnpjSoma1 = 0
Global $v_cnpjSoma2 = 0
Global $v_cnpjPrimeiroDigito = 0
Global $v_cnpjSegundoDigito = 0
Global $v_cnpjDigito = ""
Global $v_numeroCNPJ = ""
Global $i_cnpj = 0

;V_Fim *************************************************** V_Fim


;************************* FUNÇÕES *****************************

Func GerarCPF()

	;----------------------------------------------
	; 				PRIMEIRO DIGITO
	;----------------------------------------------

	$v_pesoPrimeiroDigitoCpf = 10

	While ($v_indiceArrayNoveDigitos <= 8) And ($v_pesoPrimeiroDigitoCpf > 1)

		Global $v_cpfDigitoAleatorio = Random(0, 9, 1)

		$v_arrayNoveDigitos[$v_indiceArrayNoveDigitos] = $v_cpfDigitoAleatorio

		$v_arrayResultadoNoveDigitos[$v_indiceArrayNoveDigitos] = $v_arrayNoveDigitos[$v_indiceArrayNoveDigitos] * $v_pesoPrimeiroDigitoCpf

		$v_cpfSoma1 = $v_cpfSoma1 + $v_arrayResultadoNoveDigitos[$v_indiceArrayNoveDigitos]

		$v_indiceArrayNoveDigitos += 1
		$v_pesoPrimeiroDigitoCpf -= 1

	WEnd

	$v_restoDivisaoPrimeiroDigito = Mod($v_cpfSoma1, 11)

	If ($v_restoDivisaoPrimeiroDigito < 2) Then

		$v_cpfPrimeiroDigito = 0

	Else

		$v_cpfPrimeiroDigito = 11 - $v_restoDivisaoPrimeiroDigito

	EndIf


	;----------------------------------------------
	; 				SEGUNDO DIGITO
	;----------------------------------------------

	$v_pesoSegundoDigitoCpf = 11

	$v_resultadoDecimoDigito = $v_cpfPrimeiroDigito

	While ($v_indiceArrayNoveDigitos2 <= 8)

		$v_cpfSoma2 = $v_cpfSoma2 + ($v_arrayNoveDigitos[$v_indiceArrayNoveDigitos2] * $v_pesoSegundoDigitoCpf)

		$v_indiceArrayNoveDigitos2 += 1
		$v_pesoSegundoDigitoCpf -= 1

	WEnd

	$v_cpfSoma2 = $v_cpfSoma2 + ($v_resultadoDecimoDigito * 2)

	$v_restoDivisaoSegundoDigito = Mod($v_cpfSoma2, 11)

	If ($v_restoDivisaoSegundoDigito < 2) Then

		$v_cpfSegundoDigito = 0

	Else

		$v_cpfSegundoDigito = 11 - $v_restoDivisaoSegundoDigito

	EndIf

	While ($i_cpf <= 8)

		$v_cpfDigito = $v_arrayNoveDigitos[$i_cpf]
		$v_numeroCPF = $v_numeroCPF & $v_cpfDigito

		$i_cpf += 1

	WEnd

	$v_numeroCPF = $v_numeroCPF & $v_cpfPrimeiroDigito & $v_cpfSegundoDigito

	Return $v_numeroCPF

EndFunc   ;==>GerarCPF


;**************************************************************************************************************************


Func GerarCNPJ()

	;----------------------------------------------
	; 				PRIMEIRO DIGITO
	;----------------------------------------------

	$v_pesoPrimeiroDigitoCnpj = 5

	While ($v_indicearrayDozeDigitos <= 11) ;And ($v_pesoPrimeiroDigitoCnpj > 1)

		Global $v_cnpjDigitoAleatorio = Random(0, 9, 1)

		$v_arrayDozeDigitos[$v_indicearrayDozeDigitos] = $v_cnpjDigitoAleatorio

		$v_arrayResultadoDozeDigitos[$v_indicearrayDozeDigitos] = $v_arrayDozeDigitos[$v_indicearrayDozeDigitos] * $v_pesoPrimeiroDigitoCnpj

		$v_cnpjSoma1 = $v_cnpjSoma1 + $v_arrayResultadoDozeDigitos[$v_indicearrayDozeDigitos]

		$v_indicearrayDozeDigitos += 1

		If ($v_pesoPrimeiroDigitoCnpj > 2) Then

			$v_pesoPrimeiroDigitoCnpj -= 1

		ElseIf (($v_pesoPrimeiroDigitoCnpj == 2)) Then

			$v_pesoPrimeiroDigitoCnpj = 10
			$v_pesoPrimeiroDigitoCnpj -= 1

		EndIf

	WEnd

	$v_restoDivisaoPrimeiroDigito = Mod($v_cnpjSoma1, 11)

	If ($v_restoDivisaoPrimeiroDigito < 2) Then

		$v_cnpjPrimeiroDigito = 0

	Else

		$v_cnpjPrimeiroDigito = 11 - $v_restoDivisaoPrimeiroDigito

	EndIf


	;----------------------------------------------
	; 				SEGUNDO DIGITO
	;----------------------------------------------

	$v_pesoSegundoDigitoCnpj = 6

	$v_resultadoDecimoTerceiroDigito = $v_cnpjPrimeiroDigito

	While ($v_indicearrayDozeDigitos2 <= 11)

		$v_cnpjSoma2 = $v_cnpjSoma2 + ($v_arrayDozeDigitos[$v_indicearrayDozeDigitos2] * $v_pesoSegundoDigitoCnpj)

		$v_indicearrayDozeDigitos2 += 1

		If ($v_pesoSegundoDigitoCnpj > 2) Then

			$v_pesoSegundoDigitoCnpj -= 1

		ElseIf (($v_pesoSegundoDigitoCnpj == 2)) Then

			$v_pesoSegundoDigitoCnpj = 10
			$v_pesoSegundoDigitoCnpj -= 1

		EndIf

	WEnd

	$v_cnpjSoma2 = $v_cnpjSoma2 + ($v_resultadoDecimoTerceiroDigito * 2)

	$v_restoDivisaoSegundoDigito = Mod($v_cnpjSoma2, 11)

	If ($v_restoDivisaoSegundoDigito < 2) Then

		$v_cnpjSegundoDigito = 0

	Else

		$v_cnpjSegundoDigito = 11 - $v_restoDivisaoSegundoDigito

	EndIf

	While ($i_cnpj <= 11)

		$v_cnpjDigito = $v_arrayDozeDigitos[$i_cnpj]
		$v_numeroCNPJ = $v_numeroCNPJ & $v_cnpjDigito

		$i_cnpj += 1

	WEnd

	$v_numeroCNPJ = $v_numeroCNPJ & $v_cnpjPrimeiroDigito & $v_cnpjSegundoDigito

	Return $v_numeroCNPJ

EndFunc   ;==>GerarCNPJ

;F_Fim *************************************************** F_Fim