function getDadosComoObjeto(param) {
    try{
        var objJsonParse = JSON.parse(param); 
        return objJsonParse;
    }
    catch(e){
        console.log("erro: " + e);
    }
}

function montaTabela(param){
    var dados = getDadosComoObjeto(param);

    var tbody = document.getElementById("tbody");	

    for (var i = 0; i < dados.length; i++) {
        var tr1 = document.createElement("tr");

        var td_udf = document.createElement("td");
        td_udf.setAttribute('align', 'center');
        var txt1 = document.createTextNode(dados[i].titulo);
        td_udf.appendChild(txt1);

        var td_pasta = document.createElement("td");
        td_pasta.setAttribute('align', 'center');
        var txt2 = document.createTextNode(dados[i].pasta);
        td_pasta.appendChild(txt2);

        var td_versao = document.createElement("td");
        td_versao.setAttribute('align', 'center');
        var txt3 = document.createTextNode(dados[i].versao);
        td_versao.appendChild(txt3);

        tr1.appendChild(td_udf);
        tr1.appendChild(td_pasta);
        tr1.appendChild(td_versao);        

        tbody.appendChild(tr1);

        for (var j = 0; j < dados[i].funcoes.length; j++) { 
            var tr2 = document.createElement("tr");

            var td_funcoes = document.createElement("td");
            td_funcoes.setAttribute('colspan', 3);            
            var txt4 = document.createTextNode(dados[i].funcoes[j]);
            td_funcoes.appendChild(txt4);

            tr2.appendChild(td_funcoes);
            tbody.appendChild(tr2);
        }        
     }
}

// {'+
//     '"titulo": "GeraCPF_CNPJ.au3",'+
//     '"descricao": "UDF para gerar CPF e CNPJ de forma aleatória",'+
//     '"pasta": "_UDFs\Auxiliares",'+
//     '"versao": "003",'+
//     '"autores": ['+
//         '"Ronildo"'+
//     '],'+
//     '"funcoes": ['+
//         '"GerarCPF($bPontos = False)",'+
//         '"GerarCNPJ($bPontos = False)"'+
//     ']'+
// '},'+