<%-- 
    Document   : exibirProva
    Created on : 29/08/2012, 15:03:22
    Author     : Mark
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Dominio.Conteudo"%>
<%@page import="Persistencia.DAOConteudo"%>
<%@page import="Dominio.ExercicioLacunas"%>
<%@page import="Dominio.ExercicioMEscolha"%>
<%@page import="Dominio.ExercicioVF"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<ol>
<%
    String tipo = "";
    int id = Integer.parseInt(request.getParameter("id"));
    
    // Timer
    String dura = session.getAttribute("duracao").toString();
    int horas = 0, minutos = 0;
    if (!dura.equals("0")) {
        int duracao = Integer.parseInt(dura);
        

        if (duracao < 60) {
            minutos = duracao;
        } else {
            horas = duracao / 60;
            minutos = duracao % 60;
        }
    }
    
    // PASSAR PARA CONTROLE
    // Recupera conteudo da prova
    DAOConteudo daoCont = new DAOConteudo();
    ArrayList<Conteudo> lista = new ArrayList<Conteudo>();
    lista = daoCont.listarCP(id);
    
    
    
    // Itera pelo conteudo
    for (Conteudo cont : lista) {
        tipo = cont.getExercicioTipo();
        id = cont.getIdExercicio();
        DAOExercicio dao = new DAOExercicio();
        out.print("<li>");
      
        
        
        if (tipo.equalsIgnoreCase("radio")) {
            //out.print("radio" + id);
            ExercicioVF conteudo = new ExercicioVF();
            conteudo.setId(id);
            conteudo = dao.localizar(conteudo);

            out.print("<h6>"+ conteudo.getTitulo() +"</h6>");
            //out.print("<p>"+ conteudo.getResposta() +"</p>");
            out.print("<ol class='letra'>");
            int i = 1;
            for (String alternativa : conteudo.getAlternativa()) {
                out.print("<li>");
                out.print("<label>");
                out.print("<input type='radio' name='resposta"+conteudo.getId()+"' value='"+i+"'>");
                out.print(alternativa);
                out.print("</label>");
                out.print("</li>");
                i++;
            }
            out.print("</ol>");
        } else if (tipo.equalsIgnoreCase("checkbox")) {
            //out.print("check" + id);
            ExercicioMEscolha conteudo = new ExercicioMEscolha();
            conteudo.setId(cont.getIdExercicio());
            conteudo = dao.localizar(conteudo);

            //out.print("<div id='correcao'></div>");
            out.print("<h6>"+ conteudo.getTitulo() +"</h6>");
            /*
            for (boolean corretas : conteudo.getCorreta()) {
                out.print("<p>"+ corretas +"</p>");
            }
 */ 



            out.print("<ol class='letra'>");
            int i = 1;
            for (String alternativa : conteudo.getAlternativa()) {
                out.print("<li>");
                out.print("<label>");
                out.print("<input type='checkbox' name='resposta"+conteudo.getId()+"[]' value='"+i+"'>");
                out.print(alternativa);
                out.print("</label>");
                out.print("</li>");
                i++;
            }
            out.print("</ol>");
        } else if (tipo.equalsIgnoreCase("lacuna")) {
             ExercicioLacunas conteudo = new ExercicioLacunas();
            conteudo.setId(cont.getIdExercicio());
            conteudo = dao.localizar(conteudo);

            //out.print("<div id='correcao'></div>");
            out.print("<h6>"+ conteudo.getTitulo() +"</h6>");
            /*
            for (String corretas : conteudo.getResposta()) {
                out.print("<p>"+ corretas +"</p>");
            }
 */ 



            out.print("<ol class='letra'>");
            int i = 0;
            for (String alternativa : conteudo.getPreTexto()) {
                out.print("<li>");
                out.print("<label>");
                out.print(alternativa);
                out.print("<input type='text' name='resposta"+conteudo.getId()+"[]' value='"+conteudo.getResposta()[i]+"'>");
                out.print(conteudo.getPosTexto()[i]);
                out.print("</label>");
                out.print("</li>");
                i++;
            }
            out.print("</ol>");
        }
        
        //out.print("<br />");
        
        
        
        
        
        
        
        
        
        
        
        
        
        //mssg += "<br />";
         out.print("</li>");
    }
    
    
    
    
    
    
    /*
    String mssg = "";
    mssg += "";
    out.print(mssg);
 * */
%>

</ol>
<p>
    <input type='submit' value='Atualizar' name='verificar'>
    <input type='reset' value='Limpar'>
</p>

<script>
    $('#exercicioTipo').val('provaEmAndamento');
</script>



<!--TIMER---------------------------------------------------------------------->
<%
    if (!dura.equals("0")) {
%>


<div id="content">
    <span id="timer"></span>
    <script type="text/javascript" src="arquivos/jquery.chrony.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#timer').chrony({
                hour: <%= horas %>,
                minute	: <%= minutos %>,
                second	: 0,
                displayHours: true,
                displayMinutes: true,
                displaySeconds: true,
                blink: true,
                finish: function() {
                    $(this).html('');
                    alert("Fim da prova");
                    $("form[class=conteiner]").submit();
                }
            });
        });
    </script>
</div>
<%
    }
%>