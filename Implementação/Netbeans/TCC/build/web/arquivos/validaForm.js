// Valida dados de cadastro de usuário antes de acessar BD

function validaForm() {
    d = document.cadastro;
    mensagem = "<br />O(s) campo(s) a seguir deve(m) ser preenchido(s):<br />";

    erro = 0;
    nome = true;
    senha = true;
    email = true;
    dataNasc = true;
    sexo = true;
    cpf = true;
    captcha = true;


    //validar nome
    if (validaNome() == false) {
        mensagem += "Nome<br />";
        erro++;
        nome = false;
    }
    
    if (validaSexo() == false) {
        mensagem += "Sexo<br />";
        erro++;
        sexo = false;
    }
    
    if (validaCpf() == false) {
        mensagem += "CPF<br />";
        erro++;
        cpf = false;
    }
    
    if (validaNasc() == false) {
        mensagem += "Data de Nascimento<br />";
        erro++;
        dataNasc = false;
    }
    
    if (validaEmail() == false) {
        mensagem += "Email<br />";
        erro++;
        email = false;
    }
    
    if (validaSenha() == false) {
        mensagem += "Senha<br />";
        erro++;
        senha = false;
    }
    
    if (validaKaptcha() == false) {
        mensagem += "Captcha<br />";
        erro++;
        captcha = false;
    }

    // se não houver erros permite cadastro no banco
    if (erro == 0) {
        return true;
    } else {
        
        if (captcha == false) {
            d.kaptcha.focus();
        }
        
        if (senha == false) {
             d.senha.focus();
        }
        
        if (email == false) {
            d.email.focus();
        }
        
        if (dataNasc == false) {
            d.dc.focus();
        }
        
        if (cpf == false) {
            d.cpf.focus();
        }
        
        
        
        
        if (nome == false) {
             d.nome.focus();
        }
        
        
        SwitchDiv(1, "erro");
        SwitchDiv(1, "erroBox");
        document.getElementById("erro").innerHTML = "ERRO ("+erro +")"+ mensagem;
        return false;
    }
}
// fim do valida form










function validaNome() {
    d = document.cadastro;
    if (d.nome.value.length < 3) {
        d.nome.style.borderColor = "red";
        return false;
    } else {
        if (!isNaN(d.nome.value)) {
            d.nome.style.borderColor = "red";
            return false;
        } else {d.nome.style.borderColor = "lime";
               return true;
        }
    }
}

function validaSenha() {
    d = document.cadastro;
    if (d.senha.value.length < 6) {
        d.senha.style.borderColor = "red";
        return false;
    } else {
        d.senha.style.borderColor = "lime";
        return true;
    }
}


function validaEmail() {
    d = document.cadastro;
    if (d.email.value == "") {
        d.email.style.borderColor = "red";
        return false;
    } else {
        parte1 = d.email.value.indexOf("@");
        parte2 = d.email.value.indexOf(".");
        parte3 = d.email.value.length;
        if (!(parte1 >= 3 && parte2 >= 6 && parte3 >= 9)) {
            d.email.style.borderColor = "red";
            return false;
        } else {
            d.email.style.borderColor = "lime";
            return true;
        }
    }
}


function validaNasc() {
    d = document.cadastro;
    if (d.dc.value == "") {
        d.dc.style.borderColor = "red";
        return false;
    } else {
        //validar data de nascimento
        hoje = new Date();
        anoAtual = hoje.getFullYear();
        barras = d.dc.value.split("/");
        if (barras.length == 3) {
            dia = barras[0];
            mes = barras[1];
            ano = barras[2];
            resultado = (!isNaN(dia) && (dia > 0) && (dia < 32)) && (!isNaN(mes) && (mes > 0) && (mes < 13)) && (!isNaN(ano) && (ano.length == 4) && (ano <= anoAtual && ano >= 1900));
            if (!resultado) {
                d.dc.style.borderColor = "red";
                return false;
            } else {
                d.dc.style.borderColor = "lime";
                return true;
            }
        } else {
            return false;
        }
    }
}


// verificacao de CPf
function validaCpf() {
    // Aqui começa a checagem do CPF
    var POSICAO, I, SOMA, DV, DV_INFORMADO;
    var DIGITO = new Array(10);
    VCPF = document.getElementById("cpf");
    var CPF = VCPF.value;
    DV_INFORMADO = CPF.substr(9, 2); // Retira os dois últimos dígitos do número informado

    // Desmembra o número do CPF na array DIGITO
    for (I=0; I<=8; I++) {
        DIGITO[I] = CPF.substr( I, 1);
    }

    // Calcula o valor do 10Âº dígito da verificação
    POSICAO = 10;
    SOMA = 0;
    for (I=0; I<=8; I++) {
        SOMA = SOMA + DIGITO[I] * POSICAO;
        POSICAO = POSICAO - 1;
    }
    DIGITO[9] = SOMA % 11;
    if (DIGITO[9] < 2) {
        DIGITO[9] = 0;
    }
    else{
        DIGITO[9] = 11 - DIGITO[9];
    }

    // Calcula o valor do 11Âº dígito da verificação
    POSICAO = 11;
    SOMA = 0;
    for (I=0; I<=9; I++) {
        SOMA = SOMA + DIGITO[I] * POSICAO;
        POSICAO = POSICAO - 1;
    }
    DIGITO[10] = SOMA % 11;
    if (DIGITO[10] < 2) {
        DIGITO[10] = 0;
    }
    else {
        DIGITO[10] = 11 - DIGITO[10];
    }

    // Verifica se os valores dos dígitos verificadores conferem
    DV = DIGITO[9] * 10 + DIGITO[10];
    if (CPF == "") {
        document.cadastro.cpf.style.borderColor = "red";
        return false;
    } else {
        if (DV != DV_INFORMADO) {
            document.cadastro.cpf.style.borderColor = "red";
            return false;
        } else {
            document.cadastro.cpf.style.borderColor = "lime";
            return true;
        }
    }
}




function validaKaptcha() {
    d = document.cadastro;
    if (d.kaptcha.value.length < 5) {
        d.kaptcha.style.borderColor = "red";
        return false;
    } else {
        if (!isNaN(d.kaptcha.value)) {
            d.kaptcha.style.borderColor = "red";
            return false;
        } else {d.kaptcha.style.borderColor = "lime";
            return true;
        }
    }
}


function validaSexo() {
    if (!d.sexo[0].checked && !d.sexo[1].checked) {
        document.getElementById('pSexo').style.border = '1px solid red';
        return false;
    } else {
        document.getElementById('pSexo').style.border = '0px solid black';
        return true;
    }
}