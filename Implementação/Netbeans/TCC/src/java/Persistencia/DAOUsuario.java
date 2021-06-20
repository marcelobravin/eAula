package Persistencia;

import Dominio.Endereco;
import Dominio.Usuario;
import Dominio.ObjectDomain;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DAOUsuario implements IDAO{
    // variavel de instancia que define a conexão com o BD
    private Connection conexao;
    
    public DAOUsuario() {
        Conectar();
    }
    
    public final void Conectar() {
        try {
            //ao ser instanciado cria conexao com o banco
            this.conexao = ConectaBanco.getConexao();
        } catch (Exception erro) {
            throw new RuntimeException(erro);
        }
    }
    
    
    
    
    
    // CADASTRAR recebe um objeto usuario----------------------------------------
    @Override
    public void cadastrar(ObjectDomain objeto) throws SQLException,ClassNotFoundException {
        
        // Converte ObjectDomain para usuario
        Usuario usuario = (Usuario) objeto;
        try {
            // SQL de consulta
            
            String sql = "INSERT INTO usuarios";
            sql += " (nome, cpf, email, escolaridade, senha, profissao, privilegios, sexo, dataNascimento, id_tipoLogradouro, logradouro, numero, id_cidade, id_uf, cep, dataCadastro)";
            sql += " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            
            
            // Seta atributos conforme o 'Usuario'recebido
            stmt.setString(1, usuario.getNome());
            stmt.setLong(2, usuario.getCpf());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getEscolaridade());
            stmt.setString(5, usuario.getSenha());
            stmt.setString(6, usuario.getProfissao());
            stmt.setInt(7, usuario.getPrivilegios());
            stmt.setBoolean(8, usuario.getSexo());
            stmt.setString(9, usuario.getDataNascimento());
            
            // Endereco
            stmt.setInt(10, usuario.getEnd().getIdTipoLogradouro());
            stmt.setString(11, usuario.getEnd().getLogradouro());
            stmt.setInt(12, usuario.getEnd().getNumero());
            stmt.setInt(13, usuario.getEnd().getIdCidade());
            stmt.setInt(14, usuario.getEnd().getIdUf());
            stmt.setInt(15, usuario.getEnd().getCep());
            
            stmt.setTimestamp(16, new java.sql.Timestamp(System.currentTimeMillis()));
            
            //executa inserção
            stmt.executeUpdate();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    //ATUALIZAR recebe um objeto usuario----------------------------------------
    @Override
    public void atualizar(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        
        //Converte um Object em um Usuario
        Usuario usuario = (Usuario) objeto;
        
        try {
            // SQL de atualização
            String sql = "UPDATE usuarios SET";
            sql += " nome=?, cpf=?, email=?, escolaridade=?, senha=?, profissao=?, privilegios=?, sexo=?, dataNascimento=?, id_tipoLogradouro=?, logradouro=?, numero=?, id_cidade=?, id_uf=?, cep=?";
            sql += " WHERE id=?";
            
            PreparedStatement stmt = conexao.prepareStatement(sql);
            
            
            // Seta atributos conforme o 'Usuario'recebido
            stmt.setString(1, usuario.getNome());
            stmt.setLong(2, usuario.getCpf());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getEscolaridade());
            stmt.setString(5, usuario.getSenha());
            stmt.setString(6, usuario.getProfissao());
            stmt.setInt(7, usuario.getPrivilegios());
            stmt.setBoolean(8, usuario.getSexo());
            stmt.setString(9, usuario.getDataNascimento());
            
            // Endereco
            stmt.setInt(10, usuario.getEnd().getIdTipoLogradouro());
            stmt.setString(11, usuario.getEnd().getLogradouro());
            stmt.setInt(12, usuario.getEnd().getNumero());
            stmt.setInt(13, usuario.getEnd().getIdCidade());
            stmt.setInt(14, usuario.getEnd().getIdUf());
            stmt.setInt(15, usuario.getEnd().getCep());
            
            //stmt.setTimestamp(16, new java.sql.Timestamp(System.currentTimeMillis()));
            stmt.setInt(16, usuario.getId());
            
            // Realiza atualização
            stmt.execute();
            
            //reiniciar sessão
        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    

    //método listar, devolve uma lista de usuarios
    @Override
    public ArrayList<ObjectDomain> listar() throws SQLException, ClassNotFoundException {
       
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM usuarios ORDER BY id");
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();


        //cria um objeto do tipo ArrayList de usuarios
        ArrayList<ObjectDomain> listaUsuario = new ArrayList<ObjectDomain>();
        while(resultado.next()){
            //cria um novo usuario a cada loop
            Usuario novoUsuario = new Usuario();
            novoUsuario.setId(resultado.getInt("id"));
            novoUsuario.setNome(resultado.getString("nome"));
            novoUsuario.setCpf(resultado.getLong("cpf"));
            novoUsuario.setEmail(resultado.getString("email"));
            novoUsuario.setEscolaridade(resultado.getString("escolaridade"));
            novoUsuario.setSenha(resultado.getString("senha"));
            novoUsuario.setProfissao(resultado.getString("profissao"));
            novoUsuario.setPrivilegios(resultado.getInt("privilegios"));
            novoUsuario.setSexo(resultado.getBoolean("sexo"));
            novoUsuario.setDataNascimento(resultado.getString("dataNascimento"));
            
            Endereco novoEnd = new Endereco();
            novoEnd.setIdTipoLogradouro(resultado.getInt("id_tipoLogradouro"));
            novoEnd.setLogradouro(resultado.getString("logradouro"));
            novoEnd.setNumero(resultado.getInt("numero"));
            novoEnd.setIdCidade(resultado.getInt("id_cidade"));
            novoEnd.setIdUf(resultado.getInt("id_uf"));
            novoEnd.setCep(resultado.getInt("cep"));
            
            novoUsuario.setEnd(novoEnd);
            
                        
            // insere usuario na lista
            listaUsuario.add(novoUsuario);
       }
       resultado.close();
       conexao.close();

       //Retorna a lista de usuarios
       return listaUsuario;
    }

    //método localizar por Id, devolve um usuario encontrado
    @Override
    public Usuario localizarPorId(int id) throws SQLException, ClassNotFoundException {
       
        // SQL de consulta
        String sql = "SELECT * FROM usuarios where id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, id);
        
        ResultSet rs = stmt.executeQuery();
        Usuario usuario = new Usuario();
        while(rs.next()){            
            usuario.setId(rs.getInt("id"));
            usuario.setNome(rs.getString("nome"));
            usuario.setCpf(rs.getLong("cpf"));
            usuario.setSexo(rs.getBoolean("sexo"));            
            usuario.setEmail(rs.getString("email"));
            usuario.setEscolaridade(rs.getString("escolaridade"));
            usuario.setSenha(rs.getString("senha"));
            usuario.setProfissao(rs.getString("profissao"));
            usuario.setPrivilegios(rs.getInt("privilegios"));
            
            usuario.setDataNascimento(rs.getString("dataNascimento"));

            Endereco end = new Endereco();
            
            end.setIdTipoLogradouro(rs.getInt("id_tipoLogradouro"));
            end.setLogradouro(rs.getString("logradouro"));
            end.setNumero(rs.getInt("numero"));
            end.setIdCidade(rs.getInt("id_cidade"));
            end.setIdUf(rs.getInt("id_uf"));
            end.setCep(rs.getInt("cep"));

            usuario.setEnd(end);
        }
        stmt.close();
        rs.close();
        conexao.close();
        return usuario;
    }

    

    
    
    //método excluir, recebe um 'ObjectDomain'
    @Override
    public void excluir(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        
        // Converte 'ObjectDomain' para 'Usuario'
        Usuario usuario = (Usuario) objeto;
        
        try {
            PreparedStatement sql = conexao.prepareStatement("DELETE FROM usuarios WHERE id=?");
            sql.setInt(1, usuario.getId());
            sql.execute();
        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            // Fecha a conexão
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //utilizado por realizar login
    public Usuario localizarPorNome(String nome) throws SQLException, ClassNotFoundException {
         // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT nome, senha, id, privilegios FROM usuarios WHERE nome=?");
        sql.setString(1, nome);
        
        ResultSet resultado = sql.executeQuery();
        Usuario usuario = new Usuario();
        while(resultado.next()){            
            usuario.setNome(resultado.getString("nome"));
            usuario.setSenha(resultado.getString("senha"));
            usuario.setId(resultado.getInt("id"));
            usuario.setPrivilegios(resultado.getInt("privilegios"));
        }
        conexao.close();
        return usuario;
    }
    
    
    
    
    
    
    
    
    
    
    //utilizado por realizar login
    public Usuario localizarPorEmail(Usuario usr) throws SQLException, ClassNotFoundException {
         // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM usuarios WHERE email=?");
        sql.setString(1, usr.getEmail());
        
        ResultSet resultado = sql.executeQuery();        
        
        if (resultado.next()) {            
            usr.setSenha(resultado.getString("senha"));
            usr.setEmail(resultado.getString("email"));
        }
        conexao.close();
        return usr;
    }
    
}