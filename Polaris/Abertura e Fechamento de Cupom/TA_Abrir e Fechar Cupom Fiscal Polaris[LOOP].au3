#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Efetuar a abertura e fechamento de cupons fiscais no Polaris em LOOP.
	Data Inicio ....: 23/01/2017
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 300) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
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
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesPolaris.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#cs ===============================================================================================================================
	$sTituloDaTelaPrincipalDoSistema -> Informar o valor obtido pelo Autoit Window Info do campo 'title'.
	$sNomeDoSistema -> Nome do sistema a ser testado pelo script.
#ce ===============================================================================================================================
Local Const $sTituloDaTelaPrincipalDoSistema = $TITULO_TELA_PRINCIPAL_POLARIS
Local Const $sNomeDoSistema = $NOME_SPACE_POLARIS
Local Const $iQuantidadeProdutosParaIncluir = 10
Local Const $iIntervaloDoLoop = 60000
Local $dValorPago
Local $sUsername
Local $sPassword
Local $sDatabase
Local $sHost

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF SistemaExiste.au3

;VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Abrir e Fechar Cupons Fiscais com " & $iQuantidadeProdutosParaIncluir & " itens." & _
		@CRLF & "[EXECUÇÃO EM LOOP COM INTERVALO DE " & ($iIntervaloDoLoop / 1000) & " SEGUNDOS]") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________


$sConfigBD = InputBox("Configuração Conexão Banco de Dados", _
		"Informe o USER, PASSWORD, DB_NAME e HOST separados por pipe (|).", _
		"rooteste | @teste123 | super100 | 192.168.0.14", "", 300, 150)

$aDadosConexaoBD = StringSplit(StringStripWS($sConfigBD, $STR_STRIPALL), "|", $STR_NOCOUNT)

If (Not @error And UBound($aDadosConexaoBD) == 4) Then

	$sUsername = $aDadosConexaoBD[0]
	$sPassword = $aDadosConexaoBD[1]
	$sDatabase = $aDadosConexaoBD[2]
	$sHost = $aDadosConexaoBD[3]

	$aCodigoPrecoProdutos = GetArrayCodigoEPrecoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost)
	$iTotalDeProdutos = UBound($aCodigoPrecoProdutos)

	If ($iTotalDeProdutos > 0) Then

		Send("#{UP}") ; Win + Up
		
		While (True)

			;; Continua o loop apenas se a tela do sistema estiver ativa.
			WinWaitActive($sTituloDaTelaPrincipalDoSistema)

			$dValorPago = 500
			
			For $iIndice = 0 To $iQuantidadeProdutosParaIncluir - 1 Step +1

				$aDicionario = StringSplit($aCodigoPrecoProdutos[$iIndice], ";", $STR_NOCOUNT)

				$iCodigoProduto = $aDicionario[0]
				$dPrecoProduto = $aDicionario[1]

				Send($iCodigoProduto & "{ENTER}")

				Sleep(1000)
				TelaErroExiste()

				If (WinExists("Pesquisa de Produto") Or WinExists("Confirmação")) Then
					
					Send("{ENTER}")
					Sleep(1000)
					TelaErroExiste()
					
				EndIf

				$dValorPago += $dPrecoProduto

			Next

			; Chama a tela de fechamento.
			Send("{F4}")

			; Aguarda a tela de fechamento.
			Sleep(2000)
			
			; Realiza o fechamento da venda
			Send("{ENTER 2}" & $dValorPago & "{ENTER 2}")
			
			_ArrayShuffle($aCodigoPrecoProdutos) ; Embaralha itens do array
			Sleep($iIntervaloDoLoop) ; Aguarda para abrir outro cupom
			
		WEnd

	Else

		MsgBox($MB_ICONWARNING + $MB_OK, "", "Nenhum produto encontrado para abrir o cupom!")

	EndIf

EndIf

;VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)
Exit

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES
