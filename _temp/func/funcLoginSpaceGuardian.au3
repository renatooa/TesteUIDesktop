#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o
	Descri��o ......: Efetuar o Login no Guardian
	Data Inicio ....: 13/05/2015
	Data Termino ...: 15/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

Func f_loginSpaceGuardian()

	Send("#r")
	WinWaitActive("Executar")
	Send("C:\Space\Guardian-1\syson.exe {Enter}")

	WinWaitActive("Space Guardian - Vers�o", "", 5)

	If WinExists("Space Guardian - Vers�o") == 1 Then


		Send("manutmac{ENTER}")
		WinWaitActive("Space Guardian - Vers�o", "")
		Sleep(1000)
		;Send("{Enter}")
		Send("master{Enter 4}")
		WinWaitActive("Space Guardian - Vers�o", "")

	Else
		MsgBox(0, "Falha de Login", "Tela principal do sistema n�o foi localizada!" _
		& @CR & @CR & "Desta forma a rotina de teste automatizado ser� finalizada")
		Exit
	EndIf

EndFunc   ;==>f_loginSpaceGuardian
