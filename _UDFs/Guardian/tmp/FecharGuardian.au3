; ===============================================================================================================================
; T�po de Script .: Script de Fun��o
; Descri��o ......:
; Data Inicio ....: 15/05/2015
; Data Termino ...: 15/05/2015
; Autor(s) .......: Ronildo
; ===============================================================================================================================

Func FecharGuardian()

   Sleep(1000)
   MsgBox(48, "Fechar Guardian", "Sistema Space Guardian ser� finalizado!")
   WinActivate("Space Guardian - Vers�o")
   Send("{ESC}{TAB}{ENTER}")

EndFunc   ;==>FecharGuardian