var deleteManager = {
    checkBeforeSubmit : function() {
        var checkedIds = '';

        var cu = jQuery('input:checked');

        if (cu.size() == 0) {
            alert('Selecione algum registro');
            return false;
        }

        cu.each(function(value){
            var check = jQuery(value);
            checkedIds = checkedIds + check.val() +  ',';
        });

        jQuery('#ids2Delete').attr('value', checkedIds);
        return true;
    }
}