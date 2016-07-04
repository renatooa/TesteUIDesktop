#cs ===============================================================================================================================
	Típo de Script .: Script de HotKeys
	Descrição ......: Script com mapeamento de atalhos.
	Data Inicio ....: 13/05/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once
#include <MsgBoxConstants.au3>

#EndRegion ### INCLUDES / OPS

#Region ### HOTKEYS

HotKeySet("^+q", "FinalizarScript") ; CTRL + SHIFT + Q

#EndRegion ### HOTKEYS

#Region ### FUNÇÕES

Func FinalizarScript()
	MsgBox($MB_TOPMOST + $MB_ICONINFORMATION, "HotKeys", "Script Finalizado pelo atalho CTRL+SHIFT+Q", 5)
	Exit
EndFunc

#EndRegion ### FUNÇÕES