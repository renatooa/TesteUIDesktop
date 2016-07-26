#cs ===============================================================================================================================
	T�po de Script .: Script de Fun��o - UDF
	Descri��o ......: UDF para conter mensagens genericas
	Data Inicio ....: 07/04/2016
	Data Termino ...: 07/04/2016
	Vers�o .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once

#include <MsgBoxConstants.au3>

#EndRegion ### INCLUDES / OPS

#cs FUN��ES DA UDF ================================================================================================================
=
=	ExibeMensagemPadrao($sTestesExecutados, $sInformacoesAdicionais = "")
=
#ce ===============================================================================================================================

#Region ### VARIAVEIS

#EndRegion ### VARIAVEIS

#Region ### FUN��ES

Func ExibeMensagemPadrao($sTestesExecutados, $sInformacoesAdicionais = "")

	Local Const $sMensagemExibida = "EST� ROTINA IR� EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			$sTestesExecutados & @CR & _
			$sInformacoesAdicionais & @CR & _
			"---------------------------------------" & @CR & _
			"Pressione CTRL+SHIFT+Q para " & @CR & _
			"finalizar o teste a qualquer momento"

	; Exibe MsgBox
	$iBotaoClicado = MsgBox($MB_ICONINFORMATION + $MB_OKCANCEL, "Rotina de Teste Automatizado", $sMensagemExibida)

	If $iBotaoClicado == $IDCANCEL Then

		VoltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>ExibeMensagemPadrao

#EndRegion ### FUN��ES
