#cs ===============================================================================================================================
	Típo de Script .: Script de Função
	Descrição ......: Efetuar o Login no Guardian
	Data Inicio ....: 13/05/2015
	Data Termino ...: 15/05/2015
	Versão .........: 002 --> 05/02/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

; Incluido o SendKeyDelay, os parametros e a validação dos mesmo --> 05/02/2015.

Opt("SendKeyDelay", 30)

Func LoginSpaceGuardian($sLogin = "MANUTMAC", $sSenha = "@kalunga123")

	If(Not IsString($sLogin) And Not IsString($sSenha)) Then
		MsgBox(0, "", "Login ou Senha Inválida!")
		Exit
	EndIf

	Send("#r")
	WinWaitActive("Executar")
	Send("C:\Space\Guardian-1\syson.exe {Enter}")

	WinWaitActive("Space Guardian - Versão", "", 5)

	If WinExists("Space Guardian - Versão") == 1 Then


		Send($sLogin & "{ENTER}")
		WinWaitActive("Space Guardian - Versão", "")
		Sleep(1000)
		;Send("{Enter}")
		Send($sSenha & "{Enter 4}")
		WinWaitActive("Space Guardian - Versão", "")

	Else
		MsgBox(0, "Falha de Login", "Tela principal do sistema não foi localizada!" _
		& @CR & @CR & "Desta forma a rotina de teste automatizado será finalizada")
		Exit
	EndIf

EndFunc   ;==>LoginSpaceGuardian
