#cs ===============================================================================================================================
	Típo de Script .: Script de Função - UDF
	Descrição ......: UDF para acesso as opções do Menu de Cadastros do Space Guardian
	Data Inicio ....: 07/04/2016
	Data Termino ...: 18/04/2016
	Versão .........: 001
	Autor(s) .......: Ronildo
#ce ===============================================================================================================================

#Region ### INCLUDES / OPS

#include-once
#include <MsgBoxConstants.au3>
#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\IncludesGuardian.au3"
#include "D:\Arquivo de Teste\Testes-Automatizados\_UDFs\Guardian\AbstractAbreMenuGuardian.au3"

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

Func AbreCadastrosCliente()

	AbreMenu($sAtalhoExpandirMenuCadastros, "", "{ENTER}", $TEXTO_CADASTRO_CLIENTES)

EndFunc   ;==>AbreCadastrosCliente

Func AbreCadastrosFornecedor()

	AbreMenu($sAtalhoExpandirMenuCadastros, "F", "{ENTER}", $TEXTO_CADASTRO_FORNECEDORES)

EndFunc   ;==>AbreCadastrosFornecedor

Func AbreCadastrosTransportadora()

	AbreMenu($sAtalhoExpandirMenuCadastros, "T", "{ENTER}", $TEXTO_CADASTRO_TRANSPORTADORES)

EndFunc   ;==>AbreCadastrosTransportadora

#Region ***** TABELA DE PESSOAS *****

Func AbreCadastrosTabelasDePessoasCarteiraDeClientes()

	AbreMenu($sAtalhoExpandirMenuCadastros, "TT", "{ENTER}", $TEXTO_CARTEIRA_DE_CLIENTES)

EndFunc   ;==>AbreCadastrosTabelasDePessoasCarteiraDeClientes

Func AbreCadastrosTabelasDePessoasGrupoDeCliente()

	AbreMenu($sAtalhoExpandirMenuCadastros, "TTG", "{ENTER}", $TEXTO_GRUPO_DE_CLIENTES)

EndFunc   ;==>AbreCadastrosTabelasDePessoasGrupoDeCliente

Func AbreCadastrosTabelasDePessoasAtividade()

	AbreMenu($sAtalhoExpandirMenuCadastros, "TTA", "{ENTER}", $TEXTO_ATIVIDADES)

EndFunc   ;==>AbreCadastrosTabelasDePessoasAtividade

Func AbreCadastrosTabelasDePessoasClassificacaoDePessoa()

	AbreMenu($sAtalhoExpandirMenuCadastros, "TTC", "{ENTER}", $TEXTO_CLASSIFICACAO_DE_PESSOA)

EndFunc   ;==>AbreCadastrosTabelasDePessoasClassificacaoDePessoa

Func AbreCadastrosTabelasDePessoasOpcaoEspecial()

	AbreMenu($sAtalhoExpandirMenuCadastros, "TTO", "{ENTER}", $TEXTO_OPCAO_ESPECIAL)

EndFunc   ;==>AbreCadastrosTabelasDePessoasOpcaoEspecial

Func AbreCadastrosTabelasDePessoasSegmento()

	AbreMenu($sAtalhoExpandirMenuCadastros, "TTS", "{ENTER}", $TEXTO_SEGMENTO)

EndFunc   ;==>AbreCadastrosTabelasDePessoasSegmento

Func AbreCadastrosTabelasDePessoasGerarAgendaDeVisitas()

	AbreMenu($sAtalhoExpandirMenuCadastros, "TTGG", "{ENTER}", $TEXTO_AGENDA_DE_VISITAS)

EndFunc   ;==>AbreCadastrosTabelasDePessoasGerarAgendaDeVisitas

Func AbreCadastrosTabelasDePessoasContratoDeFornecimentoDeVerbas()

	AbreMenu($sAtalhoExpandirMenuCadastros, "TTCC", "{ENTER}", $TEXTO_CONTRATOS_FORNEC_VERBA)

EndFunc   ;==>AbreCadastrosTabelasDePessoasContratoDeFornecimentoDeVerbas

#EndRegion ***** TABELA DE PESSOAS *****

#Region ***** ENDEREÇO *****

Func AbreCadastrosEnderecoBairro()
	
	AbreMenu($sAtalhoExpandirMenuCadastros, "E", "{ENTER}", $TEXTO_BAIRRO)

EndFunc   ;==>AbreCadastrosEnderecoBairro

Func AbreCadastrosEnderecoCidade()

	AbreMenu($sAtalhoExpandirMenuCadastros, "EC", "{ENTER}", $TEXTO_CIDADE)

EndFunc   ;==>AbreCadastrosEnderecoCidade

Func AbreCadastrosEnderecoUF()

	AbreMenu($sAtalhoExpandirMenuCadastros, "EU", "{ENTER}", $TEXTO_ESTADO)

EndFunc   ;==>AbreCadastrosEnderecoUF

Func AbreCadastrosEnderecoClassificacaoDeEndereco()

	AbreMenu($sAtalhoExpandirMenuCadastros, "ECC", "{ENTER}", $TEXTO_CLASS_ENDERECO)

EndFunc   ;==>AbreCadastrosEnderecoClassificacaoDeEndereco

Func AbreCadastrosEnderecoConsultaCidadeIBGE()

	AbreMenu($sAtalhoExpandirMenuCadastros, "ECCC", "{ENTER}", $TEXTO_CONSULTA_IBGE)

EndFunc   ;==>AbreCadastrosEnderecoConsultaCidadeIBGE

Func AbreCadastrosEnderecoCodigoDoPais()

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

EndFunc   ;==>AbreCadastrosEnderecoCodigoDoPais

Func AbreCadastrosEnderecoAgruparCadastroDeCidades()

	AbreMenu($sAtalhoExpandirMenuCadastros, "EA", "{ENTER}", $TEXTO_AGRUPA_CAD_CIDADES)

EndFunc   ;==>AbreCadastrosEnderecoAgruparCadastroDeCidades

Func AbreCadastrosEnderecoCEP()

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

EndFunc   ;==>AbreCadastrosEnderecoCEP

#EndRegion ***** ENDEREÇO *****

#Region ***** LOGISTICA *****

Func AbreCadastrosLogisticaRegiao()

	AbreMenu($sAtalhoExpandirMenuCadastros, "L", "{ENTER}", $TEXTO_REGIAO)

EndFunc   ;==>AbreCadastrosLogisticaRegiao

Func AbreCadastrosLogisticaRotaDeEntrega()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LR", "{ENTER}", $TEXTO_ROTA_ENTREGA)

EndFunc   ;==>AbreCadastrosLogisticaRotaDeEntrega

Func AbreCadastrosLogisticaClassificacaoDoProduto()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LC", "{ENTER}", $TEXTO_CLASS_PRODUTO)

EndFunc   ;==>AbreCadastrosLogisticaClassificacaoDoProduto

Func AbreCadastrosLogisticaTipoDeVeiculo()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LT", "{ENTER}", $TEXTO_TIPO_VEICULO)

EndFunc   ;==>AbreCadastrosLogisticaTipoDeVeiculo

Func AbreCadastrosLogisticaMotivoNaoEntregaDeCanhotos()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LM", "{ENTER}", $TEXTO_MOTIVO_NAO_ENTREGA)

EndFunc   ;==>AbreCadastrosLogisticaMotivoNaoEntregaDeCanhotos

Func AbreCadastrosLogisticaTipoDeDespesasDeFrota()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LTT", "{ENTER}", $TEXTO_TIPO_DESPESA_FROTA)

EndFunc   ;==>AbreCadastrosLogisticaTipoDeDespesasDeFrota

Func AbreCadastrosLogisticaTipoDeEntrega()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LTTT", "{ENTER}", $TEXTO_TIPO_ENTREGA)

EndFunc   ;==>AbreCadastrosLogisticaTipoDeEntrega

Func AbreCadastrosLogisticaGrupoDeEntrega()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LG", "{ENTER}", $TEXTO_GRUPO_DE_ENTREGA)

EndFunc   ;==>AbreCadastrosLogisticaGrupoDeEntrega

Func AbreCadastrosLogisticaTurnoDeEntrega()
	
	AbreMenu($sAtalhoExpandirMenuCadastros, "LTTTT", "{ENTER}", $TEXTO_TURNO_DE_ENTREGA)

EndFunc   ;==>AbreCadastrosLogisticaTurnoDeEntrega

Func AbreCadastrosLogisticaEmbalagem()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LE", "{ENTER}", $TEXTO_EMBALAGEM)

EndFunc   ;==>AbreCadastrosLogisticaEmbalagem

Func AbreCadastrosLogisticaFaixasDeFretePorPeso()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LF", "{ENTER}", $TEXTO_FAIXA_DE_FRETE)

EndFunc   ;==>AbreCadastrosLogisticaFaixasDeFretePorPeso

Func AbreCadastrosLogisticaTabelaDeFreteInterestadual()

	AbreMenu($sAtalhoExpandirMenuCadastros, "LTTTTT", "{ENTER}", $TEXTO_TABELA_DE_FRETE)

EndFunc   ;==>AbreCadastrosLogisticaTabelaDeFreteInterestadual

#EndRegion ***** LOGISTICA *****

Func AbreCadastrosProduto()

	AbreMenu($sAtalhoExpandirMenuCadastros, "P", "{ENTER}", $TEXTO_CADASTRO_PRODUTOS)

EndFunc   ;==>AbreCadastrosProduto

Func AbreCadastrosColaborador()

	AbreMenu($sAtalhoExpandirMenuCadastros, "C", "{ENTER}", $TEXTO_CADASTRO_COLABORADOR)

EndFunc   ;==>AbreCadastrosColaborador

Func AbreCadastrosVendedor()

	AbreMenu($sAtalhoExpandirMenuCadastros, "V", "{ENTER}", $TEXTO_CADASTRO_VENDEDOR)

EndFunc   ;==>AbreCadastrosVendedor

#Region **** FINANCEIRO *****

Func AbreCadastrosFinanceiroFormaDePagamento()

	AbreMenu($sAtalhoExpandirMenuCadastros, "FF{LEFT}F", "{ENTER}", $TEXTO_FORMA_PAGTO)

EndFunc   ;==>AbreCadastrosFinanceiroFormaDePagamento

Func AbreCadastrosFinanceiroCondicaoDePagamento()

	AbreMenu($sAtalhoExpandirMenuCadastros, "FF{LEFT}FC", "{ENTER}", $TEXTO_CONDICAO_PAGTO)

EndFunc   ;==>AbreCadastrosFinanceiroCondicaoDePagamento

#EndRegion **** FINANCEIRO *****

#EndRegion ### FUNÇÕES
