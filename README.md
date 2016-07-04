# Testes-Automatizados
Repositório dos scripts de testes automatizados criado com AutoIt.

# Padronizações Para Escritas dos Scripts

***************************************
<b><i>PADRONIZAÇÃO DOS NOMES DOS ARQUIVOS</i></b>
***************************************
	
* Arquivos de Teste ==> TA_[Nome do Arquivo].au3

	Ex.: TA_Cadastrar Feriado.au3
	
* Arquivos de Teste Para BUG ==> TA_BUG [Nome do Arquivo].au3

	Ex.: TA_BUG Cadastro de transportador padrão para fornecedor.au3
	
* Arquivos de UDF ==> Padrão PascalCase

	Ex.: AlteraResolucao.au3
	
* Arquivos de Form ==> frm[Nome do Arquivo].au3

	Ex.: frmPerguntaCadastro.au3

**************************
<b><i>PADRONIZAÇÃO DO CODIGO</i></b>
**************************

* Nomer as variaveis informando a primeira letra do tipo de dados que será armazenado na mesma.
 
	Ex.:<br>
		$sVariavelArmazenaString = ""<br>
		$iVariavelArmazenaInt = 10<br>
		$dVariavelArmazenaDouble = 5.5<br>
		$bVariavelArmazenaBool = true<br>
		$aVariavelArray[3] = ["Item 0", "Item 1", "Item 2"]<br>
		$vVariavelVariante = 1 OU $vVariavelVariante = "string"
		
OBS.: Exceção para as variaveis geradas pelo 'Koda FormDesigner'.		

* Funções ==> Padrão PascalCase

	Ex.:<br> 
		Func FuncaoExemplo()		
		EndFunc

-
<b><i>!!! IMPORTANTE !!!</i></b>

* <b><i> O REPOSITÓRIO DEVERÁ SER CLONADO NO DIRETÓRIO..: D:\Testes-Automatizados\\</i></b>

-
