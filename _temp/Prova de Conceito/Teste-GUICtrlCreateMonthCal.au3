#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\funcGeraCPF_CNPJ.au3"
#include <GUIConstantsEx.au3>

Opt('MustDeclareVars', 1)

Example()

Func Example()
    Local $Date, $msg
    GUICreate("Get date", 210, 190)

    $Date = GUICtrlCreateMonthCal("1953/03/25", 10, 10)
    GUISetState()

    ; Executar a GUI, até que o diálogo seja fechado ou timeout

    Do
        $msg = GUIGetMsg()
        If $msg = $Date Then MsgBox(0, "debug", "calendário clicado - " & @MDAY)
    Until $msg = $GUI_EVENT_CLOSE

    MsgBox(0, $msg, GUICtrlRead($Date), 2)
EndFunc   ;==> Exemplo




;$cpf = f_geraCPF()
;$cnpj = f_geraCNPJ()

;MsgBox(0,"","" & f_geraCPF())

;run("notepad")
;WinWaitActive("Sem título - Bloco de notas")

;Send(""& f_geraCPF())
;Sleep(500)
;Send("{ENTER}enter{ENTER}")
;Sleep(500)
;Send(""& f_geraCNPJ())

;ToolTip("Teste TOOLTIP", 500, 200, "ToOlTiP", 2, 4)
;Sleep(2000)

;#Region --- CodeWizard generated code Start ---
;MsgBox features: Title=Yes, Text=Yes, Buttons=OK, Icon=Warning
;MsgBox(48,"TESTE","123   " & Random(0,9,1))
;#EndRegion --- CodeWizard generated code End ---
;#Region --- CodeWizard generated code Start ---
;SpashImage features: Title=Yes
;SplashImageOn("teste","D:\INST_PRG\Papeldeparede\bandeira_do_brasil.jpg","-1","-1","-1","-1",2)
;Sleep(500)
;#EndRegion --- CodeWizard generated code End ---





