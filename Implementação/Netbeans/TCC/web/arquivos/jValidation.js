jQuery(function($) {
    // Quando form [não login] é submitado
    $('form[id!=login]').bind('submit', function (event) {
        var erro = 0;
        var form = $(this);



        
        
        
        
        
        
        
        
        
        
        
$("input[type=radio]").each(function() {
    // Cria atalho para este input, deste formulário
    $this = $(this, this);
    

    // Verifica se esse input é de preenchimento obrigatório
    if ($this.hasClass("obrigatorio")) {
        if (!$this.is(':checked')) {
            //alert($this);
            $this.addClass("campoIncorreto");
            erro++;
        } else {
            $this.removeClass("campoIncorreto");
        }
    }
     
     
     // pegar numero de radios e verificar 
     // se erros=radios-1
     //     erros = 0;
    //alert(erro);
    
});


// da pra deixar só isso e excluir o bloco de cima AAA
if ($("input[type=radio][class=obrigatorio]:checked").length == 1) {
//if (erro < $("input[type=radio]").length) {
    erro=0;
    //alert($("input[type=radio][class=obrigatorio]:checked").length);
}







        // Itera pelos inputs (que não sejam SUBMIT, RESET e HIDDEN)
        $("input[type!=hidden][type!=button][type!=reset][type!=submit][type!=radio], select, textarea").each(function(){

            // Cria atalho para este input, deste formulário
            $this = $(this, this);

            // Verifica se esse input é de preenchimento obrigatório
            if ($this.siblings().hasClass("obrigatorio")) {

                // Marca campos vazios e desmarca campos preenchidos (que não sejam CHECKBOX)
                if ($this.val() == "" && !$this.is(':checkbox')) {
                    $this.addClass("campoIncorreto");
                    erro++;
                } else {
                    $this.removeClass("campoIncorreto");
                }



                // Marca CHECKBOX'es selecionados e desmarca não-selecionados
                if ($this.is(':checkbox') ) {
                    if ($this.is(':checked')) {
                        $this.parent().css('color', 'black');						
                    } else {
                        $this.parent().css('color', 'red');
                        erro++;
                    }
                }
            }
        });
        
        
        



        // Verifica número de erros e exibe mensagem correspondente
        if (erro > 0) {
            $("#erroBox").remove();
            //
            //
            var caixa = "<div id='erroBox'>";
            caixa += "<img src='arquivos/imagens/icon-error.png' />";
            caixa += "<h5>ERRO</h5>";
            if (erro > 1) {
                caixa += "<p>Preencha corretamente os "+ erro +" campos em vermelho</p>";
            } else {
                caixa += "<p>Preencha corretamente o campo em vermelho</p>";
            }
            
            caixa += "</div>";
            
            form.prepend(caixa);
            return false;
        }
    });
});