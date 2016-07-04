#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Executa o Login, Inclusão e Gravação do cadastro de feriado no Space Guardian
	Data Inicio ....: 13/05/2015
	Data Termino ...: 15/05/2015
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

;************************* VARIAVEIS ***************************
Opt("TrayIconDebug", 1)

Local Const $v_CCSlarguraTela = 1366
Local Const $v_CCSalturaTela = 768

$v_larguraTela = @DesktopWidth
$v_alturaTela = @DesktopHeight

;***************************************************************

;				-----------	INCLUDES ----------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcLoginSpaceGuardian.au3"
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcCadastrarFeriado.au3"
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcFecharGuardian.au3"
#include "D:\Arquivo de Teste\Testes Automatizados\_temp\func\funcMudarResolucao.au3"

;			 -----------  FIM INCLUDES  ----------

If $v_larguraTela <> $v_CCSlarguraTela Or $v_alturaTela <> $v_alturaTela Then

	MsgBox(48, "ERRO", "RESOLUÇÃO NÃO SUPORTADA PARA A ROTINA AUTOMATIZADA! " & @CR & @CR & _
			"Resolução necessário para efetuar os teste: 1366 x 768" & @CR & @CR & _
			"Resolução será alterada")

	_ChangeEscreenRes($v_CCSlarguraTela, $v_CCSalturaTela)

EndIf

f_loginSpaceGuardian()


#Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Teste Automatizado\Guardian\Teste\form\frmPergunta.kxf
$frmPergunta = GUICreate("Dados Para Cadastro", 374, 303, -1, -1, -1, BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
GUISetIcon("D:\Arquivo de Teste\FERRAMENTAS\Imagens\icone_space.ico", -1)
$btnOk = GUICtrlCreateButton("OK", 137, 243, 91, 33)
$lblDia = GUICtrlCreateLabel("Dia do Feriado..:", 58, 78, 120, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$lblNome = GUICtrlCreateLabel("Nome do Feriado..:", 54, 134, 137, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$lblAno = GUICtrlCreateLabel("Ano do Feriado..:", 57, 191, 123, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$inpDia = GUICtrlCreateInput("", 193, 76, 41, 24, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
GUICtrlSetLimit(-1, 2)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$inpNome = GUICtrlCreateInput("", 194, 133, 137, 24)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$inpAno = GUICtrlCreateInput("", 192, 192, 65, 24, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlCreateGroup("", 8, 8, 361, 49)
$lblTexto = GUICtrlCreateLabel("Informe os Dados para Execução do Teste", 16, 24, 346, 24)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg

		Case $btnOk

			f_acaoBotaoOk()

		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


;************************* FUNÇÕES *****************************

Func f_acaoBotaoOk()

	$inpDia = GUICtrlRead($inpDia)
	$inpNome = GUICtrlRead($inpNome)
	$inpAno = GUICtrlRead($inpAno)

	GUISetState(@SW_HIDE)

	WinActivate("Space Guardian - Versão", "")
	;Sleep(1000)
	f_cadastrarFeriado($inpDia, $inpAno, $inpNome)

	;f_fecharGuardian()

	MsgBox(0, "", "Fim Execução!")

	_ChangeEscreenRes($v_larguraTela, $v_alturaTela)

	Exit

EndFunc   ;==>f_acaoBotaoOk

;***************************************************************
