package Controle;

import Dominio.Email;
import Dominio.Usuario;
import Persistencia.DAOUsuario;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Security;
import java.util.Date;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "ControleEmail", urlPatterns = {"/ControleEmail"})

public class ControleEmail extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String pagina = "/";
            String mensagem = "";
            String to = "";
            // String to = "markness@hotmail.com, seucolega@hotmail.com, seuparente@yahoo.com.br";
            
            boolean validado = false;
            
            
            // Variáveis de conexão
            Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
            final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
            final String username = "markness000@gmail.com";
            final String password = "M4rkn3ss";

            // Parâmetros de conexão com servidor Gmail
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.setProperty("mail.smtp.socketFactory.fallback", "false");

            //Session session2 = Session.getDefaultInstance(props,
            Session session = Session.getInstance(props,    
                new javax.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                       return new PasswordAuthentication(username, password);
                    }
                });

            // Ativa Debug para sessão
            session.setDebug(true);

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            Email email = new Email();
            //Recuperar senha---------------------------------------------------
            if (request.getParameter("enviarSenha") != null) {                

                Usuario usr = new Usuario();
                to = request.getParameter("email");
                usr.setEmail(to);                
                
                DAOUsuario dao = new DAOUsuario();                
                usr = dao.localizarPorEmail(usr);             
                
                if (usr.getSenha() != null) {
                    
                    email.setAssunto("Recuperação de senha");
                    email.setTexto("Sua senha é: " + usr.getSenha());
                    //email.setData(new Timestamp);
                    String content = "<h1>Recuperação de senha</h1>";
                    content += "<p>Sua senha é: " + usr.getSenha();
                    content += "<p>Caso não tenha solicitado esse email, favor desconsiderá-lo</p>";
                    content += "<a href='www.eaula.com'>www.eaula.com</a>";
                    
                    email.setConteudo(content);
                    Enviar(email, session);
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            // Enviar email para multiplos usuarios-----------------------------
            else if (request.getParameter("enviar") != null) {
                
                
                /* enviar email para endereço digitado
                Usuario usr = new Usuario();
                to = request.getParameter("destinatarios");
                usr.setEmail(to);
                DAOUsuario dao = new DAOUsuario();
                usr = dao.localizarPorEmail(usr);
                
                //validado = true;
                if (usr.getEmail() != null) {
                    
                    String subject = request.getParameter("assunto");
                    String content = request.getParameter("texto");
                    
                    email.setDestinatario(usr);
                    email.setAssunto(subject);
                    email.setConteudo(content);
                    email.setTexto(content);
                    Enviar(email, session);
                    mensagem += "Email enviado com sucesso!";
                }
                 * 
                 */
                
                // Recupera ids selecionados
                String ids[] = request.getParameterValues("ids[]");
                
                String subject = request.getParameter("assunto");
                String content = request.getParameter("texto");

                
                email.setAssunto(subject);
                email.setConteudo(content);
                email.setTexto(content);
                
                DAOUsuario dao = new DAOUsuario();
                Usuario usr = new Usuario();
                
                for (String id : ids) {
                    int x = Integer.parseInt(id);
                    
                    dao.Conectar();
                    usr = dao.localizarPorId(x);
                    if (usr.getEmail() != null) {
                    
                        email.setDestinatario(usr);
                        Enviar(email, session);
                        mensagem += "Email enviado com sucesso!<br />";
                    }
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            // Envia mensagem de sucesso
            request.setAttribute("mensagem", mensagem);

            // Define página de destino
            pagina += "sucesso.jsp";
            
            // Encaminha para página de destino
            request.getRequestDispatcher(pagina).forward(request, response);
            
            
        //TRATAMENTO DE EXCEÇÕES-----------------------------------------------------------
        } catch(Exception erro){
            request.setAttribute("erro", erro);
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        }
    }
    
    
    
    
    public void Enviar(Email email, Session session)
            throws UnsupportedEncodingException, AddressException, MessagingException {

        Message message = new MimeMessage(session);

        //Destinatário(s)
        Address[] toUser = InternetAddress.parse(email.getDestinatario().getEmail());

        message.setFrom(new InternetAddress("teste@gmail.com", "E-Aula"));
        message.setRecipients(Message.RecipientType.TO, toUser);
        message.setText(email.getTexto());
        message.setContent(email.getConteudo(), "text/html");
        message.setSentDate(new Date());
        message.setSubject(email.getAssunto());

        // Envia a mensagem
        Transport.send(message);
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