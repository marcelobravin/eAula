package Controle;

import Dominio.Disciplina;
import Dominio.ObjectDomain;
import Persistencia.DAODisciplina;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mark
 */
@WebServlet(name = "ControleDisc", urlPatterns = {"/ControleDisc"})
public class ControleDisc extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try{
            
            //LISTAR------------------------------------------------------------
           if(request.getParameter("listar")!=null){
                DAODisciplina dao = new DAODisciplina();
                ArrayList<ObjectDomain> listaDisciplina = dao.listar();

                //coloca o objeto resultado na sessão
                request.setAttribute("resultado", listaDisciplina);
                //despacha o objeto para o jsp listaDisciplina
                request.getRequestDispatcher("/listarDisciplinas.jsp").forward(request, response);
            }
           
           
           
            //EXCLUIR-----------------------------------------------------------
            else if(request.getParameter("excluir")!=null){
                DAODisciplina dao = new DAODisciplina();
                String ids[] = request.getParameterValues("id");
                for(String id : ids){
                    Disciplina disciplina = new Disciplina();
                    disciplina.setId(Integer.parseInt(id));
                    dao.excluir(disciplina);
                }
                //Envia mensagem de sucesso
                request.setAttribute("destino", "ControleDisc?listar");
                request.setAttribute("mensagem", ids.length + " Disciplina(s) excluída(s) com sucesso!");
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
            //LOCALIZAR---------------------------------------------------------
            else if(request.getParameter("localizar")!=null) {
                Disciplina disciplina = new Disciplina();

                //recupera o id selecionado
                int id = Integer.parseInt(request.getParameter("id"));

                DAODisciplina disciplinaDAO = new DAODisciplina();
                disciplina = disciplinaDAO.localizarPorId(id);

                //coloca o objeto resultado na sessão
                request.setAttribute("disciplina", disciplina);
                request.getRequestDispatcher("/atualizarDisciplina.jsp").forward(request, response);
            }
           
           
           
           
           
            //ATUALIZAR---------------------------------------------------------
            else if(request.getParameter("atualizar")!=null) {
                

                //recupera o id selecionado
                int id = Integer.parseInt(request.getParameter("id"));
                String nome = request.getParameter("nome");
                String descricao = request.getParameter("descricao");
                
                Disciplina disciplina = new Disciplina();
                disciplina.setId(id);
                disciplina.setNome(nome);
                disciplina.setDescricao(descricao);

                // chama método atualizar mandando a disciplina como parametro
                DAODisciplina disciplinaDAO = new DAODisciplina();
                disciplinaDAO.atualizar(disciplina);

                //coloca o objeto resultado na sessão
                request.setAttribute("mensagem", "Disciplina '"+ disciplina.getNome() +"' atualizada com sucesso!");
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
            
           
           
           
        } catch(Exception erro) {
            request.setAttribute("erro", erro);
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        }
    }
    
    
    
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}