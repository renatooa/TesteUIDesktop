function getDadosComoObjeto(param) {
    // var j = JSON.parse(udfs_auxiliares);
    var objJsonParse = JSON.parse(param);
    
    // var str = '';
    // for (var index = 0; index < objJsonParse.length; index++) {
    //     str += '\n' + objJsonParse[index].titulo + '\n';

    //     for (var i = 0; i < objJsonParse[index].funcoes.length; i++) {
    //         str += '\t' + (i + 1) + ' - ' + objJsonParse[index].funcoes[i] + '\n';            
    //     }       
    // }
    // console.log(str);

    return objJsonParse;
}

function montaTabela(param){
    var dados = getDadosComoObjeto(param);
}

// montaTabela(udfs_guardian);