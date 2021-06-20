package Tarefa;

import Dominio.Aula;
import Dominio.Disciplina;
import Dominio.Endereco;
//import Dominio.ObjectDomain;
//import Dominio.Usuario;
import Dominio.Materia;
import Persistencia.ConectaBanco;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
//import java.security.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.text.DateFormat;
import java.util.ArrayList;
//import java.util.Date;
//import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mark
 */
public class MontaSql extends HttpServlet{
    
    // Variável de instância que define a conexão com o BD
    private Connection conexao;
    
    // Ao ser instanciado cria conexão com o BD
    public MontaSql() {
        try {
            this.conexao = ConectaBanco.getConexao();
        } catch (Exception erro) {
            // Dar tratamento melhor para o erro
            System.out.print(erro);
        }
    }
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            // Inicializa instrução sql
            String sql = "";
            
            // Instancia lista geral
            ArrayList<ArrayList> lista = new ArrayList <ArrayList>();
            
            // Instancia sublistas
            ArrayList <String> listaAtributos = new ArrayList <String>();
            ArrayList <String> listaValores = new ArrayList <String>();
            ArrayList <String> listaTipos = new ArrayList <String>();
            
            // Adiciona sublistas na lista geral
            lista.add(listaAtributos);
            lista.add(listaValores);
            lista.add(listaTipos);
            
            
            
            
            ////////////////////////////////////////////////////////////////////
            // AMBTST
            ////////////////////////////////////////////////////////////////////
            // Vai receber operacao
            int operacao = 0;
            // 1 = INSERT  adicionar a todos campos pra q? -- ok
            // 2 = SELECT  problema para exibir e selecionar por multiplos param
            // 3 = UPDATE -- Tem q ser por id -- ok
            // 4 = DELETE ok
            
            // Vai receber objeto
            Disciplina objeto = new Disciplina();
            //objeto.setId(36);
            //objeto.setDescricao("^^");
            //objeto.setAutor("Mark");
            //objeto.setArea("power");
            //objeto.setTitulo("monster");
            //objeto.setArea("1");
            //objeto.setTitulo("vazia");
            //objeto.setTipoAula(1);
            
            
            // Desmembra os atributos do objeto e os insere nas sublistas
            // Chama métodos conforme operação solicitada
            switch(operacao) {
                case 0:
                    lista = (ArrayList) desmembrar(objeto, false, lista);
                    sql += getCriarTabela(lista, objeto);
                    sql += "<hr />";
                    sql += descrever(lista, objeto);
                    sql += "<hr />";
                    sql += getInserir(lista, objeto);
                    sql += "<hr />";
                    sql += getLocalizar(lista, objeto);
                    sql += "<hr />";
                    sql += getAtualizar(lista, objeto);
                    sql += "<hr />";
                    sql += getDeletar(lista, objeto);
                    sql += "<hr />";

                    // AMBTST
                    sql = verificarInterrogacoes(operacao, lista, sql);
                break;
                case 1:
                    lista = (ArrayList) desmembrar(objeto, true, lista);
                    sql += getInserir(lista, objeto);
                    executarComando(operacao, lista, sql);
                break;
                case 2:
                    
                    try {
                       // lista = (ArrayList) desmembrar(objeto, true, lista);
                        //sql += getLocalizar(lista, objeto);
                        
                        ArrayList<Aula> listaObjeto = new ArrayList <Aula>();
                        //listaAtributos = (ArrayList) lista.get(0);
                        
                        
                        //if (listaAtributos.isEmpty()) {
                            listaObjeto = listar();
                        //} else {
                            //listaObjeto = executarConsulta(lista, sql);
                            
                        //}
                        sql += listaObjeto.size();
                        sql += listaObjeto;
                        //request.setAttribute("resultado", listaObjeto);
                        //request.getRequestDispatcher("/pesquisaAula.jsp").forward(request, response);
                    } catch(Exception erro) {
                        request.setAttribute("erro", erro);
                        request.getRequestDispatcher("/erro.jsp").forward(request, response);
                    }
                    
                break;
                case 3:
                    lista = (ArrayList) desmembrar(objeto, true, lista);
                    sql += getAtualizar(lista, objeto);
                    executarComando(operacao, lista, sql);
                    
                break;
                case 4:
                    lista = (ArrayList) desmembrar(objeto, true, lista);
                    sql += getDeletar(lista, objeto);
                    executarComando(operacao, lista, sql);
                break;
            }
            
            
            String mensagem = sql;
            
            
            request.setAttribute("mensagem", mensagem);
            request.getRequestDispatcher("/z_mensagem.jsp").forward(request, response);
            
            
            
        //TRATAMENTO DE EXCEÇÕES-----------------------------------------------------------
        } catch (Exception erro) {
            request.setAttribute("erro", erro);
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        }
    }
    
    
    public ArrayList<Aula> listar() throws SQLException, ClassNotFoundException {
        
        // Cria um objeto do tipo ArrayList de usuarios
        ArrayList<Aula> listaObjeto = new ArrayList<Aula>();
        
        try {
            // SQL de consulta
            PreparedStatement stmt = conexao.prepareStatement("SELECT * FROM aulas;");

            // Executa a consulta e quarda o resultado em um ResultSet
            ResultSet resultado = stmt.executeQuery();

            while(resultado.next()){
                //cria um novo aula a cada loop
                Aula novoAula = new Aula();

                //seta atributos da aula
                novoAula.setId(resultado.getInt("id"));
                novoAula.setTitulo(resultado.getString("titulo"));
                novoAula.setDescricao(resultado.getString("descricao"));
                ///novoAula.setAutor(resultado.getString("autor"));
                novoAula.setIdDisciplina(resultado.getInt("id_disciplina"));
                novoAula.setRestrita(resultado.getBoolean("tipo"));
                novoAula.setSenha(resultado.getString("senha"));
                novoAula.setDataCriacao(resultado.getTimestamp("datacriacao"));
                novoAula.setDataAtualizacao(resultado.getTimestamp("dataatualizacao"));
                novoAula.setUtilizacoes(resultado.getInt("utilizacoes"));
                novoAula.setVotos(resultado.getInt("votos"));
                novoAula.setMedia(resultado.getInt("media"));
                novoAula.setConclusoes(resultado.getInt("conclusoes"));
                //novoAula.setAprovacao(resultado.getInt("aprovacao"));

                // insere aula na lista
                listaObjeto.add(novoAula);
            }
            resultado.close();
            
        } catch (Exception erro) {
            
        } finally {
            //Retorna a lista de usuarios
            conexao.close();
            return listaObjeto;
        }
    }
    
    
    
    
    
    
    
    //método listar, devolve uma lista de usuarios
    //@Override
    public ArrayList<Aula> executarConsulta(ArrayList lista, String sql) throws SQLException, ClassNotFoundException {
        
        ArrayList <String> listaValores = (ArrayList) lista.get(1);
        ArrayList <String> listaTipos = (ArrayList) lista.get(2);
        
        // Cria um objeto do tipo ArrayList de usuarios
        ArrayList<Aula> listaObjeto = new ArrayList<Aula>();
        
        
        try {
            // SQL de consulta
            PreparedStatement stmt = conexao.prepareStatement(sql);

            // Contabiliza campos da lista
            int campos = listaValores.size();

            if (campos > 0) {

                // Pular Id
                int campoInicial = 0;
                int intervalo = 1;

                // Itera pelos campos
                for(int i = campoInicial; i < campos; i++){
                    String temp = listaValores.get(i).toString();

                    // Define valor e tipo das interrogações do sql
                    if ("java.lang.String".equals(listaTipos.get(i))) {
                        stmt.setString((i + intervalo), temp);
                    } else if ("int".equals(listaTipos.get(i))) {
                        stmt.setInt((i + intervalo), Integer.parseInt(temp));
                    } else if ("java.lang.Long".equals(listaTipos.get(i))) {
                        stmt.setLong((i + intervalo), +Long.parseLong(temp));
                    } else if ("float".equals(listaTipos.get(i))) {
                        stmt.setFloat((i + intervalo), Float.parseFloat(temp));
                    } else if ("java.lang.Boolean".equals(listaTipos.get(i))) {
                        stmt.setBoolean((i + 1), Boolean.parseBoolean(temp));   
                    }
                }
            }






            // Executa a consulta e quarda o resultado em um ResultSet
            ResultSet resultado = stmt.executeQuery();

            
            while(resultado.next()){
                //cria um novo aula a cada loop
                Aula novoAula = new Aula();

                //seta atributos da aula
                novoAula.setId(resultado.getInt("id"));
                novoAula.setTitulo(resultado.getString("titulo"));
                novoAula.setDescricao(resultado.getString("descricao"));
///                novoAula.setAutor(resultado.getString("autor"));
                novoAula.setIdDisciplina(resultado.getInt("disciplina"));
                novoAula.setRestrita(resultado.getBoolean("tipo"));
                novoAula.setSenha(resultado.getString("senha"));
                novoAula.setDataCriacao(resultado.getTimestamp("datacriacao"));
                novoAula.setDataAtualizacao(resultado.getTimestamp("dataatualizacao"));
                novoAula.setUtilizacoes(resultado.getInt("utilizacoes"));
                novoAula.setVotos(resultado.getInt("votos"));
                novoAula.setMedia(resultado.getInt("media"));
                novoAula.setConclusoes(resultado.getInt("conclusoes"));
                //novoAula.setAprovacao(resultado.getInt("aprovacao"));

                // insere aula na lista
                listaObjeto.add(novoAula);
            }
            resultado.close();
            
        } catch (Exception erro) {
            
        } finally {
            //Retorna a lista de usuarios
            conexao.close();
            return listaObjeto;
        }
    }
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////
    public String descrever(ArrayList lista, Object objeto) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
        // converte objeto para poder usar getId()
        
        //------------------------------------------------------------------------------------------------------------------------------
        //Usuario objeto = (Usuario) obj;
        

        ArrayList <String> listaAtributos = (ArrayList) lista.get(0);
        ArrayList <String> listaValores = (ArrayList) lista.get(1);
        ArrayList <String> listaTipos = (ArrayList) lista.get(2);
        
        int campos = 0;
        campos = listaAtributos.size();
        
        // Pega nome da classe
        String sql = "Classe: " + objeto.getClass().getSimpleName();
        sql += "<table style='float: right'><tr>";
        sql += "<th>#</th>";
        sql += "<th>Atributos</th>";
        sql += "<th>Valores</th>";
        sql += "<th>Tipos</th>";
        
        
        // adicionar as colunas à instrução SQL.
        for(int i = 0; i< campos; i++) {
            sql += "<tr>";
            sql += "<td>";
            sql += i + 1;
            sql += "</td>";
            sql += "<td>";
            sql += listaAtributos.get(i);
            sql += "</td>";
            sql += "<td>";
            sql += listaValores.get(i);
            sql += "</td>";
            sql += "<td>";
            sql += listaTipos.get(i);
            sql += "</td>";
            sql += "</tr>";
        }
       
        // Finaliza e retorna instrução sql
        sql += "</table>";
        return sql;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////   
    public String getCriarTabela(ArrayList lista, Object objeto) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
        
        // Inicia construção da instrução sql
        String sql = "";
        sql += "DROP TABLE IF EXISTS " + objeto.getClass().getSimpleName().toLowerCase()+"s;";
        sql += "<br />CREATE TABLE " + objeto.getClass().getSimpleName().toLowerCase()+"s (<br />";
        
        
        ArrayList listaAtributos = (ArrayList) lista.get(0);
        //ArrayList listaValores = (ArrayList) lista.get(1);
        ArrayList listaTipos = (ArrayList) lista.get(2);
        
        int campos = 0;
        campos = listaAtributos.size();

        // adicionar as colunas à instrução SQL.
        for(int i = 0; i< campos; i++) {
            sql += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            sql += listaAtributos.get(i);
            sql += " ";
            //sql += listaTipos.get(i);
            
                // Define o tipo do campo
                if ("java.lang.String".equals(listaTipos.get(i))) {
                    sql += "VARCHAR(20)";
                } else if ("int".equals(listaTipos.get(i))) {
                    sql += "NUMERIC(9)";
                } else if ("java.lang.Long".equals(listaTipos.get(i))) {
                    sql += "NUMERIC(15)";
                } else if ("float".equals(listaTipos.get(i))) {
                    sql += "NUMERIC(3,2)";
                } else if ("java.lang.Boolean".equals(listaTipos.get(i))) {
                    sql += "BOOLEAN";
                } else if ("java.util.Date".equals(listaTipos.get(i))) {
                    sql += "DATE";
                } else if ("java.sql.Timestamp".equals(listaTipos.get(i))) {
                    sql += "TIMESTAMP";
                } else {
                    sql += listaAtributos.get(i);
                    sql += listaTipos.get(i);
                }
                
            // Adiciona separador
            if (i < campos - 1) {
                sql += ", ";
            }
            sql += "<br />";
        }
       
        // Finaliza e retorna instrução sql
        sql += ");";
        return sql;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    public String getLocalizar(ArrayList lista, Object objeto) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
        
        
        ArrayList <String> listaAtributos = (ArrayList) lista.get(0);
        
        ArrayList <String> listaTipos = (ArrayList) lista.get(2);
        
        // Inicia construção da instrução sql
        String sql = "";
        sql += "SELECT * FROM " + objeto.getClass().getSimpleName().toLowerCase() + "s";
        
        
        int campos = 0;        
        campos = listaAtributos.size();
        
        if (campos > 0){
            sql += " WHERE ";
        
            // Adiciona os atributos à instrução SQL.
            for(int i = 0; i< campos; i++) {
                sql += listaAtributos.get(i);
                
                //if (listaTipos.get(i).equals("java.lang.String")) {
                  //  sql += " LIKE ?";
                //} else {
                    sql += "=?";
                //}

                // Adiciona separador
                if (i < campos - 1) {
                    sql += ", ";
                }
            }
        }
       
        // Finaliza e retorna instrução sql
        sql += ";";
        return sql;
    }
    ////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////   
    public String getAtualizar(ArrayList lista, Object objeto) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
        
        // Inicia construção dinamica da instrução SQL
        String sql = "";
        sql += "UPDATE " + objeto.getClass().getSimpleName().toLowerCase()+ "s SET ";
        String condicao = "";
        condicao += " WHERE ";
        
        // Recupera lista de nomes dos atributos
        ArrayList <String> listaAtributos = (ArrayList) lista.get(0);        
       
        // Define número de campos
        int campos = listaAtributos.size();
        
        // Pular Id
        int campoInicial = 0;
        
        if (listaAtributos.get(0).equals("id")) {
            campoInicial = 1;
        }

        // Adiciona nomes dos atributos à instrução SQL
        for(int i = campoInicial; i < campos; i++) {
            
            // Concatena nome do atributo
            sql += listaAtributos.get(i) + "=?";
                        
            // Adiciona separador
            if (i < campos - 1) {
                sql += ", ";
            }
        }
        
        // Finaliza e retorna instrução sql
        sql += condicao + "id=?;";
        return sql;
    }
    ////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////   
    public String getInserir(ArrayList lista, Object objeto) {
        
        ArrayList <String> listaAtributos = (ArrayList) lista.get(0);
        
        // Inicia construção da instrução sql
        String sql = "";
        sql += "INSERT INTO " + objeto.getClass().getSimpleName().toLowerCase() + "s (";

        // Inicia a parte dos valores do SQL
        String valores = "";
        
        int campos = 0;
        campos = listaAtributos.size();
        
        // Pular Id
        int campoInicial = 0;
        
        if (listaAtributos.get(0).equals("id")) {
            campoInicial = 1;
        }
        
        // Adiciona os atributos á instrução SQL
        for(int i = campoInicial; i < campos; i++) {
            sql += listaAtributos.get(i);
            valores += "?";
            
            // Adiciona separadores
            if (i < campos - 1) {
                sql += ", ";
                valores += ", ";
            }
        }
        
        // Finaliza e retorna instrução sql
        sql += ") VALUES (" + valores + ");";
        return sql;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////   
    public String getDeletar(ArrayList lista, Object objeto) {
        
        ArrayList <String> listaAtributos = (ArrayList) lista.get(0);
        //ArrayList listaValores = (ArrayList) lista.get(1);
        //ArrayList listaTipos = (ArrayList) lista.get(2);
        
        // Inicia construção da instrução sql
        String sql = "";
        sql += "DELETE FROM " + objeto.getClass().getSimpleName().toLowerCase();
        sql += "s WHERE ";
        
        int campos = 0;
        campos = listaAtributos.size();

        // adicionar as colunas à instrução SQL.
        for(int i = 0; i< campos; i++) {
            sql += listaAtributos.get(i);
            sql += "=?";
            
            // Adiciona separador
            if (i < campos - 1) {
                sql += " and ";
            }
        }
       
        // Finaliza e retorna instrução sql
        sql += ";";
        return sql;
    }
    
    
    
    
    
    
    
    
    
    
    
    public ArrayList<ArrayList> desmembrar(Object objeto, boolean descartarNulos, ArrayList lista) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
        
        // Instancia a sublistas
        ArrayList <String> listaAtributos = (ArrayList) lista.get(0);
        ArrayList <String> listaValores = (ArrayList) lista.get(1);
        ArrayList <String> listaTipos = (ArrayList) lista.get(2);
        
        // Variável auxiliar
        String tipo = "";
        
        // Critérios a ignorar
        String ignorar = "0";
        String ignorar2 = "0.0";
        
        try {
            // Identifica os atributos da classe
            Field[] atributos = objeto.getClass().getDeclaredFields();

            // Identifica os atributos da superclasse
            Field[] superAtributos = objeto.getClass().getSuperclass().getDeclaredFields();

            // Itera pelos atributos da superclasse
            for(int i=0; i<superAtributos.length; i++) {
                Method metodoGet = objeto.getClass().getSuperclass().getMethod(getNomeMetodoGet(superAtributos[i].getName()), new Class[] {});

                if (descartarNulos == false) {

                    // Adiciona null ou valor do atributo á lista de valores de atributos
                    if (metodoGet.invoke(objeto, new Object[] {}) == null) {
                        // Adiciona null
                        listaValores.add(null);
                    } else {
                        // Pega o valor do atributo
                        listaValores.add(metodoGet.invoke(objeto, new Object[] {}).toString());
                    }
                    // Adiciona nome, tipo e valor do atributo ás listas correspondentes
                    listaAtributos.add(superAtributos[i].getName());
                    listaTipos.add(metodoGet.getReturnType().getName());

                // Se solicitação for descartar nulos
                } else {

                    // Se valor do atributo não for null
                    if (metodoGet.invoke(objeto, new Object[] {}) != null) {

                        // Pega valor do atributo
                        String teste = metodoGet.invoke(objeto, new Object[] {}).toString();

                        // Se o valor do atributo for diferente dos critérios a ignorar
                        if (!"".equals(teste) && !ignorar.equals(teste) && !ignorar2.equals(teste) && !(teste.trim()).equals("")) {

                            // Pega nome, tipo e valor do atributo
                            listaAtributos.add(superAtributos[i].getName());
                            listaTipos.add(metodoGet.getReturnType().getName());
                            listaValores.add(metodoGet.invoke(objeto, new Object[] {}).toString());
                        }
                    }
                }
            }








            // Itera pelos atributos
            for(int i=0; i<atributos.length; i++) {

                // Pega o método get do atributo atual
                Method metodoGet = objeto.getClass().getMethod(getNomeMetodoGet(atributos[i].getName()), new Class[] {});

                // Pega tipo de retorno do método get
                tipo = metodoGet.getReturnType().getName();

                // Se atributo for variável de referência aplica esse método recursivamente
                if (tipo.startsWith("Dominio.")) {                


                    // DEVE PEGAR ATRIBUTO DE REFERENCIA DINAMICAMENTE---------------------------------------------------------------------
                    Endereco ref = new Endereco();

                    // Prepara listas para aplicar esse método recursivamente
                    lista.add(listaAtributos);
                    lista.add(listaValores);
                    lista.add(listaTipos);

                    // Aplica esse método recursivamente na variável de referência
                    lista = desmembrar(ref, descartarNulos, lista);

                // Se atributo não for variável de referência
                } else {

                    // Se solicitação for de manter nulos
                    if (descartarNulos == false) {

                        // Adiciona null ou valor do atributo á lista de valores de atributos
                        if (metodoGet.invoke(objeto, new Object[] {}) == null) {
                            // Adiciona null
                            listaValores.add(null);
                        } else {
                            // Pega o valor do atributo
                            listaValores.add(metodoGet.invoke(objeto, new Object[] {}).toString());
                        }
                        // Adiciona nome, tipo e valor do atributo ás listas correspondentes
                        listaAtributos.add(atributos[i].getName());
                        listaTipos.add(metodoGet.getReturnType().getName());

                    // Se solicitação for descartar nulos
                    } else {

                        // Se valor do atributo não for null
                        if (metodoGet.invoke(objeto, new Object[] {}) != null) {

                            // Pega valor do atributo
                            String teste = metodoGet.invoke(objeto, new Object[] {}).toString();

                            // Se o valor do atributo for diferente dos critérios a ignorar
                            if (!"".equals(teste) && !ignorar.equals(teste) && !ignorar2.equals(teste) && !(teste.trim()).equals("")) {

                                // Pega nome, tipo e valor do atributo
                                listaAtributos.add(atributos[i].getName());
                                listaTipos.add(metodoGet.getReturnType().getName());
                                listaValores.add(metodoGet.invoke(objeto, new Object[] {}).toString());
                            }
                        }
                    }
                }
            }

            // Monta lista geral
            lista.add(listaAtributos);
            lista.add(listaValores);
            lista.add(listaTipos);
        } catch (Exception erro) {
            
        } finally {
            // Retorna lista de nomes, tipos e valores dos atributos
            return lista;
        }
    }
    ////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////
    private void executarComando(int operacao, ArrayList lista, String sql) throws SQLException {
        
        ArrayList <String> listaAtributos = (ArrayList) lista.get(0);
        ArrayList <String> listaValores = (ArrayList) lista.get(1);
        ArrayList <String> listaTipos = (ArrayList) lista.get(2);
        
        try {
            // SQL de inserção
            PreparedStatement stmt = conexao.prepareStatement(sql);

            // Contabiliza campos da lista
            int campos = listaValores.size();
            
            // Pular Id
            int campoInicial = 0;
            int intervalo = 1;
            
            // SELECT, DELETE
            if (operacao != 2 && operacao != 4) {
                if (listaAtributos.get(0).equals("id")) {
                    campoInicial = 1;
                    intervalo = 0;
                }
            }

            // Itera pelos campos
            for(int i = campoInicial; i < campos; i++){
                String temp = listaValores.get(i).toString();

                // Define valor e tipo das interrogações do sql
                if ("java.lang.String".equals(listaTipos.get(i))) {
                    stmt.setString((i + intervalo), temp);
                } else if ("int".equals(listaTipos.get(i))) {
                    stmt.setInt((i + intervalo), Integer.parseInt(temp));
                } else if ("java.lang.Long".equals(listaTipos.get(i))) {
                    stmt.setLong((i + intervalo), Long.parseLong(temp));
                } else if ("float".equals(listaTipos.get(i))) {
                    stmt.setFloat((i + intervalo), Float.parseFloat(temp));
                } else if ("java.lang.Boolean".equals(listaTipos.get(i))) {
                    stmt.setBoolean((i + intervalo), Boolean.parseBoolean(temp));
                }
            }
            
            

            // Chama métodos do 'PreparedStatement' conforme operação solicitada
            switch(operacao) {
                case 1:
                    //sql += getInserir(lista, objeto);
                    stmt.execute();
                break;
                case 2:
                    //sql += getLocalizar(lista, objeto);
                    stmt.executeQuery();
                break;
                case 3:
                    //sql += getAtualizar(lista, objeto);
                    try {
                        // Define última interrogação como id (atributo 0)
                        stmt.setInt(campos, Integer.parseInt(listaValores.get(0).toString()));
                        stmt.execute();
                    } catch (Exception erro) {
                        
                    }
                    
                break;
                case 4:
                    //sql += getDeletar(lista, objeto);
                    stmt.executeUpdate();
                break;
            }

        // Finaliza execução
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////
    private String verificarInterrogacoes(int operacao, ArrayList lista, String sql) throws SQLException {
        
        ArrayList <String> listaAtributos = (ArrayList) lista.get(0);
        ArrayList <String> listaValores = (ArrayList) lista.get(1);
        ArrayList <String> listaTipos = (ArrayList) lista.get(2);
        
        sql += "<hr />";
        try {
            // SQL de inserção
            //PreparedStatement stmt = conexao.prepareStatement(sql);

            // Contabiliza campos da lista
            int campos = listaValores.size();
            
            
            // Pular Id
            int campoInicial = 0;
            int intervalo = 1;
            
            // Select, Delete
            if (operacao != 2 && operacao != 4) {
                if (listaAtributos.get(0).equals("id")) {
                    campoInicial = 1;
                    intervalo = 0;
                }
            }

            // Itera pelos campos
            for(int i = campoInicial; i < campos; i++){
                String temp = listaValores.get(i).toString();

                // Define valor e tipo das interrogações do sql
                if ("java.lang.String".equals(listaTipos.get(i))) {
                    sql += "stmt.setString("+ (i + intervalo) +", " +temp+ ")";
                } else if ("int".equals(listaTipos.get(i))) {
                    sql += "stmt.setInt("+ (i + intervalo) +", "+Integer.parseInt(temp)+")";
                } else if ("java.lang.Long".equals(listaTipos.get(i))) {
                    sql += "stmt.setLong("+ (i + intervalo) +", "+Long.parseLong(temp)+")";
                } else if ("float".equals(listaTipos.get(i))) {
                    sql += "stmt.setFloat("+ (i + intervalo) +", "+Float.parseFloat(temp)+")";
                } else if ("java.lang.Boolean".equals(listaTipos.get(i))) {
                    sql += "stmt.setBoolean("+ (i + intervalo) +", "+Boolean.parseBoolean(temp)+")";
                    //stmt.setString("+i+", null);
                } else {
                    // AMBTST
                    sql += "Tipo não classificado";
                    sql += listaAtributos.get(i);
                    sql += " Tipo: ";
                    sql += listaTipos.get(i);
                }
                
                sql += "<br />";
            }
            
            if (operacao == 3) {
                sql += "stmt.setInt("+campos+", "+Integer.parseInt(listaValores.get(0).toString())+")";
            }

            // Chama métodos do 'PreparedStatement' conforme operação solicitada
            sql += "<hr />";
            switch(operacao) {
                case 0:
                    //sql += getCriarTabela(lista, objeto);
                    //sql += descrever(lista, objeto);
                break;
                case 1:
                    //sql += getInserir(lista, objeto);
                     sql += "stmt.execute()";
                break;
                case 2:
                    //sql += getLocalizar(lista, objeto);
                    sql += "stmt.executeQuery()";
                break;
                case 3:
                    //sql += getAtualizar(lista, objeto);
                    sql += "stmt.executeUpdate()";
                break;
                case 4:
                    //sql += getDeletar(lista, objeto);
                    sql += "stmt.executeUpdate()";
                break;
            }

        // Finaliza execução
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
            return sql;
        }
    }
    
    
    
    
    
    
    
     
            
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////
    public String getNomeMetodoGet(String patributo) {
        String nome = "get";
        nome += patributo.substring(0,1).toUpperCase();
        nome += patributo.substring(1);
        return(nome);
    }

    //public String temAspas(Method pmetodo) {
    //    if(pmetodo.getReturnType().getName().equals("java.lang.String")) {
      //      return("'");
        //}
        //return("");
    //}
    
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