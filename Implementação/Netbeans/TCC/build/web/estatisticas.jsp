<%-- 
    Document   : estatisticas
    Created on : 22/12/2011, 20:36:29
    Author     : Mark
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>

<%@page import="Persistencia.DAOUsuario"%>
<%@page import="Persistencia.DAOAula"%>
<%@page import="Dominio.ObjectDomain"%>
<%@page import="Dominio.Aula"%>
<%@page import="Dominio.Usuario"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Home</title>
        <%@ include file="frames/imports.jsp"%>
        <link rel="stylesheet" type="text/css" href="arquivos/pie_chart.css" />
        <script type="text/javascript" src="arquivos/pieChart.js"></script>
        <%
            // Limita para 2 casas decimais
            DecimalFormat formatador = new DecimalFormat("#0.00");
        %>
        <style>
            .barraAula {
                background-color: orange;
            }
            
            .barraUsuario {
                background-color: green;
            }
            
            .barraAula, .barraUsuario {
                height: 29px;
                border: 1px solid black;
                
                background-image: url(arquivos/imagens/sidebar_barra.png);
                -moz-border-radius-topleft: 7px;
                -moz-border-radius-bottomleft: 0px;
                -moz-border-radius-topright: 7px;
                -moz-border-radius-bottomright: 7px;
                
            }
        </style>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Estatísticas</h1>

            <div id="conteudo">
                                
                
                
                <%
                // Instancia DAO e solicita lista de aulas
                DAOAula dao = new DAOAula();
                ArrayList<ObjectDomain> listaAula = dao.listar();

                // Inicializa variáveis de estatísticas
                int totalAulas = 0;
                int publicAulas = 0;
                int restritAulas = 0;


                // Contabiliza aulas e elementos a serem calculados
                for (ObjectDomain aula : listaAula) {
                    totalAulas++;
                    Aula aulaX = (Aula) aula;
                    if(aulaX.isRestrita()) {
                        publicAulas++;
                    } else {
                        restritAulas++;
                    }
                }

                // Contabiliza porcentagem dos elementos a serem exibidos
                float porcentagemPubl = (float) publicAulas / totalAulas * 100;
                float porcentagemRest = (float) restritAulas / totalAulas * 100;
            %>
            <div>
                <h2>Aulas</h2>
                <div class="barraAula" style="width: 100%">
                    Disponíveis: <%= totalAulas %>
                </div>

                Restritas: <%= publicAulas %>
                <div class="barraAula" style="width: <%= porcentagemPubl %>%">
                    <%= formatador.format(porcentagemPubl) %>%
                </div>

                Públicas: <%= restritAulas %>
                <div class="barraAula" style="width: <%= porcentagemRest %>%">
                    <%= formatador.format(porcentagemRest) %>%
                </div>
            </div>







            <hr />
            <%
                // Instancia DAO e solicita lista de usuarios
                DAOUsuario userDao = new DAOUsuario();
                ArrayList<ObjectDomain> listaUsuario = userDao.listar();

                // Inicializa variáveis de estatísticas
                int totalUsuarios = 0;
                int estudantes = 0;
                int professores = 0;
                int administradores = 0;

                // Contabiliza usuarios e elementos a serem calculados
                for (ObjectDomain aula : listaUsuario) {
                    totalUsuarios++;
                    Usuario aulaX = (Usuario) aula;
                    if(aulaX.getPrivilegios() == 1) {
                        estudantes++;
                    } else if(aulaX.getPrivilegios() == 2) {
                        professores++;
                    } else {
                        administradores++;
                    }
                }




                // Contabiliza porcentagem dos elementos a serem exibidos
                float porcentagemEst = (float) estudantes / totalUsuarios * 100;
                float porcentagemProf = (float) professores / totalUsuarios * 100;
                float porcentagemAdm = (float) administradores / totalUsuarios * 100;




            %>


            <div>
                <h2>Usuários</h2>
                <div class="barraUsuario" style="width: 100%">
                    Total: <%= totalUsuarios %><br />
                </div>

                Professores: <%= professores %>
                <div class="barraUsuario" style="width: <%= porcentagemProf %>%">
                    <%= formatador.format(porcentagemProf) %>%
                </div>

                Estudantes: <%= estudantes %>
                <div class="barraUsuario" style="width: <%= porcentagemEst %>%">
                    <%= formatador.format(porcentagemEst) %>%
                </div>
                
                Administradores <%= administradores %>
                <div class="barraUsuario" style="width: <%= porcentagemAdm %>%">
                    <%= formatador.format(porcentagemAdm) %>%
                </div>
            </div>
            
            
            
            
            
            
            
                <table class="pieChart">
                    <tr>
                        <th>Aulas</th>
                        <th>Quantidade</th>
                        <th>Porcentagem</th>
                    </tr>
                    <tr>
                        <td>Públicas</td>
                        <td><%= publicAulas %></td>
                        <td><%= formatador.format(porcentagemPubl) %>%</td>
                    </tr>
                    <tr>
                        <td>Restritas</td>
                        <td><%= restritAulas %></td>
                        <td><%= formatador.format(porcentagemRest) %>%</td>
                    </tr>
                </table>
                    
                    
                    
                <!--// Tabela de usuários-->
                <table class="pieChart">
                    <tr><th>Usuários</th>
                        <th>Quantidade</th>
                        <th>Porcentagem</th>
                    </tr>
                    <tr>
                        <td>Estudantes</td>
                        <td><%= estudantes %></td>
                        <td><%= formatador.format(porcentagemEst) %>%</td>
                    </tr>
                    <tr>
                        <td>Professores</td>
                        <td><%= professores %></td>
                        <td><%= formatador.format(porcentagemProf) %>%</td>
                    </tr>
                    
                    <tr>
                        <td>Administradores</td>
                        <td><%= administradores %></td>
                        <td><%= formatador.format(porcentagemAdm) %>%</td>
                    </tr>
                </table>
            
            
            
            
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>