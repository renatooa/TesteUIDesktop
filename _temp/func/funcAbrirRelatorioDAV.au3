#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o
	Descri��o ......:
	Data Inicio ....: 28/05/2015
	Data Termino ...: 28/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------
#include-once
;			 -----------  FIM INCLUDES  ----------

;************************* VARIAVEIS ***************************
;***************************************************************
;************************* FUN��ES *****************************

Func f_abrirRelatorioDAV()

	WinActivate("Space Guardian - Vers�o")

	If WinActive("Space Guardian - Vers�o", "Relat�rio de Documento Auxiliar de Venda") Then

		Send("{esc}{tab}{enter}")
		Sleep(500)
		Send("!v")
		Sleep(1000)
		Send("{UP}{enter 2}")
		WinWaitActive("Space Guardian - Vers�o", "Relat�rio de Documento Auxiliar de Venda")

	Else

		Sleep(500)
		Send("!v")
		Sleep(1000)
		Send("{UP}{enter 2}")
		WinWaitActive("Space Guardian - Vers�o", "Relat�rio de Documento Auxiliar de Venda")

	EndIf

EndFunc   ;==>f_abrirRelatorioDAV

;***************************************************************
