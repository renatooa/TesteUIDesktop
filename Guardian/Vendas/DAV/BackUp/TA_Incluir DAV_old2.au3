#cs ===============================================================================================================================
	T�po de Script .: Script Execu��o de Teste
	Descri��o ......: Este Script testa a inclus�o e grava��o de DAV no Space Guardian
	Data Inicio ....: 18/05/2015
	Data Termino ...: 18/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcBotoesTelaDAV.au3"

;			 -----------  FIM INCLUDES  ----------

;************************* VARIAVEIS ***************************

;***************************************************************

MsgBox(0, "Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
		"Inclus�o e Grava��o de DAV" & @CR & @CR & "OBS.: O Space Guardian precisa est� aberto!")

f_abrirTelaInclusaoDAV()

MouseClick("left", 391, 135, 2)
Sleep(1000)

;$v_codigoNaturezaOperacao = InputBox("Natureza de Opera��o", "Informe o c�digo da natureza de opera��o!")
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
WinWaitActive("Aten��o", "")
Send("{ENTER}")
WinWaitActive("Space Guardian - Vers�o", "")
Send("{ESC}")
WinWaitActive("Confirma��o", "")
Send("{LEFT}{ENTER}")
;Sleep(3000)
;Send("{ESC}{TAB}{ENTER}")


;************************* FUN��ES *****************************

Func f_informarNaturezaOperacao()

  Local $v_codigoNaturezaOperacao = InputBox("Natureza de Opera��o", "Informe o c�digo da natureza de opera��o!")

EndFunc

;***************************************************************
