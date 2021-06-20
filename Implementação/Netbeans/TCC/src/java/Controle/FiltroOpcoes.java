package Controle;

import Dominio.Cidade;
import Dominio.Conteudo;
import Dominio.Disciplina;
import Dominio.Materia;
import Persistencia.DAOConteudo;
import Persistencia.DAOFrames;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mark
 */
public class FiltroOpcoes extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            
            
            // Carrega cidades conforme uf recebida
            if(request.getParameter("uf")!=null){
                
                int idUf = Integer.parseInt(request.getParameter("uf"));
                
                // Instancia DAOCidade e chama método listar mandando uf como parametro
                DAOFrames userDAO = new DAOFrames();
                ArrayList<Cidade> lista = null;
                 
                try {
                    lista = userDAO.listar(idUf);
                } catch (SQLException ex) {
                    Logger.getLogger(FiltroOpcoes.class.getName()).log(Level.SEVERE, null, ex);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(FiltroOpcoes.class.getName()).log(Level.SEVERE, null, ex);
                }

                //coloca o objeto resultado na sessão
                request.setAttribute("resultado", lista);
                //despacha o objeto para o jsp lista
                request.getRequestDispatcher("/frames/select_cidades.jsp").forward(request, response);
            }
            
            
            
            
            
            
            else if(request.getParameter("area")!=null){
                
                int area = Integer.parseInt(request.getParameter("area"));
                
                // Instancia DAOCidade e chama método listar mandando uf como parametro
                DAOFrames userDAO = new DAOFrames();
                ArrayList<Materia> lista = null;
                 
                try {
                    lista = userDAO.listarMateria(area);
                } catch (SQLException ex) {
                    Logger.getLogger(FiltroOpcoes.class.getName()).log(Level.SEVERE, null, ex);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(FiltroOpcoes.class.getName()).log(Level.SEVERE, null, ex);
                }

                //coloca o objeto resultado na sessão
                request.setAttribute("resultado", lista);
                //despacha o objeto para o jsp lista
                request.getRequestDispatcher("/frames/select_materias.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            else if(request.getParameter("materia")!=null){
                
                int idMateria = Integer.parseInt(request.getParameter("materia"));
                
                // Instancia DAOCidade e chama método listar mandando uf como parametro
                DAOFrames userDAO = new DAOFrames();
                ArrayList<Disciplina> lista = null;
                 
                try {
                    lista = userDAO.listarDisciplinas(idMateria);
                } catch (SQLException ex) {
                    Logger.getLogger(FiltroOpcoes.class.getName()).log(Level.SEVERE, null, ex);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(FiltroOpcoes.class.getName()).log(Level.SEVERE, null, ex);
                }

                //coloca o objeto resultado na sessão
                request.setAttribute("resultado", lista);
                //despacha o objeto para o jsp lista
                request.getRequestDispatcher("/frames/select_disciplinas.jsp").forward(request, response);
            }
            
            
            
            
            
            else if(request.getParameter("pag")!=null){
                
                // Identifica pagina e aula solicitadas
                int pagina = Integer.parseInt(request.getParameter("pag"));
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));

                // Localiza conteudo da pagina solicitada
                Conteudo cont = new Conteudo();
                cont.setIdAula(aulaId);
                cont.setPagina(pagina);

                DAOConteudo dao = new DAOConteudo();
                try {
                    cont = dao.localizar(cont);
                } catch (Exception erro) {
                    cont.setExercicioTipo("falha");
                }
                
                
                
                //coloca o objeto resultado na sessão
                request.setAttribute("conteudo", cont);
                request.getRequestDispatcher("/frames/exibirConteudo.jsp").forward(request, response);
            }
            
            
            
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
