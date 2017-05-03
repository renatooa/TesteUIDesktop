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
            var arrayTexto = [JsonObjDados[i].titulo, JsonObjDados[i].pasta, JsonObjDados[i].versao, "DTL"]

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
        var td = document.createElement("td");    
        td.setAttribute(tdAttr, tdAttrValue);
        var txt1 = document.createTextNode(arrayTextNode[i]); 
        
        if(txt1.wholeText.trim() == "DTL"){
            // var a = document.createElement("a");
            // a.setAttribute('onclick', "abrePaginaDetalhes("+ jsonToStr +")");
            // a.setAttribute('href', "pages/auxiliares.html");            
            // a.appendChild(txt1);
            // td.appendChild(a); 

            var btn = document.createElement("button");
            btn.setAttribute('onclick', "post('pages/auxiliares.html', "+ jsonToStr +")");
            btn.appendChild(txt1);
            td.appendChild(btn); 
        }
        else
            td.appendChild(txt1);

        tr.appendChild(td);     
    }
    return tr;
}

function abrePaginaDetalhes(strJson) {
    console.debug(strJson);
    //window.open("pages/auxiliares.html");   

    if(strJson){           
        window.postMessage(strJson, "pages/auxiliares.html");
        document.getElementById("titulo").innerText = strJson.titulo;
    }
}

function loadDetalhe() {
    _request = new XMLHttpRequest();
    _request.open("HEAD", window.location, true);
    //_request.send(null)

    //while (_request.readyState != 4) {};
      
    console.debug(_request.getResponseHeader("User-Agent"));
}

function post(path, params, method) {
    method = method || "post"; // Set method to post by default if not specified.

    // The rest of this code assumes you are not using a library.
    // It can be made less wordy if you use one.
    var form = document.createElement("form");
    form.setAttribute("method", method);
    form.setAttribute("action", path);

    for(var key in params) {
        if(params.hasOwnProperty(key)) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);

            form.appendChild(hiddenField);
         }
    }

    document.body.appendChild(form);
    form.submit();
}

function teste(a){ 
    // alert(a);
    //document.open("pages/auxiliares.html");
    console.debug(a);
}