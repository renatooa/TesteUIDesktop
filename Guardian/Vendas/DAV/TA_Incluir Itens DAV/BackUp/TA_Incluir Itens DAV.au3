#cs ===============================================================================================================================
	Típo de Script .: (Script de Função - UDF, Script Execução de Teste, Script de Constantes, Script de Includes)
	Descrição ......:
	Data Inicio ....:
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
Local Const $sTituloDaTelaPrincipalDoSistema = $TITULO_TELA_PRINCIPAL_GUARDIAN
Local Const $sNomeDoSistema = $NOME_SPACE_GUARDIAN

$iQtdeDeProdutos = 50
$sUsername = "root"
$sPassword = "@kalunga123"
$sDatabase = "dental"
$sHost = "localhost"

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT

VerificaSistemaEstaAberto($sNomeDoSistema, $sTituloDaTelaPrincipalDoSistema) ; Função da UDF SistemaExiste.au3

VerificaAlteraResolucao() ; Verifica a resolução atual da tela -> (função da UDF MudarResolucao.au3)

ExibeMensagemPadrao("Inclusão de Itens no DAV", "OBS.: A rotina efetua apenas a inclusão dos itens!") ; Exibe mensagem informativa -> (função na UDF Mensagens.au3)

WinActivate($sTituloDaTelaPrincipalDoSistema)

;________________________________________________________________________________________________________________

If ( WinExists("", $TEXTO_DAV) ) Then
	IncluirProdutosDAV($iQtdeDeProdutos, $sUsername, $sPassword, $sDatabase, $sHost)
Else
	MsgBox($MB_ICONWARNING, "Atenção", "Tela de Inclusão não localizada" & @CR & @CR & _
	"O script de teste será finalizada")
	Exit
EndIf


VoltaResolucaoAnterior() ; Altera a resolução do monitor caso a mesma tenha sido modificada no inicio do script -> (função da UDF MudarResolucao.au3)

#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES