# <img width="64px" height="64px" src="https://chocolatey.org/content/packageimages/autoit.3.3.14.2.png"/> TesteUIDesktop
Repositório de scripts de teste UI desktop feitos com <a href="https://www.autoitscript.com/cgi-bin/getfile.pl?../autoit3/scite/download/SciTE4AutoIt3.exe" target="_blank"><b>AutoIt</b></a>.

-

<b><i>!!! IMPORTANTE !!!</i></b>

<b><i> O REPOSITÓRIO DEVERÁ SER CLONADO NO DIRETÓRIO..: D:\Testes-Automatizados\\</i></b>

-

# Padronizações Para Escrita dos Scripts

***************************************
<b><i>PADRONIZAÇÃO DO NOME DOS ARQUIVOS</i></b>
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

* Nomear as variaveis informando a primeira letra do tipo de dados que será armazenado na mesma.
 
	Ex.:<br>
		$sVariavelArmazenaString = "texto"<br>
		$iVariavelArmazenaInt = 10<br>
		$dVariavelArmazenaDouble = 5.5<br>
		$bVariavelArmazenaBool = true<br>
		$aVariavelArray[3] = ["Item 0", "Item 1", "Item 2"]<br>
		$vVariavelVariante = 1 OU $vVariavelVariante = "string"<br>
		$oVariavelArmazenaObjeto = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sHost)
		
OBS.: Exceção para as variaveis geradas pelo 'Koda FormDesigner'.		

* Funções ==> Padrão PascalCase

	Ex.:<br> 
		Func FuncaoExemplo()		
		EndFunc
		
-
