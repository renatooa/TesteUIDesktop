#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......:
	Data Inicio ....: 25/07/2016
	Data Termino ...: 27/07/2016
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script deve ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

;#include-once
#include <Debug.au3>
#include <Date.au3>
#include <MsgBoxConstants.au3>
#include <GuiComboBox.au3>

#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesGuardian.au3"
#include "frmSolicitaDadosInclusaoDeItensDAV.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#cs ===============================================================================================================================
	$sTituloDaTelaPrincipalDoSistema -> Informar o valor obtido pelo Autoit Window Info do campo 'title'.
	$sNomeDoSistema -> Nome do sistema a ser testado pelo script.
#ce ===============================================================================================================================
Local Const $sTituloDaTelaPrincipalDoSistema = $TITULO_TELA_PRINCIPAL_GUARDIAN
Local Const $sNomeDoSistema = $NOME_SPACE_GUARDIAN

$iQtdeDeProdutos = 1
$sUsername = ""
$sPassword = ""
$sDatabase = ""
$sHost = ""

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF SistemaExiste.au3

VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Inclusão de Itens no DAV", "OBS.: A rotina efetua apenas a inclusão dos itens!") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

; Mostra Formulário
FrmSolicitaDadosInclusaoDeItensDAV()

; While para capturar ação no fomulário
While True
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $btnCancelar
			ExitLoop

		Case $cbxHostDB
			GUICtrlSetState($cbxHostDB, $GUI_DISABLE)

		Case $cbxSenhaDB
			$sUsername = GUICtrlRead($txtUserDB)

			$iIndexResult = _GUICtrlComboBox_GetCurSel($cbxSenhaDB)
			$sPasswordText = _GUICtrlComboBox_GetEditText($cbxSenhaDB)			
			If ($iIndexResult == 0) Then				
				$sPassword = StringReplace($sPasswordText, "*********", "alunga")
			Else
				$sPassword = StringReplace($sPasswordText, "****************", "enharootmysql")
			EndIf

			$sHost = _GUICtrlComboBox_GetEditText($cbxHostDB)

			$sString = GetDataBasesInString($sUsername, $sPassword, $sHost) ; Função da UDF ManipulaDadosBD.au3

			GUICtrlSetData($cbxDataBase, $sString)
			GUICtrlSetState($cbxSenhaDB, $GUI_DISABLE)
			GUICtrlSetState($cbxDataBase, $GUI_ENABLE)

		Case $btnOK
			$iQtdeDeProdutos = GUICtrlRead($txtUpDownQtdeProdutos)
			$sDatabase = _GUICtrlComboBox_GetEditText($cbxDataBase)
			GUISetState(@SW_HIDE)

			If (WinExists("", $TEXTO_DAV) And $sDatabase <> "") Then
				$iHoraEmSegundosInicio = GetHorasAtualEmSegundos() ; Função da UDF GetHoras.au3
				
				IncluirProdutosDAV($iQtdeDeProdutos, $sUsername, $sPassword, $sDatabase, $sHost) ; Função da UDF IncluirProdutos.au3
				
				If ( Not @error ) Then
					$iHoraEmSegundosFim = GetHorasAtualEmSegundos()
					MsgBox($MB_ICONINFORMATION, "Fim Execução Script", "TEMPO GASTO.: " _ 
					    & $iHoraEmSegundosFim - $iHoraEmSegundosInicio & " seg.", 10)
				EndIf

				ExitLoop
			Else
				MsgBox($MB_ICONWARNING, "Atenção", "Tela de Inclusão não localizada e/ou database não selecionado" & @CR & @CR & _
						"O script de teste será finalizado")
				ExitLoop
			EndIf
	EndSwitch
WEnd

VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)
Exit

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES