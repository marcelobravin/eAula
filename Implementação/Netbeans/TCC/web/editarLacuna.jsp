<%-- 
    Document   : editarVF
    Created on : 22/04/2012, 15:47:58 
    Author     : Mark
--%>

<%@page import="Dominio.ExercicioLacunas"%>
<%@page import="Dominio.Aula"%>
<%@page import="Dominio.Exercicio"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        //Aula aula = (Aula) request.getAttribute("aula");<<<<<<<<<<<<<<<<<<<<<<<<<<<<3
        //Aula aula = new Aula();
        //aula.setTitulo("TESTE");
        //aula.setId(13);
    %>
    <% ExercicioLacunas ex = (ExercicioLacunas) request.getAttribute("exercicio");%>
    
    <head>
        <title>Editar ExercicioLacuna</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript" src="arquivos/autogrow.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                // inicializa conteudo
                var conteudo = "",
                    i = 0;
                    
                    i = $('li').size();
                    if (i > 1) {
                        $('input[value="Remover todos"]').removeAttr('disabled');
                        $('input[value="Remover último"]').removeAttr('disabled');
                    } else {
                        desabilitar();
                    }
                    
                    
                 $('form input[value="Adicionar"]').click(function(){
                    i++;
                    conteudo = "<li>";
                    conteudo += "<input type='text' value='Pré-texto"+i+"' name='pre_texto[]' onClick='this.select()'>";
                    conteudo += "&nbsp;";
                    conteudo += "<input type='text' value='resposta"+i+"' name='resposta[]' onClick='this.select()'>";
                    conteudo += "&nbsp;";
                    conteudo += "<input type='text' value='Pós-texto"+i+"' name='pos_texto[]' onClick='this.select()'>";
                    conteudo += "&nbsp;";
                    conteudo += "<a href='javascript:void(0)' title='Remove essa alternativa'>X</a>";
                    conteudo += "</li>";


                    // Habilita botões 'remover'
                    if (i == 2) {
                        $('input[value="Remover todos"]').removeAttr('disabled');
                        $('input[value="Remover último"]').removeAttr('disabled');
                    }

                    $(conteudo).appendTo('form ol');
                    return false;
                });



                $('form input[value="Remover todos"]').click(function () {
                    i = 1;
                    $('li').next().remove();
                    desabilitar();
                    return false;
                });


                $('form input[value="Remover último"]').click(function () {
                    if (i>=1) {
                        $("form ol li:last-child").remove();
                        i--;

                        if (i==1) {
                            desabilitar();
                        }
                    }
                    return false;
                });



                $('form a[title="Remove essa alternativa"]').live("click", function () {
                    $(this).parent().remove();
                    i--;
                    if (i==1) {
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
                                
                                for (String alternativa : ex.getPreTexto()) {
                                    mssg += "<li>";
                                    //mssg += alternativa;
                                    
                                    mssg += "<input type='text' value='"+alternativa+"' name='pre_texto[]' onClick='this.select()'>";
                                    mssg += "<input type='text' value='"+ex.getResposta()[i]+"' name='resposta[]' onClick='this.select()'>";
                                    mssg += "<input type='text' value='"+ex.getPosTexto()[i]+"' name='pos_texto[]' onClick='this.select()'>";
                                    
                                    //mssg += "<input type='text' value='"+ex.getResposta()[i]+"' name='alternativa[]' onClick='this.select()'>";
                                    //mssg += ex.getPosTexto()[i];
                                    
                                    if (i >= 1) {
                                        mssg += "<a href='javascript:void(0)' title='Remove essa alternativa'>X</a>";
                                    }
                                    
                                    mssg += "</li>";
                                    i++;
                                }
                            %>
                            
                            <%= mssg %>
			</ol>
                    
                       
                        
                        <!-- Fim do formulario -->
                        <input type="submit" name="editarLacuna" value="Atualizar" />
                        <input type="reset" value="Limpar" />             
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>