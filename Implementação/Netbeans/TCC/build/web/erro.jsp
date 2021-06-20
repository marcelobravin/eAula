<%-- 
    Document   : erro
    Created on : 29/10/2011, 23:40:10
    Author     : Mark
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page language="java" import="java.io.*" isErrorPage="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Erro</title>
        <%@ include file="frames/imports.jsp"%>
    </head>
    <body>
        <strong>
            <h1>Erro</h1>
            <font color="red">
                Houve um erro durante o processo!<br />
                Contate o administrador do sistema e informe a seguinte mensagem de erro:<br />
                
                <p>Exception: <%= request.getAttribute("erro").toString() %></p>
                
                Message : <%= ((Exception)request.getAttribute("erro")).getMessage() %>
            </font>
        </strong>
    </body>
</html>
