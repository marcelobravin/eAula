<%-- 
    Document   : exibirConteudo
    Created on : 18/12/2011, 04:06:07
    Author     : Mark
--%>

<%@page import="Dominio.Arquivo"%>
<%@page import="Dominio.Prova"%>
<%@page import="Dominio.ExercicioLacunas"%>
<%@page import="Dominio.ExercicioMEscolha"%>
<%@page import="Dominio.ExercicioVF"%>
<%@page import="Dominio.Texto"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page import="Dominio.Conteudo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Recebe o conteudo
    Conteudo cont = (Conteudo) request.getAttribute("conteudo");
    DAOExercicio dao = new DAOExercicio();
    
    
    String campos = "";
    campos += "<input type='text' id='exercicioTipo' value='"+cont.getExercicioTipo()+"'>";
    campos += "<input type='text' id='exercicioId' value='"+cont.getIdExercicio()+"'>";
    out.print(campos);
    
       
    
    
    
    // Identifica o tipo de conteudo
    if (cont.getExercicioTipo().equals("texto")) {
        Texto conteudo = new Texto();
        conteudo.setId(cont.getIdExercicio());
        conteudo = dao.localizar(conteudo);
        
        out.print("<div id='correcao'></div>");
        
        out.print("<h4>"+ conteudo.getTitulo() +"</h4>");
        out.print("<p>"+ conteudo.getTexto() +"</p>");
        out.print("<input type='submit' value='Proxima' name='verificar'>");


                                           
    } else if (cont.getExercicioTipo().equals("radio")) {
        ExercicioVF conteudo = new ExercicioVF();
        conteudo.setId(cont.getIdExercicio());
        conteudo = dao.localizar(conteudo);
        
        
        
        out.print("<div id='correcao'></div>");
        out.print("<h4>"+ conteudo.getTitulo() +"</h4>");
        out.print("<p>"+ conteudo.getResposta() +"</p>");
        out.print("<ol class='letra'>");
        int i = 1;
        for (String alternativa : conteudo.getAlternativa()) {
            out.print("<li>");
            out.print("<label>");
            out.print("<input type='radio' name='resposta' value='"+i+"'>");
            out.print(alternativa);
            out.print("</label>");
            out.print("</li>");
            i++;
        }
        out.print("<input type='submit' value='Atualizar' name='verificar'>");
        out.print("<input type='reset' value='Limpar'>");
        out.print("</ol>");
        
        
        
        
        
        
        
        
        
        
    } else if (cont.getExercicioTipo().equals("arquivo")) {
        Arquivo conteudo = new Arquivo();
        conteudo.setId(cont.getIdExercicio());
        conteudo = dao.localizar(conteudo);
        
        out.print("<div id='correcao'></div>");
        
        out.print("<h4>"+ conteudo.getTitulo() +"</h4>");
        //out.print("<img src='arquivos/imagens/uploads/imagem_" + 1 + ".jpg' />");
        out.print("<img src='arquivos/imagens/uploads/"+ conteudo.getNome() +"' />");
        
        
        
        out.print("<p>"+ conteudo.getLegenda() +"</p>");
        out.print("<input type='submit' value='Proxima' name='verificar'>");
        
        
        
        
        
        
        
        
        
        
    } else if (cont.getExercicioTipo().equals("checkbox")) {
        ExercicioMEscolha conteudo = new ExercicioMEscolha();
        conteudo.setId(cont.getIdExercicio());
        conteudo = dao.localizar(conteudo);
        
        out.print("<div id='correcao'></div>");
        out.print("<h4>"+ conteudo.getTitulo() +"</h4>");
        for (boolean corretas : conteudo.getCorreta()) {
            out.print("<p>"+ corretas +"</p>");
        }
        
        
        
        out.print("<ol class='letra'>");
        int i = 1;
        for (String alternativa : conteudo.getAlternativa()) {
            out.print("<li>");
            out.print("<label>");
            out.print("<input type='checkbox' name='resposta[]' value='"+i+"'>");
            out.print(alternativa);
            out.print("</label>");
            out.print("</li>");
            i++;
        }
        out.print("<input type='submit' value='Atualizar' name='verificar'>");
        out.print("<input type='reset' value='Limpar'>");
        out.print("</ol>");
        
        
        
        
        
    } else if (cont.getExercicioTipo().equals("lacuna")) {
        ExercicioLacunas conteudo = new ExercicioLacunas();
        conteudo.setId(cont.getIdExercicio());
        conteudo = dao.localizar(conteudo);
        
        out.print("<div id='correcao'></div>");
        out.print("<h4>"+ conteudo.getTitulo() +"</h4>");
        for (String corretas : conteudo.getResposta()) {
            out.print("<p>"+ corretas +"</p>");
        }
        
        
        
        out.print("<ol class='letra'>");
        int i = 0;
        for (String alternativa : conteudo.getPreTexto()) {
            out.print("<li>");
            out.print("<label>");
            out.print(alternativa);
            out.print("<input type='text' name='resposta[]' value='"+conteudo.getResposta()[i]+"'>");
            out.print(conteudo.getPosTexto()[i]);
            out.print("</label>");
            out.print("</li>");
            i++;
        }
        out.print("<input type='submit' value='Atualizar' name='verificar'>");
        out.print("<input type='reset' value='Limpar'>");
        out.print("</ol>");
        
    } else if (cont.getExercicioTipo().equals("prova")) {
        Prova conteudo = new Prova();
        conteudo.setId(cont.getIdExercicio());
        conteudo = dao.localizar(conteudo);
        
        // Timer
        session.setAttribute("duracao", conteudo.getDuracao());
        //session.setAttribute("duracao", "0");
        
        out.print("<div id='correcao'>");
        out.print("Tempo: " + conteudo.getDuracao());
        out.print("<br />");
        out.print("Retorno: " + conteudo.getRetorno());
        out.print("<br />");
        out.print("<input type='submit' value='Iniciar Prova' name='verificar'>");
        out.print("</div>");
    } else {
        out.print("Tipo de conteúdo desconhecido!");
        %>
        <iframe width="420" height="315" src="http://www.youtube.com/embed/KT7xJ0tjB4A" frameborder="0" allowfullscreen></iframe>
        <%
    }
%>