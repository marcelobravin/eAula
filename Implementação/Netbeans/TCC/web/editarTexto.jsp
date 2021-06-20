<%-- 
    Document   : editarTexto 
    Created on : 29/04/2012, 02:22:16
    Author     : Mark
--%>

<%@page import="Dominio.Texto"%>
<%@page import="Dominio.ExercicioVF"%>
<%@page import="Dominio.Aula"%>
<%@page import="Dominio.Exercicio"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% Texto ex = (Texto) request.getAttribute("exercicio");%> 
    <head>
        <title>EditarVF</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript" src="arquivos/autogrow.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                // inicializa conteudo
                var conteudo = "",
                    i = 0;
                    
                    i = $('li').size();
                    if (i > 2) {
                        $('input[value="Remover todos"]').removeAttr('disabled');
                        $('input[value="Remover último"]').removeAttr('disabled');
                    } else {
                        desabilitar();
                    }
                    
                    
                $('form input[value="Adicionar"]').click(function(){
                    i++;
                    conteudo = "<li>";
                    conteudo += "<input type='text' value='Alternativa"+i+"' name='alternativa[]' onClick='this.select()'>";
                    conteudo += " <input type='radio' value='"+i+"' name='resposta'>";
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

                        if (i==2) {
                            desabilitar();
                        }
                    }
                    return false;
                });



                $('form a[title="Remove essa alternativa"]').live("click", function () {
                    $(this).parent().remove();
                    i--;

                    var j = 0;
                    $('form input[type="radio"]').each(function(){
                        j++;
                        $(this).attr('value', j);
                    });

                    if (i==2) {
                        desabilitar();
                    }
                    return false;
                });


                // Desabilita botões 'remover'
                function desabilitar() {
                    $('input[value="Remover todos"]').attr('disabled', 'disabled');
                    $('input[value="Remover último"]').attr('disabled', 'disabled');
                }
            });
        </script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>AulaId: <%=request.getParameter("aulaId")%></h1>
        
            

            <div id="conteudo">
                <center>
                    
                    <h2>Editar Conteúdo</h2>
                    <form name="cadastro" action="ControleExercicio" method="post" class="conteiner">
                        
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        <input type="hidden" name="id" id="id" value="<%= ex.getId()%>" />
                    
                        
                        
                        <input type="text" value="<%= ex.getTitulo()%>" name="titulo" onClick="this.select()">
			
			<p>
                            <input type="button" value="Adicionar" />
                            <input type="button" value="Remover todos" disabled="disabled" />
                            <input type="button" value="Remover último" disabled="disabled" />
			</p>
			
			
                        <p>
                            <textarea name="texto" onClick="this.select()"><%= ex.getTexto() %></textarea>
                            <input type="text" disabled="disabled" size="1" value="255" name="caracteres">
			</p>
                    
                       
                        
                        <!-- Fim do formulario -->
                        <input type="submit" name="editarTexto" value="Atualizar" />
                        <input type="reset" value="Limpar" />             
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>