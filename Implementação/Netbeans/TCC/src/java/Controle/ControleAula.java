package Controle;

import Dominio.Aula;
import Dominio.Conteudo;
import Dominio.Disciplina;
import Dominio.ObjectDomain;
import Dominio.Progresso;
import Dominio.Usuario;
import Dominio.Voto;
import Persistencia.DAOAula;
import Persistencia.DAOConteudo;
import Persistencia.DAODisciplina;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mark
 */
public class ControleAula extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            
            //INSERIR-----------------------------------------------------------
            if(request.getParameter("inserir")!=null){
                
                //recupera os dados do formulário
                Usuario autor = (Usuario) request.getSession().getAttribute("user");
                int autorNum = autor.getId();
                String titulo = request.getParameter("titulo");
                String descricao = request.getParameter("descricao");
                boolean tipoAula = Boolean.valueOf(request.getParameter("restrita"));
                String senha = request.getParameter("senha");
                int disciplina = Integer.parseInt(request.getParameter("disciplina"));
                
                        //caso de uso opcional 'criar disciplina'
                        if (disciplina == 0){
                            // Instancia disciplina
                            Disciplina disc = new Disciplina();
                            // Seta atributos da disciplina conforme o formulário de criação de aula
                            disc.setNome(request.getParameter("criarDisc"));
                            disc.setDescricao(request.getParameter("criarDiscDesc"));
                            disc.setIdMateria(Integer.parseInt(request.getParameter("materia")));

                            // Instancia DAO e chama método cadastrar
                            DAODisciplina daoDisc = new DAODisciplina();
                            
                            // Sobrepõe o valor pelo id da nova disciplina
                            disciplina = daoDisc.cadastrar2(disc);
                        }
                
                //seta atributos na aula a ser salva
                Aula aula = new Aula();
                aula.setTitulo(titulo);
                aula.setDescricao(descricao);
                aula.setIdAutor(autorNum);
                aula.setIdDisciplina(disciplina);
                aula.setRestrita(tipoAula);
                aula.setSenha(senha);
                aula.setDataCriacao(new java.sql.Timestamp(System.currentTimeMillis()));

                // Instancia DAO e chama método inserir
                DAOAula daoAula = new DAOAula();
                aula.setId(daoAula.cadastrar2(aula));
                //daoAula.fecharConexao();
                
                // Cria e envia mensagem de sucesso
                String mensagem = "Aula '"+aula.getTitulo()+"' cadastrada com sucesso!<br>Disciplina criada"+disciplina;
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aula.getId();
                request.setAttribute("destino", destino);
                
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
           
            
            
            
            
            //ATUALIZAR---------------------------------------------------------
            else if(request.getParameter("atualizar")!=null){
                
                //recupera os dados do formulário
                
                int aulaId = Integer.parseInt(request.getParameter("id"));
                String titulo = request.getParameter("titulo");
                
                
                String descricao = request.getParameter("descricao");
                boolean tipoAula = Boolean.valueOf(request.getParameter("restrita"));
                String senha = request.getParameter("senha");
                int disciplina = Integer.parseInt(request.getParameter("disciplina"));
                
                    //caso de uso opcional 'criar disciplina'
                    if (disciplina == 0){
                        // Instancia disciplina
                        Disciplina disc = new Disciplina();
                        // Seta atributos da disciplina conforme o formulário de criação de aula
                        disc.setNome(request.getParameter("criarDisc"));
                        disc.setDescricao(request.getParameter("criarDiscDesc"));
                        disc.setIdMateria(Integer.parseInt(request.getParameter("materia")));

                        // Instancia DAO e chama método cadastrar
                        DAODisciplina daoDisc = new DAODisciplina();

                        // Sobrepõe o valor pelo id da nova disciplina
                        disciplina = daoDisc.cadastrar2(disc);
                    }
                
                //seta atributos na aula a ser salva
                Aula aula = new Aula();
                aula.setId(aulaId);
                aula.setTitulo(titulo);
                aula.setDescricao(descricao);
                //aula.setIdAutor(autorNum);
                aula.setIdDisciplina(disciplina);
                aula.setRestrita(tipoAula);
                aula.setSenha(senha);
                
                
                aula.setDataAtualizacao(new java.sql.Timestamp(System.currentTimeMillis()));

                // Instancia DAO e chama método inserir
                DAOAula daoAula = new DAOAula();
                daoAula.atualizar(aula);
                
                // Cria e envia mensagem de sucesso
                String mensagem = "Aula '"+aula.getTitulo()+"' atualizada com sucesso!<br>Disciplina criada";
                request.setAttribute("mensagem", mensagem);
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //LOCALIZAR--------------------------------------------------
            else if(request.getParameter("localizar")!=null) {
                 Aula aula = new Aula();
                 

                // Recupera o id selecionado
                int id = Integer.parseInt(request.getParameter("id"));

                // Localiza aula pelo id
                DAOAula aulaDAO = new DAOAula();
                aula = aulaDAO.localizarPorId(id);

                // Coloca o objeto resultado na sessão
                request.setAttribute("aula", aula);

                // Encaminha para página 'atualizarAula', 'criarConteudo' ou 'qualificar' conforme parametro do request
                String pagina = "";
                if (request.getParameter("Atualizar")!=null) {
                    pagina = "/atualizarAula.jsp";
                } else if (request.getParameter("Incluir")!=null) {
                    pagina = "/gerenciarConteudo.jsp";
                    
                    
                    // Localiza conteudo da aula
                    DAOConteudo dao = new DAOConteudo();
                    ArrayList<Conteudo> lista = dao.listar(id);
                    
                    // Coloca o objeto resultado na sessão
                    request.setAttribute("lista", lista);
                } else if (request.getParameter("Qualificar")!=null){
                    pagina = "/qualificarAula.jsp";
                    aulaDAO = new DAOAula();
                    aulaDAO.Registrar(id, false);
                    
                } else if (request.getParameter("Iniciar")!=null){
                    pagina = "/iniciarAula.jsp";
                    
                    
                    
                    
                    
                    // colocar depois de clicar em iniciar
                    DAOConteudo dao = new DAOConteudo();
                    aulaDAO = new DAOAula();
                    aulaDAO.Registrar(id, true);
                    
                    
                    Progresso pr = new Progresso();
                    pr.setId_aula(id);
                    pr.setId_usuario(3);
                    int x = 0;
                    x = dao.localizar(pr);
                    pr.setPosicao(x);
                    
                    
                    
                    // Localiza conteudo da aula
                    dao.Conectar();
                    ArrayList<Conteudo> lista = dao.listar(id);
                    
                    // Coloca o objeto resultado na sessão
                    request.setAttribute("aula", aula);
                    request.setAttribute("lista", lista);
                    request.setAttribute("progresso", pr);
                }
                
                // Envia para página de destino
                request.getRequestDispatcher(pagina).forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            //EXCLUIR-----------------------------------------------------------
            else if(request.getParameter("excluir")!=null){
                
                // Instancia DAO
                DAOAula aulaDAO = new DAOAula();
                
                // Recupera ids selecionados
                String ids[] = request.getParameterValues("id");
                
                // Itera pelos id's
                for (String id : ids){
                    // Instancia aula e seta id
                    Aula aula = new Aula();
                    aula.setId(Integer.parseInt(id));
                    
                    // Chama método 'excluir' mandando aula como parâmetro
                    aulaDAO.excluir(aula);
                }
                aulaDAO.fecharConexao();
                
                //Envia mensagem de sucesso
                String mensagem = ids.length+" Aula(s) excluída(s) com sucesso!!";
                
                request.setAttribute("mensagem", mensagem);
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            //VOTAR-------------------------------------------------------------
            // realiza qualificação da aula
            else if(request.getParameter("votar")!=null){
                
                int id = Integer.parseInt(request.getParameter("id"));
                int nota = Integer.parseInt(request.getParameter("nota"));
                //int idUsr = 3;//Integer.parseInt(request.getParameter("id"));
                //int idUsr = Integer.parseInt(request.getParameter("userId"));
                // tem q pegar id do usuario
                
                Usuario usr = new Usuario();
                HttpSession sessao = request.getSession();
                usr = (Usuario) sessao.getAttribute("user");
                int idUsr = usr.getId();
                
                
           
                
                
                Voto voto = new Voto();
                voto.setAulaId(id);
                voto.setUsuarioId(idUsr);
                voto.setNota(nota);
                
               
                Voto voto2 = new Voto();
                DAOAula aulaDAO = new DAOAula();
                voto2 = aulaDAO.Localizar(voto);
                
                
                
                
                
                if (voto2.getId() == 0) {
                    aulaDAO.Conectar();
                    aulaDAO.Qualificar(voto);
                } else {
                    aulaDAO.Conectar();
                    voto2.setNota(nota);
                    aulaDAO.Requalificar(voto2);
                }

                

                
                // Finaliza-----------------------------------------------------
                // Envia mensagem de sucesso
                String destino = "ControleAula?listar";
                String mensagem = "Aula votada com sucesso!!";
                
                
                // Define página de destino                
                request.setAttribute("destino", destino);                
                request.setAttribute("mensagem", mensagem);
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            if(request.getParameter("listar") != null) {
                DAOAula aulaDAO = new DAOAula();
                ArrayList<ObjectDomain> listaAula = aulaDAO.listar();

                //coloca o objeto resultado na sessão
                request.setAttribute("resultado", listaAula);
                //despacha o objeto para o jsp listaCliente
                request.getRequestDispatcher("/pesquisaAula.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            else if(request.getParameter("pesquisar") != null) {
                /*
                boolean restrita = Boolean.valueOf(request.getParameter("restrita"));
                String area = request.getParameter("area");
                String autor = request.getParameter("autor");
                String titulo = request.getParameter("titulo");
                
                Aula aula = new Aula();
                aula.setRestrita(restrita);
                //aula.setIdAutor(autor);
                aula.setTitulo(titulo);
                
                DAOAula aulaDAO = new DAOAula();
                ArrayList<Aula> listaAula = aulaDAO.listarCondicional(aula);
                
                //coloca o objeto resultado na sessão
                request.setAttribute("resultado", listaAula);
                //despacha o objeto para o jsp listaCliente
                request.getRequestDispatcher("/pesquisaAula.jsp").forward(request, response);
                 * 
                 */
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