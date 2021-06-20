jQuery(function($) {
	
	// Quando form é submitado
	$('form').bind('submit', function (event) {
		var erro = 0;
		
		// Itera pelos inputs (que não sejam SUBMIT, RESET e HIDDEN)
		$("input[type!=hidden][type!=button][type!=reset][type!=submit], select").each(function(){
		
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
		if (erro == 0) {
			$(".ok").removeClass("invisivel");
			$(".erro").addClass("invisivel");
		} else {
			$(".erro").removeClass("invisivel");
			$(".ok").addClass("invisivel");
			return false;
		}
	});
});