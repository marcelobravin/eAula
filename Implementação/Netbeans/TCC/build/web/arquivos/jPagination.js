/*Gerencia pagina��o--------------------------------------------------------*/
var show_per_page = 10;
var number_of_items = 0;
var number_of_pages = 0;

$(document).ready(function () {

	// Controla numero de resultados a exibir
	$('#paginas').change(function () {
				
		// Muda numero de resultados a exibir
		show_per_page = parseInt($(this).val());
                
                if (show_per_page == 0) {
                    show_per_page = number_of_items;
                }
		
		// Retorna a página 1
		$('#paginaAtual').val(1);
		inicializarPaginacao();		
	});

	/////////////////////////////////////////////////////////////////////////////////
	// Inicia pagina��o
	inicializarPaginacao();

	$('.paginaControle:not(.paginaAtual)').live("click", function () {
		$this = $(this);

		// Permite acesso somente se for clicada em página diferenta da atual
//		if (!$this.hasClass('paginaAtual')) {
			
				
			desmarcarTodos();
			
			
		
		
			var num = parseInt($('#paginaAtual').val());

			// Verifica qual pagina foi selecionada atrav�s do bot�o de controle
			if ($this.attr('id') == "primeira") {
				num = 1;
			} else if ($this.attr('id') == "anterior") {
				num--;
			} else if ($this.attr('id') == "proxima") {
				num++;
			} else if ($this.attr('id') == "ultima") {
				num = number_of_pages;
			} else {
				num = $this.attr('id');
			}


			// Marca pagina selecionada para 'proximo' e 'anterior'
			$('#paginaAtual').val(num);
			// Solicita exibi��o da p�gina selecionada
			exibirPagina(num);
		//}
	});
});



// Inicializar
function inicializarPaginacao() {
	desmarcarTodos();
		
	var i = 0;

	// Conta qtde de TR's
	$('tbody tr').each(function () {
		i++;
	});


	// Calcula numero de linhas e p�ginas
	number_of_items = i;
	number_of_pages = Math.ceil(number_of_items / show_per_page);


	// Constroi botoes do controle de paginacao
	var paginas = "";
	for (j = 1; j <= number_of_pages; j++) {
		paginas += "<a href='javascript:void(0)' class='paginaControle' id='" + j + "'>" + j + "</a> ";
	}

	// Exibe controle de paginacao
	$('.paginas').html(paginas);


	// Exibe p�gina 1
	exibirPagina(1);
}




// Esconde todas linhas
function apagaTodos() {
	$('tbody tr').each(function () {
		$(this).addClass('invisivel');
	});
}





//Exibe p�gina solicitada---------------------------------------------------
function exibirPagina(num) {
	apagaTodos();
	

	// Desmarca todas p�ginas
	for (l = 1; l <= number_of_pages; l++) {
		$('#' + l).removeClass('paginaAtual');
	}

	// Marca p�gina atual
	$('#' + num).addClass('paginaAtual');


	// Marca/desmarca op��es 'primeira' e 'anterior'
	if (num == 1) {
		$('#primeira').addClass('paginaAtual');
		$('#anterior').addClass('paginaAtual');
	} else {
		$('#primeira').removeClass('paginaAtual');
		$('#anterior').removeClass('paginaAtual');
	}

	// Marca/desmarca op��es 'ultima' e 'proxima'
	if (num == number_of_pages || number_of_items == 0) {
		$('#ultima').addClass('paginaAtual');
		$('#proxima').addClass('paginaAtual');
	} else {
		$('#ultima').removeClass('paginaAtual');
		$('#proxima').removeClass('paginaAtual');
	}





	// Itera pelas linhas
	var i = 0;
	$('tbody tr').each(function () {
		i++;

		// Crit�rio de inicio e final da exibi��o
		var inicio = show_per_page * (num - 1);
		var fim = show_per_page * num;

		// Exibe linhas solicitadas
		if (i > inicio && i <= fim) {
			$(this).removeClass('invisivel');
		}
	});
}