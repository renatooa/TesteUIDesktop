#cs ===============================================================================================================================
	Típo de Script .: | Script de Função - UDF | 
	Descrição ......: 
	Data Inicio ....: 27/09/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1)             ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100)            ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
;Opt("SendKeyDownDelay",1)          ; Altera o tempo que uma tecla é mantida pressionada antes de ser liberada durante um pressionamento de tecla.
#include-once
#include "D:\Testes-Automatizados\TesteUIDesktop\_UDFs\IncludesGuardian.au3"

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS
#EndRegion ### VARIAVEIS

#cs FUNÇÕES DA UDF ================================================================================================================
    =
    =   ClickBotaoIncluir()
	=	ClickBotaoAlterar()
	=	ClickBotaoCancelar()
	=	ClickBotaoImprimir()
	=	ClickBotaoVisualizar()
	=	ClickBotaoLiberar()
	=	ClickBotaoReprovar()
	=	ClickBotaoSeparar()
	=	ClickBotaoAnularSeparacao()
	=	ClickBotaoStatusDAV()
	=	ClickBotaoExportaCupom()
	=	ClickBotaoNotas()
	=	ClickBotaoFinanceiro()
	=	ClickBotaoDocRec()
	=	ClickBotaoDadosEntrega()
	=
#ce ===============================================================================================================================    

#Region ### FUNÇÕES

Func ClickBotaoIncluir()
	Send($BTN_INCLUIR)
EndFunc

Func ClickBotaoAlterar()
	Send($BTN_ALTERAR)
EndFunc

Func ClickBotaoCancelar()
	Send($BTN_CANCELAR)
EndFunc

Func ClickBotaoImprimir()
	Send($BTN_IMPRIMIR)
EndFunc

Func ClickBotaoVisualizar()
	Send($BTN_VISUALIZAR)
EndFunc

Func ClickBotaoLiberar()
	Send($BTN_CP_LIBERAR)
EndFunc

Func ClickBotaoReprovar()
	Send($BTN_CP_REPROVAR)
EndFunc

Func ClickBotaoSeparar()
	Send($BTN_VD_SEPARAR)
EndFunc

Func ClickBotaoAnularSeparacao()
	Send($BTN_VD_ANULAR_SEPARACAO)
EndFunc

Func ClickBotaoStatusDAV()
	Send($BTN_VD_STATUS)
EndFunc

Func ClickBotaoExportaCupom()
	Send($BTN_VD_EXP_CUPOM)
EndFunc

Func ClickBotaoNotas()
	Send($BTN_VD_NOTAS)
EndFunc

Func ClickBotaoFinanceiro()
	Send($BTN_VD_FINANCEIRO)
EndFunc

Func ClickBotaoDocRec()
	Send($BTN_VD_DOC_REC)
EndFunc

Func ClickBotaoDadosEntrega()
	Send($BTN_VD_DADOS_ENTREGA)
EndFunc

#EndRegion ### FUNÇÕES