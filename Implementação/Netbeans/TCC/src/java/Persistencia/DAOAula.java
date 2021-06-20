package Persistencia;

import Dominio.Aula;
import Dominio.ObjectDomain;
import Dominio.Voto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


/**
 *
 * @author Mark
 */
public class DAOAula implements IDAO {
    
    // variavel de instancia que define a conexão com o BD
    private Connection conexao;
    
    //ao ser instanciado cria conexao com o banco
    public DAOAula() {
        Conectar();
    }
    
    public final void Conectar() {
        try {
            this.conexao = ConectaBanco.getConexao();
        } catch (Exception erro) {
            System.out.print(erro);
            throw new RuntimeException(erro);
        }
    }
 

    //método cadastrar, recebe um ObjectDomain
    // OBSOLETO DEVIDO A 'INT CADASTRAR2()'
    @Override
    public void cadastrar(ObjectDomain objeto) throws SQLException,ClassNotFoundException {
        
        // converte objeto para aula
        Aula aula = (Aula) objeto;
        
        try {
            // SQL de inserção
            String sql = "INSERT INTO aulas (";
            sql += "titulo, descricao, id_autor, id_disciplina, restrita, senha, dataCriacao, utilizacoes, votos, media, conclusoes, aprovacao, dataAtualizacao";
            sql += ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
           
            // seta valores a serem cadastrados conforme atributos da aula recebida
            stmt.setString(1, aula.getTitulo());
            stmt.setString(2, aula.getDescricao());
            stmt.setInt(3, aula.getIdAutor());
            stmt.setInt(4, aula.getIdDisciplina());
            stmt.setBoolean(5, aula.isRestrita());
            stmt.setString(6, aula.getSenha());
            //stmt.setString(7, "now()");
            stmt.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis()));
            stmt.setInt(8, aula.getUtilizacoes());
            stmt.setInt(9, aula.getVotos());
            stmt.setFloat(10, aula.getMedia());
            stmt.setInt(11, aula.getConclusoes());
            stmt.setBoolean(12, aula.isAprovacao());
            stmt.setTimestamp(13, new java.sql.Timestamp(System.currentTimeMillis()));

            stmt.execute();
            
            
            
            
            //this.criarTabela(aula);
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    //método atualizar, recebe um ObjectDomain
    @Override
    public void atualizar(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        
        // converte objeto para aula
        Aula aula = (Aula) objeto;
        try {
            
            // SQL de consulta
            String sql = "UPDATE aulas SET ";
            sql += "titulo=?, descricao=?, id_disciplina=?, restrita=?, senha=?, utilizacoes=?, votos=?, media=?, conclusoes=?, aprovacao=?, dataAtualizacao=?";
            sql += " WHERE id=?";
            PreparedStatement stmt = conexao.prepareStatement(sql);

            // seta valores a serem cadastrados conforme atributos da aula recebida
            stmt.setString(1, aula.getTitulo());
            stmt.setString(2, aula.getDescricao());
            stmt.setInt(3, aula.getIdDisciplina());
            //stmt.setInt(3, 2);
            stmt.setBoolean(4, aula.isRestrita());
            stmt.setString(5, aula.getSenha());
            stmt.setInt(6, aula.getUtilizacoes());
            stmt.setInt(7, aula.getVotos());
            stmt.setFloat(8, aula.getMedia());
            stmt.setInt(9, aula.getConclusoes());
            stmt.setBoolean(10, aula.isAprovacao());
            stmt.setTimestamp(11, aula.getDataAtualizacao());
            
            
            stmt.setInt(12, aula.getId());
            stmt.execute();
            
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    /*
    public void criarTabela(ObjectDomain objeto) throws SQLException,ClassNotFoundException {
    //public void criarTabela() throws SQLException,ClassNotFoundException {
        
        // Converte objeto para aula
        Aula aula = (Aula) objeto;
        
        try {
            // SQL de criação
            PreparedStatement sql = conexao.prepareStatement("DROP TABLE IF EXISTS aula"+aula.getId()+";CREATE TABLE aula"+aula.getId()+"(id SERIAL, tipo_conteudo VARCHAR, tabela NUMERIC, id_exercicio NUMERIC, posicao NUMERIC");
           
            // Executa criação da tabela
            sql.execute();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    */
    
    
    
    
    
    
    
    
    
    // QDO LOCALIZAR CONDICIONAL FUNCIONAR ESSE MÉTODO ESTARÁ OBSOLETO
    //método listar, devolve uma lista de aulas
    @Override
    public ArrayList<ObjectDomain> listar() throws SQLException, ClassNotFoundException{
        
        // SQL de consulta
        String sql = "SELECT * FROM aulas";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet rs = stmt.executeQuery();

        //cria um objeto do tipo ArrayList de aulas
        ArrayList<ObjectDomain> listaAula = new ArrayList<ObjectDomain>();
        while(rs.next()){
            
            //cria um novo aula a cada loop
            Aula novoAula = new Aula();
            
            //seta atributos da aula
            novoAula.setId(rs.getInt("id"));
            novoAula.setTitulo(rs.getString("titulo"));
            novoAula.setDescricao(rs.getString("descricao"));
            novoAula.setIdAutor(rs.getInt("id_autor"));
            ////aula.setArea(rs.getString("area"));
            ////aula.setMateria(rs.getString("materia"));
            novoAula.setIdDisciplina(rs.getInt("id_disciplina"));
            novoAula.setRestrita(rs.getBoolean("restrita"));
            novoAula.setSenha(rs.getString("senha"));
            novoAula.setDataCriacao(rs.getTimestamp("datacriacao"));
            novoAula.setDataAtualizacao(rs.getTimestamp("dataatualizacao"));
            novoAula.setUtilizacoes(rs.getInt("utilizacoes"));
            //novoAula.setVotos(rs.getInt("votos"));
            //novoAula.setMedia(rs.getInt("media"));
            novoAula.setConclusoes(rs.getInt("conclusoes"));
            novoAula.setAprovacao(rs.getBoolean("aprovacao"));
            
            
            
            
            
            
            // SQL de consulta
            stmt = conexao.prepareStatement("SELECT SUM(nota) FROM votos WHERE id_aula=?");
            stmt.setInt(1, novoAula.getId());
            ResultSet rs2 = stmt.executeQuery();
            int votos = 0;
            while(rs2.next()){
                novoAula.setMedia(rs2.getInt("sum"));
                votos++;
            }
            rs2.close();
            
            novoAula.setVotos(rs.getInt(votos));
            
                   
            

            
            
            
            
     
            
            
            
            
                        
            // insere aula na lista
            listaAula.add(novoAula);
       }
       rs.close();
       conexao.close();

       //Retorna a lista de aulas
       return listaAula;
    }
    
    
    
    
    
    // QDO LOCALIZAR CONDICIONAL FUNCIONAR ESSE MÉTODO ESTARÁ OBSOLETO
    //método listar, devolve uma lista de aulas
    public ArrayList<Aula> listarMinhasAulas(int idAutor) throws SQLException, ClassNotFoundException{
        // SQL de consulta
        String sql = "SELECT * FROM aulas WHERE id_autor=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, idAutor);
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet rs = stmt.executeQuery();

        //cria um objeto do tipo ArrayList de aulas
        ArrayList<Aula> listaAula = new ArrayList<Aula>();
        while (rs.next()) {
            //cria um novo aula a cada loop
            Aula novoAula = new Aula();
            //seta atributos da aula
            novoAula.setId(rs.getInt("id"));
            novoAula.setTitulo(rs.getString("titulo"));
            novoAula.setDescricao(rs.getString("descricao"));
            novoAula.setIdAutor(rs.getInt("id_autor"));
            ////aula.setArea(rs.getString("area"));
            ////aula.setMateria(rs.getString("materia"));
            novoAula.setIdDisciplina(rs.getInt("id_disciplina"));
            novoAula.setRestrita(rs.getBoolean("restrita"));
            novoAula.setSenha(rs.getString("senha"));
            novoAula.setDataCriacao(rs.getTimestamp("datacriacao"));
            novoAula.setDataAtualizacao(rs.getTimestamp("dataatualizacao"));
            novoAula.setUtilizacoes(rs.getInt("utilizacoes"));
            //novoAula.setVotos(rs.getInt("votos"));
            //novoAula.setMedia(rs.getInt("media"));
            novoAula.setConclusoes(rs.getInt("conclusoes"));
            novoAula.setAprovacao(rs.getBoolean("aprovacao"));
            
            
            
            
            // SQL de consulta
            stmt = conexao.prepareStatement("SELECT SUM(nota) FROM votos WHERE id_aula=?");
            stmt.setInt(1, novoAula.getId());
            ResultSet rs2 = stmt.executeQuery();
            int votos = 0;
            while(rs2.next()){
                novoAula.setMedia(rs2.getInt("sum"));
                votos++;
            }
            rs2.close();
            
            novoAula.setVotos(rs.getInt(votos));
                        
            // insere aula na lista
            listaAula.add(novoAula);
       }
       rs.close();
       conexao.close();

       //Retorna a lista de aulas
       return listaAula;
    }
    
    
    
    
    
    
    // ALTERAR PARA RECEBER UMA AULA [OU PELO MENOS UM OBJDOMAIN]
    // MESCLAR COM LOCALIZAR CONDICIONAL
    
    //método localizar por Id, devolve um aula encontrado
    @Override
    public Aula localizarPorId(int id) throws SQLException, ClassNotFoundException {
        
        // SQL de consulta
        String sql = "SELECT * FROM aulas WHERE id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, id);
        
        // executa sql e armazena resultado num resultset
        ResultSet rs = stmt.executeQuery();
        
        //instancia aula e seta atributos conforme valores do DB
        Aula aula = new Aula();
        while(rs.next()){
            aula.setId(rs.getInt("id"));
            aula.setTitulo(rs.getString("titulo"));
            aula.setDescricao(rs.getString("descricao"));
            aula.setIdAutor(rs.getInt("id_autor"));
            //aula.setArea(rs.getString("area"));
            //aula.setMateria(rs.getString("materia"));
            aula.setIdDisciplina(rs.getInt("id_disciplina"));
            aula.setRestrita(rs.getBoolean("restrita"));
            aula.setSenha(rs.getString("senha"));
            aula.setDataCriacao(rs.getTimestamp("datacriacao"));
            aula.setDataAtualizacao(rs.getTimestamp("dataatualizacao"));
            aula.setUtilizacoes(rs.getInt("utilizacoes"));
            //aula.setVotos(rs.getInt("votos"));
            //aula.setMedia(rs.getInt("media"));
            aula.setConclusoes(rs.getInt("conclusoes"));
            aula.setAprovacao(rs.getBoolean("aprovacao"));
            
            
            
            
            // SQL de consulta
            stmt = conexao.prepareStatement("SELECT SUM(nota) FROM votos WHERE id_aula=?");
            stmt.setInt(1, aula.getId());
            ResultSet rs2 = stmt.executeQuery();
            int votos = 0;
            while(rs2.next()){
                aula.setMedia(rs2.getInt("sum"));
                votos++;
            }
            rs2.close();
            
            aula.setVotos(rs.getInt(votos));
            
        }
        
        // Fecha conexão e resultado
        rs.close();
        conexao.close();
        return aula;
    }

    
    
    

    
    
    //método excluir, recebe um objeto 'ObjectDomain'
    @Override
    public void excluir(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        
        // Converte 'ObjectDomain' para 'Aula'
        Aula aula = (Aula) objeto;
        
        try {
            // CASCADE resolve?
            PreparedStatement sql = conexao.prepareStatement("DELETE FROM aulas WHERE id=?");
            sql.setInt(1, aula.getId());
            sql.execute();
            
            
            
            // SELECT tipo_exercicio, id_exercicio FROM conteudo WHERE id_aula=/
                // for exercicio : lista
                    // DELETE FROM  tipo_exercicio_respostas WHERE id=id_exercicio
                    // DELETE FROM  tipo_exercicio_perguntas WHERE id=id_exercicio
            // DELETE FROM progresso WHERE id_aula=?
            // DELETE FROM conteudo WHERE id_aula=?
            // DELETE FROM aulas WHERE id=?
            
        } catch (Exception erro) {
            System.out.println(erro);
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
       
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    public void Qualificar(Voto voto) throws SQLException, ClassNotFoundException {

       try {
            // SQL de inserção
            String sql = "INSERT INTO votos (id_aula, id_usuario, nota) VALUES (?, ?, ?)";
            
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, voto.getAulaId());
            stmt.setInt(2, voto.getUsuarioId());
            stmt.setInt(3, voto.getNota());

            stmt.execute();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    public void Requalificar(Voto voto) throws SQLException, ClassNotFoundException {

       try {
            // SQL de consulta
            String sql = "UPDATE votos SET nota=? WHERE id=?";
            
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, voto.getNota());
            stmt.setInt(2, voto.getId());
            stmt.execute();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
     
    
    
    
    public Voto Localizar(Voto voto) throws SQLException, ClassNotFoundException {
        try {
            //Recupera valores da aula
            String sql = "SELECT * FROM votos WHERE id_usuario=? AND id_aula=?";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, voto.getUsuarioId());
            stmt.setInt(2, voto.getAulaId());

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                voto.setId(rs.getInt("id"));
                voto.setNota(rs.getInt("nota"));
            }
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
            return voto;
        }
    }
    
    
    public void Registrar(int id, boolean regInicio) throws SQLException, ClassNotFoundException {
       try {
           
           /*
            //Recupera valores da aula
            String sql = "SELECT * FROM aulas WHERE id=?";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();
            Aula aula = new Aula();
            while (rs.next()) {
                aula.setUtilizacoes(rs.getInt("utilizacoes"));
                aula.setConclusoes(rs.getInt("conclusoes"));
            }
            
            
            //Incrementa valores da aula
            int novoUtilizacoes = aula.getUtilizacoes() + 1;            
            int novoConclusoes = aula.getConclusoes() + 1;
            
            //Atualiza valores da aula
            String sql = "UPDATE aulas SET ";
            if (regInicio) {
                sql += "utilizacoes=? WHERE id=?";
            } else {
                sql += "conclusoes=? WHERE id=?";
            }
            PreparedStatement stmt = conexao.prepareStatement(sql);

            
            if (regInicio) {
                stmt.setInt(1, novoUtilizacoes);
            } else {
                stmt.setInt(1, novoConclusoes);
            }
            stmt.setInt(2, id);
            stmt.executeUpdate();
            * 
            */
           
           //Recupera valores da aula
            String sql = "UPDATE aulas SET ";
            if (regInicio) {
                sql += "utilizacoes=utilizacoes+1 WHERE id=?";
            } else {
                sql += "conclusoes=conclusoes+1 WHERE id=?";
            }
            
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
           
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    public void fecharConexao() throws SQLException {
        this.conexao.close();
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public int cadastrar2(ObjectDomain objeto) throws SQLException,ClassNotFoundException {
        int id = 0;
        // converte objeto para aula
        Aula aula = (Aula) objeto;
        
        try {
            // SQL de inserção
            String sql = "INSERT INTO aulas (";
            sql += "titulo, descricao, id_autor, id_disciplina, restrita, senha, dataCriacao, utilizacoes, votos, media, conclusoes, aprovacao, dataAtualizacao";
            sql += ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
           
            // seta valores a serem cadastrados conforme atributos da aula recebida
            stmt.setString(1, aula.getTitulo());
            stmt.setString(2, aula.getDescricao());
            stmt.setInt(3, aula.getIdAutor());
            stmt.setInt(4, aula.getIdDisciplina());
            stmt.setBoolean(5, aula.isRestrita());
            stmt.setString(6, aula.getSenha());
            //stmt.setString(7, "now()");
            stmt.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis()));
            stmt.setInt(8, aula.getUtilizacoes());
            stmt.setInt(9, aula.getVotos());
            stmt.setFloat(10, aula.getMedia());
            stmt.setInt(11, aula.getConclusoes());
            stmt.setBoolean(12, aula.isAprovacao());
            stmt.setTimestamp(13, new java.sql.Timestamp(System.currentTimeMillis()));

            stmt.execute();
            
            
            sql = "SELECT id FROM aulas";
            stmt = conexao.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                id = rs.getInt("id");
            }
            
            
            //this.criarTabela(aula);
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
            return id;
        }
    }
}