<%-- 
    Document   : esqueciSenha
    Created on : 06/09/2012, 20:44
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <%
        // CONTROLE DE ACESSO
        Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
        
        // Verifica se usuário existe
        if (usr2 != null) {
            request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
    %>
                <jsp:forward page="loginInvalido.jsp"></jsp:forward>
    <%        
        }
    %>
    <head>
        <title>Esqueci a senha</title>
        <%@ include file="frames/imports.jsp"%>        
        <script src="arquivos/jquery_002.js"></script>
	<script type="text/javascript" src="arquivos/jValidation.js"></script>
    
    </head>
   
    <body>
         <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Esqueci a senha</h1>

            <div id="conteudo">
                
                <center>
                    
                    <form name="cadastro" action="ControleEmail" method="post" class="conteiner">
                        <fieldset>
                            <legend>Informe seu email e enviaremos sua senha</legend>
                            <p>
                                <label class="obrigatorio">
                                    Email:
                                </label>
                                <input type="text" name="email" maxlength="70" />
                            </p>
                        </fieldset>
                        
                        
                        <input type="submit" name="enviarSenha" value="Enviar" />
                        <input type="reset" value="Cancelar" />
                    </form>

                   
                </center>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>