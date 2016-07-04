#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Este Script testa a inclusão e gravação de DAV no Space Guardian
	Data Inicio ....: 18/05/2015
	Data Termino ...: 18/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcBotoesTelaDAV.au3"

;			 -----------  FIM INCLUDES  ----------

;************************* VARIAVEIS ***************************

;***************************************************************

MsgBox(0, "Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
		"Inclusão e Gravação de DAV" & @CR & @CR & "OBS.: O Space Guardian precisa está aberto!")

f_abrirTelaInclusaoDAV()

MouseClick("left", 391, 135, 2)
Sleep(1000)

;$v_codigoNaturezaOperacao = InputBox("Natureza de Operação", "Informe o código da natureza de operação!")
;Send(""& $v_codigoNaturezaOperacao )

;f_informarNaturezaOperacao()

Sleep(1000)
;Send("{enter 2}")

Send("{ENTER 3}8943{ENTER 9}9991")
Sleep(1000)
Send("{ENTER 4}1{ENTER 4}")
Sleep(1000)
Send("{TAB 10}")
Sleep(500)
Send("{ENTER}{TAB 3}{ENTER}")
WinWaitActive("Atenção", "")
Send("{ENTER}")
WinWaitActive("Space Guardian - Versão", "")
Send("{ESC}")
WinWaitActive("Confirmação", "")
Send("{LEFT}{ENTER}")
;Sleep(3000)
;Send("{ESC}{TAB}{ENTER}")


;************************* FUNÇÕES *****************************

Func f_informarNaturezaOperacao()

  Local $v_codigoNaturezaOperacao = InputBox("Natureza de Operação", "Informe o código da natureza de operação!")

EndFunc

;***************************************************************
