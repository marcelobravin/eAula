<%-- 
    Document   : editarProva --> gerenciar conteudo
    Created on : 23/08/2012, 21:15:19
    Author     : Mark
--%>


<%@page import="Dominio.Texto"%>
<%@page import="Dominio.ExercicioLacunas"%>
<%@page import="Dominio.ExercicioMEscolha"%>
<%@page import="Dominio.ExercicioVF"%>
<%@page import="Dominio.Conteudo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Persistencia.DAOConteudo"%>
<%@page import="Dominio.Prova"%>
<%@page import="Dominio.Aula"%>
<%@page import="Dominio.Exercicio"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <% Prova ex1 = (Prova) request.getAttribute("exercicio");%>
    <% 
        Aula aula = (Aula) request.getAttribute("aula");
        DAOConteudo dao1 = new DAOConteudo();
        ArrayList<Conteudo> listaConteudo = dao1.listarCP(ex1.getId());
    
    %>
    
    <head>
        <title>Gerenciar Prova</title>
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
                        url: "ControleConteudo?localizar&excluir&id=" + id + "&tipo=" + classe +"&aulaId=<%=ex1.getId()%>&conteudoProva",

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

                        success: function() {//response){
                            //var url = "ControleExercicio?localizar&Editar&id=" + id + "&tipo=" + classe+ "&aulaId=" + < % =aula.getId()%>;
                            //var url = "ControleExercicio?localizar&id=" + id + "&tipo=" + classe+ "&aulaId=" + < %=aula.getId()%>;
                            //var url = "ControleExercicio?localizar&id=" + id + "&tipo=" + classe;
                            var url = "ControleExercicio?localizar&id=" + id + "&tipo=" + classe+"&aulaId=<%=request.getParameter("aulaId")%>&provaConteudo&provaId=<%= ex1.getId()%>";
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
            <h1>AulaId: <%=request.getParameter("aulaId")%></h1>
        
            

            <div id="conteudo">
                <center>       
                    <h2>Gerenciar Prova</h2>
                     <p>
                        <a href="exercicioVF.jsp?aulaId=<%=request.getParameter("aulaId")%>&provaId=<%= ex1.getId()%>" title="Clique aqui para criar exercício">Verdadeiro/Falso</a>
                        <a href="exercicioMultiplaEscolha.jsp?aulaId=<%=request.getParameter("aulaId")%>&provaId=<%= ex1.getId()%>">Múltipla Escolha</a>
                        <a href="exercicioLacunas.jsp?aulaId=<%=request.getParameter("aulaId")%>&provaId=<%= ex1.getId()%>">Preencher Lacunas</a>
                    </p>
                        
                    <%
                        int j = 0;
                        int r = 1;
                        String mssg = "# exercicios: " + listaConteudo.size();

                        out.print(mssg);

                        if (listaConteudo.size() == 0) {
                            out.print("Não há conteúdo cadastrado");
                        }
                    %>
                    
                    
                    <form name="cadastro" action="ControleExercicio" method="post" class="conteiner">
                        
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        <input type="hidden" name="id" id="id" value="<%= ex1.getId()%>" />
                    
                        <p>Tempo:<input type="text" value="<%= ex1.getDuracao()%>" name="duracao" /></p>
                        <p>Retry:<input type="text" value="<%= ex1.getRetorno()%>" name="retry" /></p>
                        <p>RandomOrder:<input type="checkbox" name="randomOrder"><%= ex1.isRandomOrder() %></p>
			
                        
                        <!-- Fim do formulario -->
                        <input type="submit" name="editarProva" value="Atualizar" />
                        <input type="reset" value="Limpar" />          
                        
                        
                        
                        
                        <hr />
                        
                         
                       
			
                        
                        
                        <ol type="a">
                            <%
                            

                            for (Conteudo cont : listaConteudo) {
                                mssg = "";

                                // li é fechado dentro do conteudo
                                mssg += "<li";
                                j++;

                                // RADIO
                                //==================================================
                                if (cont.getExercicioTipo().equals("radio")) {
                                    r = 1;


                                    DAOExercicio dao = new DAOExercicio();
                                    ExercicioVF exercicio = new ExercicioVF();
                                    exercicio.setId(cont.getIdExercicio());

                                    ExercicioVF ex = new ExercicioVF();
                                    ex = dao.localizar(exercicio);

                                    mssg += " id='" + ex.getId() + "' class='radio'>";

                                    mssg += "<h6>";
                                    mssg += ex.getTitulo();
                                    mssg += "</h6>";


                                    mssg += "<ol class='letra'>";
                                    for (String sentenca : ex.getAlternativa()) {
                                        mssg += "<li>";
                                        mssg += "<label>";
                                        mssg += "<input disabled='disabled' name='alternativa" + ex.getId() + "' type='radio' value='" + r + "'";
                                        if (ex.getResposta() == r) {
                                            mssg += " checked='checked'";
                                        }
                                        mssg += ">";
                                        mssg += sentenca;
                                        mssg += "</label>";


                                        r++;
                                        mssg += "</li>";


                                    }
                                    mssg += "</ol>";
                                }










                                // CHECKBOX
                                //==================================================
                                if (cont.getExercicioTipo().equals("checkbox")) {

                                    r = 0;

                                    DAOExercicio dao = new DAOExercicio();
                                    ExercicioMEscolha exercicio = new ExercicioMEscolha();
                                    exercicio.setId(cont.getIdExercicio());

                                    ExercicioMEscolha ex = new ExercicioMEscolha();
                                    ex = dao.localizar(exercicio);



                                    mssg += " id='" + ex.getId() + "' class='checkbox'>";

                                    mssg += "<h6>";
                                    mssg += ex.getTitulo();
                                    mssg += "</h6>";


                                    mssg += "<ol class='letra' id='" + ex.getId() + "'>";
                                    for (String sentenca : ex.getAlternativa()) {
                                        mssg += "<li>";

                                        mssg += "<label>";
                                        mssg += "<input disabled='disabled' name='alternativa" + ex.getId() + "' type='checkbox' value=''";
                                        if (ex.getCorreta()[r]) {
                                            mssg += " checked='checked'";
                                        }
                                        mssg += ">";
                                        mssg += sentenca;
                                        mssg += "</label>";


                                        mssg += "</li>";
                                        r++;
                                    }

                                    mssg += "</ol>";
                                }













                                // LACUNAS
                                //==================================================
                                if (cont.getExercicioTipo().equals("lacuna")) {
                                    r = 0;

                                    DAOExercicio dao = new DAOExercicio();
                                    ExercicioLacunas exercicio = new ExercicioLacunas();
                                    exercicio.setId(cont.getIdExercicio());

                                    ExercicioLacunas ex = new ExercicioLacunas();
                                    ex = dao.localizar(exercicio);


                                    String[] preTexto = ex.getPreTexto();

                                    String[] posTexto = ex.getPosTexto();

                                    mssg += " id='" + ex.getId() + "' class='lacuna'>";

                                    mssg += "<h6>";
                                    mssg += ex.getTitulo();
                                    mssg += "</h6>";

                                    mssg += "<ol class='letra' id='" + ex.getId() + "'>";
                                    for (String sentenca : ex.getResposta()) {
                                        mssg += "<li>";

                                        mssg += "<label>";
                                        mssg += preTexto[r];
                                        mssg += " <input disabled='disabled' name='alternativa" + ex.getId() + "' type='text' value='" + sentenca + "'> ";
                                        mssg += posTexto[r];
                                        mssg += "</label>";

                                        mssg += "</li>";
                                        r++;
                                    }
                                    mssg += "</ol>";
                                }



















                                // TEXTO
                                //==================================================
                                if (cont.getExercicioTipo().equals("texto")) {

                                    DAOExercicio dao = new DAOExercicio();
                                    Texto exercicio = new Texto();
                                    exercicio.setId(cont.getIdExercicio());

                                    Texto ex = new Texto();
                                    ex = dao.localizar(exercicio);

                                    mssg += " id='" + ex.getId() + "' class='texto'>";

                                    mssg += "<h6>";
                                    mssg += ex.getTitulo();
                                    mssg += "</h6>";

                                    mssg += ex.getTexto();
                                    mssg += "<br />";
                                }

























                                mssg += "<input class='editar' type='button' value='Editar'>";
                                mssg += "<input class='excluir delete-button' type='button' value='Excluir'>";


                                mssg += "<hr />";
                                mssg += "</li>";

                                ////////////////////////////////////////////////////
                                out.print(mssg);

                            }


                        %>
                    </ol>
                       
                        
                         
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>