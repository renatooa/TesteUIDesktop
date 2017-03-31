#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......:
	Data Inicio ....: 09/02/2017
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1)             ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 300)           ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDelay", 1000) ;SLEEP PARA PC LENTO
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script deve ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

;#include-once
#include <Debug.au3>
#include <Date.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <Array.au3>

#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#cs ===============================================================================================================================
	$sTituloDaTelaPrincipalDoSistema -> Informar o valor obtido pelo Autoit Window Info do campo 'title'.
	$sNomeDoSistema -> Nome do sistema a ser testado pelo script.
#ce ===============================================================================================================================
Local Const $sTituloDaTelaPrincipalDoSistema = $TITULO_TELA_PRINCIPAL_GUARDIAN
Local Const $sNomeDoSistema = $NOME_SPACE_GUARDIAN

Local $sUsername = ""
Local $sPassword = ""
Local $sDatabase = ""
Local $sHost = ""
Local $sTabela = "natoper"
Local $aCodigoLayouts
Local Const $iQtdeDeProdutos = 1
Local Const $iCodigoProduto = 2
Local Const $sNatOper = "VEN"
Local Const $iCodigoCliente = 140
Local Const $iCodigoVendedor = 1
Local Const $sCTRL_A = "^a"
Local Const $sCTRL_T = "^t"

Local Const $iCampoNatOperEixoX = 387
Local Const $iCampoNatOperEixoY = 134
Local Const $iBotaoGravarEixoX = 903
Local Const $iBotaoGravarEixoY = 659

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ;;; Função da UDF Validacoes.au3

VerificaAlteraResolucao() ;;; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Inclusão de DAV é alteração do layout da Natureza de Operação," _
	& "Para validar PDF gerado para envio de Email.", _
	@CRLF & "OBS.: COMANDO QUE DELETA O PDF DEVE SER COMENTADO NO CÓDIGO FONTE!") ;;; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

$sConfigBD = InputBox("Configuração Conexão Banco de Dados", _
		"Informe o USER, PASSWORD, DB_NAME e HOST separados por pipe (|).", _
		"root | @senharootmysql123 | syson | 192.168.0.6", "", 300, 150)

$aDadosConexaoBD = StringSplit(StringStripWS($sConfigBD, $STR_STRIPALL), "|", $STR_NOCOUNT)

If (Not @error And UBound($aDadosConexaoBD) == 4) Then

	$sUsername = $aDadosConexaoBD[0]
	$sPassword = $aDadosConexaoBD[1]
	$sDatabase = $aDadosConexaoBD[2]
	$sHost = $aDadosConexaoBD[3]

	$aCodigoLayouts = GetArrayCodigoLayouts($sUsername, $sPassword, $sDatabase, $sHost)
	$iTotalDeLayouts = (UBound($aCodigoLayouts) - 1)

	If ($iTotalDeLayouts > 0) Then

		$sWhereArgs = "nat_codigo = '" & $sNatOper & "'"
		AbreVendasDAV()

		; Loop para update do código do layout na 
		; natureza de operação e inclusão do DAV
		For $i = 0 To $iTotalDeLayouts Step +1

			Local $aCamposValores[] = ["nat_laycodigos|" & $aCodigoLayouts[$i], _
									   "nat_layprevenda|" & $aCodigoLayouts[$i], _
									   "nat_layorcam|" & $aCodigoLayouts[$i], _
									   "nat_laypedpar|" & $aCodigoLayouts[$i]]
			
			; Executa o Update
			$oMySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)
			_MySQLUpdate($oMySqlConn, $sTabela, $aCamposValores, $sWhereArgs)
			_MySQLEnd($oMySqlConn)

			MsgBox($MB_OK + $MB_ICONINFORMATION, _
				"Total de layouts: " & ($i + 1) & "/" & ($iTotalDeLayouts + 1), _
				"Update no Layout da Nat.Oper. [" & $sNatOper & "] para o código [" & $aCodigoLayouts[$i] & "] ", 2)

			WinActivate("", $TEXTO_CONSULTA_DAV)

			Send($BTN_INCLUIR)

			TelaRegistroSendoUsadoExiste()

			WinWaitActive("", $TEXTO_DAV)

			MouseClick("LEFT", $iCampoNatOperEixoX, $iCampoNatOperEixoY, 3)
			Send($sNatOper)
			Send("{ENTER 3}" & $iCodigoCliente)
			Send("{ENTER}" & $iCodigoVendedor & "{TAB 2}")

			Send($sCTRL_T)

			Sleep(1000)
			;Sleep(4000) ;SLEEP PARA PC LENTO

			; Inclui produto fixo.
			IncluirProdutosDAV($iQtdeDeProdutos, null, null, null, null, $iCodigoProduto)

			If ( @error ) Then
				ExitLoop		
			EndIf

			Sleep(500)
			;Sleep(2000) ;SLEEP PARA PC LENTO
			MouseClick("LEFT", $iBotaoGravarEixoX, $iBotaoGravarEixoY)

			TelaGravacaoConcluidaExiste(1000)

			TelaAcaoAposGravarDAVExiste()

			TelaIDispatchExceptionExiste()

    		TelaExcecaoExiste()

			;Sleep(5000)
			;Send("{ESC}")

			TelaDesejaFecharSessaoExiste("S")

			WinWaitNotActive("", $TEXTO_DAV)
		
		Next

	EndIf

EndIf

; [TEST]
_Assert(True, false)

VoltaResolucaoAnterior() ;;; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)
Exit

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES