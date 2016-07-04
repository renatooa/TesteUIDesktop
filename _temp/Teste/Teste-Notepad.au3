$V_larguraTela = @DesktopWidth
$V_alturaTela = @DesktopHeight

run("notepad")

WinWaitActive("Sem título - Bloco de notas")
Send("Teste digitação")

IF $V_larguraTela == 1366 And $V_alturaTela == 768 Then

	MouseClick("left", 132, 45)
	MouseClick("left", 132, 95)

Else

	MsgBox(0,"","Sua resolução de tela é.: " & $V_larguraTela & " x " & $V_alturaTela)

	MouseClick("left", 132, 45)
	MouseClick("left", 132, 95)

EndIf

Exit
