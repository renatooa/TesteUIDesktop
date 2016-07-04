#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF para acesso as opções do Menu de Cadastros do Space Guardian
	Data Inicio ....: 07/04/2016
	Data Termino ...:
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once
#include <MsgBoxConstants.au3>

Opt("TrayIconDebug", 1) ; Debug na caixa de dica do icone da bandeja.
Opt("SendKeyDelay", 100) ; Alterna o tamanho da pausa breve entre o envio de pressionamentos de teclas.

#EndRegion ### INCLUDES / OPS

#Region ### VARIAVEIS

; O sinal de exclamação (!) equivale á tecla ALT
;
Local Const $sAtalhoExpandirMenuCadastros = "!c"
Local Const $sTextoTelaConsultaCodigoPais = "Tabela Pais"
Local Const $sTextoTelaCadastroDeCEP = "Cadastro de CEP"

#EndRegion ### VARIAVEIS

#Region ### FUNÇÕES
Func AbreCadCliente()

	Send($sAtalhoExpandirMenuCadastros)
	Send("{ENTER}")
	WinWaitActive("", "Clientes")

EndFunc   ;==>AbreCadCliente

Func AbreCadFornecedor()

	Send($sAtalhoExpandirMenuCadastros)
	Send("F{ENTER}")
	WinWaitActive("", "Fornecedores")

EndFunc   ;==>AbreCadFornecedor

Func AbreCadTransportadora()

	Send($sAtalhoExpandirMenuCadastros)
	Send("T{ENTER}")
	WinWaitActive("", "Transportadores")

EndFunc   ;==>AbreCadTransportadora

#Region ***** TABELA DE PESSOAS *****

Func AbreCadTabelasDePessoasCarteiraDeClientes()

	Send($sAtalhoExpandirMenuCadastros)
	Send("TT{ENTER}")
	WinWaitActive("", "Carteira De Clientes")

EndFunc   ;==>AbreCadTabelasDePessoasCarteiraDeClientes

Func AbreCadTabelasDePessoasGrupoDeCliente()

	Send($sAtalhoExpandirMenuCadastros)
	Send("TTG{ENTER}")
	WinWaitActive("", "Carteira De Clientes")

EndFunc   ;==>AbreCadTabelasDePessoasGrupoDeCliente

Func AbreCadTabelasDePessoasAtividade()

	Send($sAtalhoExpandirMenuCadastros)
	Send("TTA{ENTER}")
	WinWaitActive("", "Atividades")

EndFunc   ;==>AbreCadTabelasDePessoasAtividade

Func AbreCadTabelasDePessoasClassificacaoDePessoa()

	Send($sAtalhoExpandirMenuCadastros)
	Send("TTC{ENTER}")
	WinWaitActive("", "Classificação De Pessoa")

EndFunc   ;==>AbreCadTabelasDePessoasClassificacaoDePessoa

Func AbreCadTabelasDePessoasOpcaoEspecial()

	Send($sAtalhoExpandirMenuCadastros)
	Send("TTO{ENTER}")
	WinWaitActive("", "Opcao Especial")

EndFunc   ;==>AbreCadTabelasDePessoasOpcaoEspecial

Func AbreCadTabelasDePessoasSegmento()

	Send($sAtalhoExpandirMenuCadastros)
	Send("TTS{ENTER}")
	WinWaitActive("", "Segmento")

EndFunc   ;==>AbreCadTabelasDePessoasSegmento

Func AbreCadTabelasDePessoasGerarAgendaDeVisitas()

	Send($sAtalhoExpandirMenuCadastros)
	Send("TTGG{ENTER}")
	WinWaitActive("", "Gerar Agenda de Visitas / Telemarketing")

EndFunc   ;==>AbreCadTabelasDePessoasGerarAgendaDeVisitas

Func AbreCadTabelasDePessoasContratoDeFornecimentoDeVerbas()

	Send($sAtalhoExpandirMenuCadastros)
	Send("TTCC{ENTER}")
	WinWaitActive("", "Tela Padrão")

EndFunc   ;==>AbreCadTabelasDePessoasContratoDeFornecimentoDeVerbas

#EndRegion ***** TABELA DE PESSOAS *****

#Region ***** ENDEREÇO *****

Func AbreCadEnderecoBairro()

	Send($sAtalhoExpandirMenuCadastros)
	Send("E{ENTER}")
	WinWaitActive("", "Bairros")

EndFunc   ;==>AbreCadEnderecoBairro

Func AbreCadEnderecoCidade()

	Send($sAtalhoExpandirMenuCadastros)
	Send("EC{ENTER}")
	WinWaitActive("", "Cidades")

EndFunc   ;==>AbreCadEnderecoCidade

Func AbreCadEnderecoUF()

	Send($sAtalhoExpandirMenuCadastros)
	Send("EU{ENTER}")
	WinWaitActive("", "Estados")

EndFunc   ;==>AbreCadEnderecoUF

Func AbreCadEnderecoClassificacaoDeEndereco()

	Send($sAtalhoExpandirMenuCadastros)
	Send("ECC{ENTER}")
	WinWaitActive("", "Classificação De Endereços")

EndFunc   ;==>AbreCadEnderecoClassificacaoDeEndereco

Func AbreCadEnderecoConsultaCidadeIBGE()

	Send($sAtalhoExpandirMenuCadastros)
	Send("ECCC{ENTER}")
	WinWaitActive("", "Tabela De Cidades Ibge")

EndFunc   ;==>AbreCadEnderecoConsultaCidadeIBGE

Func AbreCadEnderecoCodigoDoPais()

	Send($sAtalhoExpandirMenuCadastros)
	Send("ECCCC{ENTER}")
	$iResultadoWait = WinWaitActive("", $sTextoTelaConsultaCodigoPais, 1)

	If ($iResultadoWait == 0) Then
		Send("{ESC}S")
		Send("C{ENTER}")
		$iResultadoWait = WinWaitActive("", $sTextoTelaConsultaCodigoPais, 1)
		If ($iResultadoWait == 0) Then
			MsgBox($MB_ICONWARNING, "Alerta", "Tela de Código do Pais não localizada!" & @CRLF & _
					"O script será finalizado.")
			Exit
		EndIf
	EndIf

EndFunc   ;==>AbreCadEnderecoCodigoDoPais

Func AbreCadEnderecoAgruparCadastroDeCidades()

	Send($sAtalhoExpandirMenuCadastros)
	Send("EA{ENTER}")
	WinWaitActive("", "Transferência de Cadastro de Cidades")

EndFunc   ;==>AbreCadEnderecoAgruparCadastroDeCidades

Func AbreCadEnderecoCEP()

	Send($sAtalhoExpandirMenuCadastros)
	Send("ECCCCC{ENTER}")
	$iResultadoWait = WinWaitActive("", $sTextoTelaCadastroDeCEP, 1)

	If ($iResultadoWait == 0) Then
		Send("{ESC}S")
		Send("C{ENTER}")
		$iResultadoWait = WinWaitActive("", $sTextoTelaCadastroDeCEP, 1)
		If ($iResultadoWait == 0) Then
			MsgBox($MB_ICONWARNING, "Alerta", "Tela de Cadastro de CEP não localizada!" & @CRLF & _
					"O script será finalizado.")
			Exit
		EndIf
	EndIf

EndFunc   ;==>AbreCadEnderecoCEP

#EndRegion ***** ENDEREÇO *****

#Region ***** LOGISTICA *****

Func AbreCadLogisticaRegiao()

	Send($sAtalhoExpandirMenuCadastros)
	Send("L{ENTER}")
	WinWaitActive("", "Regiões")

EndFunc   ;==>AbreCadLogisticaRegiao

Func AbreCadLogisticaRotaDeEntrega()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LR{ENTER}")
	WinWaitActive("", "Rotas De Entrega")

EndFunc   ;==>AbreCadLogisticaRotaDeEntrega

Func AbreCadLogisticaClassificacaoDoProduto()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LC{ENTER}")
	WinWaitActive("", "Classificação Do Produto")

EndFunc   ;==>AbreCadLogisticaClassificacaoDoProduto

Func AbreCadLogisticaTipoDeVeiculo()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LT{ENTER}")
	WinWaitActive("", "Tipo De Veículos")

EndFunc   ;==>AbreCadLogisticaTipoDeVeiculo

Func AbreCadLogisticaMotivoNaoEntregaDeCanhotos()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LM{ENTER}")
	WinWaitActive("", "Motivo Nao Entrega Canhotos")

EndFunc   ;==>AbreCadLogisticaMotivoNaoEntregaDeCanhotos

Func AbreCadLogisticaTipoDeDespesasDeFrota()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LTT{ENTER}")
	WinWaitActive("", "Tipo De Despesas Da Frota")

EndFunc   ;==>AbreCadLogisticaTipoDeDespesasDeFrota

Func AbreCadLogisticaTipoDeEntrega()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LTTT{ENTER}")
	WinWaitActive("", "Tipo De Entrega")

EndFunc   ;==>AbreCadLogisticaTipoDeEntrega

Func AbreCadLogisticaGrupoDeEntrega()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LG{ENTER}")
	WinWaitActive("", "Grupo De Entrega")

EndFunc   ;==>AbreCadLogisticaGrupoDeEntrega

Func AbreCadLogisticaTurnoDeEntrega()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LTTTT{ENTER}")
	WinWaitActive("", "Turno De Entrega")

EndFunc   ;==>AbreCadLogisticaTurnoDeEntrega

Func AbreCadLogisticaEmbalagem()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LE{ENTER}")
	WinWaitActive("", "Embalagem")

EndFunc   ;==>AbreCadLogisticaEmbalagem

Func AbreCadLogisticaFaixasDeFretePorPeso()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LF{ENTER}")
	WinWaitActive("", "Faixas De Frete")

EndFunc   ;==>AbreCadLogisticaFaixasDeFretePorPeso

Func AbreCadLogisticaTabelaDeFreteInterestadual()

	Send($sAtalhoExpandirMenuCadastros)
	Send("LTTTTT{ENTER}")
	WinWaitActive("", "Frete")

EndFunc   ;==>AbreCadLogisticaTabelaDeFreteInterestadual

#EndRegion ***** LOGISTICA *****

Func AbreCadProduto()

	Send($sAtalhoExpandirMenuCadastros)
	Send("P{ENTER}")
	WinWaitActive("", "Tabela De Produtos")

EndFunc   ;==>AbreCadProduto

Func AbreCadColaborador()

	Send($sAtalhoExpandirMenuCadastros)
	Send("C{ENTER}")
	WinWaitActive("", "Colaboradores")

EndFunc   ;==>AbreCadColaborador

Func AbreCadVendedor()

	Send($sAtalhoExpandirMenuCadastros)
	Send("V{ENTER}")
	WinWaitActive("", "Vendedores")

EndFunc   ;==>AbreCadVendedor

#Region **** FINANCEIRO *****

Func AbreCadFinanceiroFormaDePagamento()

	Send($sAtalhoExpandirMenuCadastros)
	Send("FF{LEFT}F{ENTER}")
	WinWaitActive("", "Formas De Pagamento")

EndFunc   ;==>AbreCadVendedor

Func AbreCadFinanceiroCondicaoDePagamento()

	Send($sAtalhoExpandirMenuCadastros)
	Send("FF{LEFT}FC{ENTER}")
	WinWaitActive("", "Condições De Pagamento")

EndFunc   

#EndRegion **** FINANCEIRO *****

#EndRegion ### FUNÇÕES

#Region TESTE

;~ WinActivate("Space Guardian")
;~ AbreCadProduto()

#EndRegion TESTE
