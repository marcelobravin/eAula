package Persistencia;


import Dominio.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Mark
 */
public class DAOFrames {
    
    // variavel de instancia que define a conexão com o BD
    private Connection conexao;
    
    //ao ser instanciado cria conexao com o banco
    public DAOFrames() {
        try {
            this.conexao = ConectaBanco.getConexao();
        } catch (Exception erro) {
            // dar tratamento melhor para o erro
            throw new RuntimeException(erro);
        }
    }
    
    public void fecharConexao() throws SQLException {
        this.conexao.close();
    }

    
    
    
    public ArrayList<Cidade> listar(int idUf) throws SQLException, ClassNotFoundException {
        
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM cidades WHERE id_uf=?");
        sql.setInt(1, idUf);
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();

        //cria um objeto do tipo ArrayList de disciplinas
        ArrayList<Cidade> listaMat = new ArrayList<Cidade>();
        while(resultado.next()){
            //cria um novo disciplina a cada loop
            Cidade novaDisc = new Cidade();
            novaDisc.setId(resultado.getInt("id"));
            novaDisc.setNome(resultado.getString("nome"));
            //novaDisc.setUf(resultado.getString("uf"));
                        
            // insere disciplina na lista
            listaMat.add(novaDisc);
       }
       resultado.close();
       //conexao.close();

       //Retorna a lista de disciplinas
       return listaMat;
    }
    
    
    
    
    
    
    public ArrayList<Materia> listarMateria(int area) throws SQLException, ClassNotFoundException {
        
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM materias WHERE area=? ORDER BY nome");
        
        sql.setInt(1, area);
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();


        //cria um objeto do tipo ArrayList de disciplinas
        ArrayList<Materia> listaMat = new ArrayList<Materia>();
        while(resultado.next()){
            //cria um novo disciplina a cada loop
            Materia novaDisc = new Materia();
            novaDisc.setId(resultado.getInt("id"));
            novaDisc.setNome(resultado.getString("nome"));
            novaDisc.setArea(resultado.getInt("area"));
            novaDisc.setDescricao(resultado.getString("descricao"));
                        
            // insere disciplina na lista
            listaMat.add(novaDisc);
       }
       resultado.close();
       //conexao.close();

       //Retorna a lista de disciplinas
       return listaMat;
    }
    
    
    
    
    
    
    
    
    
    public ArrayList<Disciplina> listarDisciplinas(int idMateria) throws SQLException, ClassNotFoundException {
        
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM disciplinas WHERE id_materia=?");
        
        sql.setInt(1, idMateria);
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();


        //cria um objeto do tipo ArrayList de disciplinas
        ArrayList<Disciplina> lista = new ArrayList<Disciplina>();
        while(resultado.next()){
            //cria um novo disciplina a cada loop
            Disciplina novaDisc = new Disciplina();
            novaDisc.setId(resultado.getInt("id"));
            novaDisc.setNome(resultado.getString("nome"));
            novaDisc.setIdMateria(resultado.getInt("id_materia"));
            novaDisc.setDescricao(resultado.getString("descricao"));
                        
            // insere disciplina na lista
            lista.add(novaDisc);
       }
       resultado.close();
       //conexao.close();

       //Retorna a lista de disciplinas
       return lista;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public ArrayList<Estado> listarEstados() throws SQLException, ClassNotFoundException {
        
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM estados ORDER BY id");
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();


        //cria um objeto do tipo ArrayList de disciplinas
        ArrayList<Estado> listaMat = new ArrayList<Estado>();
        while(resultado.next()){
            //cria um novo disciplina a cada loop
            Estado novaDisc = new Estado();
            novaDisc.setId(resultado.getInt("id"));
            novaDisc.setNome(resultado.getString("nome"));
            novaDisc.setUf(resultado.getString("uf"));
                        
            // insere disciplina na lista
            listaMat.add(novaDisc);
       }
       resultado.close();
       //conexao.close();
      

       //Retorna a lista de disciplinas
       return listaMat;
    }
    
    
    
    
    public ArrayList<Logradouro> listarLogradouros() throws SQLException, ClassNotFoundException {
        
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM logradouros ORDER BY id");
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();


        //cria um objeto do tipo ArrayList de disciplinas
        ArrayList<Logradouro> lista = new ArrayList<Logradouro>();
        while(resultado.next()){
            //cria um novo disciplina a cada loop
            Logradouro logr = new Logradouro();
            logr.setId(resultado.getInt("id"));
            logr.setNome(resultado.getString("nome"));
            logr.setAbreviacao(resultado.getString("abreviacao"));
                        
            // insere disciplina na lista
            lista.add(logr);
       }
       resultado.close();
       //conexao.close();

       //Retorna a lista de disciplinas
       return lista;
    }
}