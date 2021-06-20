<%-- 
    Document   : minhasAulas
    Created on : 03/11/2011, 20:34:43
    Author     : Mark
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Dominio.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@page import="Persistencia.DAOAula"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.Aula"%>
<%
    // Limita para 2 casas decimais
    DecimalFormat formatador = new DecimalFormat("#0.00");
%>
<html>
    <head>
        <title>Minhas aulas</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/checkBeforeSubmit.js"></script>
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript" src="arquivos/jquerySort.js"></script>
        <script type="text/javascript" src="arquivos/jCheckAll.js"></script>
        <script type="text/javascript" src="arquivos/jLoadXml.js"></script>
        <script type="text/javascript" src="arquivos/jPagination.js"></script>
    </head>
    <body>
        <%
            // CONTROLE DE ACESSO
            //pega o nome de usuário que está registrado na sessão
            Usuario autor = (Usuario) request.getSession().getAttribute("user");
            if (autor != null) {
                if (autor.getPrivilegios() <= 1) {            
                request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!<br />Sua permissão: " + session.getAttribute("privilegios"));
        %>
	<jsp:forward page="loginInvalido.jsp"></jsp:forward>
        <%
               }
            }
             

            // instancia DAOAula e chama método listaMinhasAulas
            DAOAula aulaDAO = new DAOAula();
            ArrayList<Aula> listaAula = aulaDAO.listarMinhasAulas(autor.getId());
        %>
        
        
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Minhas aulas</h1>
            
            <div id="conteudo">
                

                <form action="ControleAula" method="get" onsubmit="return deleteManager.checkBeforeSubmit();">

                    

                    <table>
                        <caption class="botoesPesquisa">
                            
                            <span class="floatLeft">
                                <input type="submit" class="delete-button" name="excluir" value="Excluir" title="Clique aqui para excluir as aulas selecionadas" />
                                <input type="hidden" id="ids2Delete" value="" />
                                
                                <% int j = listaAula.size(); %>
                            </span>
                            
                            
                            <%@ include file="frames/select_paginacao.jsp"%>
                        
                        </caption>
                        <thead>
                            <tr>
                                <td class="th"><input type="checkbox" id="checkAll" onClick="javascript:void(0)"/></td>
                                <th class="invisivel"><a href="javascript:void(0)">Id</a></th>
                                <th><a href="javascript:void(0)">Título</a></th>
                                <th><a href="javascript:void(0)">Descrição</a></th>
                                <th><a href="javascript:void(0)">Disciplina</a></th>
                                <th><a href="javascript:void(0)">Restrita</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Senha</a></th>
                                <th><a href="javascript:void(0)">Utilizações</a></th>
                                <th><a href="javascript:void(0)">Votos</a></th>
                                <th><a href="javascript:void(0)">Média</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Conclusões</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Aprovação</a></th>
                                <th><a href="javascript:void(0)">Criação</a></th>
                                <th><a href="javascript:void(0)">Atualizacao</a></th>
                                <td class="th">Opções</td>
                            </tr>
                        </thead>
                        <tbody>
                        <script type="text/javascript">


                            // reordena tabela por th clicado
                            var th = jQuery('th'),
                            li = jQuery('li'),
                            inverse = false;

                            th.click(function(){
                                // descolore todas linhas de tabela
                                //$("tr").removeClass("impar");
                                deszebrar();

                                var header = $(this),
                                index = header.index();

                                header
                                .closest('table')
                                .find('td')
                                .filter(function(){
                                    return $(this).index() === index;
                                })
                                .sort(function(a, b){

                                    a = $(a).text();
                                    b = $(b).text();

                                    return (
                                    isNaN(a) || isNaN(b) ?
                                        a > b : +a > +b
                                ) ?
                                        inverse ? -1 : 1 :
                                        inverse ? 1 : -1;
                                }, function(){
                                    return this.parentNode;
                                });
                                inverse = !inverse;
                                
                                // Recolore linha impares
                                zebrar();
                            });
                        </script>




                        <%
                            // Cria zebramento de tabela
                            for (Aula aula : listaAula) {
                        %>

                            <td><input type="checkbox" name="id" value="<%= aula.getId()%>" /></td>

                            <td class="invisivel"><%= aula.getId()%></td>
                            <td><%= aula.getTitulo()%></td>
                            <td><%= aula.getDescricao()%></td>
                            <td><%= aula.getIdDisciplina()%></td>
                            <td><%= aula.isRestrita()%></td>
                            <td class="invisivel"><%= aula.getSenha()%></td>
                            <td><%= aula.getUtilizacoes()%></td>
                            <td><%= aula.getVotos()%></td>
                            <td><%= aula.getMedia() %> / <%= formatador.format((double) aula.getMedia() / aula.getVotos()) %></td>
                            <td class="invisivel"><%= aula.getConclusoes()%></td>
                            <td class="invisivel"><%= aula.isAprovacao()%></td>
                            <td>
                                <% SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); %>
                                <%= sdf.format(aula.getDataCriacao())%>
                            </td>
                            <td>
                                <% sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss"); %>
                                <%= sdf.format(aula.getDataAtualizacao())%>
                                </td>

                            <td>
                                <!--a href="ControleAula?localizar&Atualizar&id=<%=aula.getId()%>" title='Clique aqui para editar a aula "<%=aula.getTitulo()%>"'>
                                    <input type="button" value="Atualizar">
                                </a>

                                <a href="ControleAula?localizar&Incluir&id=<%=aula.getId()%>" title='Clique aqui para gerenciar o conteúdo da aula "<%=aula.getTitulo()%>"'>
                                    <input type="button" value="Conteúdo">
                                </a-->
                                    
                                    
                                <a class="atualizar" href="ControleAula?localizar&Atualizar&id=<%=aula.getId()%>" title='Clique aqui para editar a aula "<%=aula.getTitulo()%>"'></a>
                                <a class="conteudo" href="ControleAula?localizar&Incluir&id=<%=aula.getId()%>" title='Clique aqui para gerenciar o conteúdo da aula "<%=aula.getTitulo()%>"'></a>
                                <a class="deletar" href="ControleAula?excluir&id=<%=aula.getId()%>" title='Clique aqui para excluir a aula "<%=aula.getTitulo()%>"' alt="Excluir"></a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                        
                        
                        <tfoot>
                            <tr class="pan">
                                <td colspan="15">
                                    
                                    <a href="javascript:void(0)" class="paginaControle" id="primeira">Primeira</a>
                                    <a href="javascript:void(0)" class="paginaControle" id="anterior">Anterior</a>

                                    <span class="paginas">paginas</span>

                                    <a href="javascript:void(0)" class="paginaControle" id="proxima">Próxima</a>
                                    <a href="javascript:void(0)" class="paginaControle" id="ultima">Última</a>
                                </td>
                            </tr>
                        </tfoot>
                        
                    </table>
                </form>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>