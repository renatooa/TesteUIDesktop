#cs ===============================================================================================================================
 T�po de Script .: (Script de Fun��o, Script Execu��o de Teste)
 Descri��o ......:
 Data Inicio ....: 18/05/2015
 Data Termino ...:
 Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcBotoesTelaDAV.au3"

;			 -----------  FIM INCLUDES  ----------

;************************* VARIAVEIS ***************************



;***************************************************************

MsgBox(0,"Rotina de Teste Automatizado", "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR& @CR& _
"Altera��o e Grava��o de DAV" & @CR& @CR& "OBS.: O Space Guardian precisa est� aberto!")

f_abrirTelaAlteracaoComItemDAV()

MouseClick("left", 314, 354, 2)
MouseClick("left", 1007, 417, 1)
Send ("8{ENTER 3}")
WinWaitActive("Confirma��o")
Send ("{ENTER}")
MouseClick("left", 899, 618, 1)










;************************* FUN��ES *****************************



;***************************************************************