package Controle;

import Dominio.Usuario;
import Persistencia.DAOUsuario;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mark
 */
@WebServlet(name = "Login", urlPatterns = {"/Logar"})
public class Login extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            HttpSession sessao = request.getSession();
            String pagina = "home.jsp";
            String mensagem = "";
            
            
            // LOG IN-----------------------------------------------------------
            if(request.getParameter("acao").equals("login")) {
                //recuperar o nome inserido
                String nome = request.getParameter("login");
                String senha = request.getParameter("senha");

                // verifica no BD o nome inserido
                DAOUsuario userDAO = new DAOUsuario();
                Usuario usuario = userDAO.localizarPorNome(nome);
                
                // Se usuario e senha estiverem corretos
                if (usuario.getNome() != null && !"".equals(usuario.getNome())) {
                    if (usuario.getSenha().equals(senha)) {
                        
                        
                        
                        //Inicia a sessão
                        sessao.setAttribute("user", usuario);
                        //sessao.setMaxInactiveInterval(-1);
                        
                        
                        //mensagem = "Usuário logado com sucesso!";
                        //pagina = "/sucesso.jsp";
                        pagina = "/home.jsp";
                    }
                    
                    // Se a senha estiver incorreta
                    else {
                        mensagem = "Senha inválida!";
                        pagina = "/loginInvalido.jsp";
                    }
                }
                
                // Se o nome de usuario estiver incorreto
                else {
                    mensagem = "Usuário inexistente!";
                    pagina = "/loginInvalido.jsp";
                }
            }
            
            
            
            // LOG OUT----------------------------------------------------------
            else if(request.getParameter("acao").equals("logout")) {
                // invalida a sessao                
                sessao.invalidate();

                //mensagem = "Usuário deslogado com sucesso!";
                //pagina = "/sucesso.jsp";
                pagina = "/home.jsp";
            }

            
            
            
            
            
            // vai pra pagina e exibe mensagem correspondentes
            request.setAttribute("mensagem", mensagem);
            request.getRequestDispatcher(pagina).forward(request, response);
            
            
            
            
        // tratamento de erros--------------------------------------------------
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
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
