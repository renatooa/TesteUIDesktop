#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Teste do Relatório de DAV
	Data Inicio ....: 28/05/2015
	Data Termino ...:
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcAbrirRelatorioDAV.au3"

;			 -----------  FIM INCLUDES  ----------

;************************* VARIAVEIS ***************************
;***************************************************************

$v_msgInicial = MsgBox(0, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
		"Impressão do Relatório de DAV Utilizando" & @CR & "Todos os campos de forma alternada com o Modelo 1" _
		 & @CR & @CR & "OBS.: O Space Guardian precisa está aberto!")

;### Tidy Error: If/ElseIf statement without a then..
If $v_msgInicial = 0 Then

	Exit

Else

	f_abrirRelatorioDAV()

	Sleep(1000)
	Send("{tab 2} 01 {up 4} {enter}")

	WinWaitActive("", "Opções de Impressão")
	Send("{tab 2}")
	Send("{enter}")

	f_sairReport()

	;----------------------------------------------------------------
	;------------- Classificação Nat. Ope. PREENCHIDO
	;----------------------------------------------------------------

	f_mensagem("Impressão do relatório com o campo ""Classificação Nat. Ope."" preenchido!")

	Sleep(1000)
	Send("{tab 4} 15 {up 8} {enter}")

	WinWaitActive("", "Opções de Impressão")
	Send("{tab 2}")
	Send("{enter}")

	f_sairReport()

	;----------------------------------------------------------------
	;------------------- Nat. Operação PREENCHIDO
	;----------------------------------------------------------------

	f_mensagem("Impressão do relatório com o campo ""Nat. Operação"" preenchido!")

	Sleep(1000)
	Send("{tab 4} ^a {del}{tab}")
	;Sleep(500)
	Send("vin {tab}{up 10}")
	Send("{enter}")

	WinWaitActive("", "Opções de Impressão")
	Send("{tab 2}")
	Send("{enter}")

	f_sairReport()

	;----------------------------------------------------------------
	;------------ Supervisor PREENCHIDO
	;----------------------------------------------------------------

	f_mensagem("Impressão do relatório com o campo ""Supervisor"" preenchido!")

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

	f_mensagem("Impressão do relatório com o campo ""RCA"" preenchido!")

	Sleep(1000)
	Send("{tab 6} ^a {del}{tab}")
	Sleep(200)
	Send("43 {tab}")
	Send("{up 12}")
	Send("{enter}")

	f_esperarTelaAtencao()

EndIf

;************************* FUNÇÕES *****************************

Func f_mensagem($msg)

	MsgBox(1, "", "" & $msg)

EndFunc   ;==>f_mensagem

Func f_sairReport()

	WinWaitActive("", "Report Designer")
	Sleep(1000)
	Send("{esc}")

EndFunc   ;==>f_sairReport

Func f_esperarTelaAtencao()

	$telaAtencaoRetorno = WinWaitActive("Atenção", "", 2)

	if $telaAtencaoRetorno == 0 Then

		WinWaitActive("", "Opções de Impressão")
		Send("{tab 2}")
		Send("{enter}")

		f_sairReport()

	Else

		Sleep(2000)
		Send("{enter}")

	EndIf

EndFunc   ;==>f_esperarTelaAtencao


;***************************************************************
