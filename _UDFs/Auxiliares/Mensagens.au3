#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF para conter mensagens genericas
	Data Inicio ....: 07/04/2016
	Data Termino ...: 07/04/2016
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once

#include <MsgBoxConstants.au3>

#EndRegion ### INCLUDES / OPS

#cs FUNÇÕES DA UDF ================================================================================================================
=
=	ExibeMensagemPadrao($sTestesExecutados, $sInformacoesAdicionais = "")
=
#ce ===============================================================================================================================

#Region ### VARIAVEIS

#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES

Func ExibeMensagemPadrao($sTestesExecutados, $sInformacoesAdicionais = "")

	Local Const $sMensagemExibida = "ESTÁ ROTINA IRÁ EXECUTAR O SEGUINTE TESTE " & @CR & @CR & _
			$sTestesExecutados & @CR & _
			$sInformacoesAdicionais & @CR & @CR & _
			"---------------------------------------------------------------------------" & @CR & _
			"Pressione CTRL+SHIFT+Q para finalizar o teste a qualquer momento." & @CR & _
			"---------------------------------------------------------------------------"

	; Exibe MsgBox
	$iBotaoClicado = MsgBox($MB_ICONINFORMATION + $MB_OKCANCEL, "Rotina de Teste Automatizado", $sMensagemExibida)

	If $iBotaoClicado == $IDCANCEL Then

		VoltaResolucaoAnterior()
		Exit

	EndIf

EndFunc   ;==>ExibeMensagemPadrao

#EndRegion ### FUNÇÕES
