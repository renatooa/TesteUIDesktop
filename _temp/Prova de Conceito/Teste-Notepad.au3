$V_larguraTela = @DesktopWidth
$V_alturaTela = @DesktopHeight

run("notepad")

WinWaitActive("Sem t�tulo - Bloco de notas")
Send("Teste digita��o")

IF $V_larguraTela == 1366 And $V_alturaTela == 768 Then

	MouseClick("left", 132, 45)
	MouseClick("left", 132, 95)

Else

	MsgBox(0,"","Sua resolu��o de tela �.: " & $V_larguraTela & " x " & $V_alturaTela)

	MouseClick("left", 132, 45)
	MouseClick("left", 132, 95)

EndIf

Exit
