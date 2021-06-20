package Controle;

import Dominio.Arquivo;
import Dominio.Aula;
import Dominio.Conteudo;
import Dominio.Exercicio;
import Dominio.ExercicioVF;
import Dominio.ExercicioLacunas;
import Dominio.ExercicioMEscolha;
import Dominio.Prova;
import Dominio.Texto;
import Persistencia.DAOAula;
import Persistencia.DAOConteudo;
import Persistencia.DAOExercicio;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.sql.SQLException;
import java.text.Normalizer.Form;
import java.util.ArrayList;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.ImageIcon;

/**
 *
 * @author Mark
 */
public class ControleExercicio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Colocar em todas
        response.setContentType("text/html;charset=UTF-8");
        
        
        try {
            
            // Exercicio 'Verdadeiro/Falso'
            if(request.getParameter("inserirVF")!=null){
                // Cadastra exercicio-------------------------------------------
                // Instancia exercicio
                ExercicioVF exercicio = new ExercicioVF();
                
                // Recupera do formulário e seta atributos
                String titulo = request.getParameter("pergunta");
                exercicio.setTitulo(titulo);
                int correta = Integer.parseInt(request.getParameter("resposta"));
                exercicio.setResposta(correta);
                
                
                                
                // Recupera alternativas
                String alternativas[] = request.getParameterValues("alternativa[]");
                exercicio.setAlternativa(alternativas);
                
                // Instancia DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.cadastrar(exercicio);
                
                
                
                // Cadastra conteudo--------------------------------------------
                boolean pan = false;
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                int provaId = 0;
                
                try {
                    provaId = Integer.parseInt(request.getParameter("provaId"));
                    pan = true;
                } catch(NumberFormatException erro) {
                    
                }
                
                
                
                String mensagem = "Exercicio radio criado!";
                Conteudo cont = new Conteudo();
                cont.setExercicioTipo("radio");                    
                cont.setIdAula(aulaId);
                // posicao

                DAOConteudo daoCont = new DAOConteudo();
                
                if (!pan) {                    
                    daoCont.cadastrar(cont);
                    mensagem += " na aula!";
                } else {
                    cont.setIdAula(provaId);
                    daoCont.cadastrarCP(cont);
                    mensagem += "na prova!";
                    
                    destino = "ControleExercicio?localizar&id="+provaId+"&tipo=prova&aulaId="+aulaId;
                }
                
                // Finaliza-----------------------------------------------------
                // Envia mensagem de sucesso
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino                
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            // Exercicio 'MultiplaEscolha'
            else if(request.getParameter("inserirMulti")!=null){
                
                // Instancia objeto
                ExercicioMEscolha exercicio = new ExercicioMEscolha();
                
                // Recupera os dados do formulário
                String titulo = request.getParameter("pergunta");
                exercicio.setTitulo(titulo);
                 
                // Recupera texto das alternativas
                String alternativas[] = request.getParameterValues("alternativa[]");
                exercicio.setAlternativa(alternativas);
                
                // Recupera respostas
                String resposta[] = null;
                if (request.getParameterValues("correta[]") != null) {
                    resposta = request.getParameterValues("correta[]");
                }
                
                
              
                // Declara um array e aloca a memória para X booleans
                boolean[] pan = new boolean[alternativas.length];
                
                
                // Itera pelas alternativas
                if (alternativas != null) {
                    for (int a = 0; a< alternativas.length; a++) {
                        
                        // Inicializa resposta atual como falsa
                        pan[a] = false;
                        
                        // Compara resposta atual e se necessário seta como verdadeira
                        if (resposta != null) {
                            for (int j=0; j<resposta.length; j++) {
                                if (Integer.parseInt(resposta[j]) == a+1) {
                                    pan[a] = true;
                                }
                            }
                        }
                    }
                }
                ////////////////////////////////////////////////////////////////
                exercicio.setCorreta(pan);
                
                                
                // Instancia DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.cadastrarMulti(exercicio);
                String mensagem = "Exercicio checkbox criado!";
                
                
                
                
                
                
                
                
                
                // Cadastra conteudo--------------------------------------------
                boolean pah = false;
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                int provaId = 0;
                
                try {
                    provaId = Integer.parseInt(request.getParameter("provaId"));
                    pah = true;
                } catch(NumberFormatException erro) {
                    
                }
                
                
                
                
                // Insere conteudo
                Conteudo cont = new Conteudo();
                cont.setExercicioTipo("checkbox");
                cont.setIdAula(aulaId);
                // posicao

                DAOConteudo daoCont = new DAOConteudo();
                
                if (!pah) {                    
                    daoCont.cadastrar(cont);
                    mensagem += " na aula!";
                } else {
                    cont.setIdAula(provaId);
                    daoCont.cadastrarCP(cont);
                    mensagem += " na prova!";                    
                    destino = "ControleExercicio?localizar&id="+provaId+"&tipo=prova&aulaId="+aulaId;
                }
                
                
                
                

                // Envia mensagem de sucesso
                request.setAttribute("mensagem", mensagem);
                request.setAttribute("destino", destino);
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            // Exercicio 'Lacunas'
            else if(request.getParameter("inserirLacunas")!=null){
                
                // Instancia objeto
                ExercicioLacunas exercicio = new ExercicioLacunas();
                
                // Recupera os dados do formulário e seta atributos
                String titulo = request.getParameter("pergunta");
                exercicio.setTitulo(titulo);
                
                String preTextos[] = request.getParameterValues("pre_texto[]");
                exercicio.setPreTexto(preTextos);
                
                String respostas[] = request.getParameterValues("resposta[]");
                exercicio.setResposta(respostas);
                
                String posTextos[] = request.getParameterValues("pos_texto[]");
                exercicio.setPosTexto(posTextos);
                
                
                
                
                // Instancia um objeto DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.cadastrarLacunas(exercicio);
                String mensagem = "Exercicio lacuna criado!";
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                // Cadastra conteudo--------------------------------------------
                boolean pah = false;
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                int provaId = 0;
                
                try {
                    provaId = Integer.parseInt(request.getParameter("provaId"));
                    pah = true;
                } catch(NumberFormatException erro) {
                    
                }
                
                
                
                
                // Insere conteudo
                Conteudo cont = new Conteudo();
                cont.setExercicioTipo("lacuna");
                cont.setIdAula(aulaId);
                // posicao

                DAOConteudo daoCont = new DAOConteudo();
                
                if (!pah) {                    
                    daoCont.cadastrar(cont);
                    mensagem += " na aula!";
                } else {
                    cont.setIdAula(provaId);
                    daoCont.cadastrarCP(cont);
                    mensagem += " na prova!";                    
                    destino = "ControleExercicio?localizar&id="+provaId+"&tipo=prova&aulaId="+aulaId;
                }

                // Envia mensagem de sucesso                
                request.setAttribute("mensagem", mensagem);
                request.setAttribute("destino", destino);
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            // Exercicio 'Texto'
            else if(request.getParameter("inserirTexto")!=null){
                
                // Instancia objeto
                Texto exercicio = new Texto();
                
                // Recupera os dados do formulário e seta atributos
                String titulo = request.getParameter("titulo");
                exercicio.setTitulo(titulo);
                
                String texto = request.getParameter("texto");
                exercicio.setTexto(texto);
                
                
                
                // Instancia um objeto DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.cadastrar(exercicio);
                
                // Insere conteudo
                Conteudo cont = new Conteudo();
                cont.setExercicioTipo("texto");
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                cont.setIdAula(aulaId);
                // posicao
                
                DAOConteudo daoCont = new DAOConteudo();
                daoCont.cadastrar(cont);

                // Envia mensagem de sucesso
                String mensagem = "Texto criado!";
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            // Exercicio 'Texto'
            else if(request.getParameter("inserirImagem") != null) {
                
                //MultipartRequest multipartRequest = new MultipartRequest(request, getServletContext().getRealPath("/APPS/adm/upload/tmp/"), /* 150MB */ 153600 * 153600, new DefaultFileRenamePolicy());
                String endereco = getServletContext().getRealPath("/arquivos/imagens/uploads/");
                int tamanho = 153600 * 153600;/* 150MB */ 
                
                MultipartRequest multipartRequest = new MultipartRequest(request, endereco, tamanho, new DefaultFileRenamePolicy());
                
                //if (multipartRequest.getParameter("save") != null) {
                    upload(request, response, multipartRequest);
                /*} else {
                    throw new IOException();
                }*/
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            else if(request.getParameter("inserirProva")!=null){
                // Instancia objeto
                Prova exercicio = new Prova();
                
                // Recupera os dados do formulário e seta atributos
                int duracao =  Integer.parseInt(request.getParameter("duracao"));
                int retorno =  Integer.parseInt(request.getParameter("retry"));
                //boolean random = request.getParameter("randomOrder");
                boolean random = false;
                
                
                exercicio.setDuracao(duracao);
                exercicio.setRetorno(retorno);
                exercicio.setRandomOrder(random);
                
                
                // Instancia um objeto DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.cadastrar(exercicio);
                
                // Insere conteudo
                Conteudo cont = new Conteudo();
                cont.setExercicioTipo("prova");
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                cont.setIdAula(aulaId);
                // posicao
                
                DAOConteudo daoCont = new DAOConteudo();
                daoCont.cadastrar(cont);

                // Envia mensagem de sucesso
                String mensagem = "Prova criada!";
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            else if(request.getParameter("localizar")!=null) {
                int id = Integer.parseInt(request.getParameter("id"));
                String tipo = request.getParameter("tipo");
                
                String pagina = "";
                if (tipo.equals("radio")) {
                    ExercicioVF exercicio = new ExercicioVF();
                    exercicio.setId(id);

                    DAOExercicio daoEx = new DAOExercicio();
                    ExercicioVF ex = new ExercicioVF();
                    ex = daoEx.localizar(exercicio);

                    // Coloca o objeto resultado na sessão
                    request.setAttribute("exercicio", ex);
                    // Define página de destino
                    pagina = "/editarVF.jsp";
                    
                    
                    
                    
                    
                } else if (tipo.equals("checkbox")) {
                    ExercicioMEscolha exercicio = new ExercicioMEscolha();
                    exercicio.setId(id);

                    DAOExercicio daoEx = new DAOExercicio();
                    ExercicioMEscolha ex = new ExercicioMEscolha();
                    ex = daoEx.localizar(exercicio);

                    // Coloca o objeto resultado na sessão
                    request.setAttribute("exercicio", ex);
                    // Define página de destino
                    pagina = "/editarMEscolha.jsp";
                } else if (tipo.equals("lacuna")) {
                    ExercicioLacunas exercicio = new ExercicioLacunas();
                    exercicio.setId(id);

                    DAOExercicio daoEx = new DAOExercicio();
                    ExercicioLacunas ex = new ExercicioLacunas();
                    ex = daoEx.localizar(exercicio);

                    // Coloca o objeto resultado na sessão
                    request.setAttribute("exercicio", ex);
                    // Define página de destino
                    pagina = "/editarLacuna.jsp";
                } else if (tipo.equals("texto")) {
                    Texto exercicio = new Texto();
                    exercicio.setId(id);

                    DAOExercicio daoEx = new DAOExercicio();
                    Texto ex = new Texto();
                    ex = daoEx.localizar(exercicio);

                    // Coloca o objeto resultado na sessão
                    request.setAttribute("exercicio", ex);
                    // Define página de destino
                    pagina = "/editarTexto.jsp";
                } else if (tipo.equals("arquivo")) {
                    Arquivo exercicio = new Arquivo();
                    exercicio.setId(id);

                    DAOExercicio daoEx = new DAOExercicio();
                    Arquivo ex = new Arquivo();
                    ex = daoEx.localizar(exercicio);

                    // Coloca o objeto resultado na sessão
                    request.setAttribute("exercicio", ex);
                    // Define página de destino
                    pagina = "/editarImagem.jsp";
                } else if (tipo.equals("prova")) {
                    Prova exercicio = new Prova();
                    exercicio.setId(id);

                    DAOExercicio daoEx = new DAOExercicio();
                    Prova ex = new Prova();
                    ex = daoEx.localizar(exercicio);

                    // Coloca o objeto resultado na sessão
                    request.setAttribute("exercicio", ex);
                    // Define página de destino
                    pagina = "/gerenciarProva.jsp";
                }

                
                request.getRequestDispatcher(pagina).forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            // Exercicio 'Verdadeiro/Falso'
            else if(request.getParameter("editarVF")!=null){
                
                // Instancia exercicio
                ExercicioVF exercicio = new ExercicioVF();
                
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                exercicio.setResposta(aulaId);///////////////////////////////////////////////////////////////////
                
                // Recupera do formulário e seta atributos
                String titulo = request.getParameter("pergunta");
                exercicio.setTitulo(titulo);
                
                
                //
                
                int correta = Integer.parseInt(request.getParameter("resposta"));
                exercicio.setResposta(correta);
                
                int id = Integer.parseInt(request.getParameter("id"));
                exercicio.setId(id);
                
                
                                
                // Recupera alternativas
                String alternativas[] = request.getParameterValues("alternativa[]");
                exercicio.setAlternativa(alternativas);
                
                // Instancia DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.atualizar(exercicio);
                
                
                
                // Envia mensagem de sucesso
                String mensagem = "Exercicio radio atualizado!";
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                
                if (request.getParameter("provaConteudo") != null) {
                    //destino = "home";
                    destino = "ControleExercicio?localizar&id="+request.getParameter("prova")+"&tipo=prova&aulaId="+aulaId;
                }
                
                //String destino = "home";
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
               
            
            
            
            
            
            
            
            
            
            
            // Exercicio 'Verdadeiro/Falso'
            else if(request.getParameter("editarMEscolha")!=null){
                
                // Instancia exercicio
                ExercicioMEscolha exercicio = new ExercicioMEscolha();
                
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                //exercicio.setResposta(aulaId);
                                
                int id = Integer.parseInt(request.getParameter("id"));
                exercicio.setId(id);
                
                
                // Recupera os dados do formulário
                String titulo = request.getParameter("pergunta");
                exercicio.setTitulo(titulo);
                 
                // Recupera texto das alternativas
                String alternativas[] = request.getParameterValues("alternativa[]");
                exercicio.setAlternativa(alternativas);
                
                // Recupera respostas
                String resposta[] = null;
                if (request.getParameterValues("correta[]") != null) {
                    resposta = request.getParameterValues("correta[]");
                }
                
                
              
                // Declara um array e aloca a memória para X booleans
                boolean[] pan;
                pan = new boolean[alternativas.length];
                
                
                // Itera pelas alternativas
                if (alternativas != null) {
                    for (int a = 0; a< alternativas.length; a++) {
                        
                        // Inicializa resposta atual como falsa
                        pan[a] = false;
                        
                        // Compara resposta atual e se necessário seta como verdadeira
                        if (resposta != null) {
                            for (int j=0; j<resposta.length; j++) {
                                if (Integer.parseInt(resposta[j]) == a+1) {
                                    pan[a] = true;
                                }
                            }
                        }
                    }
                }
                ////////////////////////////////////////////////////////////////
                exercicio.setCorreta(pan);
                
                
                // Instancia DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.atualizar(exercicio);
                
                
                
                // Envia mensagem de sucesso
                String mensagem = "Exercicio checkbox atualizado!";
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                if (request.getParameter("provaConteudo") != null) {
                    //destino = "home";
                    destino = "ControleExercicio?localizar&id="+request.getParameter("prova")+"&tipo=prova&aulaId="+aulaId;
                }
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            // Exercicio 'Verdadeiro/Falso'
            else if(request.getParameter("editarLacuna")!=null){
                
                // Instancia exercicio
                ExercicioLacunas exercicio = new ExercicioLacunas();
                
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                                
                int id = Integer.parseInt(request.getParameter("id"));
                exercicio.setId(id);
                
                
                // Recupera os dados do formulário
                String titulo = request.getParameter("pergunta");
                exercicio.setTitulo(titulo);
                 
                
                String preTextos[] = request.getParameterValues("pre_texto[]");
                exercicio.setPreTexto(preTextos);
                
                String respostas[] = request.getParameterValues("resposta[]");
                exercicio.setResposta(respostas);
                
                String posTextos[] = request.getParameterValues("pos_texto[]");
                exercicio.setPosTexto(posTextos);
                
                
                // Instancia DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.atualizar(exercicio);
                
                
                
                // Envia mensagem de sucesso
                String mensagem = "Exercicio lacuna atualizado!";
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                if (request.getParameter("provaConteudo") != null) {
                    //destino = "home";
                    destino = "ControleExercicio?localizar&id="+request.getParameter("prova")+"&tipo=prova&aulaId="+aulaId;
                }
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            // Exercicio 'Verdadeiro/Falso'
            else if(request.getParameter("editarTexto")!=null){
                
                // Instancia exercicio
                Texto exercicio = new Texto();
                
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                                
                int id = Integer.parseInt(request.getParameter("id"));
                exercicio.setId(id);
                
                // Recupera os dados do formulário e seta atributos
                String titulo = request.getParameter("titulo");
                exercicio.setTitulo(titulo);
                
                String texto = request.getParameter("texto");
                exercicio.setTexto(texto);
                
                
                // Instancia DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.atualizar(exercicio);
                
                
                
                // Envia mensagem de sucesso
                String mensagem = "Texto atualizado!";
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            // Exercicio 'Verdadeiro/Falso'
            else if(request.getParameter("editarImagem")!=null){
                
                // Instancia exercicio
                Arquivo exercicio = new Arquivo();
                
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                                
                int id = Integer.parseInt(request.getParameter("id"));
                exercicio.setId(id);
                
                // Recupera os dados do formulário e seta atributos
                String titulo = request.getParameter("titulo");
                exercicio.setTitulo(titulo);
                
                String texto = request.getParameter("legenda");
                exercicio.setLegenda(texto);
                
                
                // Instancia DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.atualizar(exercicio);
                
                
                
                // Envia mensagem de sucesso
                String mensagem = "Imagem atualizada!";
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            // Exercicio 'Verdadeiro/Falso'
            else if(request.getParameter("editarProva")!=null){
                
                // Instancia exercicio
                Prova exercicio = new Prova();
                
                int aulaId = Integer.parseInt(request.getParameter("aulaId"));
                                
                int id = Integer.parseInt(request.getParameter("id"));
                exercicio.setId(id);
                
                 // Recupera os dados do formulário e seta atributos
                int duracao =  Integer.parseInt(request.getParameter("duracao"));
                int retorno =  Integer.parseInt(request.getParameter("retry"));
                //boolean random = request.getParameter("randomOrder");
                boolean random = false;
                
                
                exercicio.setDuracao(duracao);
                exercicio.setRetorno(retorno);
                exercicio.setRandomOrder(random);
                
                
                // Instancia DAOExercicio e chama método inserir
                DAOExercicio daoEx = new DAOExercicio();
                daoEx.atualizar(exercicio);
                
                
                
                // Envia mensagem de sucesso
                String mensagem = "Prova atualizada!";
                request.setAttribute("mensagem", mensagem);
                
                // Define página de destino
                String destino = "ControleAula?localizar&Incluir&id="+aulaId;
                request.setAttribute("destino", destino);
                
                // Redireciona página
                request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
            }
            
            
            
            
            
            
            
            
            
            // Exercicio 'Verdadeiro/Falso'
            else if(request.getParameter("corrigir")!=null){
                
                Aula aula = new Aula();
                 
                // Recupera o id selecionado
                int id = Integer.parseInt(request.getParameter("id"));

                // Localiza aula pelo id
                DAOAula aulaDAO = new DAOAula();
                aula = aulaDAO.localizarPorId(id);
                    
                // Localiza conteudo da aula
                DAOConteudo dao = new DAOConteudo();
                ArrayList<Conteudo> lista = dao.listar(id);

                //-----------------------------------------------------------------
                ArrayList<Exercicio> listaRespostas = new ArrayList<Exercicio>();
                 
                
                
                
                //String teste = "";
                int z = 0;
                for (Conteudo cont: lista) {
                    
                   
                    ///if tipo de exercicio
                    if ("radio".equals(cont.getExercicioTipo())) {
                        ///if tipo de exercicio
                        ExercicioVF e = new ExercicioVF();

                        int resposta = 0;
                        try {
                            int num = cont.getIdExercicio();
                            resposta = Integer.parseInt(request.getParameter("alternativa"+num));

                        } catch(Exception er) {
                            System.out.print(er.getMessage());                        
                        }

                        e.setResposta(resposta);
                        listaRespostas.add(e);
                        z++;
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    else if ("checkbox".equals(cont.getExercicioTipo())) {
                        
                        ExercicioMEscolha e = new ExercicioMEscolha();
                        
                        try {
                            
                        
                            int num = cont.getIdExercicio();                           
                            
                            String[] respostaDadas = request.getParameterValues("alternativa"+num+"[]");
                            
                            int numAlternativasEx = Integer.parseInt(request.getParameter("numAlternativasEx"+num));
                            boolean[] respostas2 = new boolean[numAlternativasEx];
                            
                            if (respostaDadas != null) {
                                for (int a = 0; a< respostaDadas.length; a++) {
                                    // Indices contidos em respostas dadas são setados como verdadeiros
                                    int x = Integer.parseInt(respostaDadas[a]);
                                    respostas2[x-1] = true;
                                }
                            }
                            
                                
                            
                            e.setCorreta(respostas2);
                        } catch(Exception er) {
                            System.out.print(er.getMessage());                        
                        }

                        //e.setCorreta(respostas);
                        listaRespostas.add(e);
                        z++;
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    else if ("lacuna".equals(cont.getExercicioTipo())) {
                        
                        ExercicioLacunas e = new ExercicioLacunas();
                        
                        try {   
                            String[] respostaDadas = request.getParameterValues("alternativa"+cont.getIdExercicio()+"[]");
                            e.setResposta(respostaDadas);
                        } catch(Exception er) {
                            System.out.print(er.getMessage());                        
                        }

                        listaRespostas.add(e);
                        z++;
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                //-----------------------------------------------------------------

                // Coloca objetos resultado na sessão e define página de destino
                request.setAttribute("aula", aula);
                request.setAttribute("lista", lista);
                request.setAttribute("listaRespostas", listaRespostas);
                String pagina = "/iniciarCorrecao.jsp";
                
                // Envia para página de destino
                request.getRequestDispatcher(pagina).forward(request, response);
            }
            
            
            
            
            
            
            
            
        //TRATAMENTO DE EXCEÇÕES-----------------------------------------------------------
        } catch(Exception erro){
            request.setAttribute("erro", erro);
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        }
    }
    
    
    private void upload(HttpServletRequest request, HttpServletResponse response, MultipartRequest multipartRequest) throws IOException, ClassNotFoundException, SQLException { //OK  
        
        // Instancia objeto
        Arquivo exercicio = new Arquivo();
        exercicio.setTipo("imagem");
  
        String nome = "foto";
        File tmpFile = multipartRequest.getFile("arquivo"); //esse daqui é o name do input file
        int beginIndex = getServletContext().getRealPath("/arquivos/imagens/uploads/").length() + 1;
        nome = tmpFile.getPath().substring(beginIndex);
       
        
        String fileName = getServletContext().getRealPath("/arquivos/imagens/uploads/" + nome);
        File f=new File(fileName);
        
        
        String extensao = "";
        extensao = nome.substring(nome.lastIndexOf("."));
        
        
        int x = 0;
        DAOExercicio daoEx = new DAOExercicio();
        x = daoEx.retornarMaxId() + 1;
        
        String nomeNovo = x + extensao;
        //boolean flag = f.renameTo(new File(getServletContext().getRealPath("/arquivos/imagens/uploads/" + nomeNovo)));
        f.renameTo(new File(getServletContext().getRealPath("/arquivos/imagens/uploads/" + nomeNovo)));
        
        
        
//        ImageIcon img = new ImageIcon (Form.class.getClassLoader().getResource(getServletContext().getRealPath("/arquivos/imagens/uploads/" + nomeNovo)));  
//img.setImage(img.getImage().getScaledInstance(50, 50, 100));
        
        /*
// Cria channel na origem
        
        // faz cópia da imagem
FileChannel oriChannel = new FileInputStream(getServletContext().getRealPath("/arquivos/imagens/uploads/" + nomeNovo)).getChannel();
// Cria channel no destino
FileChannel destChannel = new FileOutputStream(getServletContext().getRealPath("/arquivos/imagens/uploads/thumb" + nomeNovo)).getChannel();
// Copia conteúdo da origem no destino
destChannel.transferFrom(oriChannel, 0, oriChannel.size());

// Fecha channels
oriChannel.close();
destChannel.close();

         * 
         */


    //String pathImg = "C:\\Documents and Settings\\ricardo\\Meus documentos\\Minhas imagens\\foto.jpg";
    String pathImg = getServletContext().getRealPath("/arquivos/imagens/uploads/" + nomeNovo);
    File imgFile = new File(pathImg);
 
    //String destino = "C:\\Documents and Settings\\ricardo\\Desktop\\thumbs.jpg";
    String destino = getServletContext().getRealPath("/arquivos/imagens/uploads/thumb" + nomeNovo);
    File imgDestino = new File(destino);
 
    try {
        redimensionarImagem(imgFile, imgDestino, 200, 200);
    } catch (Exception e) {
        e.printStackTrace();
    }
/*
BufferedImage bufImagemLida =  ImageIO.read();

			//cria imagem para
			BufferedImage imagemRedimensionada = new BufferedImage(largura,altura , BufferedImage.TYPE_INT_RGB);

			//realiza o redimensionamento da imagem
			graphisImagem = imagemRedimensionada.createGraphics();
			graphisImagem.drawImage(bufImagemLida,0,0, largura, altura,null);
			baos = new ByteArrayOutputStream();

			//escreve a imagem no OutputStream
			ImageIO.write(imagemRedimensionada, EXTENSAO, baos);


 * 
 */





        /*
        //f = new File(fileName);
        BufferedImage imagem = null;  
        try {  
            //imagem = ImageIO.read(f);
            //RedimensionarImagem.class.getResourceAsStream("background.jpg")
                    
		imagem = ImageIO.read(ControleExercicio.class.getResourceAsStream("C:/Users/Mark/Desktop/eAula!9/Implementação/Netbeans/TCC/build/web/arquivos/imagens/uploads/54.jpg"));
        } catch (IOException ex) {  
            System.out.print("fdf");
        }  
        
        BufferedImage new_img = new BufferedImage(200, 200, BufferedImage.TYPE_INT_RGB);  
        Graphics2D g = new_img.createGraphics();  
  
        g.drawImage(imagem, 0, 0, 200, 200, null);  
        ImageIO.write(new_img, "JPG", new File("/arquivos/imagens/uploads/" + nomeNovo));  
        
         * 
         */
        
        
        
        String titulo = multipartRequest.getParameter("titulo");        
        String legenda = multipartRequest.getParameter("legenda");
        int aulaId = Integer.parseInt(multipartRequest.getParameter("aulaId"));
        
        exercicio.setTitulo(titulo);
        exercicio.setLegenda(legenda);
        exercicio.setNome(nomeNovo);
        
         // Insere conteudo
        Conteudo cont = new Conteudo();
        cont.setExercicioTipo("arquivo");
        cont.setIdAula(aulaId);
  

        try {
            // Instancia um objeto DAOExercicio e chama método inserir
            daoEx.Conectar();
            daoEx.cadastrar(exercicio);
            
            DAOConteudo daoCont = new DAOConteudo();
            daoCont.cadastrar(cont);
            
            // Envia mensagem de sucesso
            String mensagem = "Imagem criada!";
            String destino2 = "ControleAula?localizar&Incluir&id="+aulaId;
            
            // Redireciona página
            request.setAttribute("mensagem", mensagem);
            request.setAttribute("destino", destino2);
            request.getRequestDispatcher("/sucesso.jsp").forward(request, response);
        } catch (Exception erro) {

        }
    }
    
    /**
* Salva uma imagem redimensionada (thumbs) no disco.
*
* @param fileImgOriginal
* @param fileImgRedimensionada
* @param altura
* @param largura
* @throws Exception
*/
private static void redimensionarImagem(File fileImgOriginal, File fileImgRedimensionada, int altura, int largura)
        throws Exception {
 
    // Primeiramente, vamos verificar se a imagem original existe e se ela
    // pode ser lida para que possamos redimensiona-la e salva-la em disco.
    if (!fileImgOriginal.exists()) {
        throw new Exception(
                "A imagem que você quer redimensionar não existe");
    }
 
    // Vamos ver se a imagem pode ser lida
    if (!fileImgOriginal.canRead()) {
        throw new Exception(
                "A imagem que você quer redimensionar não pode ser lida");
    }
 
    // Se passou pelas verificações acima, vamos ler a imagem e obter um
    // objeto do tipo Image
    Image imagem = ImageIO.read(fileImgOriginal);
 
    // Agora, vamos obter um objeto do tipo imagem novamente, só que
    // reduzindo seu tamanho para o tamanho que queremos.
    Image thumbs = imagem.getScaledInstance(largura, altura,BufferedImage.SCALE_SMOOTH);
 
    // Já temos nosso thumbs criado em memória. Precisamos salvar esse
    // thumbs em disco. Para isso, usaremos o objeto BufferedImage
    BufferedImage buffer = new BufferedImage(largura, altura,BufferedImage.TYPE_INT_RGB);
         
    // Desenha a imagem, que foi redimensionada acima, no buffer.
    buffer.createGraphics().drawImage(thumbs, 0, 0, null);
     
    // Salva a imagem no disco!
    ImageIO.write(buffer, getExtension(fileImgRedimensionada), fileImgRedimensionada);
         
    // Faz o "flush" do buffer
    buffer.flush();
}

private static String getExtension(File file) {
    String nomeArq = file.getName();
    String ext = nomeArq.substring(nomeArq.lastIndexOf('.') + 1);
    return ext;
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