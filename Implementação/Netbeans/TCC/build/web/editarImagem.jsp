<%-- 
    Document   : editarTexto 
    Created on : 08/09/2012, 22:22:23
    Author     : Mark
--%>

<%@page import="Dominio.Arquivo"%>
<%@page import="Dominio.Aula"%>
<%@page import="Dominio.Exercicio"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% Arquivo ex = (Arquivo) request.getAttribute("exercicio");%> 
    <head>
        <title>Editar Imagem</title>
        <%@ include file="frames/imports.jsp"%>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>AulaId: <%=request.getParameter("aulaId")%></h1>
        
            

            <div id="conteudo">
                <center>
                    
                    <h2>Editar Imagem</h2>
                    <form name="cadastro" action="ControleExercicio" method="post" class="conteiner">
                        
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        <input type="hidden" name="id" id="id" value="<%= ex.getId()%>" />
                    
                        
                        
                        <p>
                            <label>
                                Título:
                            </label>
                            <input type="text" value="<%= ex.getTitulo()%>" name="titulo" onClick="this.select()">
                        </p>

        
                        <p>
                            <label class="obrigatorio">
                                Imagem:
                            </label>                            
                            <!--img src="arquivos/imagens/uploads/imagem_1.jpg" /-->
                            <img src="arquivos/imagens/uploads/<%= ex.getNome() %>" />
			</p>
                        
                        <p>
                            <label>
                                Legenda:
                            </label>
                            <input type="text" value="<%= ex.getLegenda()%>" name="legenda" onClick="this.select()">
                        </p>
                        
                        
                        
			
			
			
                    
                       
                        
                        <!-- Fim do formulario -->
                        <input type="submit" name="editarImagem" value="Atualizar" />
                        <input type="reset" value="Limpar" />             
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>