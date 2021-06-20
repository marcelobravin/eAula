<%-- 
    Document   : editarVF
    Created on : 21/04/2012, 16:52:15
    Author     : Mark
--%>

<%@page import="Dominio.ExercicioMEscolha"%>
<%@page import="Dominio.Aula"%>
<%@page import="Dominio.Exercicio"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        //Aula aula = (Aula) request.getAttribute("aula");
        //Aula aula = new Aula();
        //aula.setTitulo("tt");
        //aula.setId(13);
    %>
    <% ExercicioMEscolha ex = (ExercicioMEscolha) request.getAttribute("exercicio");%>
    
    <head>
        <title>Editar ExercicioMEscolha</title>
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
                    conteudo += "<input type='text' value='Alternativa"+i+"' name='alternativa[]'>";
                    conteudo += "<input type='checkbox' name='correta[]' value='"+i+"'>";
                    conteudo += "&nbsp;";
                    conteudo += "<a href='javascript:void(0)' title='Remove essa alternativa'>X</a>";
                    conteudo += "</li>";


                    // Habilita botões 'remover'
                    if (i > 2) {
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
                    if (i > 2) {
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
                    $('input[value="Remover todos"]').attr('disabled', 'disabled');
                    $('input[value="Remover último"]').attr('disabled', 'disabled');
                }
            });
        </script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Aula Id: <%=request.getParameter("aulaId")%></h1>
        
            

            <div id="conteudo">
                <center>
                    
                    <h2>Editar Conteúdo</h2>
                    <%
                        String dest = "";
                        if (request.getParameter("provaConteudo") != null) {
                            dest = "?provaConteudo&prova="+request.getParameter("provaId");
                        }
                    %>
                    
                    <form name="cadastro" action="ControleExercicio<%=dest%>" method="post" class="conteiner">
                        
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        <input type="hidden" name="id" id="id" value="<%= ex.getId()%>" />
                    
                        
                        
                        <input type="text" value="<%= ex.getTitulo()%>" id="pergunta" name="pergunta" onClick="this.select()">
			
			<p>
                            <input type="button" value="Adicionar" />
                            <input type="button" value="Remover todos" disabled="disabled" />
                            <input type="button" value="Remover último" disabled="disabled" />
			</p>
			
			
			<ol type="a">
                            
                            
                            <%
                                String mssg = "";
                                int i = 0;
                                //boolean[] corretas = new boolean[3];
                                //corretas = ex.getCorreta();
                                
                                for (String alternativa : ex.getAlternativa()) {
                                    mssg += "<li>";
                                    mssg += "<input type='text' value='"+alternativa+"' name='alternativa[]' onClick='this.select()'>";
                                    mssg += "<input type='checkbox' name='correta[]' value='"+(i+1)+"'";
                                    
                                    if (ex.getCorreta()[i] == true) {
                                        mssg += " checked='checked'";
                                    }
                                    mssg += ">";
                                    
                                    if (i > 1) {
                                        mssg += "<a href='javascript:void(0)' title='Remove essa alternativa'>X</a>";
                                    }
                                    
                                    
                                    mssg += "</li>";
                                    i++;
                                }
                            %>
                            
                            <%= mssg %>
			</ol>
                    
                       
                        
                        <!-- Fim do formulario -->
                        <input type="submit" name="editarMEscolha" value="Atualizar" />
                        <input type="reset" value="Limpar" />             
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>