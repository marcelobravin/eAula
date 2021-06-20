<%-- 
    Document   : mensagem
    Created on : 13/09/2012, 02:18:40
    Author     : Mark
--%>

<%@page import="Dominio.Mensagem"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
    <%
        // CONTROLE DE ACESSO
        // Pega usuario na sessão
        Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
        if (usr2 == null) {
        //if (null != null) {
            request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
            %>
                <jsp:forward page="loginInvalido.jsp"></jsp:forward>
            <%
        }
        
        // Pega usuario no request
        Mensagem mssg = (Mensagem) request.getAttribute("mensagem");
    %>
    <head>
        <title>Mensagem</title>
        <%@ include file="frames/imports.jsp"%>        
        <script src="arquivos/jquery_002.js"></script>
	<script type="text/javascript" src="arquivos/jValidation.js"></script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <div id="conteudo">
                
                <center>
                    <h1>Mensagem</h1>
                    
                    <form name="cadastro" action="ControleMensagem" method="post" class="conteiner">
                        <h2><%= mssg.getDestinatario().getNome() %></h2>
                        <input type="hidden" name="alvoId" value="<%= mssg.getDestinatario().getId() %>" />
                        <p>
                            
                            
                            
                            <%
                                // Mostra imagem de avatar conforme sexo do destinatario
                                if (mssg.getDestinatario().getSexo()) {
                                    out.print("<img class='obrigatorio' src='arquivos/imagens/avatar_masculino.png' />");
                                } else {
                                    out.print("<img class='obrigatorio' src='arquivos/imagens/avatar_feminino.png' />");
                                }
                            %>
                            
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