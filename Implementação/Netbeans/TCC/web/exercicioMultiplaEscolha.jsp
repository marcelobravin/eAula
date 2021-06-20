<%-- 
    Document   : exercicioMultiplaEscolha
    Created on : 14/12/2011, 17:38:30
    Author     : Mark
--%>

<%@page import="Dominio.Aula"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
    <head>
        <title>Exercício - Verdadeiro\Falso</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript" src="arquivos/autogrow.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                // inicializa conteudo
                var conteudo = "",
                    i = 2;

                $('form input[value="Adicionar"]').click(function(){
                    i++;
                    conteudo = "<li>";
                    conteudo += "<input type='text' value='Alternativa"+i+"' name='alternativa[]'>";
                    conteudo += "<input type='checkbox' name='correta[]' value='"+i+"'>";
                    conteudo += "&nbsp;";
                    conteudo += "<a href='javascript:void(0)' title='Remove essa alternativa'>X</a>";
                    conteudo += "</li>";


                    // Habilita botões 'remover'
                    if (i == 3) {
                        $('input[value="Remover todos"]').removeAttr('disabled');
                        $('input[value="Remover último"]').removeAttr('disabled');
                    }

                    $(conteudo).appendTo('form ol');
                    return false;
                });



                $('form input[value="Remover todos"]').click(function () {
                    i = 2;
                    $('li').next().next().remove();
                    desabilitar();
                    return false;
                });


                $('form input[value="Remover último"]').click(function () {
                    if (i>2) {
                        $("form ol li:last-child").remove();
                        i--;

                        if (i<=2) {
                            desabilitar();
                        }
                    }
                    return false;
                });



                $('form a[title="Remove essa alternativa"]').live("click", function () {
                    $(this).parent().remove();
                    i--;

                    if (i<=2) {
                        desabilitar();
                    }
                    return false;
                });


                // Desabilita botões 'remover'
                function desabilitar() {
                    //alert("des");
                    //$('input[value="Remover todos"]').attr('title', 'disabled');
                    $('input[value="Remover todos"]').attr('disabled', 'disabled');
                    $('input[value="Remover último"]').attr('disabled', 'disabled');
                }
            });
        </script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Criação de Exercício - Aula: <%=request.getParameter("aulaId")%></h1>
            
            <div id="conteudo">                
                <center>
                    
                    <h2>Exercício - Múltipla Escolha</h2>
                    <form name="cadastro" action="ControleExercicio" method="post" class="conteiner">
                        
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        <input type="hidden" name="provaId" id="provaId" value="<%=request.getParameter("provaId")%>" />
                         <!-- Botões do formulário -->
                        <input type="text" value="Marque a(s) resposta(s) verdadeira(s)" id="pergunta" name="pergunta">
			
			<p>
                            <input type="button" value="Adicionar" />
                            <input type="button" value="Remover todos" disabled="disabled" />
                            <input type="button" value="Remover último" disabled="disabled" />
			</p>
			
			<ol type="a">
                            <li>
                                <input type="text" value="Alternativa1" name="alternativa[]">
                                <input type="checkbox" name="correta[]" value="1">
                            </li>

                            <li>
                                <input type="text" value="Alternativa2" name="alternativa[]">
                                <input type="checkbox" name="correta[]" value="2">
                            </li>
			</ol>


                        <!-- Fim do formulario -->
                        <input type="submit" name="inserirMulti" value="Salvar" />
                        <input type="reset" value="Limpar" />
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>