package Controle;

import Dominio.Mensagem;
import Dominio.Usuario;
import Persistencia.DAOMensagem;
import Persistencia.DAOUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mark
 */
@WebServlet(name = "ControleMensagem", urlPatterns = {"/ControleMensagem"})
public class ControleMensagem extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ControleMensagem</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControleMensagem at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
            
            
            String pagina = "/";
            if (request.getParameter("preparar") != null) {
                int id = Integer.parseInt(request.getParameter("para"));
                
                Mensagem mssg = new Mensagem();
                Usuario usr = new Usuario();
                DAOUsuario dao = new DAOUsuario();
                
                usr = dao.localizarPorId(id);
                //usr.setId(id);
                
                
                
                //mssg.setIdAlvo(id);
                mssg.setDestinatario(usr);
                
                
                pagina = "/mensagem.jsp";                
                request.setAttribute("mensagem", mssg);
            } else if (request.getParameter("enviar") != null) {
                // Recupera parametros
                int id = Integer.parseInt(request.getParameter("alvoId"));
                
                Usuario remetente = (Usuario) request.getSession().getAttribute("user");
                String conteudo = request.getParameter("texto");
                
                Usuario destinatario = new Usuario();
                DAOUsuario daoUsr = new DAOUsuario();
                //destinatario.setId(id);
                destinatario = daoUsr.localizarPorId(id);
                
                // Instancia e prepara objeto
                Mensagem mssg = new Mensagem();
                mssg.setDestinatario(destinatario);
                mssg.setRemetente(remetente);
                mssg.setConteudo(conteudo);
                mssg.setData_hora(new java.sql.Timestamp(System.currentTimeMillis()));
                
                // Salva
                DAOMensagem dao = new DAOMensagem();
                dao.Cadastrar(mssg);
                
                
                pagina = "/sucesso.jsp";
                request.setAttribute("mensagem", "Mensagem enviada com sucesso de " + mssg.getRemetente().getNome() + " para "+ mssg.getDestinatario().getNome());
            } else if (request.getParameter("listar") != null) {
                
                Usuario usr = (Usuario) request.getSession().getAttribute("user");
                
                try {
                    Mensagem mssg = new Mensagem();
                    mssg.setDestinatario(usr);
                    
                    

                    DAOMensagem dao = new DAOMensagem();

                    ArrayList<Mensagem> lista = dao.listar(mssg);
                    
                    DAOUsuario daoUsr = new DAOUsuario();
                    
                    for (Mensagem mssg2 : lista) {
                        //daoUsr.Conectar();
                        //mssg2.setDestinatario(daoUsr.localizarPorId(mssg2.getDestinatario().getId()));
                        
                        daoUsr.Conectar();
                        mssg2.setRemetente(daoUsr.localizarPorId(mssg2.getRemetente().getId()));
                    }
                    

                    //coloca o objeto resultado na sessão e despacha para o jsp listaUsuario
                    request.setAttribute("resultado", lista);
                    pagina = "/listaMensagens.jsp";
                } catch(Exception erro) {
                    // id 0
                    request.setAttribute("erro", erro);
                    request.getRequestDispatcher("/erro.jsp").forward(request, response);
                }
                
                
            } else if (request.getParameter("excluir") != null) {
                
                // Recupera ids selecionados
                String ids[] = request.getParameterValues("id");
                
                DAOMensagem dao = new DAOMensagem();
                Mensagem mssg = new Mensagem();
                
                // Itera pelos id's instanciando usuarios e chamando 'excluir'
                for(String id : ids){
                    // Instancia DAO
                    dao.Conectar();
                
                    // Instancia usuario e seta id
                    mssg.setId(Integer.parseInt(id));
                    
                    // Chama método 'excluir' mandando objeto como parâmetro
                    dao.Excluir(mssg);
                }
                
                // Define página de destino
                String destino = "ControleMensagem?listar";
                request.setAttribute("destino", destino);
                
                //Envia mensagem de sucesso
                request.setAttribute("mensagem", ids.length + " mensagens excluídas com sucesso!!");
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            // Encaminha para página de destino
            request.getRequestDispatcher(pagina).forward(request, response);
            
        } catch(Exception erro) {
            request.setAttribute("erro", erro);
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        } finally {            
            //out.close();
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
