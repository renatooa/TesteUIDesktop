#include "WinAPI.au3"

_WinAPI_Beep(500, 1000)

$botao = ""
$msg = MsgBox(1,"Teste", "Armazena retorno na Variavel $msg")


Switch $msg

   case 1
   $botao = "Valor de Retono do Bot�o OK � "
   MsgBox(0,"Retorno", "" & $botao & "* " & $msg & " *")

   case 2
   $botao = "Valor de Retono do Bot�o CANCELAR � "
   MsgBox(0,"Retorno", "" & $botao & "* "& $msg &"  *")

   $tst = WinActivate("Space Guardian - Vers�o")

  if $tst <> WinGetHandle("Space Guardian - Vers�o") Then

   MsgBox(0,"","" & $tst)

EndIf

EndSwitch



