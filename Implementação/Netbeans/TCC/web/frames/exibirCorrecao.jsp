<%-- 
    Document   : exibirCorrecao
    Created on : 30/08/2012, 00:31:58
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


<%
    String tipo = "";
    int id = Integer.parseInt(request.getParameter("id"));
    
    
    // Recupera conteudo da prova
    DAOConteudo daoCont = new DAOConteudo();
    ArrayList<Conteudo> lista = new ArrayList<Conteudo>();
    lista = daoCont.listarCP(id);
    
    
    
    int exercicios = -1;
    for (Conteudo cont : lista) {
        //exercicios++;
        
        tipo = cont.getExercicioTipo();
        id = cont.getIdExercicio();
        DAOExercicio dao = new DAOExercicio();
      
        
        
        if (tipo.equalsIgnoreCase("radio")) {
            ExercicioVF conteudo = new ExercicioVF();
            conteudo.setId(id);
            conteudo = dao.localizar(conteudo);
            
            //out.print("<span id='correta'>");
            //out.print(conteudo.getResposta());
            //out.print("</span>");
        } else if (tipo.equalsIgnoreCase("checkbox")) {
            ExercicioMEscolha conteudo = new ExercicioMEscolha();
            conteudo.setId(cont.getIdExercicio());
            conteudo = dao.localizar(conteudo);
            
            
            for (boolean alternativa : conteudo.getCorreta()) {                
                //out.print(alternativa);
            }
            
            
        } else if (tipo.equalsIgnoreCase("lacuna")) {
            ExercicioLacunas conteudo = new ExercicioLacunas();
            conteudo.setId(cont.getIdExercicio());
            conteudo = dao.localizar(conteudo);
            

            for (String alternativa : conteudo.getResposta()) {
                //out.print(alternativa);
            }
        }
    }
%>



<script>
    $('#exercicioTipo').val('provaCorrigida');
    // AMBTST
    $('form[class=conteiner] input').attr('disabled', 'disabled');
    
    var erros,
    alternativa,
    exercicio,
    cor,
    incorretas;
    
    erros = 0;
    incorretas = 0;
    cor ="vermelho";
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
<%
   exercicios = 0;
   int erros = 0;
    for (Conteudo cont : lista) {
        exercicios++;
        
        out.print("exercicio = ");
        out.print(exercicios);
        out.print(";");
        
        tipo = cont.getExercicioTipo();
        id = cont.getIdExercicio();
        DAOExercicio dao = new DAOExercicio();
      
        
        
        if (tipo.equalsIgnoreCase("radio")) {
            ExercicioVF conteudo = new ExercicioVF();
            conteudo.setId(id);
            conteudo = dao.localizar(conteudo);
            
            out.print("alternativa = ");
            out.print(conteudo.getResposta());
            out.print(";");
            
            %>
                // Respostas: dada e correta
                var x, y;
                x = <%=conteudo.getResposta()%>;
                y = $('#correcao ol li:nth-child('+ exercicio +') ol li input:checked').val();
                
                // Compara respostas
                if ( x == y) {
                    cor ="verde";
                } else {
                    cor ="vermelho";
                    erros++;
                }
                // Marca resposta correta
                $('#correcao ol li:nth-child('+ exercicio +') ol li:nth-child('+ alternativa +')').addClass(cor);
            <%
        } else if (tipo.equalsIgnoreCase("checkbox")) {
            ExercicioMEscolha conteudo = new ExercicioMEscolha();
            conteudo.setId(id);
            conteudo = dao.localizar(conteudo);
            
            
            //% >                incorretas = 0;            <%
            
            int i = 1;
            for (boolean alternativa : conteudo.getCorreta()) {
                if (alternativa) {
                    %>
                        // Define respostas: dada e correta
                        var x, y;
                        x = <%=alternativa%>;
                        y = $('#correcao ol li:nth-child('+ exercicio +') ol li:nth-child('+ <%=i%> +') input:checked').val();
                        
                        // Compara respostas
                        if (<%=i%> == y) {
                            cor ="verde";
                        } else {
                            cor ="vermelho";
                            incorretas++;
                        }
                        
                        // Marca respostas corretas
                        $('#correcao ol li:nth-child('+ exercicio +') ol li:nth-child('+ <%=i%> +')').addClass(cor);
                    <%
                } else {
                    %>
                        // Respostas incorretas
                        var x;
                        x = $('#correcao ol li:nth-child('+ exercicio +') ol li:nth-child('+ <%=i%> +') input:checked').val();
                        
                        // Compara respostas
                        if (<%=i%> == x) {
                            cor ="vermelho";
                            incorretas++;
                            // Marca respostas incorretas
                            $('#correcao ol li:nth-child('+ exercicio +') ol li:nth-child('+ <%=i%> +')').addClass(cor);
                        }
                    <%
                }
                i++;
            }
            %>
                // Compara respostas
                if (incorretas > 0) {
                    erros++;
                    incorretas = 0;
                }
            <%
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        } else if (tipo.equalsIgnoreCase("lacuna")) {
            ExercicioLacunas conteudo = new ExercicioLacunas();
            conteudo.setId(id);
            conteudo = dao.localizar(conteudo);
            
            
            //% >                incorretas = 0;             <%
            
            int i = 1;
            for (String sentenca : conteudo.getResposta()) {
                %>
                    // Define respostas: dada e correta
                    var x, y;
                    x = "<%=sentenca%>";
                    y = $('#correcao ol li:nth-child('+ exercicio +') ol li:nth-child('+ <%=i%> +') input').val();
                    
                    //alert(x +"-"+ y);

                    // Compara respostas
                    if (x == y) {
                        cor ="verde";
                    } else {
                        cor ="vermelho";
                        //incorretas++;
                    }

                    // Marca respostas corretas
                    $('#correcao ol li:nth-child('+ exercicio +') ol li:nth-child('+ <%=i%> +')').addClass(cor);
                <%
                i++;
            }
            
            %>
                // Compara respostas
                if (incorretas > 0) {
                    erros++;
                    incorretas = 0;
                }
            <%
            
            
            
            
            
        }
    }
    
%>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //alert("erros: " + erros);
    // Finaliza
    var limiar = 0;
    if (erros == limiar) {
        ProximaPagina();
    }
</script>




<h3>Estatísticas</h3>
<%
    double porcentagemAcerto = 100;
    if (erros > 0) {
        porcentagemAcerto = (100 / exercicios) * (exercicios - erros);
    }
%>

<p>
    Numero de questões: <%= exercicios %>
</p>

<p>
    Numero de acertos: <%= exercicios - erros %>
</p>

<p>
    Porcentagem de acerto:
    <%
        String cor = "";
        if (porcentagemAcerto >= 50) {
                cor = "verde";
        } else {
                cor = "vermelho";
        }

    %>

    <span class="<%= cor %>">
        <%= porcentagemAcerto %>%
    </span>
</p>