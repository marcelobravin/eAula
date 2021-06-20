package Persistencia;

import Dominio.Disciplina;
import Dominio.ObjectDomain;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Mark
 */
public class DAODisciplina implements IDAO {
    
    // variavel de instancia que define a conexão com o BD
    private Connection conexao;
    
    //ao ser instanciado cria conexao com o banco
    public DAODisciplina() {
        try {
            this.conexao = ConectaBanco.getConexao();
        } catch (Exception erro) {
            throw new RuntimeException(erro);
        }
    }

    @Override
    public void cadastrar(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        Disciplina disciplina = (Disciplina) objeto;
        try {
            // SQL de consulta
            String sql = "INSERT INTO disciplinas(nome, descricao, id_materia) VALUES(?,?,?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
           
            stmt.setString(1, disciplina.getNome());
            stmt.setString(2, disciplina.getDescricao());
            stmt.setInt(3, disciplina.getIdMateria());

            stmt.execute();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    public int cadastrar2(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        Disciplina disciplina = (Disciplina) objeto;
        int perguntaId = -99;
        try {
            // SQL de consulta
            String sql = "INSERT INTO disciplinas(nome, descricao, id_materia) VALUES(?,?,?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
           
            stmt.setString(1, disciplina.getNome());
            stmt.setString(2, disciplina.getDescricao());
            stmt.setInt(3, disciplina.getIdMateria());

            stmt.execute();
            
            
            sql = "SELECT id FROM disciplinas";
            stmt = conexao.prepareStatement(sql);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()){
                perguntaId = rs.getInt("id");
            }
            
            
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
            return perguntaId;
        }
    }
    
    
    
    
    

    
    //método listar, devolve uma lista de disciplinas
    @Override
    public ArrayList<ObjectDomain> listar() throws SQLException, ClassNotFoundException {
        
       
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM disciplinas ORDER BY id");
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();


        //cria um objeto do tipo ArrayList de disciplinas
        ArrayList<ObjectDomain> listaDisciplina = new ArrayList<ObjectDomain>();
        while(resultado.next()){
            //cria um novo disciplina a cada loop
            Disciplina novaDisc = new Disciplina();
            novaDisc.setId(resultado.getInt("id"));
            novaDisc.setNome(resultado.getString("nome"));
            novaDisc.setDescricao(resultado.getString("descricao"));
            novaDisc.setIdMateria(resultado.getInt("id_materia"));
                        
            // insere disciplina na lista
            listaDisciplina.add(novaDisc);
       }
       resultado.close();
       conexao.close();

       //Retorna a lista de disciplinas
       return listaDisciplina;
    }

    @Override
    public Disciplina localizarPorId(int id) throws SQLException, ClassNotFoundException {
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM disciplinas WHERE id=?");
        sql.setInt(1, id);
        
        // executa sql e armazena resultado num resultset
        ResultSet resultado = sql.executeQuery();
        
        //instancia disciplina e seta atributos conforme valores do DB
        Disciplina disciplina = new Disciplina();
        while(resultado.next()){
            disciplina.setId(resultado.getInt("id"));
            disciplina.setNome(resultado.getString("nome"));
        }
        
        // Fecha conexão e resultado
        //resultado.close();
        conexao.close();
        return disciplina;
    }

    @Override
    public void atualizar(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        // converte objeto para disciplina
        Disciplina disciplina = (Disciplina) objeto;
        try {
            
            // SQL de consulta
            PreparedStatement sql = conexao.prepareStatement("UPDATE disciplinas SET nome=?, descricao=? WHERE id=?");

            // seta valores a serem cadastrados conforme atributos da disciplina recebida
            sql.setString(1, disciplina.getNome());
            sql.setString(2, disciplina.getDescricao());
            sql.setInt(3, disciplina.getId());

            sql.execute();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }

    @Override
    public void excluir(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        //Converte um Object em um Disciplina
        Disciplina disciplina = (Disciplina) objeto;
        
        try {
            PreparedStatement sql = conexao.prepareStatement("DELETE FROM disciplinas WHERE id=?");
            sql.setInt(1, disciplina.getId());
            sql.execute();
        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
}