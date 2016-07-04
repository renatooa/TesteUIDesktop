#include "D:\Arquivo de Teste\Testes-Automatizados\_temp\func\mysql_2.au3"

$sUsername = "root"
$sPassword = "@kalunga123"
$sDatabase = "banco_teste"
$sServer = "localhost"
$sDriver = "{MySQL ODBC 5.1 Driver}"
$iPort = 3306

Global $str = ""
Global $linha
$resultado = "";

$mySqlConn = mysql_connect($sServer, $sUsername, $sPassword, $sDatabase, $iPort, $sDriver)

;$query = "Insert Into cliente (nome) values('Cliente Autoit Outro')"
$query = "Select concat(codigo, ' - ' ,nome) From Cliente"

;$obQuery = mysql_query("INSERT INTO test (`value`) VALUES('This is a test!')")

$arArray = mysql_fetch_array($query)

If IsArray($arArray) Then
    For $i = 0 to Ubound($arArray, 1) - 1

        For $j = 0 To UBound($arArray, 2) - 1
			$str = $str & $arArray[$i][$j][1] & @CRLF
        Next
    Next
	MsgBox(0,"",$str)
Else
    ConsoleWrite("!>" & mysql_error() & @CRLF)
EndIf

mysql_close()



