#include "WinAPI.au3"

_WinAPI_Beep(500, 1000)

$botao = ""
$msg = MsgBox(1,"Teste", "Armazena retorno na Variavel $msg")


Switch $msg

   case 1
   $botao = "Valor de Retono do Botão OK é "
   MsgBox(0,"Retorno", "" & $botao & "* " & $msg & " *")

   case 2
   $botao = "Valor de Retono do Botão CANCELAR é "
   MsgBox(0,"Retorno", "" & $botao & "* "& $msg &"  *")

   $tst = WinActivate("Space Guardian - Versão")

  if $tst <> WinGetHandle("Space Guardian - Versão") Then

   MsgBox(0,"","" & $tst)

EndIf

EndSwitch



