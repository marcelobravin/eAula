$(document).ready(function(){
	// Autogrow para campos de texto
	var oneLetterWidth = 7,
		minCharacters = 5;
		minWidth = 50;
	
	$('input:text').live( 'keyup keydown', function () {
		var $this = $(this);
		resize($this);
	});
	
	
	/*
	$('input:text').each( function () {
		var $this = $(this);
		resize($this);
	});
	*/
	
	
	function resize($this) {
		var len = $this.val().length;
		
		if (len > minCharacters) {
			// increase width
			$this.width(len * oneLetterWidth);
		} else {
			// restore minimal width;
			$this.width(minWidth);
		}
	}
});

