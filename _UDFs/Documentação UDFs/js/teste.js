function getDadosComoObjeto(param) {
    try{
        // var j = JSON.parse(udfs_auxiliares);
        var objJsonParse = JSON.parse(param); 
        return objJsonParse;
    }
    catch(e){
        console.log("erro: " + e);
    }
}

function montaTabela(param){
    var dados = getDadosComoObjeto(param);

    var str = '';
    for (var index = 0; index < dados.length; index++) {
        str += '\n' + dados[index].titulo + '\n';

        for (var i = 0; i < dados[index].funcoes.length; i++) {
            str += '\t' + (i + 1) + ' - ' + dados[index].funcoes[i] + '\n';            
        }       
    }
    console.log(str);
}