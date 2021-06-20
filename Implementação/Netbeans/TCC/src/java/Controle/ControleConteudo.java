package Controle;

import Dominio.Arquivo;
import Dominio.Conteudo;
import Dominio.Progresso;
import Persistencia.DAOConteudo;
import Persistencia.DAOExercicio;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mark
 */
public class ControleConteudo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            
            //LOCALIZAR--------------------------------------------------
            if(request.getParameter("localizar")!=null) {
                if (request.getParameter("excluir")!=null) {
                    // Recupera o id selecionado
                    int id = Integer.parseInt(request.getParameter("id"));
                    String tipo = request.getParameter("tipo");
                    int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                    
                    Conteudo cont = new Conteudo();
                    cont.setExercicioTipo(tipo);
                    cont.setIdExercicio(id);
                    cont.setIdAula(aulaId);

                    DAOConteudo dao = new DAOConteudo();
                    
                    if (tipo.equals("arquivo")) {
                        // Deleta arquivo do servidor
                        DAOExercicio dEx = new DAOExercicio();
                        Arquivo arq = new Arquivo();
                        arq.setId(id);
                        arq = dEx.localizar(arq);

                        String fileName = getServletContext().getRealPath("/arquivos/imagens/uploads/" + arq.getNome());
                        File f = new File(fileName);
                        f.delete();
                        //boolean flag=f.delete();
                    }
                    
                    if (request.getParameter("conteudoProva") == null) {
                        dao.excluir(cont);
                    } else {
                        dao.excluirCP(cont);
                    }
                }
                
                
                else if (request.getParameter("Exibir")!=null) {
                    // Recupera o id selecionado
                    int pagina = Integer.parseInt(request.getParameter("pag"));
                    int aulaId = Integer.parseInt(request.getParameter("aulaId"));


                    Conteudo cont = new Conteudo();
                    cont.setIdAula(aulaId);
                    cont.setPagina(pagina);

                    DAOConteudo dao = new DAOConteudo();
                    cont = dao.localizar(cont);
                    //request.setAttribute("conteudo", cont);
                }
                
                
                
                
                else if (request.getParameter("mover")!=null) {
                    // Recupera o id selecionado
                    int id = Integer.parseInt(request.getParameter("id"));
                    String tipo = request.getParameter("tipo");
                    int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                    
                    Conteudo cont = new Conteudo();
                    cont.setExercicioTipo(tipo);
                    cont.setIdExercicio(id);
                    cont.setIdAula(aulaId);

                    DAOConteudo dao = new DAOConteudo();
                    
                    if (request.getParameter("direcao").equalsIgnoreCase("cima")) {
                        dao.reposicionar(cont, true);
                    } else {
                        dao.reposicionar(cont, false);
                    }
                    
                    
                }
                
                
                
                
                
                else if (request.getParameter("atualizar")!=null) {
                    
                    // Recupera parametros
                    int id = Integer.parseInt(request.getParameter("id"));
                    int pagina = Integer.parseInt(request.getParameter("pagina"));
                    int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                    
                    // Instancia objeto e seta atributos
                    Progresso cont = new Progresso();
                    cont.setId_aula(aulaId);
                    cont.setId_usuario(id);
                    cont.setPosicao(pagina);
                    
                    // existe
                    DAOConteudo dao = new DAOConteudo();
                    int saved = 0;
                    saved = dao.localizar(cont);
                    
                    // Se usuario melhorou seu progresso
                    if (saved == 0 || pagina > saved) {
                        dao.Conectar();
                        dao.progredir(cont);
                    }
                }
                
                
                
                
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
        //TRATAMENTO DE EXCEÇÕES-----------------------------------------------------------
        } catch(Exception erro){
            request.setAttribute("erro", erro);
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
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