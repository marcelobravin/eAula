<%-- 
    Document   : qualificarAula
    Created on : 02/12/2011, 19:31:41
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.Aula"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Qualificar Aula</title>
        <%@ include file="frames/imports.jsp"%>
        <%
            Aula aula = (Aula) request.getAttribute("aula");
            // CONTROLE DE ACESSO
            Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
            if (usr2 == null) {
                request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
        %>
            <jsp:forward page="loginInvalido.jsp"></jsp:forward>
        <%
            }
        %>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Qualificar aula</h1>
            
            

            <div id="conteudo">
                <center>
                    
                    <form action="ControleAula" method="post" class="conteiner">
                        
                        <input type="hidden" name="id" id="id" value="<%=aula.getId()%>" />
                        <h2>
                            <%=aula.getTitulo()%>
                        </h2>

                        Vote<br />
                        <input type="radio" name="nota" value="1" id="nota" title="Muito ruim" />1
                        <input type="radio" name="nota" value="2" id="nota" title="Ruim" />2
                        <input type="radio" name="nota" value="3" id="nota" title="Regular" checked="checked"/>3
                        <input type="radio" name="nota" value="4" id="nota" title="Boa" />4
                        <input type="radio" name="nota" value="5" id="nota" title="Muito boa" />5
                        <br />
                        
                        <input type="submit" name="votar" value="Qualificar aula">
                        <a href="ControleAula?listar">
                            <input type="button" class="delete-button" value="Não qualificar">
                        </a>

                        <%
                            if (usr.getPrivilegios() == 3) {
                                out.print("<p><input type='checkbox' value='xxx' title='Ótima' />Aprovado por administrador</p>");
                            }
                        %>
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>