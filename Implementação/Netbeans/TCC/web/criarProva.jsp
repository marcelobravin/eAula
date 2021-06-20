<%-- 
    Document   : criarProva
    Created on : 23/08/2012, 00:34:21
    Author     : Mark
--%>


<%@page import="Dominio.Texto"%>
<%@page import="Dominio.ExercicioLacunas"%>
<%@page import="Dominio.ExercicioMEscolha"%>
<%@page import="Dominio.ExercicioVF"%>
<%@page import="Dominio.Conteudo"%>
<%@page import="Dominio.Aula"%>
<%@page import="Dominio.Exercicio"%>
<%@page import="Persistencia.DAOConteudo"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Incluir Conteudo</title>
        <%@ include file="frames/imports.jsp"%>

        <script type="text/javascript" src="arquivos/jquery.js"></script>


        <script type="text/javascript">
            $(document).ready(function() {

                //$(".excluir").on('click',function() {
                $(".excluir").click(function() {
                    var $this = $(this),
                    classe = "",
                    id = $this.parent().attr('id');
                    
                    if ($this.parent().hasClass('radio')) {
                        classe = "radio";
                    } else if ($this.parent().hasClass('checkbox')) {
                        classe = "checkbox";
                    } else if ($this.parent().hasClass('lacuna')) {
                        classe = "lacuna";
                    } else if ($this.parent().hasClass('texto')) {
                        classe = "texto";
                    }
                    
                    
                    
                    alert("Excluindo: "+ classe +", nº:"+id);
                    
                    

                    $.ajax({
                        type: "GET",
                        url: "ControleConteudo?localizar&Excluir&id=" + id + "&tipo=" + classe,

                        success: function(){//response){
                            $this.parent().remove();
                            // Exibe mensagem de lista vazia
                            if ($("ol").find("li").size() == 0) {
                                $('form').append("Não há conteúdo cadastrado!");
                            };
                        },

                        error: function(erro){
                            alert("Ocorreu um erro durante a requisição" + erro);
                        }
                    });
                    return false;
                });
                
                
                
                
                
                
                
                
                
                
                
                //$(".excluir").on('click',function() {
                $(".editar").click(function() {
                
                    var $this = $(this),
                    classe = "",
                    id = $this.parent().attr('id');
                    
                    if ($this.parent().hasClass('radio')) {
                        classe = "radio";
                    } else if ($this.parent().hasClass('checkbox')) {
                        classe = "checkbox";
                    } else if ($this.parent().hasClass('lacuna')) {
                        classe = "lacuna";
                    } else if ($this.parent().hasClass('texto')) {
                        classe = "texto";
                    }
                    
                    
                    

                    $.ajax({
                        type: "GET",
                        // referenciar aula
                        url: "ControleExercicio?localizar&Editar&id=" + id + "&tipo=" + classe,

                        success: function(){//response){
                            var url = "ControleExercicio?localizar&Editar&id=" + id + "&tipo=" + classe+ "&aulaId=" + <%//=aula.getId()%>;
                            $(window.location).attr('href',url);
                        },

                        error: function(erro){
                            alert("Ocorreu um erro durante a requisição" + erro);
                        }
                    });
                });
                
                
                
            });						
        </script>

    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Criação de Prova</h1>



            <div id="conteudo">
                <center>
                    
                    




                    
                    
                    <form name="cadastro" action="ControleExercicio" method="post" class="conteiner" style="width:65%">
                        
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        
                        transform em lable
                        <p>Tempo:<input type="text" value="0" name="duracao" /></p>
                        <p>Retry:<input type="text" value="0" name="retry" /></p>
                        <p>RandomOrder:<input type="checkbox" name="randomOrder"></p>
                        


                        <!-- Fim do formulario -->
                        <input type="submit" name="inserirProva" value="Salvar" />
                        <input type="reset" value="Limpar" />
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>