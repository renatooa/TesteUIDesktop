; ===============================================================================================================================
; Típo de Script .: Script de Função
; Descrição ......:
; Data Inicio ....: 15/05/2015
; Data Termino ...: 15/05/2015
; Autor(s) .......: Ronildo
; ===============================================================================================================================

Func FecharGuardian()

   Sleep(1000)
   MsgBox(48, "Fechar Guardian", "Sistema Space Guardian será finalizado!")
   WinActivate("Space Guardian - Versão")
   Send("{ESC}{TAB}{ENTER}")

EndFunc   ;==>FecharGuardian