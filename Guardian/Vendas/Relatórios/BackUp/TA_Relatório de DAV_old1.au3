#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Teste do Relat�rio de DAV
	Data Inicio ....: 28/05/2015
	Data Termino ...:
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcAbrirRelatorioDAV.au3"

;			 -----------  FIM INCLUDES  ----------

;************************* VARIAVEIS ***************************
;***************************************************************

$v_msgInicial = MsgBox(0, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
		"Impress�o do Relat�rio de DAV Utilizando" & @CR & "Todos os campos de forma alternada com o Modelo 1" _
		& @CR & @CR & "OBS.: O Space Guardian precisa est� aberto!")

		If $v_msgInicial = 0

		   Exit

	   Else

f_abrirRelatorioDAV()

Sleep(1000)
Send("{tab 2} 01 {up 4} {enter}")

WinWaitActive("", "Op��es de Impress�o")
Send("{tab 2}")
Send("{enter}")

f_sairReport()

;----------------------------------------------------------------
;------------- Classifica��o Nat. Ope. PREENCHIDO
;----------------------------------------------------------------

f_mensagem("Impress�o do relat�rio com o campo ""Classifica��o Nat. Ope."" preenchido!")

Sleep(1000)
Send("{tab 4} 15 {up 8} {enter}")

WinWaitActive("", "Op��es de Impress�o")
Send("{tab 2}")
Send("{enter}")

f_sairReport()

;----------------------------------------------------------------
;------------------- Nat. Opera��o PREENCHIDO
;----------------------------------------------------------------

f_mensagem("Impress�o do relat�rio com o campo ""Nat. Opera��o"" preenchido!")

Sleep(1000)
Send("{tab 4} ^a {del}{tab}")
;Sleep(500)
Send("vin {tab}{up 10}")
Send("{enter}")

WinWaitActive("", "Op��es de Impress�o")
Send("{tab 2}")
Send("{enter}")

f_sairReport()

;----------------------------------------------------------------
;------------ Supervisor PREENCHIDO
;----------------------------------------------------------------

f_mensagem("Impress�o do relat�rio com o campo ""Supervisor"" preenchido!")

Sleep(1000)
Send("{tab 5} ^a {del}{tab}")
Sleep(200)
Send("1 {tab}")
Send("{up 11}")
Send("{enter}")

f_esperarTelaAtencao()

;----------------------------------------------------------------
;--------------- RCA PREENCHIDO
;----------------------------------------------------------------

f_mensagem("Impress�o do relat�rio com o campo ""RCA"" preenchido!")

Sleep(1000)
Send("{tab 6} ^a {del}{tab}")
Sleep(200)
Send("43 {tab}")
Send("{up 12}")
Send("{enter}")

f_esperarTelaAtencao()

EndIf

;************************* FUN��ES *****************************

Func f_mensagem($msg)

	MsgBox(1, "", "" & $msg)

EndFunc   ;==>f_mensagem

Func f_sairReport()

	WinWaitActive("", "Report Designer")
	Sleep(1000)
	Send("{esc}")

EndFunc   ;==>f_sairReport

Func f_esperarTelaAtencao()

	$telaAtencaoRetorno = WinWaitActive("Aten��o", "", 2)

	if $telaAtencaoRetorno == 0 Then

		WinWaitActive("", "Op��es de Impress�o")
		Send("{tab 2}")
		Send("{enter}")

		f_sairReport()

	Else

		Sleep(2000)
		Send("{enter}")

	EndIf

EndFunc   ;==>f_esperarTelaAtencao


;***************************************************************
