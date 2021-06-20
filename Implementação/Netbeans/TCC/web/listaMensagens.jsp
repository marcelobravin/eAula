<%-- 
    Document   : lista
    Created on : 13/09/2012, 17:11:43
    Author     : Mark
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Dominio.Mensagem"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.Usuario"%>

<html>
<%
    // Limita para 2 casas decimais
    //DecimalFormat formatador = new DecimalFormat("#0.00");
    SimpleDateFormat sdf;
%>
    <head>
        <title>Mensagens</title>
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
                if (usr2.getPrivilegios() < 1) {
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
            <h1>Mensagens</h1>
            
            
       

            <div id="conteudo">
                
                

                <form action="ControleMensagem" method="post" onsubmit="return deleteManager.checkBeforeSubmit();">
                    <table>
                        <caption class="botoesPesquisa">
                            <span class="floatLeft">

                                <input type="submit" class="delete-button" name="excluir" value="Excluir" title="Clique aqui para excluir as mensagens selecionadas" />



                                <input type="hidden" id="ids2Delete" value="" />

                                <%
                                    ArrayList<Mensagem> lista = (ArrayList<Mensagem>) request.getAttribute("resultado");
                                    int j = lista.size();
                                %>
                            </span>
                            <%@ include file="frames/select_paginacao.jsp"%>
                        </caption>

                    
                        <thead>
                            <tr>
                                <td class="th"><input type="checkbox" id="checkAll" onClick="javascript:void(0)"/></td>
                                <th><a href="javascript:void(0)">Id</a></th>
                                <th><a href="javascript:void(0)">Remetente</a></th>
                                <th><a href="javascript:void(0)">Conteudo</a></th>
                                <th><a href="javascript:void(0)">Data</a></th>
                                
                                <!--<td class="th">Opções</td>-->
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
                                for (Mensagem mssg : lista) {
                            %>

                                <td><input type="checkbox" name="id" value="<%= mssg.getId()%>" /></td>
                                <td><%= mssg.getId()%></td>
                                <td>
                                    <a href="ControleMensagem?preparar&para=<%= mssg.getRemetente().getId() %>" title='Clique aqui para enviar uma mensagem para "<%=mssg.getRemetente().getNome() %>"'>
                                        <%= mssg.getRemetente().getNome() %>
                                    </a>
                                    <td><%= mssg.getConteudo() %></td>
                                    
                                     <% sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm");%>
                                    <td><%= sdf.format(mssg.getData_hora())%></td>
                                </td>
                                    
                                
                                <!--

                                <td>
                                    <a href="ControleUsuario?localizarPorID=Atualizar&id=< %=usuario.getId()%>" title='Clique aqui para editar o usuário "< %=usuario.getNome()%>"'>
                                        <input type="button" value="Atualizar">
                                    </a>
                                </td>
                                -->
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