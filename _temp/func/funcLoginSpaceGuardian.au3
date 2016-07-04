#cs ===============================================================================================================================
	Típo de Script .: Script de Função
	Descrição ......: Efetuar o Login no Guardian
	Data Inicio ....: 13/05/2015
	Data Termino ...: 15/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

Func f_loginSpaceGuardian()

	Send("#r")
	WinWaitActive("Executar")
	Send("C:\Space\Guardian-1\syson.exe {Enter}")

	WinWaitActive("Space Guardian - Versão", "", 5)

	If WinExists("Space Guardian - Versão") == 1 Then


		Send("manutmac{ENTER}")
		WinWaitActive("Space Guardian - Versão", "")
		Sleep(1000)
		;Send("{Enter}")
		Send("master{Enter 4}")
		WinWaitActive("Space Guardian - Versão", "")

	Else
		MsgBox(0, "Falha de Login", "Tela principal do sistema não foi localizada!" _
		& @CR & @CR & "Desta forma a rotina de teste automatizado será finalizada")
		Exit
	EndIf

EndFunc   ;==>f_loginSpaceGuardian
