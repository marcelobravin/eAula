<%-- 
    Document   : texto 
    Created on : 29/04/2012, 22:36:38
    Author     : Mark
--%>

<%@page import="Dominio.Aula"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
    <head>
        <title>Exercício - Verdadeiro\Falso</title>
        <%@ include file="frames/imports.jsp"%>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <div id="conteudo">
                
                <center>
                    <h1>Criação de Conteúdo - Aula: <%=request.getParameter("aulaId")%></h1>
                    <h2>Texto</h2>
                    <form name="cadastro" action="ControleExercicio" method="post" class="conteiner">
                        
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        <!-- Botões do formulário -->
                        <input type="text" value="Título" id="pergunta" name="titulo">
			
			
                        <p>
                            <textarea name="texto" onClick="this.select()"></textarea>
                            <input type="text" disabled="disabled" size="1" value="255" name="caracteres">
			</p>

                        <!-- Fim do formulario -->
                        <input type="submit" name="inserirTexto" value="Criar exercício" />
                        <input type="reset" value="Limpar" />
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>