#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o
	Descri��o ......: Efetuar o Login no Guardian
	Data Inicio ....: 13/05/2015
	Data Termino ...: 15/05/2015
	Vers�o .........: 002 --> 05/02/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

; Incluido o SendKeyDelay, os parametros e a valida��o dos mesmo --> 05/02/2015.

Opt("SendKeyDelay", 30)

Func LoginSpaceGuardian($sLogin = "MANUTMAC", $sSenha = "@kalunga123")

	If(Not IsString($sLogin) And Not IsString($sSenha)) Then
		MsgBox(0, "", "Login ou Senha Inv�lida!")
		Exit
	EndIf

	Send("#r")
	WinWaitActive("Executar")
	Send("C:\Space\Guardian-1\syson.exe {Enter}")

	WinWaitActive("Space Guardian - Vers�o", "", 5)

	If WinExists("Space Guardian - Vers�o") == 1 Then


		Send($sLogin & "{ENTER}")
		WinWaitActive("Space Guardian - Vers�o", "")
		Sleep(1000)
		;Send("{Enter}")
		Send($sSenha & "{Enter 4}")
		WinWaitActive("Space Guardian - Vers�o", "")

	Else
		MsgBox(0, "Falha de Login", "Tela principal do sistema n�o foi localizada!" _
		& @CR & @CR & "Desta forma a rotina de teste automatizado ser� finalizada")
		Exit
	EndIf

EndFunc   ;==>LoginSpaceGuardian
