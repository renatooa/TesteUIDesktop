#cs ===============================================================================================================================
	Típo de Script .: Script de Função
	Descrição ......:
	Data Inicio ....: 28/05/2015
	Data Termino ...: 28/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------
#include-once
;			 -----------  FIM INCLUDES  ----------

;************************* VARIAVEIS ***************************
;***************************************************************
;************************* FUNÇÕES *****************************

Func f_abrirRelatorioDAV()

	WinActivate("Space Guardian - Versão")

	If WinActive("Space Guardian - Versão", "Relatório de Documento Auxiliar de Venda") Then

		Send("{esc}{tab}{enter}")
		Sleep(500)
		Send("!v")
		Sleep(1000)
		Send("{UP}{enter 2}")
		WinWaitActive("Space Guardian - Versão", "Relatório de Documento Auxiliar de Venda")

	Else

		Sleep(500)
		Send("!v")
		Sleep(1000)
		Send("{UP}{enter 2}")
		WinWaitActive("Space Guardian - Versão", "Relatório de Documento Auxiliar de Venda")

	EndIf

EndFunc   ;==>f_abrirRelatorioDAV

;***************************************************************
