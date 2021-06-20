<%-- 
    Document   : listaAula
    Created on : 02/11/2011, 19:03:55
    Author     : Mark
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.Aula"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%
    // Limita para 2 casas decimais
    DecimalFormat formatador = new DecimalFormat("#0.00");
    SimpleDateFormat sdf;
%>
<html>
    <head>
        <title>Pesquisa de Aula</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript" src="arquivos/jquerySort.js"></script>
        <script type="text/javascript" src="arquivos/jLoadXml.js"></script>
        <script type="text/javascript" src="arquivos/jSwitchDiv.js"></script>
        
        <script type="text/javascript" src="arquivos/jCheckAll.js"></script>
        <script type="text/javascript" src="arquivos/jPagination.js"></script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Pesquisa de Aula</h1>
            
            
            <div id="conteudo">
                <span class="pesquisaLocation">
                    <div id="toolTip1" class="pesquisa">

                        <form name="pesquisa" id="pesquisa" action="ControleAula" method="get">
                            <a class="floatRight">
                                <img src="arquivos/imagens/fechar.gif" class="iluminar" onClick="SwitchDiv(0, 'toolTip1')" alt="Fechar" title="Clique aqui para fechar a caixa de pesquisa" />
                            </a>
                            <%
                                String titulo = "";
                                if (request.getParameter("titulo") != null) {
                                    titulo = request.getParameter("titulo");
                                }
                            %>
                            <p>Título:<br /><input type="text" name="titulo" size="15" maxlength="70" value="<%=titulo%>" /></p>
                            <%
                                String autor = "";
                                if (request.getParameter("autor") != null) {
                                    autor = request.getParameter("autor");
                                }
                            %>
                            <p>Autor:<br /><input type="text" name="autor" size="15" maxlength="70" value="<%=autor%>" /></p>
                            <%
                                String areaSelected0 = "";
                                String areaSelected1 = "";
                                String areaSelected2 = "";
                                String areaSelected3 = "";
                                if (request.getParameter("area") != null) {
                                    int area = Integer.parseInt(request.getParameter("area"));

                                    if (area == 1) {
                                        areaSelected1 = "selected = 'selected'";
                                    } else if (area == 2) {
                                        areaSelected2 = "selected = 'selected'";
                                    } else if (area == 3) {
                                        areaSelected3 = "selected = 'selected'";
                                    } else {
                                        areaSelected0 = "selected = 'selected'";
                                    }
                                }
                            %>
                            <p>
                                Área:<br />
                                <select name="area">
                                    <option value="0" <%= areaSelected0 %>>Todas</option>
                                    <option value="1" <%= areaSelected1 %>>Ciências exatas</option>
                                    <option value="2" <%= areaSelected2 %>>Ciências humanas</option>
                                    <option value="3" <%= areaSelected3 %>>Ciências biomédicas</option>
                                </select>
                            </p>

                            <p>
                                <span class="gray">Matéria:</span><br />
                                <select name="materia" disabled="disabled">
                                    <option value="0">Todas</option>
                                    <option value="1">Matemática</option>
                                    <option value="2">Ciências</option>
                                    <option value="3">Geografia</option>
                                    <option value="4">História</option>
                                    <option value="5">Idioma</option>
                                    <option value="6">Informática</option>
                                    <option value="7">Arte</option>
                                </select>
                            </p>

                            <p>
                                <span class="gray">Disciplina:</span><br />
                                <select name="disciplina" disabled="disabled">
                                    <option value="0">Todas</option>
                                    <option value="1">Trigonometria</option>
                                    <option value="2">Álgebra</option>
                                    <option value="3">Geometria</option>
                                    <option value="4">Outros</option>
                                </select>
                            </p>

                            <%
                                String tipoSelected0 = "";
                                String tipoSelected1 = "";
                                String tipoSelected2 = "";
                                if (request.getParameter("tipo") != null) {
                                    int tipo = Integer.parseInt(request.getParameter("tipo"));

                                    if (tipo == 1) {
                                        tipoSelected1 = "selected = 'selected'";
                                    } else if (tipo == 2) {
                                        tipoSelected2 = "selected = 'selected'";
                                    } else {
                                        tipoSelected0 = "selected = 'selected'";
                                    }
                                }
                            %>
                            <p>
                                Categoria:<br />
                                <select name="tipo">
                                    <option value="2" <%= tipoSelected2 %>>Ambas</option>
                                    <option value="1" <%= tipoSelected1 %>>Públicas</option>
                                    <option value="0" <%= tipoSelected0 %>>Restritas</option>
                                </select>
                            </p>

                            <p>
                                Mostrar:<br />
                                <select name="mostrar">
                                    <option value="1">Todas</option>
                                    <option value="2">Iniciadas</option>
                                    <option value="3">Concluídas</option>
                                    <option value="4">Não iniciadas</option>
                                </select>
                            </p>


                            <center>
                                <input type="submit" name="pesquisar" value="Pesquisar" />
                                <input type="reset" value="Limpar" />
                            </center>
                        </form>
                    </div>
                </span>


                <table>
                    <caption class="botoesPesquisa">
                        <span class="floatLeft">
                            <a onClick="SwitchDiv(1, 'toolTip1')" title="Clique aqui para refinar os critérios de busca" >Critérios de pesquisa</a>
                            <%
                                ArrayList<Aula> listaAula = (ArrayList<Aula>) request.getAttribute("resultado");
                                int j = 0;
                                for (Aula aula : listaAula) {
                                   j++;
                                }
                            %>
                        </span>
                        <%@ include file="frames/select_paginacao.jsp"%>
                    
                    
                    </caption>
































                

                    <thead>
                        <tr>
                            <td class="invisivel">&nbsp;</td>
                            <th class="invisivel"><a href="javascript:void(0)">Id</a></th>
                            <th><a href="javascript:void(0)">Título</a></th>
                            <th><a href="javascript:void(0)">Descrição</a></th>
                            <th><a href="javascript:void(0)">Autor</a></th>
                            <th><a href="javascript:void(0)">Disciplina</a></th>
                            
                            <th><a href="javascript:void(0)">Restrita</a></th>
                            <th class="invisivel"><a href="javascript:void(0)">Senha</a></th>
                            <th><a href="javascript:void(0)">Utilizações</a></th>
                            <th><a href="javascript:void(0)">Votos</a></th>
                            <th><a href="javascript:void(0)">Nota</a></th>
                            <th class="invisivel"><a href="javascript:void(0)">Conclusões</a></th>
                            <th class="invisivel"><a href="javascript:void(0)">Aprovação</a></th>
                            <th><a href="javascript:void(0)">Criação</a></th>
                            <th><a href="javascript:void(0)">Atualizaçao</a></th>
                            <!--<td>Opções</td>-->
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
                            for (Aula aula : listaAula) {
                        %>

                        <td class="invisivel">&nbsp;</td>
                        <td class="invisivel"><%= aula.getId()%></td>
                        <td>
                            <a href="ControleAula?localizar&Iniciar&id=<%=aula.getId()%>" title='Clique aqui para iniciar a aula "<%=aula.getTitulo()%>"'>
                                <%= aula.getTitulo()%>
                            </a>                            
                        </td>
                        <td><%= aula.getDescricao()%></td>
                        <td><a href="ControleMensagem?preparar&para=<%=aula.getIdAutor()%>" title='Clique aqui para enviar uma mensagem para "<%=aula.getIdAutor()%>"'><%= aula.getIdAutor()%></a></td>
                        <td><%= aula.getIdDisciplina()%></td>
                        
                        <td><%= aula.isRestrita()%></td>
                        <td class="invisivel"><%= aula.getSenha()%></td>
                        <td><%= aula.getUtilizacoes()%></td>
                        <td>
                            <a href="ControleAula?localizar&Qualificar&id=<%=aula.getId()%>" title='Clique aqui para qualificar a aula "<%=aula.getTitulo()%>"'>
                                <%= aula.getVotos()%>
                            </a>
                            
                        </td>
                        <td>
                            
                            <img src="arquivos/imagens/estrela<%= aula.getMedia() / aula.getVotos() %>.gif" title="Total: <%= aula.getMedia() %> Média: <%= formatador.format((double) aula.getMedia() / aula.getVotos()) %>">
                        </td>
                        <td class="invisivel"><%= aula.getConclusoes()%></td>
                        <td class="invisivel"><%= aula.isAprovacao()%></td>
                        
                        <% sdf = new SimpleDateFormat("dd/MM/yyyy");%>
                        <td><%= sdf.format(aula.getDataCriacao())%></td>
                        <% sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm");%>
                        <td><%= sdf.format(aula.getDataAtualizacao())%></td>
                        <!--
                        <td>
                            <a href="ControleAula?localizar&Iniciar&id=<%=aula.getId()%>" title='Clique aqui para iniciar a aula "<%=aula.getTitulo()%>"'>
                                <input type="button" value="Iniciar">
                            </a>
                            <a href="ControleAula?localizar&Qualificar&id=<%=aula.getId()%>" title='Clique aqui para qualificar a aula "<%=aula.getTitulo()%>"'>
                                <input type="button" value="Qualificar">
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
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>