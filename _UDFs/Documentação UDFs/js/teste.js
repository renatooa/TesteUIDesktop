function getJsonDadosComoObjeto(strJsonUdf) {    
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
    var JsonObjDados = getJsonDadosComoObjeto(strJsonUdf);
    var tbody = document.getElementById("tbody");    

    if(JsonObjDados && tbody){
        
        if(tbody && tbody.childNodes.length > 0){
            tbody.remove();
            tbody = document.createElement("tbody");
            tbody.setAttribute('id', 'tbody');

            document.getElementById("table").appendChild(tbody);
        }

        for (var i = 0; i < JsonObjDados.length; i++) {
            var tr1 = document.createElement("tr");
            var arrayTexto = [JsonObjDados[i].titulo, JsonObjDados[i].pasta, JsonObjDados[i].versao]

            var tr = criaLinhaColuna(arrayTexto, JsonObjDados[i]);
            tbody.appendChild(tr);

            // for (var j = 0; j < JsonObjDados[i].funcoes.length; j++) {
            //     var tr = criaLinhaColuna([JsonObjDados[i].funcoes[j]], 'colspan', 3);
            //     tbody.appendChild(tr);
            // }        
        }
    }
}

function criaLinhaColuna(arrayTextNode, JsonObj, tdAttr = 'align', tdAttrValue = 'center') {
    var jsonToStr = JSON.stringify(JsonObj);
    var tr = document.createElement("tr");

    for (var i = 0; i < arrayTextNode.length; i++) {
        var a = document.createElement("a");    
        var td = document.createElement("td");    
        td.setAttribute(tdAttr, tdAttrValue);
        var txt1 = document.createTextNode(arrayTextNode[i]); 
        
        a.setAttribute('onclick', "teste("+ jsonToStr +")");

        a.appendChild(txt1);
        td.appendChild(a); 
        tr.appendChild(td);     
    }
    return tr;
}

function teste(a){ 
    // alert(a);
    document.open("pages/auxiliares.html");
    console.debug(a);
}