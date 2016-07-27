#cs ===============================================================================================================================
    Típo de Script .: Script de View - Formulário KodaForm
    Descrição ......: Formulário de Solicitação de Código
    Data Inicio ....: 26/07/2016
    Data Termino ...: 26/07/2016
    Versão .........: 001
    Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS

;Global $lblTexto = ""
Global $txtCodigo = ""
Global $btnOK = ""
Global $btnCancelar = ""

#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func FrmSolicitaCodigo($sTextoMensagem)

    #Region ### START Koda GUI section ### Form=D:\Arquivo de Teste\Testes-Automatizados\_temp\form\frmSolicitaCodigo.kxf
    $frmSolicitaCodigo = GUICreate("Solicita Natureza de Operação", 330, 134, -1, -1, BitOR($WS_SYSMENU, $WS_POPUP, $DS_MODALFRAME), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
    GUISetBkColor(0xC0DCC0)
    $GroupBox1 = GUICtrlCreateGroup("", 8, 1, 312, 89)
    $lblTexto = GUICtrlCreateLabel(StringUpper($sTextoMensagem), 24, 24, 280, 17)
    GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
    $txtCodigo = GUICtrlCreateInput("", 24, 48, 65, 21)
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    $btnOK = GUICtrlCreateButton("&OK", 150, 99, 75, 25)
    $btnCancelar = GUICtrlCreateButton("&Cancelar", 229, 100, 75, 25)
    GUISetState(@SW_SHOW)
    #EndRegion ### END Koda GUI section ###

EndFunc

#EndRegion ### FUNÇÕES