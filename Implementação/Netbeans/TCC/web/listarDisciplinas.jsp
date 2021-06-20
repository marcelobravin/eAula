<%-- 
    Document   : listaDisciplina
    Created on : 30/10/2011, 00:02:09
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.Disciplina"%>

<html>
    <head>
        <title>Disciplinas</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/checkBeforeSubmit.js"></script>
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript" src="arquivos/jquerySort.js"></script>
        <script type="text/javascript" src="arquivos/jCheckAll.js"></script>
        <script type="text/javascript" src="arquivos/jPagination.js"></script>
    </head>
    <body>
        <%
            // CONTROLE DE ACESSO
            Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
            if (usr2 != null) {
                if (usr2.getPrivilegios() < 3) {
                    request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!<br />Sua permissão: " + usr2.getPrivilegios());
        %>
                    <jsp:forward page="loginInvalido.jsp"></jsp:forward>
        <%
               }
            } else {
                request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
                %>
                    <jsp:forward page="loginInvalido.jsp"></jsp:forward>
                <%
            }
        %>
         <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Disciplinas</h1>
            
            
            
       

            <div id="conteudo">
                

                <form action="ControleDisc" method="post" onsubmit="return deleteManager.checkBeforeSubmit();">
                    <table>

                        <caption class="botoesPesquisa">
                            <span class="floatLeft">
                                <input type="submit" class="delete-button" name="excluir" value="Excluir" title="Clique aqui para excluir os usuários selecionados" />
                                <input type="hidden" id="ids2Delete" value="" />

                                <%
                                    ArrayList<Disciplina> listaDisciplina = (ArrayList<Disciplina>) request.getAttribute("resultado");
                                    int j = listaDisciplina.size();
                                %>
                            </span>
                            
                            <%@ include file="frames/select_paginacao.jsp"%>                        
                        </caption>

                    
                        <thead>
                            <tr>
                                <td class="th"><input type="checkbox" id="checkAll" onClick="javascript:void(0)"/></td>
                                <th><a href="javascript:void(0)">Id</a></th>
                                <th><a href="javascript:void(0)">Nome</a></th>
                                <th><a href="javascript:void(0)">Descrição</a></th>
                                <th><a href="javascript:void(0)">Matéria</a></th>
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
                                for (Disciplina disciplina : listaDisciplina) {      
                            %>

                                <td><input type="checkbox" name="id" value="<%= disciplina.getId()%>" /></td>

                                <td><%= disciplina.getId()%></td>
                                <td><%= disciplina.getNome()%></td>
                                <td><%= disciplina.getDescricao()%></td>
                                <td><%= disciplina.getIdMateria() %></td>

                                <td>
                                    <a class="atualizar" href="ControleDisc?localizar&id=<%=disciplina.getId()%>" title='Clique aqui para editar a disciplina "<%=disciplina.getNome()%>"'></a>
                                    <a class="deletar" href="ControleDisc?excluir&id=<%=disciplina.getId()%>" title='Clique aqui para excluir a disciplina "<%=disciplina.getNome()%>"' alt="Excluir"></a>
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