#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\mysql_1.au3"

$sUsername = "root"
$sPassword = "@kalunga123"
$sDatabase = "banco_teste"
$sServer = "localhost"
$sDriver = "{MySQL ODBC 5.1 Driver}"

$str = ""
$resultado = ""

$mySqlConn = _MySQLConnect($sUsername, $sPassword, $sDatabase, $sServer, $sDriver)

;$query = "Insert Into cliente (nome) values('Cliente Autoit')"
$query = "Select concat(codigo, ' - ', nome) As CodNome From Cliente"

$resultado = _Query($mySqlConn, $query)

if(IsObj($resultado)) Then
	MsgBox(0,"","É um Objeto")

	With $resultado
		While Not .EOF
			$str = $str & .Fields('CodNome').Value & @CR
			.MoveNext
		WEnd
	EndWith

	MsgBox(0, "", $str)

EndIf





