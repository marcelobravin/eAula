<%-- 
    Document   : listaUsuario
    Created on : 30/10/2011, 00:02:09
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.Usuario"%>

<html>
    <head>
        <title>Usuários</title>
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
            <h1>Usuários</h1>
            
            
       

            <div id="conteudo">
                
                

                <form action="ControleUsuario" method="post" onsubmit="return deleteManager.checkBeforeSubmit();">
                    <table>
                        <caption class="botoesPesquisa">
                            <span class="floatLeft">

                                <input type="submit" class="delete-button" name="excluir" value="Excluir" title="Clique aqui para excluir os usuários selecionados" />
                                <input type="submit" name="email" value="Enviar email" title="Clique aqui para enviar um email para os usuários selecionados" />



                                <input type="hidden" id="ids2Delete" value="" />

                                <%
                                    ArrayList<Usuario> listaUsuario = (ArrayList<Usuario>) request.getAttribute("resultado");
                                    int j = listaUsuario.size();
                                %>
                            </span>
                            <%@ include file="frames/select_paginacao.jsp"%>
                        </caption>

                    
                        <thead>
                            <tr>
                                <td class="th"><input type="checkbox" id="checkAll" onClick="javascript:void(0)"/></td>
                                <th><a href="javascript:void(0)">Id</a></th>
                                <th><a href="javascript:void(0)">Nome</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Cpf</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Email</a></th>
                                <th><a href="javascript:void(0)">Escolaridade</a></th>
                                <th><a href="javascript:void(0)">Senha</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Profissão</a></th>
                                <th><a href="javascript:void(0)">Privilégios</a></th>
                                <th><a href="javascript:void(0)">Sexo</a></th>
                                <th><a href="javascript:void(0)">Nascimento</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Endereço</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Cidade</a></th>
                                <th><a href="javascript:void(0)">Uf</a></th>
                                <th class="invisivel"><a href="javascript:void(0)">Cep</a></th>
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
                                for (Usuario usuario : listaUsuario) {
                            %>

                                <td><input type="checkbox" name="id" value="<%= usuario.getId()%>" /></td>

                                <td>
                                    <a href="ControleUsuario?localizarPorID=Atualizar&id=<%=usuario.getId()%>" title='Clique aqui para editar o usuário "<%=usuario.getNome()%>"'>
                                        <%= usuario.getId()%>
                                    </a>
                                </td>
                                    
                                <td>
                                    <a href="ControleMensagem?preparar&para=<%= usuario.getId()%>" title='Clique aqui para enviar uma mensagem para "<%=usuario.getNome()%>"'>
                                        <%= usuario.getNome()%>
                                    </a>
                                </td>
                                <td class="invisivel"><%= usuario.getCpf()%></td>
                                <td class="invisivel"><%= usuario.getEmail()%></td>
                                <td><%= usuario.getEscolaridade()%></td>
                                <td><%= usuario.getSenha()%></td>
                                <td class="invisivel"><%= usuario.getProfissao()%></td>
                                <td><%= usuario.getPrivilegios()%></td>
                                <td><%= usuario.getSexo()%></td>
                                <td><%= usuario.getDataNascimento()%></td>
                                <td class="invisivel"><%= usuario.getEnd().getIdTipoLogradouro()%>: <%= usuario.getEnd().getLogradouro()%>, <%= usuario.getEnd().getNumero()%></td>
                                <td class="invisivel"><%= usuario.getEnd().getIdCidade()%></td>
                                <td><%= usuario.getEnd().getIdUf()%></td>
                                <td class="invisivel"><%= usuario.getEnd().getCep()%></td>
                                

                                <td>
                                    <a 
                                        <input type="button" value="Atualizar">
                                    </a>
                                        
                                        
                                        
                                <a class="atualizar" href="ControleUsuario?localizarPorID=Atualizar&id=<%=usuario.getId()%>" title='Clique aqui para editar o usuário "<%=usuario.getNome()%>"'></a>
                                <a class="mensagem" href="ControleMensagem?preparar&para=<%= usuario.getId()%>" title='Clique aqui para enviar uma mensagem para "<%=usuario.getNome()%>"'></a>
                                <a class="email" href="ControleUsuario?email&id=<%= usuario.getId()%>" title='Clique aqui para enviar um email para "<%=usuario.getNome()%>"'></a>
                                <a class="deletar" href="ControleUsuario?excluir&id=<%=usuario.getId()%>" title='Clique aqui para excluir o usuário "<%=usuario.getNome()%>"' alt="Excluir"></a>
                                
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