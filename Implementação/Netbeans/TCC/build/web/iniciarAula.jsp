<%-- 
    Document   : iniciarAula
    Created on : 30/04/2012, 20:38:42
    Author     : Mark
--%>

<%@page import="Dominio.Progresso"%>
<%@page import="Dominio.Conteudo"%>
<%@page import="Dominio.Aula"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        Aula aula = (Aula) request.getAttribute("aula");
        Progresso pr = (Progresso) request.getAttribute("progresso");
        ArrayList<Conteudo> listaConteudo = (ArrayList<Conteudo>) request.getAttribute("lista");
    %>
    <head>
        <title>Aula: <%= aula.getTitulo()%></title>
        <%@ include file="frames/imports.jsp"%>
        <script src="arquivos/jLoadXml.js" type="text/javascript"></script>
        <script src="arquivos/jquery.js" type="text/javascript"></script>
        <style>
            .bloqueado,
            .bloqueado:hover {
                text-decoration: line-through;
                color: black;
                cursor: default;
            }
        </style>
        <script>
            $(document).ready(function () {


                // Verifica resposta
                $("form[class=conteiner]").submit(function() {

                    // Pega o valor dos inputs
                    var tipo = $('#exercicioTipo').val(),
                    id = $('#exercicioId').val(),
                    resposta;
                    
                    if (tipo == "radio") {
                        resposta = $(':radio[name=resposta]:checked').val();
                    } else if (tipo == "checkbox") {
                        resposta = 0;
                        // Mudar separador
                        resposta += ", ";
                        $(':checkbox[name=resposta[]]:checked').each(function(){
                            resposta += $(this).val();
                            // Mudar separador
                            resposta += ", ";
                        });
                    } else if (tipo == "lacuna") {
                        resposta = ""
                        $('label input:text[name=resposta[]]').each(function(){
                            resposta += $(this).val();
                            
                            // Mudar separador
                            resposta += ", ";
                        });

                    } else if (tipo == "texto" || tipo == "arquivo") {
                        //alert("texto");
                        //resposta = "";
                    } else if (tipo == "prova" || tipo == "provaEmAndamento") {
                        //alert("prova");
                    } else {
                        alert("erro na identificação do tipo de conteudo![iniciarAula65]");
                    }

                    
                    // Localiza resposta                    
                    if (tipo == "texto" || tipo == "arquivo") {
                        ProximaPagina();
                    } else if (tipo == "prova") {
                        $.post('frames/exibirProva.jsp', {tipo: tipo, id: id}, function(data) {
                            $("#correcao").html(data);
                        });
                    } else if (tipo == "provaEmAndamento") {
                        $.post('frames/exibirCorrecao.jsp', {tipo: tipo, id: id}, function(data) {
                            //$("#correcao").html(data);
                            $("#correcao").prepend(data);
                            // Timer
                            $("#content").remove();
                        });
                    } else {                        
                        $.post('frames/exibirResposta.jsp', {tipo: tipo, id: id, resposta: resposta}, function(data) {
                            $("#correcao").html(data);

                            if (data.trim() == "acertou!") {
                                ProximaPagina();
                            }
                        });
                    }
                    return false;
                });
                
                
                
                $('.paginaControle:not(.paginaAtual, .bloqueado)').live("click", function () {
                    $this = $(this);
                    
                    $('.paginaControle').each(function(){
                        $(this).removeClass('paginaAtual');
                    });
                    
                    

                    var num = parseInt($('#paginaAtual').val());

                    // Verifica qual pagina foi selecionada atraves do bot�o de controle
                    if ($this.attr('id') == "iniciar") {
                        $('#blocoControle').removeClass('invisivel');
                        num = 1;
                    } else if ($this.attr('id') == "primeira") {                        
                        num = 1;
                    } else if ($this.attr('id') == "anterior") {
                        num--;
                    } else if ($this.attr('id') == "proxima") {
                        num++;
                    } else if ($this.attr('id') == "ultima") {
                        num = <%=listaConteudo.size()%>;
                    } else {
                        num = $this.attr('id');
                    }
                    
                    
                    
                    
                    // Marca pagina atual
                    $('#' + num).addClass('paginaAtual');
                    // Marca pagina selecionada para 'proximo' e 'anterior'
                    $('#paginaAtual').val(num);

                    // Marca opcoes 'primeira' e 'anterior'
                    if (num == 1) {
                        $('#primeira').addClass('paginaAtual');
                        $('#anterior').addClass('paginaAtual');
                    }

                    // Marca opcoes 'ultima' e 'proxima'
                    // Verificar se proxima pagina está bloqueada
                    if (num == <%=listaConteudo.size()%> || <%=listaConteudo.size()%> == 0) {
                        $('#ultima').addClass('paginaAtual');
                        $('#proxima').addClass('paginaAtual');
                    }

                    


                    
                    
                    
                    // Carrega conteudo da pagina solicitada
                    loadDiv('FiltroOpcoes?pag='+num+'&aulaId='+<%= aula.getId() %>, 'palco')
                });
            });
            
            
            
            function ProximaPagina() {
                // Desabilita inputs
                $('input:radio').attr('disabled', 'disabled');
                $('input:checkbox').attr('disabled', 'disabled');
                $('label input:text').attr('disabled', 'disabled');

                $('form[class=conteiner] input:reset').attr('disabled', 'disabled');
                $('form[class=conteiner] input:submit').attr('disabled', 'disabled');

                pagina = $('#paginaAtual').val();
                pagina++;
                
                
                
                
                
                
                
                
                var x = $("#userId").val();
                if (x != "undefined") {
                    $.ajax({
                        type: "GET",

                        url: "ControleConteudo?localizar&atualizar&id=" + x +"&pagina="+(pagina-1)+"&aulaId=<%=aula.getId()%>",

                        success: function() {//response){
                            //alert("Progresso salvo no BD!"+(pagina -1));
                            //alert($("#userId").val());
                        },

                        error: function(erro) {
                            alert("Ocorreu um erro durante a requisição" + erro);
                        }
                    });
                }
                    
                
                
                
                
                
                
                
                

                // Finalizar aula
                if (pagina == <%=listaConteudo.size()%> + 1) {
                    // contabilizar utilizações da aula
                    var pan = "utilizacoes= x <a href='ControleAula?localizar&Qualificar&id=<%=aula.getId()%>' title='Clique aqui para qualificar a aula '<%=aula.getTitulo()%>'>Votar</a>";

                    $("#correcao").html(pan);
                } else {
                    $('#'+pagina).removeClass('bloqueado');
                }
            }
        </script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>

            <h1>Iniciar Aula</h1>
            


            <div id="conteudo">
                
                <center>
                    
                    <form name="cadastro" method="post" class="conteiner">
                        <h2>
                            <%= aula.getTitulo()%>
                            <input type="hidden" id="paginaAtual" value="0">
                        </h2>
                        <input type="hidden" value="<%=aula.getId()%>" name="id">
                        <div id="palco">
                            
                            <br />
                            
                            <p>Paginas: <%= listaConteudo.size() %></p>
                            <p>Progresso: <%= pr.getPosicao() %></p>
                            <p>Descrição</p>
                            <p>Requisitos</p>
                            
                            <%
                                if (pr.getPosicao() == 0) {
                                    if (aula.isRestrita()) {
                                        out.print("<label>Senha:<input type='password' /></label>");
                                        
                                    } else {
                                        out.print("<a href='javascript:void(0)' class='paginaControle' id='iniciar'>Iniciar Aula</a>");
                                    }
                                    
                                } else {
                                    out.print("<a href='javascript:void(0)' class='paginaControle' id='iniciar'>Continuar Aula</a>");
                                }
                            %>
                            
                        </div>
                    
                    
                    
                        <p class="invisivel" id="blocoControle">
                            <a href="javascript:void(0)" class="paginaControle" id="primeira">Primeira</a>
                            <a href="javascript:void(0)" class="paginaControle" id="anterior">Anterior</a>
                            <%
                                String classe = "";
                                for (int j=1; j<=listaConteudo.size(); j++) {
                                    if (j > 1) {
                                        classe = "paginaControle bloqueado";
                                    } else {
                                        classe = "paginaControle paginaAtual";
                                    }
                            %>
                            <a href="javascript:void(0)" class="<%=classe%>" id="<%= j %>"><%= j %></a>
                            <%
                                }
                            %>
                            <a href="javascript:void(0)" class="paginaControle" id="proxima">Próxima</a>
                            <a href="javascript:void(0)" class="paginaControle" id="ultima">Última</a>
                        </p>

                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>