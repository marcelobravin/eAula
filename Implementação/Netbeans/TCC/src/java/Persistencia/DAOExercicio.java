package Persistencia;

import Dominio.Arquivo;
import Dominio.ExercicioVF;
import Dominio.ExercicioLacunas;
import Dominio.ExercicioMEscolha;
import Dominio.ObjectDomain;
import Dominio.Prova;
import Dominio.Texto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Mark
 */
public class DAOExercicio implements IDAO {

    // variavel de instancia que define a conexão com o BD
    private Connection conexao;

    public DAOExercicio() {
        Conectar();
    }
    
    
    
    public final void Conectar() {
        try {
            this.conexao = ConectaBanco.getConexao();
        } catch (Exception erro) {
            throw new RuntimeException(erro);
        }
    }

    //método cadastrar, recebe um ObjectDomain 
    @Override
    public void cadastrar(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        
        // converte objeto para exercicio
        ExercicioVF exercicio = (ExercicioVF) objeto;

        try {            
            // SQL de inserção da pergunta
            String sql = "INSERT INTO e_radio_perguntas(texto, resposta) VALUES(?,?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);

            // seta valores a serem cadastrados conforme atributos do exercicio recebida
            stmt.setString(1, exercicio.getTitulo());
            stmt.setInt(2, exercicio.getResposta());
            stmt.execute();
            
            // Recupera id da pergunta inserida
            sql = "SELECT id FROM e_radio_perguntas";
            stmt = conexao.prepareStatement(sql);
                    
            ResultSet rs = stmt.executeQuery();            
            int key = -1;
            while (rs.next()) {
                key = rs.getInt("id");
            }
            exercicio.setPerguntaId(key);
            
            
            
            // Itera pelas alternativas
            if (exercicio.getAlternativa() != null) {
                for (String alternativa : exercicio.getAlternativa()) {
                    // Insere respostas
                    sql = "INSERT INTO e_radio_respostas (pergunta_id, texto) VALUES (?,?)";
                    stmt = conexao.prepareStatement(sql);

                    stmt.setInt(1, exercicio.getPerguntaId());
                    stmt.setString(2, alternativa);
                    stmt.execute();
                }
            }

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }

    public void cadastrarMulti(ObjectDomain objeto) throws SQLException, ClassNotFoundException {

        // converte objeto para exercicio
        ExercicioMEscolha exercicio = (ExercicioMEscolha) objeto;

        try {
            // Cria sql e insere pergunta
            String sql = "INSERT INTO e_checkbox_perguntas (texto) VALUES(?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            
            stmt.setString(1, exercicio.getTitulo());
            
            stmt.execute();
            
            
            
            
            // Recupera id da pergunta inserida
            sql = "SELECT id FROM e_checkbox_perguntas";
            stmt = conexao.prepareStatement(sql);
                    
            ResultSet rs = stmt.executeQuery();            
            int key = -1;
            while (rs.next()) {
                key = rs.getInt("id");
            }
            exercicio.setPerguntaId(key);
            
            
            
            
            // Declara um array e aloca a memória para X booleans
            boolean[] pan;
            pan = new boolean[exercicio.getAlternativa().length];
            pan = exercicio.getCorreta();

            // Itera pelas alternativas
            int i = 0;
            if (exercicio.getAlternativa() != null) {
                for (String alternativa : exercicio.getAlternativa()) {
                    
                    // Cria sql
                    stmt = conexao.prepareStatement("INSERT INTO e_checkbox_respostas (pergunta_id, alternativa, correta) VALUES(?,?,?)");
                    
                    // Seta valores conforme atributos
                    stmt.setInt(1, exercicio.getPerguntaId());
                    stmt.setString(2, alternativa);
                    stmt.setBoolean(3, pan[i]);
                    
                    // Insere resposta
                    stmt.execute();
                    i++;
                }
            }
            // Fecha PreparedStatement
            stmt.close();
        } catch (Exception erro) {
            System.out.println(erro);
        } finally {            
            conexao.close();
        }
    }

    // listar exercicios mais atual
    public ArrayList<ExercicioVF> listar2(ExercicioVF exercicio) throws SQLException, ClassNotFoundException {
        ArrayList<ExercicioVF> lista = new ArrayList<ExercicioVF>();

        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM exercicios");



        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();

        while (resultado.next()) {

            //cria um novo aula a cada loop
            ExercicioVF novoEx = new ExercicioVF();

            //seta atributos da aula
            novoEx.setId(resultado.getInt("id"));
            novoEx.setTitulo(resultado.getString("titulo"));
            novoEx.setResposta(resultado.getInt("correta"));


            String sentenca = resultado.getString("sentencas");

            ArrayList sentencas = new ArrayList();
            sentencas.add(sentenca);




            //novoEx.setSentencas(sentencas);


            // insere aula na lista
            lista.add(novoEx);
        }
        resultado.close();
        conexao.close();

        return lista;
    }
    
    
    
    
    
    
    

    // listar exercicios mais atual
    public ExercicioVF localizar(ExercicioVF exercicio) throws SQLException, ClassNotFoundException {


        // SQL de consulta
        String sql = "SELECT * FROM e_radio_perguntas WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, exercicio.getId());
        
        
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = stmt.executeQuery();
        
        
        //cria um novo aula a cada loop
        ExercicioVF novoEx = new ExercicioVF();

        while (resultado.next()) {
            //seta atributos da aula
            novoEx.setId(resultado.getInt("id"));
            novoEx.setTitulo(resultado.getString("texto"));
            novoEx.setResposta(resultado.getInt("resposta"));
        }
        
        
        
        
        
        // SQL de consulta
        sql = "SELECT * FROM e_radio_respostas WHERE pergunta_id=?";
        stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, exercicio.getId());
        
        
        
        ResultSet rs2 = stmt.executeQuery();
        
        int i = 0;
        while (rs2.next()) {            
            i++;
        }
        
        resultado = stmt.executeQuery();
        
        String[] alternativas = new String[i];
        i = 0;
        while (resultado.next()) {
            alternativas[i] = resultado.getString("texto");
            i++;
        }
        
        novoEx.setAlternativa(alternativas);
        
        
        // Finaliza e retorna resultado
        resultado.close();
        conexao.close();
        return novoEx;
    }
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // listar exercicios mais atual
    public ExercicioMEscolha localizar(ExercicioMEscolha exercicio) throws SQLException, ClassNotFoundException {


        // SQL de consulta
        String sql = "SELECT * FROM e_checkbox_perguntas WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, exercicio.getId());
        
        
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = stmt.executeQuery();
        
        
        //cria uma novo aula a cada loop
        ExercicioMEscolha novoEx = new ExercicioMEscolha();

        while (resultado.next()) {
            //seta atributos da aula
            novoEx.setId(resultado.getInt("id"));
            novoEx.setTitulo(resultado.getString("texto"));            
        }
        
        
        
        
        
        // SQL de consulta
        sql = "SELECT * FROM e_checkbox_respostas WHERE pergunta_id=?";
        stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, exercicio.getId());
        
        
        
        ResultSet rs2 = stmt.executeQuery();
        
        int i = 0;
        while (rs2.next()) {            
            i++;
        }
        
        //resultado.beforeFirst();
        
        resultado = stmt.executeQuery();
        
        String[] alternativas = new String[i];
        boolean[] corretas = new boolean[i];
        i = 0;
        while (resultado.next()) {
            alternativas[i] = resultado.getString("alternativa");
            corretas[i] = resultado.getBoolean("correta");
            i++;
        }
        
        novoEx.setAlternativa(alternativas);
        novoEx.setCorreta(corretas);
        
        
        // Finaliza e retorna resultado
        resultado.close();
        conexao.close();
        return novoEx;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // listar exercicios mais atual
    public ExercicioLacunas localizar(ExercicioLacunas exercicio) throws SQLException, ClassNotFoundException {


        // SQL de consulta
        String sql = "SELECT * FROM e_lacuna_perguntas WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, exercicio.getId());
        
        
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = stmt.executeQuery();
        
        
        //cria uma novo aula a cada loop
        ExercicioLacunas novoEx = new ExercicioLacunas();

        while (resultado.next()) {
            //seta atributos da aula
            novoEx.setId(resultado.getInt("id"));
            novoEx.setTitulo(resultado.getString("texto"));            
        }
        
        
        
        
        
        // SQL de consulta
        sql = "SELECT * FROM e_lacuna_respostas WHERE pergunta_id=?";
        stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, exercicio.getId());
        
        
        
        ResultSet rs2 = stmt.executeQuery();
        
        int i = 0;
        while (rs2.next()) {            
            i++;
        }
        
        //resultado.beforeFirst();
        
        resultado = stmt.executeQuery();
        
        String[] alternativas = new String[i];
        String[] preTexto = new String[i];
        String[] posTexto = new String[i];
        
        i = 0;
        while (resultado.next()) {
            alternativas[i] = resultado.getString("resposta");
            preTexto[i] = resultado.getString("pre_texto");
            posTexto[i] = resultado.getString("pos_texto");
            i++;
        }
        
        novoEx.setResposta(alternativas);
        novoEx.setPosTexto(posTexto);
        novoEx.setPreTexto(preTexto);
        
        
        // Finaliza e retorna resultado
        resultado.close();
        conexao.close();
        return novoEx;
    }
    
    
    
    
    
    
    
    // listar exercicios mais atual
    public Texto localizar(Texto exercicio) throws SQLException, ClassNotFoundException {


        // SQL de consulta
        String sql = "SELECT * FROM textos WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, exercicio.getId());
        
        
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = stmt.executeQuery();
        
        
        //cria uma novo aula a cada loop
        Texto novoEx = new Texto();

        while (resultado.next()) {
            //seta atributos da aula
            novoEx.setId(resultado.getInt("id"));
            novoEx.setTitulo(resultado.getString("titulo"));
            novoEx.setTexto(resultado.getString("texto"));
        }
        
        
        
        
        
        // Finaliza e retorna resultado
        resultado.close();
        conexao.close();
        return novoEx;
    }
    
    
    
    
    
    
    
    // listar exercicios mais atual
    public Arquivo localizar(Arquivo exercicio) throws SQLException, ClassNotFoundException {


        // SQL de consulta
        String sql = "SELECT * FROM arquivos WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, exercicio.getId());
        
        
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = stmt.executeQuery();
        
        
        //cria uma novo aula a cada loop
        Arquivo novoEx = new Arquivo();

        while (resultado.next()) {
            //seta atributos da aula
            novoEx.setId(resultado.getInt("id"));
            novoEx.setTipo(resultado.getString("tipo"));
            novoEx.setNome(resultado.getString("nome"));
            novoEx.setTitulo(resultado.getString("titulo"));
            novoEx.setLegenda(resultado.getString("legenda"));
        }
        
        
        
        
        
        // Finaliza e retorna resultado
        resultado.close();
        conexao.close();
        return novoEx;
    }
    
    
    
    
    
    
    // listar exercicios mais atual
    public Prova localizar(Prova exercicio) throws SQLException, ClassNotFoundException {

        // SQL de consulta
        String sql = "SELECT * FROM e_provas WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        
        // Executa a consulta e quarda o resultado em um ResultSet        
        stmt.setInt(1, exercicio.getId());
        ResultSet resultado = stmt.executeQuery();
        
        
        //cria uma novo aula a cada loop
        Prova novoEx = new Prova();

        while (resultado.next()) {
            //seta atributos da aula
            novoEx.setId(resultado.getInt("id"));
            novoEx.setDuracao(resultado.getInt("duracao"));
            novoEx.setRetorno(resultado.getInt("retorno"));
            novoEx.setRandomOrder(resultado.getBoolean("randomOrder"));
        }
        
        
        
        
        
        // Finaliza e retorna resultado
        resultado.close();
        conexao.close();
        return novoEx;
    }
    
    
    
// obsoleto
    public int verificarResposta(ExercicioVF exercicio) throws SQLException, ClassNotFoundException {
        int resposta = 0;
        //ArrayList<ExercicioVF> lista = new ArrayList<ExercicioVF>();

        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM exercicios WHERE id=?");

        sql.setInt(1, exercicio.getId());

        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();

        while (resultado.next()) {

            //cria um novo aula a cada loop
            ExercicioVF novoAula = new ExercicioVF();

            //seta atributos da aula
            novoAula.setId(resultado.getInt("id"));
            novoAula.setResposta(resultado.getInt("correta"));



            //novoAula.setSentencas(sentencas);
            resposta = resultado.getInt("correta");

            // insere aula na lista
            //lista.add(novoAula);
        }
        resultado.close();
        conexao.close();

        return resposta;
    }

    public void cadastrarLacunas(ObjectDomain objeto) throws SQLException, ClassNotFoundException {

        // converte objeto para exercicio
        ExercicioLacunas exercicio = (ExercicioLacunas) objeto;

        try {
            // Cria sql e insere pergunta
            String sql = "INSERT INTO e_lacuna_perguntas (texto) VALUES(?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setString(1, exercicio.getTitulo());
            stmt.execute();
            
            // Recupera id da pergunta inserida
            sql = "SELECT id FROM e_lacuna_perguntas";
            stmt = conexao.prepareStatement(sql);
                    
            ResultSet rs = stmt.executeQuery();            
            int key = -1;
            while (rs.next()) {
                key = rs.getInt("id");
            }
            exercicio.setPerguntaId(key);
            
            // Declara um array e aloca a memória para X booleans
            
            /*
            String[] resposta;
            String[] posTexto;
            resposta = new String[exercicio.getPreTexto().length];//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            posTexto = new String[exercicio.getPreTexto().length];
            resposta = exercicio.getResposta();
            posTexto = exercicio.getPosTexto();
            
             * 
             */
            
            String[] resposta = exercicio.getResposta();
            String[] posTexto = exercicio.getPosTexto();
            
            
            int i = 0;
            if (exercicio.getPreTexto() != null) {
                for (String alternativa : exercicio.getPreTexto()) {
                    
                    // Cria sql
                    sql = "INSERT INTO e_lacuna_respostas (pergunta_id, pre_texto, resposta, pos_texto) VALUES(?,?,?,?)";
                    stmt = conexao.prepareStatement(sql);
                    
                    // Seta valores conforme atributos
                    stmt.setInt(1, exercicio.getPerguntaId());
                    stmt.setString(2, alternativa);
                    stmt.setString(3, resposta[i]);
                    stmt.setString(4, posTexto[i]);
                    
                    // Insere resposta
                    stmt.execute();
                    i++;
                }
            }
            ////////////////////////////////////////////////////////////////////
            
            
            
            
            
            
            
            
            
            
        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            
    public void cadastrar(Texto exercicio) throws SQLException, ClassNotFoundException {
        try {            
            // SQL de inserção do texto
            String sql = "INSERT INTO textos(titulo, texto) VALUES(?,?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);

            // Seta valores a serem cadastrados conforme atributos do texto recebido
            stmt.setString(1, exercicio.getTitulo());
            stmt.setString(2, exercicio.getTexto());
            stmt.execute();
            

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
            
    public void cadastrar(Arquivo exercicio) throws SQLException, ClassNotFoundException {
        
        try {
            // SQL de inserção do texto
            String sql = "INSERT INTO arquivos (tipo, nome, titulo, legenda) VALUES(?,?,?,?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);

            // Seta valores a serem cadastrados conforme atributos do texto recebido
            stmt.setString(1, exercicio.getTipo());
            stmt.setString(2, exercicio.getNome());
            stmt.setString(3, exercicio.getTitulo());
            stmt.setString(4, exercicio.getLegenda());
            stmt.execute();
            

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
           
    public void cadastrar(Prova exercicio) throws SQLException, ClassNotFoundException {
        try {            
            // SQL de inserção do texto
            String sql = "INSERT INTO e_provas(duracao, retorno, randomOrder) VALUES(?,?,?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);

            // Seta valores a serem cadastrados conforme atributos do texto recebido
            stmt.setInt(1, exercicio.getDuracao());
            stmt.setInt(2, exercicio.getRetorno());
            stmt.setBoolean(3, exercicio.isRandomOrder());
            stmt.execute();
            

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    

    @Override
    public ArrayList<ObjectDomain> listar() throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ObjectDomain localizarPorId(int id) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    

    @Override
    public void excluir(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void atualizar(ExercicioVF exercicio) throws SQLException {
        try {
            
            // SQL de inserção da pergunta
            String sql = "UPDATE e_radio_perguntas SET texto=?, resposta=? WHERE id=?";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            // seta valores a serem cadastrados conforme atributos do exercicio recebido
            stmt.setString(1, exercicio.getTitulo());
            stmt.setInt(2, exercicio.getResposta());
            stmt.setInt(3, exercicio.getId());
            stmt.executeUpdate();
           
            
            
            sql = "SELECT id FROM e_radio_respostas WHERE pergunta_id=? ORDER BY id ASC";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, exercicio.getId());

            ResultSet rs = stmt.executeQuery();
            ArrayList<Integer> lista = new ArrayList<Integer>();
            while (rs.next()) {
                lista.add(rs.getInt("id"));
            }
            
            
            int x = 0;
            for (String alternativa : exercicio.getAlternativa()) {
                if (x < lista.size()) {
                    sql = "UPDATE e_radio_respostas SET texto=? WHERE id=?";
                    
                    stmt = conexao.prepareStatement(sql);
                    stmt.setString(1, alternativa);

                    int k = (int) lista.get(x);
                    stmt.setInt(2, k);

                    stmt.executeUpdate();
                    
                } else {
                    sql = "INSERT INTO e_radio_respostas (pergunta_id, texto) VALUES (?,?)";
                    stmt = conexao.prepareStatement(sql);

                    stmt.setInt(1, exercicio.getId());
                    stmt.setString(2, alternativa);
                    stmt.execute();
                }
                x++;
            }
            
            if (x - lista.size() < 0) {
                int k = Math.abs(x - lista.size())-1;
                
		while (k >= 0) {
                    sql = "DELETE FROM e_radio_respostas WHERE id=?";
                    stmt = conexao.prepareStatement(sql);
                    int j = (int) lista.get(x+k);
                    stmt.setInt(1, j);
                    stmt.execute();
                    k--;
		}
            }
            

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public void atualizar(ExercicioMEscolha exercicio) throws SQLException {
        try {
            
            // SQL de inserção da pergunta
            String sql = "UPDATE e_checkbox_perguntas SET texto=? WHERE id=?";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            // seta valores a serem cadastrados conforme atributos do exercicio recebido
            stmt.setString(1, exercicio.getTitulo());
            stmt.setInt(2, exercicio.getId());
            stmt.executeUpdate();
           
            
            
            sql = "SELECT id FROM e_checkbox_respostas WHERE pergunta_id=? ORDER BY id ASC";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, exercicio.getId());

            ResultSet rs = stmt.executeQuery();
            ArrayList<Integer> lista = new ArrayList<Integer>();
            while (rs.next()) {
                lista.add(rs.getInt("id"));
            }
            
            
            int x = 0;
            // Declara um array e aloca a memória para X booleans
            //boolean[] pan;
            //pan = new boolean[exercicio.getAlternativa().length];
            //pan = exercicio.getCorreta();
            
            for (String alternativa : exercicio.getAlternativa()) {
                if (x < lista.size()) {
                    sql = "UPDATE e_checkbox_respostas SET alternativa=?, correta=? WHERE id=?";
                    
                    
                    stmt = conexao.prepareStatement(sql);
                    stmt.setString(1, alternativa);
                    //stmt.setBoolean(2, pan[x]);
                    stmt.setBoolean(2, exercicio.getCorreta()[x]);////////////////////////////////////////////////////

                    int k = (int) lista.get(x);
                    stmt.setInt(3, k);

                    stmt.executeUpdate();
                    
                } else {
                    sql = "INSERT INTO e_checkbox_respostas (pergunta_id, alternativa, correta) VALUES(?,?,?)";
                    stmt = conexao.prepareStatement(sql);

                    stmt.setInt(1, exercicio.getId());
                    stmt.setString(2, alternativa);
                    //stmt.setBoolean(3, false);
                    stmt.setBoolean(3, exercicio.getCorreta()[x]);
                    
                    stmt.execute();
                }
                ++x;
            }
            
            if (x - lista.size() < 0) {
                int k = Math.abs(x - lista.size())-1;
                
		while (k >= 0) {
                    sql = "DELETE FROM e_checkbox_respostas WHERE id=?";
                    stmt = conexao.prepareStatement(sql);
                    int j = (int) lista.get(x+k);
                    stmt.setInt(1, j);
                    stmt.execute();
                    k--;
		}
            }
            

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    public void atualizar(ExercicioLacunas exercicio) throws SQLException {
        try {
            
            // SQL de inserção da pergunta
            ////////////////////////VVV
            String sql = "UPDATE e_lacuna_perguntas SET texto=? WHERE id=?";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            // seta valores a serem cadastrados conforme atributos do exercicio recebido
            stmt.setString(1, exercicio.getTitulo());
            stmt.setInt(2, exercicio.getId());
            stmt.executeUpdate();
           
            
            
            sql = "SELECT id FROM e_lacuna_respostas WHERE pergunta_id=? ORDER BY id ASC";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, exercicio.getId());

            ResultSet rs = stmt.executeQuery();
            ArrayList<Integer> lista = new ArrayList<Integer>();
            while (rs.next()) {
                lista.add(rs.getInt("id"));
            }
            
            
            int x = 0;            
            for (String alternativa : exercicio.getPreTexto()) {
                if (x < lista.size()) {
                    //sql = "UPDATE e_lacuna_respostas SET alternativa=?, correta=? WHERE id=?";
                    sql = "UPDATE e_lacuna_respostas SET pre_texto=?, resposta=?, pos_texto=? WHERE id=?";
                    
                    
                    stmt = conexao.prepareStatement(sql);
                    stmt.setString(1, alternativa);
                    stmt.setString(2, exercicio.getResposta()[x]);
                    stmt.setString(3, exercicio.getPosTexto()[x]);

                    int k = (int) lista.get(x);
                    stmt.setInt(4, k);

                    stmt.executeUpdate();
                    
                } else {
                    //sql = "INSERT INTO e_lacuna_respostas (pergunta_id, alternativa, correta) VALUES(?,?,?)";
                    // Cria sql
                    sql = "INSERT INTO e_lacuna_respostas (pergunta_id, pre_texto, resposta, pos_texto) VALUES(?,?,?,?)";
                    stmt = conexao.prepareStatement(sql);
                    
                    // Seta valores conforme atributos
                    stmt.setInt(1, exercicio.getId());
                    stmt.setString(2, alternativa);
                    stmt.setString(3, exercicio.getResposta()[x]);
                    stmt.setString(4, exercicio.getPosTexto()[x]);
                    
                    // Insere resposta
                    stmt.execute();
                }
                ++x;
            }
            
            if (x - lista.size() < 0) {
                int k = Math.abs(x - lista.size())-1;
                
		while (k >= 0) {
                    sql = "DELETE FROM e_lacuna_respostas WHERE id=?";
                    stmt = conexao.prepareStatement(sql);
                    int j = (int) lista.get(x+k);
                    stmt.setInt(1, j);
                    stmt.execute();
                    k--;
		}
            }
            

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public void atualizar(Prova texto) throws SQLException {
        
        try {
            // SQL de inserção da pergunta
            String sql = "UPDATE e_provas SET duracao=?, retorno=?, randomOrder=? WHERE id=?";
            //String sql = "INSERT INTO e_provas(duracao, retorno, randomOrder) VALUES(?,?,?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            

            // Seta valores a serem cadastrados conforme atributos do texto recebido
            stmt.setInt(1, texto.getDuracao());
            stmt.setInt(2, texto.getRetorno());
            stmt.setBoolean(3, texto.isRandomOrder());
            stmt.setInt(4, texto.getId());
            stmt.executeUpdate();

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    public void atualizar(Texto texto) throws SQLException {
        
        try {
            // SQL de inserção da pergunta
            String sql = "UPDATE textos SET titulo=?, texto=? WHERE id=?";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setString(1, texto.getTitulo());
            stmt.setString(2, texto.getTexto());
            stmt.setInt(3, texto.getId());
            stmt.executeUpdate();

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    public void atualizar(Arquivo texto) throws SQLException {
        
        try {
            // SQL de inserção da pergunta
            String sql = "UPDATE arquivos SET titulo=?, legenda=? WHERE id=?";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setString(1, texto.getTitulo());
            stmt.setString(2, texto.getLegenda());
            stmt.setInt(3, texto.getId());
            stmt.executeUpdate();

        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    // listar exercicios mais atual
    public int retornarMaxId() throws SQLException, ClassNotFoundException {
        
        int num = 0;
        
        // SQL de consulta
        String sql = "SELECT MAX(id) FROM arquivos";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            num = rs.getInt("max");
        }
        
        // Finaliza e retorna resultado
        rs.close();
        conexao.close();
        return num;
    }
    
    

    @Override
    public void atualizar(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}