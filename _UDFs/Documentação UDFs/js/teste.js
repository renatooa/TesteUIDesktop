function carregaJson() {
    var j = JSON.parse(udf_auxiliares);
    var str = '';

    for (var index = 0; index < j.length; index++) {
        str += j[index].titulo + '\n';        
    }

    alert(str);
}

carregaJson();