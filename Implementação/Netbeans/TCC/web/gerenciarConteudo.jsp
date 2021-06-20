<%-- 
    Document   : gerenciar conteudo
    Created on : 14/12/2011, 17:34:56
    Author     : Mark
--%>

<%@page import="Dominio.Arquivo"%>
<%@page import="Dominio.Prova"%>
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
    <%
        Aula aula = (Aula) request.getAttribute("aula");
        ArrayList<Conteudo> listaConteudo = (ArrayList<Conteudo>) request.getAttribute("lista");
    %>
    <head>
        <title>Gerenciar Conteudo</title>
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
                    } else if ($this.parent().hasClass('arquivo')) {
                        classe = "arquivo";
                    } else if ($this.parent().hasClass('prova')) {
                        classe = "prova";
                    }
                    
                    alert("Excluindo: "+ classe +", nº:" + id);
                    
                    $.ajax({
                        type: "GET",
                        url: "ControleConteudo?localizar&excluir&id=" + id + "&tipo=" + classe +"&aulaId=<%=aula.getId()%>",

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
                
                
                
                
                // Mover
                $(".mover").click(function() {
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
                    } else if ($this.parent().hasClass('arquivo')) {
                        classe = "arquivo";
                    } else if ($this.parent().hasClass('prova')) {
                        classe = "prova";
                    }
                    
                    if ($this.hasClass('cima')) {
                        direcao = "cima";
                    } else {
                        direcao = "baixo";
                    }
                    
                    //alert("Movendo: "+ classe +", nº:" + id + " para "+ direcao);

                    $.ajax({
                        type: "GET",
                        url: "ControleConteudo?localizar&mover&id=" + id + "&tipo=" + classe +"&aulaId=<%=aula.getId()%>&direcao="+direcao,

                        success: function(){//response){
                            location.reload();
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
                    } else if ($this.parent().hasClass('arquivo')) {
                        classe = "arquivo";
                    } else if ($this.parent().hasClass('prova')) {
                        classe = "prova";
                    }
                    
                    $.ajax({
                        type: "GET",
                        // referenciar aula
                        url: "ControleExercicio?localizar&Editar&id=" + id + "&tipo=" + classe,

                        success: function() {//response){
                            //var url = "ControleExercicio?localizar&Editar&id=" + id + "&tipo=" + classe+ "&aulaId=" + < % =aula.getId()%>;
                            var url = "ControleExercicio?localizar&id=" + id + "&tipo=" + classe+ "&aulaId=" + <%=aula.getId()%>;
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
            <h1>Gerenciar Conteúdo</h1>



            <div id="conteudo">
                <center>
                    
                    <h2><%= aula.getTitulo()%></h2>

                    <p>
                        <a href="texto.jsp?aulaId=<%=aula.getId()%>">Texto</a>
                        <a href="zUploadForm.jsp?aulaId=<%=aula.getId()%>">Arquivo(Imagem/Audio/Video)</a>
                    </p>

                    <p>
                        <a href="exercicioVF.jsp?aulaId=<%=aula.getId()%>" title="Clique aqui para criar exercício">Verdadeiro/Falso</a>
                        <a href="exercicioMultiplaEscolha.jsp?aulaId=<%=aula.getId()%>">Múltipla Escolha</a>
                        <a href="exercicioLacunas.jsp?aulaId=<%=aula.getId()%>">Preencher Lacunas</a>
                        Exercicio dissertativo
                    </p>

                    <p>
                        
                        <a href="criarProva.jsp?aulaId=<%=aula.getId()%>">Prova</a>
                        
                        Redação
                    </p>



                    <%
                        int j = 0;
                        int r = 1;
                        String mssg = "";
                        mssg += "<form name='cadastro' action='ControleExercicio' method='post' class='conteiner' onsubmit='return deleteManager.checkBeforeSubmit()'>";
                        mssg += "<h2># exercicios: " + listaConteudo.size() + "</h2>";
                        mssg += "<input id='aulaId' type='hidden' value='" + aula.getId() + "' name='aulaId'>";
                        mssg += "<ol>";
                        out.print(mssg);


                        if (listaConteudo.size() == 0) {
                            out.print("Não há conteúdo cadastrado");
                        }


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
                            
                            
                            
                            
                            
                            
                            
                            
                            // TEXTO
                            //==================================================
                            if (cont.getExercicioTipo().equals("arquivo")) {

                                DAOExercicio dao = new DAOExercicio();
                                Arquivo exercicio = new Arquivo();
                                exercicio.setId(cont.getIdExercicio());

                                Arquivo ex = new Arquivo();
                                ex = dao.localizar(exercicio);
                                
                                
                                mssg += " id='" + ex.getId() + "' class='arquivo'>";
                                mssg += "<h6>";
                                mssg += "Imagem";
                                mssg += "</h6>";
                                if (ex.getTitulo() != null) {
                                    mssg += "<h5>";
                                    mssg += ex.getTitulo();
                                    mssg += "</h5>";
                                }                                
                                
                                
                                //mssg += "<img src='arquivos/imagens/uploads/imagem_";
                                //mssg += 1;
                                //mssg += ".jpg' />";
                                
                                mssg += "<img src='arquivos/imagens/uploads/thumb"+ ex.getNome() +"' />";
                                
                                
                                
                                if (ex.getLegenda() != null) {
                                    mssg += "<h5>";
                                    mssg += ex.getLegenda();
                                    mssg += "</h5>";
                                } else {
                                    mssg += "<br />";
                                }
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            // TEXTO
                            //==================================================
                            if (cont.getExercicioTipo().equals("prova")) {

                                DAOExercicio dao = new DAOExercicio();
                                Prova exercicio = new Prova();
                                exercicio.setId(cont.getIdExercicio());

                                Prova ex = new Prova();
                                ex = dao.localizar(exercicio);

                                mssg += " id='" + ex.getId() + "' class='prova'>";

                                mssg += "<h6>";
                                //mssg += ex.getTitulo();
                                mssg += "Prova";                                
                                mssg += "</h6>";
                                
                                mssg += "<p>Duracao: "+ex.getDuracao()+"</p>";
                                mssg += "<p>Retorno: "+ex.getRetorno()+"</p>";
                                mssg += "<p>Random: "+ex.isRandomOrder()+"</p>";
                                mssg += "<p>#exercicios:</p>";
                            }
                            
                            
                            
                            






                            mssg += "<input class='editar' type='button' value='Editar'>";
                            if (j > 1) {
                                //mssg += "<input class='mover cima' type='button' value='Mover pra cima'>";
                                mssg += "<a class='mover cima' title='Clique aqui para mover esse conteúdo para cima'></a>";
                            }
                            
                            if (j < listaConteudo.size()) {
                                //mssg += "<input class='mover baixo' type='button' value='Mover pra baixo'>";
                                mssg += "<a class='mover baixo' title='Clique aqui para mover esse conteúdo para baixo'></a>";
                            }
                            mssg += "<input class='excluir delete-button' type='button' value='Excluir'>";


                            mssg += "<hr />";
                            mssg += "</li>";

                            ////////////////////////////////////////////////////
                            out.print(mssg);

                        }

                        out.print("</ol>");
                    %>




                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>