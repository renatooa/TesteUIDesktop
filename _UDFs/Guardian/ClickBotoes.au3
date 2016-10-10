#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: Funções para acionar os botões que possuem teclas de atalho.
	Data Inicio ....: 27/09/2016
	Data Termino ...: ~
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.
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
EndFunc   ;==>ClickBotaoIncluir

Func ClickBotaoAlterar()
	Send($BTN_ALTERAR)
EndFunc   ;==>ClickBotaoAlterar

Func ClickBotaoCancelar()
	Send($BTN_CANCELAR)
EndFunc   ;==>ClickBotaoCancelar

Func ClickBotaoImprimir()
	Send($BTN_IMPRIMIR)
EndFunc   ;==>ClickBotaoImprimir

Func ClickBotaoVisualizar()
	Send($BTN_VISUALIZAR)
EndFunc   ;==>ClickBotaoVisualizar

Func ClickBotaoLiberar()
	Send($BTN_CP_LIBERAR)
EndFunc   ;==>ClickBotaoLiberar

Func ClickBotaoReprovar()
	Send($BTN_CP_REPROVAR)
EndFunc   ;==>ClickBotaoReprovar

Func ClickBotaoSeparar()
	Send($BTN_VD_SEPARAR)
EndFunc   ;==>ClickBotaoSeparar

Func ClickBotaoAnularSeparacao()
	Send($BTN_VD_ANULAR_SEPARACAO)
EndFunc   ;==>ClickBotaoAnularSeparacao

Func ClickBotaoStatusDAV()
	Send($BTN_VD_STATUS)
EndFunc   ;==>ClickBotaoStatusDAV

Func ClickBotaoExportaCupom()
	Send($BTN_VD_EXP_CUPOM)
EndFunc   ;==>ClickBotaoExportaCupom

Func ClickBotaoNotas()
	Send($BTN_VD_NOTAS)
EndFunc   ;==>ClickBotaoNotas

Func ClickBotaoFinanceiro()
	Send($BTN_VD_FINANCEIRO)
EndFunc   ;==>ClickBotaoFinanceiro

Func ClickBotaoDocRec()
	Send($BTN_VD_DOC_REC)
EndFunc   ;==>ClickBotaoDocRec

Func ClickBotaoDadosEntrega()
	Send($BTN_VD_DADOS_ENTREGA)
EndFunc   ;==>ClickBotaoDadosEntrega

#EndRegion ### FUNÇÕES
