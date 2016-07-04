#cs ===============================================================================================================================
	Típo de Script .: Script Execução de Teste
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

#include <Debug.au3>
#include <MsgBoxConstants.au3>

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS

Local Const $sClasseTelaLogin = "GlassWndClass-GlassWindowClass-2"
Local Const $sUsuarioLogin = "manutmac"
Local Const $sSenhaLogin = "teste"
Local Const $iCodigoProduto = 10
Local Const $dValorPagamento = 500

; EIXOS X, Y CLIQUE DO MOUSE
Local Const $iCampoUsuarioLoginEixoX = 753
Local Const $iCampoUsuarioLoginEixoY = 249

#EndRegion ### VARIAVEIS

#Region ### EXECUÇÃO DO SCRIPT


WinActivate("[CLASS:" & $sClasseTelaLogin & "]")

; FAZ LOGIN NO SISTEMA
MouseClick("LEFT", $iCampoUsuarioLoginEixoX, $iCampoUsuarioLoginEixoY, 3)

Send($sUsuarioLogin & "{TAB}")

Send("!{END}" & $sSenhaLogin & "{TAB}{ENTER}")

; ABRE CUPOM
$iQtdeInclusoesDoProduto = InputBox("Quantidade de Itens", "Informe a quantidade de itens para o cupom")

For $i = 1 To $iQtdeInclusoesDoProduto Step +1

	Send($iCodigoProduto & "{ENTER}")
	Sleep(500)

Next

; FECHA CUPOM
WinWaitActive("[CLASS: ]")

Send("{F4}{TAB 2}")

Sleep(2000)

Send("{ENTER}{DOWN 3}{ENTER}") ;~> SELECIONA FORMA E CONDIÇÃO DE PAGAMENTO

Send($dValorPagamento & "{ENTER}")

; PROCEDIMENTOS TELAS SITEF
WinWaitActive("title", "[text]")



#EndRegion ### EXECUÇÃO DO SCRIPT

#Region ### FUNÇÕES
#EndRegion ### FUNÇÕES