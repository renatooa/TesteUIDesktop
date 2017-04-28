function getDadosComoObjeto(strJsonUdf) {    
    if(strJsonUdf){
        try{
            var objJsonParse = JSON.parse(strJsonUdf); 
            return objJsonParse;        
        }
        catch(ex){
            console.error(ex.message);
        }
    }
}

function montaTabela(strJsonUdf){
    var dados = getDadosComoObjeto(strJsonUdf);
    var tbody = document.getElementById("tbody");    

    if(dados && tbody){
        
        if(tbody && tbody.childNodes.length > 0){
            tbody.remove();
            tbody = document.createElement("tbody");
            tbody.setAttribute('id', 'tbody');

            document.getElementById("table").appendChild(tbody);
        }

        for (var i = 0; i < dados.length; i++) {
            var tr1 = document.createElement("tr");
            var arrayTexto = [dados[i].titulo, dados[i].pasta, dados[i].versao]

            var tr = criaLinhaColuna(arrayTexto, dados[i]);
            tbody.appendChild(tr);

            // for (var j = 0; j < dados[i].funcoes.length; j++) {
            //     var tr = criaLinhaColuna([dados[i].funcoes[j]], 'colspan', 3);
            //     tbody.appendChild(tr);
            // }        
        }
    }
}

function criaLinhaColuna(arrayTextNode, obj, tdAttr = 'align', tdAttrValue = 'center') {
    var tr = document.createElement("tr");

    for (var i = 0; i < arrayTextNode.length; i++) {  
        var td = document.createElement("td");    
        td.setAttribute(tdAttr, tdAttrValue);
        var txt1 = document.createTextNode(arrayTextNode[i]);

        td.appendChild(txt1); 
        tr.appendChild(td);     
    }
    return tr;
}

function teste(a){ 
    // alert(a);
    console.debug(a.versao);
}