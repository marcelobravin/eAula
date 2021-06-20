<%-- 
    Document   : userInfo
    Created on : 21/12/2011, 16:40:20
    Author     : Mark
--%>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
<title>Server Variable in JSP</title>
</head>


    <body>
    Character Encoding : <b><%=request.getCharacterEncoding()%></b><br />

    Context Path : <strong><%=request.getContextPath()%></strong><br />

    Path Info : <strong><%=request.getPathInfo()%></strong><br />

    Protocol with version: <strong><%=request.getProtocol()%></strong><br />

    Absolute Path file:<b><%=request.getRealPath("serverVariable.jsp")%></b><br/>

    Client Address in form of IP Address:<b><%=request.getRemoteAddr()%></b><br/>

    Client Host : <strong><%=request.getRemoteHost()%></strong><br />

    URI : <strong><%=request.getRequestURI()%></strong><br />

    Scheme in form of protocol : <strong><%=request.getScheme()%></strong><br />

    Server Name : <strong><%=request.getServerName()%></strong><br />

    Server Port no : <strong><%=request.getServerPort()%></strong><br />

    Servlet path current File name : <b><%=request.getServletPath()%></b><br />

    Remote User : <b><%=request.getRemoteUser() %></b><br />

</body>
</html>