<%-- 
    Document   : loginInvalido
    Created on : 27/11/2011, 23:14:17
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Acesso Negado</title>
        <%@ include file="frames/imports.jsp"%>
        <script language="JavaScript">
            redirTime = "1000";
            redirURL = "http://localhost:8084/TCC/home.jsp";
            function redirTimer() { self.setTimeout("self.location.href = redirURL;",redirTime); }
        </script>
    </head>
    <body onLoad="redirTimer()">
        <h1>Acesso Negado</h1>
        <strong><%= request.getAttribute("mensagem")%></strong>
    </body>
</html>
