<%-- 
    Document   : sucesso
    Created on : 29/10/2011, 23:39:22
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Sucesso</title>
        <%@ include file="frames/imports.jsp"%>
        <script language="JavaScript">
            redirTime = "1000"; // milisegundos
            
            <%
                String destino = "home.jsp";
                if (request.getAttribute("destino") != null) {
                    destino = request.getAttribute("destino").toString();
                }
            %>
            
            redirURL = "http://localhost:8084/TCC/<%=destino%>";
            function redirTimer() {
                self.setTimeout("self.location.href = redirURL;", redirTime);
            }
        </script>
    </head>
    <body onLoad="redirTimer()">
         <center>
            <div class="body">
                <div id="conteudo">
                    <h1>Sucesso</h1>
                    <strong class="conteiner">
                        <%= request.getAttribute("mensagem")%>
                    </strong>
                </div>
            </div>
        </center>
    </body>
</html>