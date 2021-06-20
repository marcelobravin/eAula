// função aparecer/desaparecer div erro
function SwitchDiv(numero, campo) {
    if (numero == 1) {
        document.getElementById(campo).style.display = "inline";
        if (campo == "erroBox") {
            document.getElementById(campo).style.display = "block";
        }
    } else {
        document.getElementById(campo).style.display = "none";
    }
}