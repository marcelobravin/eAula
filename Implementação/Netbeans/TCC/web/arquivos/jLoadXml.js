// Carrega conteudo no elemento especificado em 'alvo'
function loadDiv(str, alvo) {
    var xmlhttp;
    
    
    // Insere imagem de carregando no local alvo
    document.getElementById(alvo).innerHTML= "<img src='arquivos/imagens/loading.gif'>";
    
    // Se solicitação for vazia, limpa e desliga os selects
    var listaVazia ="";
    
    //--------------------------------------------------------------------------
    if (str=="FiltroOpcoes?uf=") {
        listaVazia = "<span id='labelCidade' class='gray'>";
        listaVazia += "<label class='obrigatorio'>";
        listaVazia += "Cidade:";
        listaVazia += "</label>";
        listaVazia += "</span>";
        listaVazia += "<select name='campoCidade' id='campoCidade' disabled='disabled'></select>";
        
        
        document.getElementById(alvo).innerHTML = listaVazia;
        return;
        
        //----------------------------------------------------------------------
    } else if (str=="FiltroOpcoes?area=") {
        listaVazia = "<span id='labelMateria' class='gray'>";
        listaVazia += "<label class='obrigatorio'>";
        listaVazia += "Matéria:";
        listaVazia += "</label>";
        listaVazia += "</span>";
        
        listaVazia += "<select name='materia' id='materia' disabled='disabled'></select>";
        
        document.getElementById(alvo).innerHTML = listaVazia;        
        listaVazia = "<span id='labelDisciplina' class='gray'>";
        listaVazia += "<label class='obrigatorio'>";
        listaVazia += "Disciplina:";
        listaVazia += "</label>";
        listaVazia += "</span>";
        
        listaVazia += "<select name='disciplina' id='disciplina' disabled='disabled'></select>";
        
        document.getElementById("selectDisciplina").innerHTML = listaVazia;
        return;
    }
    //--------------------------------------------------------------------------
    else if (str=="FiltroOpcoes?materia=") {
        listaVazia = "<span id='labelDisciplina' class='gray'>";
        listaVazia += "<label class='obrigatorio'>";
        listaVazia += "Disciplina:";
        listaVazia += "</label>";
        listaVazia += "</span>";
        
        listaVazia += "<select name='disciplina' id='disciplina' disabled='disabled'></select>";
        
        document.getElementById(alvo).innerHTML = listaVazia;
        return;
    }
    
    
    
    // Se a solicitação for válida preenche com o conteúdo gerado pela servlet 'FiltroOpcoes'
    else {
        // Verifica navegador do usuário
        // IE7+, Firefox, Chrome, Opera, Safari
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        // IE6, IE5
        else {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }

        // Quando carregamento for concluído
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                document.getElementById(alvo).innerHTML=xmlhttp.responseText;
            }
        }

        // Finaliza carregamento e envio de dados
        xmlhttp.open("GET", str, true);
        xmlhttp.send();
    }
}