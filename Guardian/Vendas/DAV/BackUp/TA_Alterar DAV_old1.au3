#cs ===============================================================================================================================
 Típo de Script .: (Script de Função, Script Execução de Teste)
 Descrição ......:
 Data Inicio ....: 18/05/2015
 Data Termino ...:
 Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;				-----------	INCLUDES ----------

#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcBotoesTelaDAV.au3"

;			 -----------  FIM INCLUDES  ----------

;************************* VARIAVEIS ***************************



;***************************************************************

MsgBox(0,"Rotina de Teste Automatizado", "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR& @CR& _
"Alteração e Gravação de DAV" & @CR& @CR& "OBS.: O Space Guardian precisa está aberto!")

f_abrirTelaAlteracaoComItemDAV()

MouseClick("left", 314, 354, 2)
MouseClick("left", 1007, 417, 1)
Send ("8{ENTER 3}")
WinWaitActive("Confirmação")
Send ("{ENTER}")
MouseClick("left", 899, 618, 1)










;************************* FUNÇÕES *****************************



;***************************************************************