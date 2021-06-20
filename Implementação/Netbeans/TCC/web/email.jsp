<%-- 
    Document   : mensagem
    Created on : 13/09/2012, 02:18:40
    Author     : Mark
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
    <%
        // CONTROLE DE ACESSO
        Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
        
        // Verifica se usuário existe
        if (usr2 == null) {
            request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
    %>
                <jsp:forward page="loginInvalido.jsp"></jsp:forward>
    <%
        }
            
        // Verifica permissão de acesso
        if (usr2.getPrivilegios() < 3) {
            request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!<br />Sua permissão: " + usr2.getPrivilegios());
    %>
            <jsp:forward page="loginInvalido.jsp"></jsp:forward>
    <%
        }
                
        // Pega usuario no request
        ArrayList<Usuario> lista = (ArrayList<Usuario>) request.getAttribute("listaUsuario");
    %>
    <head>
        <title>Email</title>
        <%@ include file="frames/imports.jsp"%>        
        <script src="arquivos/jquery_002.js"></script>
	<script type="text/javascript" src="arquivos/jValidation.js"></script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <div id="conteudo">
                
                <center>
                    <h1>Email</h1>
                    
                    <form name="cadastro" action="ControleEmail" method="post" class="conteiner">
                        <h2>
                            <%= lista.size() %>
                        </h2>
                        
                        
                        <%
                            //String x = "";
                            //int y = 0;
                            for (Usuario dst : lista) {
                                //x += dst.getId();
                                //y++;
                                //if (y < lista.size()) {
                                  //  x += ",";
                                //}
                                %>
                                    <input type="text" name="ids[]" value="<%= dst.getId() %>">
                                <%
                                
                            }
                        %>
                        
                        
                        
                        <p>
                            <label class="">
                                Para:
                            </label>
                            <input type="text" name="destinatarios" maxlength="70" />
                        </p>
                        
                        <p>
                            <label class="obrigatorio">
                                Assunto:
                            </label>
                            <input type="text" name="assunto" maxlength="70" />
                        </p>
                        
                        <p>                            
                            <textarea name="texto" onClick="this.select()"></textarea>
			</p>

                        <!-- Fim do formulario -->
                        <p>
                            <input type="submit" name="enviar" value="Enviar" />
                            <input type="reset" value="Limpar" />
                        </p>
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>