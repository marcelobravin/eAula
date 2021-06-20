/*Colore linhas checked--------------------------------------------------------*/
$(document).ready(function () {
    zebrar();
    
    /*CLICANDO EM CHECK ALL--------------------------------------------------------*/
    $('#checkAll').click(function () {
        var $this = $(this);        
        checarTodos($this);
    });


    /*CLICANDO NA CHECKBOX---------------------------------------------------------*/
    $('input[type=checkbox]').click(function () {
        var $this = $(this);
		// Colore linha
        marcar($this);
	verificar();
    });
});





// Adiciona classe às linhas selecionadas da tabela
function checarTodos($this) {
	
	// Itera por todas linhas diferentes de 'checkAll'
	$('input[type=checkbox]:not(#checkAll)').each(function () {
		// Marca linha como 'checkAll' está marcado
		if (!$(this).parent().parent().hasClass('invisivel')) {
			this.checked = $this.attr('checked');
			$this = $(this);
			// Colore linha
			marcar($this);
		}
	});
}


// Adiciona classe às linhas selecionadas da tabela
function marcar($this) {
	
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




// Desmarca todos checkbox
function desmarcarTodos() {
	
	var $selectAll = $('#checkAll');
	$selectAll.attr('checked', false);
	checarTodos($selectAll);
}
	





// Se marcar todos individualmente, marca 'checkAll'
function verificar() {

	var falsos = 0;
	// Itera pelos checkbox
	$('input[type=checkbox]:not(#checkAll)').each(function(){		
		var $this = $(this);
		
		// Contabiliza itens não checados que estejam visíveis
		if (!$this.parent().parent().hasClass('invisivel') && $this.attr('checked') == false) {
			falsos++;			
		}
	});
	
	// Se todas linhas além de 'checkAll' estiverem checadas, marca 'checkAll'
	if (falsos == 0) {
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
