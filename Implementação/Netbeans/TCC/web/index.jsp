<%-- 
    Document   : home
    Created on : 19/11/2011, 20:12:57
    Author     : Mark
--%>

<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Home</title>
        <%@ include file="frames/imports.jsp"%>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Bemvindo</h1>
            <div id="conteudo">
                <%
                    // Se a sessão estiver vazia apresenta opção de login
                    if (usr == null) {
                %>

                    <div id="Professor" class="floatRight">
                        <h4>Professor</h4>
                        Ensine o que quiser!
                        <hr />
                        Criar aulas é fácil
                        <hr />
                        Adicione exercícios e publique suas aulas<br />
                        <hr />
                        Receba feedback de seu método de ensino
                    </div>



                    <div id="Estudante">
                        <h4>Estudante</h4>
                        Aprenda no seu ritmo
                        <hr />
                        Pratique a vontade com exercícios interativos
                        <hr />
                        Aprenda o que quiser e quando quiser
                        <hr />
                        Avalie as aulas e ajude a melhorar a qualidade de ensino
                    </div>

                <%
                    }
                    // Se a sessão estiver aberta apresenta tipo de usuário e opção de logout
                    else {
                %>
                            
                
                <%
                    //Estabelece opções conforme permissões de acesso
                    //opções de professor
                box = "";
                            switch(usr.getPrivilegios()) {
                                case 1:
                                    
                                    box += "Estudante";
                                break;
                                
                                case 2:
                                     box += "Professor";
                                break;
                                
                                case 3:
                                    box += "Administrador";
                                break;
                            }
                    
                    /*
                    if (acesso.endsWith("2")) {
                        box += "Professor";                      
                    }
                    //opções de estudante
                    else if (acesso.endsWith("1")) {
                        box += "Estudante";
                    }//opções de administrador
                    else if (acesso.endsWith("3")) {
                        box += "Administrador";
                    }
 */ 
                %>
                        
                         
                        
                    <center>
                        <div id="<%= box %>">
                            <h4><%= box %></h4>
                            mostrar aulas recomendadas, mensagens, listas, agnda anotações, correções, avisos
                            <hr />
                            top 10 aulas, top 10 usuarios
                            <hr />
                            <a href="MontaSql" >Testar sqlGenerator"</a>
                            <hr />
                            <a href="userInfo.jsp">Testar UserInfo</a>
                            <hr />
                            <a href="zUploadForm_1.jsp">Testar file upload</a>
                            <hr />
                            <a href="zMail.jsp">Mail</a>
                        </div>
                    </center>
                <%
                    }
                %>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>