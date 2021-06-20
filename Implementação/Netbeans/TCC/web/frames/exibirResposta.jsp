<%-- 
    Document   : exibirResposta
    Created on : 05/05/2012, 15:59:16
    Author     : Mark
--%>

<%@page import="Dominio.ExercicioLacunas"%>
<%@page import="Dominio.ExercicioMEscolha"%>
<%@page import="Dominio.ExercicioVF"%>
<%@page import="Persistencia.DAOExercicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String tipo = request.getParameter("tipo");
    int id = Integer.parseInt(request.getParameter("id"));
    
    DAOExercicio dao = new DAOExercicio();
    String mssg = "";
    
    
    if (tipo.equalsIgnoreCase("radio")) {
        
        // Localiza exercicio
        ExercicioVF ex = new ExercicioVF();
        ex.setId(id);
        ex = dao.localizar(ex);
        
        // pega e compara respostas
        int respostaDada = Integer.parseInt(request.getParameter("resposta"));
        int respostaCorreta = ex.getResposta();
        if (respostaCorreta == respostaDada) {
            mssg += "acertou!";
        } else {
            mssg += "errou!";
        }
    } else if (tipo.equalsIgnoreCase("checkbox")) {
        
        // Localiza exercicio
        ExercicioMEscolha ex = new ExercicioMEscolha();
        ex.setId(id);
        ex = dao.localizar(ex);        
        
        // pega e compara respostas
        String verificar = request.getParameter("resposta");
        String[] respostasDadas = verificar.split(", ");
        
        //boolean[] r = ex.getCorreta();
        boolean[] r = new boolean[ex.getCorreta().length];
        
        /*int u = 0;
        for (boolean r2: r) {
            r[u] = false;
            u++;
        }
 */ 
        
        
        for (String respostaDada: respostasDadas) {
            int o = Integer.parseInt(respostaDada);
            if (o > 0) {
                o--;
                r[o] = true;
            }
        }
        
        
        
       
        int erros = 0;
        
        
        int i = 0;
        for (boolean resposta : ex.getCorreta()) {
            //out.print(resposta);
            //out.print("-");
            //out.print(r[i]);
            
            
            if (resposta != r[i]) {
                erros++;
            }
            i++;
        }
        
        
        
        
        
        
        /*
        for (String respostaDada: respostasDadas) {
            out.print(respostaDada);
            int resp = Integer.parseInt(respostaDada);
            if (resp > 0) {
                if (!ex.getCorreta()[resp]) {
                    erros++;
                }
            }
        }
 */ 
        
        /*
        for (String respostaDada: respostasDadas) {            
            int x = Integer.parseInt(respostaDada);
            
            if(x > 0) {
                x--;
                //out.print(respostaDada+" - "+ex.getCorreta()[x]);
                if (ex.getCorreta()[x]) {
                    erros++;
                }
            }
        }
        */
        
        /*
        int i = 0;
        for (boolean resposta : ex.getCorreta()) {
            i++;
            //out.print(resposta);
            if (resposta) {
                if (respostasDadas.length > i) {
                    //out.print(respostasDadas[i]);
                    if (respostasDadas[i].equals(i)) {
                        out.print("correto");
                    }
                }
            }
            
        }
 */ 
        
        if (erros == 0) {
            mssg += "acertou!";
        } else {
            mssg += "errou!";
        }
        
        
        
    } else if (tipo.equalsIgnoreCase("lacuna")) {
        
        // Localiza exercicio
        ExercicioLacunas ex = new ExercicioLacunas();
        ex.setId(id);
        ex = dao.localizar(ex);
        
        // pega e compara respostas
        String verificar = request.getParameter("resposta");
        String[] respostasDadas = verificar.split(", ");        
        
       
        int erros = 0;
        int x = 0;
        for (String respostaDada: respostasDadas) {
            // ignoreCase?
            //if (!ex.isPreciseCase) {
                if (!ex.getResposta()[x].equalsIgnoreCase(respostaDada)) {
                    erros++;
                }
            
                
            //} else {
                //if (!ex.getResposta()[x].equals(respostaDada)) {
                    //erros++;
                //}
            //}
                
                
            x++;
        }
        
        if (erros == 0) {
            mssg += "acertou!";
        } else {
            mssg += "errou!";
        }
        
    } else if (tipo.equalsIgnoreCase("texto") || tipo.equalsIgnoreCase("arquivo")) {
        mssg += "acertou!";
    } else {
        mssg += "erro";
    }
    
    
    out.print(mssg);
%>