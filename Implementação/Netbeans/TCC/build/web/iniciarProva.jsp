<%-- 
    Document   : iniciarProva
    Created on : 06/01/2012, 18:25:18
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
    <head>
        <title>JSP Page</title>
        <%@ include file="frames/imports.jsp"%>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
        
            <h1>Aula: <%= aula.getTitulo()%></h1>
            <h2>Id: <%= aula.getId()%></h2>


            <div id="conteudo">
                <center>
                    <%
                        int j = 0;
                        int r = 0;
                        String mssg = "# exercicios: "+listaConteudo.size();
                        //mssg += "<form name='cadastro' action='ControleAula' method='post' class='conteiner'>";
                        mssg += "<form name='cadastro' action='ControleExercicio' method='post' class='conteiner'>";
                        //mssg += "<input type='text' value='5' name='pan'>";/////////////////////////////////////////
                        mssg += "<input type='hidden' value='"+aula.getId()+"' name='id'>";
                        mssg += "<ol>";
                        out.print(mssg);
                        
                        
                        
                        
                        
                        for (Conteudo cont : listaConteudo) {
                            mssg = "";
                            mssg += "<li>";
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

                                mssg += "<h6>";
                                mssg += ex.getTitulo();
                                mssg += "</h6>";
                                
                                
                                mssg += "<ol class='letra'>";
                                for (String sentenca : ex.getAlternativa()) {
                                    mssg += "<li>";
                                    mssg += "<label>";
                                    mssg += "<input type='radio' name='alternativa"+ ex.getId() +"' value='"+ r +"'>";
                                    //mssg += "<input type='radio' name='zzz' value='"+ r +"'>";
                                    mssg += sentenca;
                                    mssg += "</label>";
                                    
                                    if (ex.getResposta() == r) {
                                        mssg += "<<<<<<<<<<<";
                                    }
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

                                
                                boolean[] corretas = ex.getCorreta();
                                
                                mssg += "<h6>";
                                mssg += ex.getTitulo();
                                mssg += "</h6>";
                                mssg += "<input type='hidden' name='numAlternativasEx"+ ex.getId() +"' value='"+ex.getAlternativa().length+"'>";
                                
                                mssg += "<ol class='letra'>";
                                for (String sentenca : ex.getAlternativa()) {
                                    mssg += "<li>";

                                    mssg += "<label>";
                                    mssg += "<input name='alternativa"+ ex.getId() +"[]' type='checkbox' value='"+(r + 1)+"'>";
                                    mssg += sentenca;
                                    mssg += "</label>";
                                    
                                    if (corretas[r]) {
                                        mssg += "<<<<<<<<<";
                                    }
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


                                String[] corretas = new String[1];
                                corretas = ex.getPreTexto();
                                
                                String[] posTexto = new String[1];
                                posTexto = ex.getPosTexto();
                                
                                
                                mssg += "<h6>";
                                mssg += ex.getTitulo();
                                mssg += "</h6>";
                                
                                mssg += "<ol class='letra'>";
                                for (String sentenca : ex.getResposta()) {
                                    mssg += "<li>";

                                    mssg += "<label>";
                                    mssg += corretas[r];
                                    mssg += " <input name='alternativa"+ ex.getId() +"[]' type='text' value='"+sentenca+"'> ";
                                    
                                    mssg += posTexto[r];
                                    mssg += "</label>";
                                    
                                    mssg += "</li>";
                                    r++;
                                }
                                mssg += "</ol>";
                            }           

                            
                            
                            
                            
                            
                            
                            


                                mssg += "</li>";
                                mssg += "<hr />";
                                ////////////////////////////////////////////////////
                                out.print(mssg);
                                
                            }

                            out.print("</ol>");
                        %>
                    
                        <!-- Botões..............................................-->
                        
                        <input type="submit" name="corrigir" value="Corrigir" />
                        
                        
                        
                        <input type='reset' value='Limpar' />
                        
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>       
    </body>
</html>