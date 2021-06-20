<%-- 
    Document   : iniciarCorrecao
    Created on : 21/04/2012, 11:09:01
    Author     : Mark
--%>


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
    <% Aula aula = (Aula) request.getAttribute("aula");%>
    <% ArrayList<Conteudo> listaConteudo = (ArrayList<Conteudo>) request.getAttribute("lista");%>
    <% ArrayList<Exercicio> listaRespostas = (ArrayList<Exercicio>) request.getAttribute("listaRespostas");%>
    <head>
        <title>JSP Page</title>
        <%@ include file="frames/imports.jsp"%>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
        
            <h1>Correção Aula: <%= aula.getTitulo()%></h1>
            <h2>Id: <%= aula.getId()%></h2>


            <div id="conteudo">
                <center>
                    <%
                        int j = 0;
                        int r = 1;
                        int erros = 0;
                        String mssg = "";
                        mssg += "<form name='cadastro' action='ControleExercicio' method='post' class='conteiner'  onsubmit='return deleteManager.checkBeforeSubmit()'>";
                        mssg += "<ol>";
                        out.print(mssg);
                        
                        
                        
                        
                        
                        for (Conteudo cont : listaConteudo) {
                            mssg = "";
                            mssg += "<li>";
                            
                            // RADIO
                            //==================================================
                            if (cont.getExercicioTipo().equals("radio")) {
                                r = 1;
                               
                                DAOExercicio dao = new DAOExercicio();
                                ExercicioVF exercicio = new ExercicioVF();
                                exercicio.setId(cont.getIdExercicio());                                

                                ExercicioVF ex = new ExercicioVF();
                                ex = dao.localizar(exercicio);
                                //////////////////////////////////////////////////////////////////////////
                                exercicio = (ExercicioVF) listaRespostas.get(j);
                               
                                
                                mssg += "<h6>";
                                mssg += ex.getTitulo();
                                mssg += "</h6>";
                                
                                
                                if (exercicio.getResposta() == 0){
                                    erros++;
                                }
                                
                                
                                mssg += "<ol class='letra'>";
                                for (String sentenca : ex.getAlternativa()) {
                                    mssg += "<li";
   
                                    if (exercicio.getResposta() == r) {
                                        if (exercicio.getResposta() == ex.getResposta()) {
                                            mssg += " class='verde'";
                                        } else {
                                            mssg += " class='vermelho'";
                                            erros++;
                                        }
                                    }
                                    mssg += ">";
                                    mssg += "<label>";
                                    mssg += "<input disabled='disabled' name='alternativa"+ ex.getId() +"' type='radio' value='"+ r +"'";
                                    if (ex.getResposta() == r) {                                        
                                        mssg += "checked='checked'";
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
                                
                                
                                
                                //////////////////////////////////////////////////////////////////////////
                                exercicio = (ExercicioMEscolha) listaRespostas.get(j);
                                

                                boolean[] corretas = new boolean[exercicio.getCorreta().length];
                                corretas = ex.getCorreta();
                                
                                mssg += "<h6>";
                                mssg += ex.getTitulo();
                                mssg += "</h6>";
                                
                                mssg += "<ol class='letra'>";
                                double incorretas = 0;
                                for (String sentenca : ex.getAlternativa()) {
                                    mssg += "<li";
                                    
                                    
                                    if (exercicio.getCorreta()[r]) {
                                        if (corretas[r]) {
                                            mssg += " class='verde'";
                                        } else {
                                            mssg += " class='vermelho'";
                                            incorretas++;
                                        }
                                    }
                                    mssg += ">";
                                    
                                    
                                    

                                    mssg += "<label>";
                                    mssg += "<input disabled='disabled' name='alternativa"+ ex.getId() +"' type='checkbox' value=''";
                                    if (corretas[r]) {
                                        mssg += "checked='checked'";
                                        if (!exercicio.getCorreta()[r]) {                                            
                                            mssg += " class='vermelho'";
                                            incorretas++;
                                        }
                                    }
                                    mssg += ">";
                                    mssg += sentenca;
                                    mssg += "</label>";
                                    
                                    
                                    
                                    
                                    mssg += "</li>";
                                    r++;
                                }
                                
                                incorretas /= ex.getAlternativa().length;
                                if (incorretas <=1 && incorretas !=0) {
                                    erros++;                                    
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

                                //////////////////////////////////////////////////////////////////////////
                                exercicio = (ExercicioLacunas) listaRespostas.get(j);
                                String[] preTexto = new String[1];
                                preTexto = ex.getPreTexto();
                                
                                String[] posTexto = new String[1];
                                posTexto = ex.getPosTexto();
                                
                                
                                mssg += "<h6>";
                                mssg += ex.getTitulo();
                                mssg += "</h6>";
                                
                                mssg += "<ol class='letra'>";
                                double incorretas = 0;
                                for (String sentenca : ex.getResposta()) {
                                    mssg += "<li>";

                                    mssg += "<label>";
                                    mssg += preTexto[r];
                                    
                                    
                                    if (!sentenca.equalsIgnoreCase(exercicio.getResposta()[r])) {
                                        mssg += " <input disabled='disabled' type='text' value='"+exercicio.getResposta()[r]+"'> ";
                                        mssg += " ("+sentenca+") ";
                                        incorretas++;
                                    } else {
                                        mssg += " <span class='verde'>";
                                        mssg += exercicio.getResposta()[r];
                                        mssg += "</span> ";
                                    }
                                    
                                    mssg += posTexto[r];
                                    mssg += "</label>";
                                    
                                    mssg += "</li>";
                                    r++;
                                }
                                
                                incorretas /= ex.getResposta().length;
                                if (incorretas <=1 && incorretas !=0) {
                                    erros++;                                    
                                }
                                mssg += "</ol>";
                            }           

                            
                            
                            
                            
                            
                            
                            


                                mssg += "</li>";
                                mssg += "<hr />";
                                ////////////////////////////////////////////////////
                                out.print(mssg);
                             
                                j++;   
                            }

                            out.print("</ol>");
                        %>
                    
                       
                        
		
			<h3>Estatísticas</h3>
                        <p>
                            Numero de questões: <%= listaConteudo.size() %>
                        </p>
                        
                        <p>
                            Numero de acertos: <%= listaConteudo.size() - erros %>
                        </p>
                        
                        <%
                            double porcentagemAcerto = 100;
                            if (erros > 0) {
                                porcentagemAcerto = (100 / listaConteudo.size()) * (listaConteudo.size() - erros);
                            }
                        %>
                        
                        
                        
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
                                            
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>