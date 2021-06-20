package Controle;

import Dominio.ObjectDomain;
import Dominio.Usuario;
import Dominio.Endereco;
import Persistencia.DAOUsuario;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ControleUsuario", urlPatterns = {"/ControleUsuario"})

public class ControleUsuario extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String pagina = "/";
            
            //INSERIR-----------------------------------------------------------
            if (request.getParameter("inserir") != null) {
                String naFigura = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
                //String naFigura = "";
                String digitado = request.getParameter("kaptcha");
                
                //Se captcha estiver correto
                if(digitado.equals(naFigura)) {
                    
                    //cria um objeto usuario
                    Usuario usuario = new Usuario();                    
                    Endereco end = new Endereco();
                    
                    // Recupera os dados do formulário e seta atributos
                    String nome = request.getParameter("nome");
                    usuario.setNome(nome);
                    
                    Long cpf = Long.parseLong(request.getParameter("cpf"));
                    usuario.setCpf(cpf);
                    
                    String nascimento = request.getParameter("dc");
                    usuario.setDataNascimento(nascimento);
                    
                    String email = request.getParameter("email");                    
                    usuario.setEmail(email);
                    
                    String senha = request.getParameter("senha");
                    usuario.setSenha(senha);
                    
                    String profissao = request.getParameter("profissao");
                    usuario.setProfissao(profissao);
                    
                    String escolaridade = request.getParameter("escolaridade");
                    usuario.setEscolaridade(escolaridade);
                    
                    usuario.setDataCadastro(new java.sql.Timestamp(System.currentTimeMillis()));
                    
                    int privilegios = Integer.parseInt(request.getParameter("tipoUsuario"));
                    usuario.setPrivilegios(privilegios);
                                        
                    Boolean sexo = false;
                    if (request.getParameter("sexo").equals("masculino")) {
                        sexo = true;
                    }
                    usuario.setSexo(sexo);
                    
                    // Recupera e seta atributos de 'Endereco'
                    int tipoLogradouro = Integer.parseInt(request.getParameter("tipoLogradouro"));
                    end.setIdTipoLogradouro(tipoLogradouro);
                    
                    String logradouro = request.getParameter("logradouro");
                    end.setLogradouro(logradouro);
                    
                    int numero = Integer.parseInt(request.getParameter("numero"));
                    end.setNumero(numero);
                    
                    int cep = Integer.parseInt(request.getParameter("cep"));
                    end.setCep(cep);
                    
                    int cidade = Integer.parseInt(request.getParameter("campoCidade"));
                    end.setIdCidade(cidade);
                    
                    int uf = Integer.parseInt(request.getParameter("uf"));
                    end.setIdUf(uf);
                    
                    
                    
                    // Seta endereco
                    usuario.setEnd(end);
                    
                    //cria um objeto DAOUsuario e chama método cadastrar passando usuário como parametro
                    DAOUsuario userDAO = new DAOUsuario();
                    userDAO.cadastrar(usuario);

                    // Envia mensagem de sucesso
                    String mensagem = "Usuário cadastrado com sucesso !";
                    request.setAttribute("mensagem", mensagem);
                    
                    // Define página de destino
                    pagina += "sucesso.jsp";
                    
                    //pagina += "Login?acao=login&login="+usuario.getNome()+"&senha="+usuario.getSenha();
                }
                else {
                    pagina += "cadastroUsuario.jsp";
                }
                
                // Encaminha para página de destino
                request.getRequestDispatcher(pagina).forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
             //ATUALIZAR-----------------------------------------------------------
            else if(request.getParameter("atualizar")!=null){
                //recupera os dados do formulário
                //cria um objeto usuario
                Usuario usuario = new Usuario();              
                Endereco end = new Endereco();
                
                int id = Integer.parseInt(request.getParameter("id"));
                usuario.setId(id);
                
                

                // Recupera os dados do formulário e seta atributos
                String nome = request.getParameter("nome");
                usuario.setNome(nome);

                Long cpf = Long.parseLong(request.getParameter("cpf"));
                usuario.setCpf(cpf);
                
                String nascimento = request.getParameter("dc");
                usuario.setDataNascimento(nascimento);

                String email = request.getParameter("email");                    
                usuario.setEmail(email);

                String senha = request.getParameter("senha");
                usuario.setSenha(senha);

                String profissao = request.getParameter("profissao");
                usuario.setProfissao(profissao);

                String escolaridade = request.getParameter("escolaridade");
                usuario.setEscolaridade(escolaridade);

                //usuario.setDataCadastro(new java.sql.Timestamp(System.currentTimeMillis()));

                int privilegios = Integer.parseInt(request.getParameter("tipoUsuario"));
                usuario.setPrivilegios(privilegios);

                Boolean sexo = false;
                if (request.getParameter("sexo").equals("masculino")) {
                    sexo = true;
                }
                usuario.setSexo(sexo);

                // Recupera e seta atributos de 'Endereco'
                int tipoLogradouro = Integer.parseInt(request.getParameter("tipoLogradouro"));
                end.setIdTipoLogradouro(tipoLogradouro);

                String logradouro = request.getParameter("logradouro");
                end.setLogradouro(logradouro);

                int numero = Integer.parseInt(request.getParameter("numero"));
                end.setNumero(numero);

                int cep = Integer.parseInt(request.getParameter("cep"));
                end.setCep(cep);

                int cidade = Integer.parseInt(request.getParameter("campoCidade"));
                end.setIdCidade(cidade);

                int uf = Integer.parseInt(request.getParameter("uf"));
                end.setIdUf(uf);

                // Seta endereco
                usuario.setEnd(end);

                //cria um objeto DAOUsuario e chama método atualizar passando usuário como parametro
                DAOUsuario userDAO = new DAOUsuario();
                userDAO.atualizar(usuario);

                //envia mensagem de sucesso
                request.setAttribute("mensagem", "Usuário atualizado com sucesso !");                
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            //LISTAR------------------------------------------------------------
            else if(request.getParameter("listar")!=null){
                DAOUsuario dao = new DAOUsuario();
                ArrayList<ObjectDomain> lista = dao.listar();

                //coloca o objeto resultado na sessão e despacha para o jsp listaUsuario
                request.setAttribute("resultado", lista);
                request.getRequestDispatcher("/listaUsuarios.jsp").forward(request, response);
            }
            
            
            //LOCALIZAR POR ID--------------------------------------------------
            else if(request.getParameter("localizarPorID")!=null){
                
                Usuario usr = (Usuario) request.getSession().getAttribute("user");
                
                if (usr != null) {
                    if (usr.getPrivilegios() == 3) {                
                        if (request.getSession().getAttribute("usuarioId") != null) {
                            //recupera o id selecionado
                            int id = Integer.parseInt(request.getParameter("id"));

                            DAOUsuario userDAO = new DAOUsuario();
                            Usuario usuario = userDAO.localizarPorId(id);

                            request.setAttribute("usuario", usuario);
                            request.getRequestDispatcher("/atualizar.jsp").forward(request, response);
                        } else {
                            request.setAttribute("mensagem", "Usuário nulo!");
                            request.getRequestDispatcher("/loginInvalido.jsp").forward(request, response);
                        }
                    } else {
                        //request.setAttribute("mensagem", "Usuário nulo!");
                        //request.getRequestDispatcher("/loginInvalido.jsp").forward(request, response);
                        request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
                        request.getRequestDispatcher("/loginInvalido.jsp").forward(request, response);
                    }
                } else {
                    //request.setAttribute("mensagem", "Usuário nulo!");
                    //request.getRequestDispatcher("/loginInvalido.jsp").forward(request, response);
                    request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
                    request.getRequestDispatcher("/loginInvalido.jsp").forward(request, response);
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //ME LOCALIZAR POR ID--------------------------------------------------
            else if(request.getParameter("meLocalizarPorID")!=null){
                
                //if (request.getSession().getAttribute("usuarioId") != null) {
                Usuario usr = (Usuario) request.getSession().getAttribute("user");
                if (usr != null) {
                    //String id = request.getSession().getAttribute("usuarioId").toString();
                    //int idConvertido = (int) Integer.parseInt(id);
                    int idConvertido = usr.getId();

                    DAOUsuario userDAO = new DAOUsuario();
                    Usuario usuario = userDAO.localizarPorId(idConvertido);

                    request.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("/atualizar.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensagem", "Usuário nulo!");
                    request.getRequestDispatcher("/loginInvalido.jsp").forward(request, response);
                }
            }
            
            
           
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //EXCLUIR-----------------------------------------------------------
            else if (request.getParameter("excluir") != null) {
                
                // Recupera ids selecionados
                String ids[] = request.getParameterValues("id");
                
                // Itera pelos id's instanciando usuarios e chamando 'excluir'
                for(String id : ids){
                    // Instancia DAO
                    DAOUsuario userDAO = new DAOUsuario();
                
                    // Instancia usuario e seta id
                    Usuario usuario = new Usuario();
                    usuario.setId(Integer.parseInt(id));
                    
                    // Chama método 'excluir' mandando usuario como parâmetro
                    userDAO.excluir(usuario);
                }
                
                //Envia mensagem de sucesso
                request.setAttribute("destino", "/ControleUsuario?listar");
                request.setAttribute("mensagem", ids.length + " Usuário(s) excluído(s) com sucesso!!");
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            else if(request.getParameter("email")!=null){
                
                String ids[] = request.getParameterValues("id");
                
                ArrayList<Usuario> lista = new ArrayList<Usuario>();
                
                DAOUsuario dao = new DAOUsuario();
                Usuario usuario = new Usuario();
                
                for(String id : ids){
                    //usuario.setId(Integer.parseInt(id));
                    dao.Conectar();
                    usuario = dao.localizarPorId(Integer.parseInt(id));
                    lista.add(usuario);
                }
                
                //Envia mensagem de sucesso
                //request.setAttribute("mensagem", ids.length + " Usuário(s) excluído(s) com sucesso!!");
                request.setAttribute("listaUsuario", lista);
                request.getRequestDispatcher("/email.jsp").forward(request, response);
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