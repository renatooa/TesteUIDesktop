#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
	Descrição ......: Efetuar a abertura de cupom fiscal no Polaris com a quantidade de produtos informada
					  no InputBox apresentado no inicio da execução do script.
	Data Inicio ....: 12/01/2017
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1)             ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100)            ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
;Opt("WinWaitDelay", 200)           ; Altera quanto tempo um script DEVE ser pausado brevemente após uma operação bem-sucedida com janela.
;Opt("MouseClickDelay", 10)         ; Altera o tempo entre os cliques do mouse.
;Opt("MouseClickDownDelay", 10)     ; Altera o tempo que o botão é mantido pressionado antes da liberação.
;Opt("MouseClickDragDelay", 250)    ; Altera o tamanho da pausa breve no início e no final de uma operação arrastar do mouse.

;#include-once
#include <Debug.au3>
#include <Date.au3>
#include <MsgBoxConstants.au3>

#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesAuxiliares.au3"
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#cs ===============================================================================================================================
	$sTituloDaTelaPrincipalDoSistema -> Informar o valor obtido pelo Autoit Window Info do campo 'title'.
	$sNomeDoSistema -> Nome do sistema a ser testado pelo script.
#ce ===============================================================================================================================
Local Const $sTituloDaTelaPrincipalDoSistema = "Space Polaris"
Local Const $sNomeDoSistema = $sTituloDaTelaPrincipalDoSistema
Local $sUsername = "root"
Local $sPassword = "@kalunga123"
Local $sDatabase = "super100"
Local $sHost = "192.168.0.14"

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF SistemaExiste.au3

VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Inclusão de Produtos no Cupom Fiscal.") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________
	
$aCodigoProdutos = GetArrayCodigoProdutosParaVenda($sUsername, $sPassword, $sDatabase, $sHost)
$iTotalDeProdutos = UBound($aCodigoProdutos) - 1

If ( $iTotalDeProdutos > 0 ) Then

	Send("#{UP}") ; Win + Up
	
	$iQuantidadeProdutosParaIncluir = _
		InputBox("Quantidade de Produtos para Inclusão", _
			"Informe um número entre [1 e " & $iTotalDeProdutos & "].", _
			"", "", 260, 150)

	If ( Not @error Or Not $iQuantidadeProdutosParaIncluir == "0" Or StringIsInt($iQuantidadeProdutosParaIncluir)) Then	
	
		For $iIndice = 0 To $iQuantidadeProdutosParaIncluir - 1 Step +1

			Send($aCodigoProdutos[$iIndice] & "{ENTER}")

			Sleep(500)

			If ( WinExists("Pesquisa de Produto") ) Then
			
				Send("{ENTER}")
				Sleep(500)
			
			EndIf

			If ( WinExists("Confirmação") ) Then
			
				Send("{ENTER}")
			
			EndIf

		Next

	EndIf

	Send("#{DOWN}") ; Win + Down

Else

	MsgBox($MB_ICONWARNING + $MB_OK, "", "Nenhum item encontrado para inclusão!")

EndIf

VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)
Exit

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES