#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o
	Descri��o ......: Fun��es para efetuar a a��o de click dos bot�es da tela de consulta do DAV
	Data Inicio ....: 18/05/2015
	Data Termino ...: 18/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------

#include-once

;			 -----------  FIM INCLUDES  ----------

;Global $v_verificarTelaGuardianAtiva = WinActivate("Space Guardian - Vers�o")

;************************* FUN��ES *****************************

Func f_verificarTelaGuardianAtiva()

	Local $v_TelaGuardianAtiva = WinActivate("Space Guardian - Vers�o")

	If $v_TelaGuardianAtiva == 0 Then

		MsgBox(48, "Aten��o", "TELA DO SPACE GUARDIAN N�O FOI LOCALIZADA!")
		Exit

	EndIf

EndFunc   ;==>f_verificarTelaGuardianAtiva

Func f_abrirTelaInclusaoDAV()

	f_verificarTelaGuardianAtiva()

	Send("!v{ENTER}")
	Sleep(1000)
	Send("{F2}")
	WinWaitActive("Space Guardian", "Documento Auxiliar de Venda")

EndFunc   ;==>f_abrirTelaInclusaoDAV

Func f_abrirTelaAlteracaoComItemDAV()

	f_verificarTelaGuardianAtiva()

	Send("!v{ENTER}")
	Sleep(1000)
	Send("{F3}")
	WinWaitActive("Space Guardian", "Documento Auxiliar de Venda")

EndFunc   ;==>f_abrirTelaAlteracaoComItemDAV

Func f_abrirTelaAlteracaoSemItemDAV()

	f_verificarTelaGuardianAtiva()

	Send("!v{ENTER}")
	MouseClick("left", 443, 613, 1)
	WinWaitActive("Space Guardian", "Documento Auxiliar de Venda")

EndFunc   ;==>f_abrirTelaAlteracaoSemItemDAV

Func f_abrirTelaCancelarDAV()

	f_verificarTelaGuardianAtiva()

	Send("!v{ENTER}")
	Sleep(1000)
	Send("{F4}")
	WinWaitActive("Space Guardian", "Documento Auxiliar de Venda")

EndFunc   ;==>f_abrirTelaCancelarDAV

;***************************************************************
