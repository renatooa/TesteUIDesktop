#cs ===============================================================================================================================
	Típo de Script .: Script de Função
	Descrição ......: Inclusão e Gravação de Cadastro de Feriado
	Data Inicio ....: 14/05/2015
	Data Termino ...: 15/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

Func CadastrarFeriado($v_diaFeriado, $v_anoFeriado, $v_nomeFeriado)

	; ---- Abrir Tela de Cadastro ----

	Sleep(1000)
	MouseClick("left", 20, 39, 2)
	MouseClick("left", 56, 362, 1)
	WinWaitActive("Space Guardian - Versão", "Feriados")
	MouseClick("left", 432, 525, 1)

	WinWaitActive("Space Guardian - Versão", "Cadastro de Feriados")

	Sleep(1000)
	Opt("SendKeyDelay", 30)
	Send("{ENTER}" & $v_diaFeriado & "{ENTER}{DOWN 4}{ENTER 2}" & $v_anoFeriado & "{TAB}" & $v_nomeFeriado)
	MouseClick("left", 727, 404, 1)
	MouseClick("left", 838, 459, 1)

	; ---- Fechar a Tela de Cadastro ----

	WinWaitActive("Space Guardian - Versão", "Feriados")
	MouseClick("left", 1004, 209, 1)
	WinWaitActive("Space Guardian - Versão")
	MouseClick("left", 456, 230, 1)

EndFunc   ;==>CadastrarFeriado
