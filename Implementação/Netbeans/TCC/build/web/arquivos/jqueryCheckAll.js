/*Colore linhas checked--------------------------------------------------------*/
$(document).ready(function () {
	zebrar();
    
    /*CLICANDO EM CHECK ALL--------------------------------------------------------*/
    $('#checkAll').click(function () {
        var $this = $(this);
        
        // Itera por todas linhas
        $('input[type=checkbox]:not(#checkAll)').each(function () {
			// Marca linha
            this.checked = $this.attr('checked');
            $this = $(this);
			// Colore linha
            colorir($this);
        });
    });


    /*CLICANDO NA CHECKBOX---------------------------------------------------------*/
    $('input[type=checkbox]').click(function () {
        var $this = $(this);
		// Colore linha
        colorir($this);
		
		// Verifica se todos foram selecionados
		verificar();
    });
});




// Adiciona classe às linhas selecionadas da tabela
function colorir($this) {
	
	// Verifica se essa checkbox foi marcada ou desmarcada
    if ($this.attr('checked') == true) {
		// Colore linha
        $this.parent().parent().addClass('selected')
		
    } else {
		// Se uma linha for desmarcada, desmarca 'checkAll'
        $this.parent().parent().removeClass('selected');
        $('#checkAll').attr('checked', false);
    }
}





// Se marcar todos individualmente, marca 'checkAll'
function verificar() {

	var falsos = 0;
	// Itera pelos checkbox
	$('input[type=checkbox]').each(function(){
		// Contabiliza checkbox desmarcados
		if ($(this).attr('checked') == false) {
			falsos++;
		}
	});
	
	// Se não houver linhas desmarcadas, marca 'checkAll'
	if (falsos == 1) { // limiar 1 po causa do próprio checkAll
		$('#checkAll').attr('checked', true);
	}
}




// Dá pra separar em jZebra 
// tirar zebra() d jCheckAll: linha 2
//Zebramento====================================================================
//$(document).ready(function () {
	//zebrar();
//});	
	
// colore linhas da tabela impares
function zebrar() {
    $("tr:odd").addClass("impar");
}

// descolore todas linhas da tabela
function deszebrar() {
    $("tr").removeClass("impar");
}
