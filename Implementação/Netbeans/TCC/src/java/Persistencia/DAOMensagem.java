package Persistencia;

import Dominio.Mensagem;
import Dominio.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Mark
 */
public class DAOMensagem {
    // variavel de instancia que define a conexão com o BD
    private Connection conexao;
    
    
    // Ao ser instanciado cria conexao com o banco
    public DAOMensagem() {
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
    
    public void Cadastrar(Mensagem objeto) throws SQLException {
        PreparedStatement stmt = null;
                
        try {
            // Monta instrução sql
            String sql = "INSERT INTO mensagens ";
            sql += "(id_remetente, id_alvo, conteudo, data_hora)";
            sql += " VALUES (?, ?, ?, ?)";
            
            // Prepara declaração
            stmt = conexao.prepareStatement(sql);            
            stmt.setInt(1, objeto.getRemetente().getId());
            stmt.setInt(2, objeto.getDestinatario().getId());
            stmt.setString(3, objeto.getConteudo());
            stmt.setTimestamp(4, objeto.getData_hora());

            stmt.execute();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
            stmt.close();
        }
    }
    
    
    
    public ArrayList<Mensagem> listar(Mensagem obj) throws SQLException, ClassNotFoundException {
       
        // SQL de consulta
        String sql = "SELECT * FROM mensagens WHERE id_alvo=? ORDER BY data_hora";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, obj.getDestinatario().getId());
        ResultSet rs = stmt.executeQuery();


        //cria um objeto do tipo ArrayList de usuarios
        ArrayList<Mensagem> lista = new ArrayList<Mensagem>();
        
        
        
        while(rs.next()){
            //cria um novo usuario a cada loop
            Mensagem mssg = new Mensagem();
            Usuario usr = new Usuario();
            
            mssg.setId(rs.getInt("id"));            
            mssg.setConteudo(rs.getString("conteudo"));
            mssg.setData_hora(rs.getTimestamp("data_hora"));
            
            
            
            //usr.setId(rs.getInt("id_alvo"));
            //mssg.setDestinatario(usr);
            
            usr.setId(rs.getInt("id_remetente"));
            mssg.setRemetente(usr);
            
            
            
                        
            // insere usuario na lista
            lista.add(mssg);
       }
       rs.close();
       conexao.close();

       //Retorna a lista de usuarios
       return lista;
    }
    
    
    
    public void Excluir(Mensagem obj) throws SQLException, ClassNotFoundException {
        
        try {
            PreparedStatement sql = conexao.prepareStatement("DELETE FROM mensagens WHERE id=?");
            sql.setInt(1, obj.getId());
            sql.execute();
        } catch (Exception erro) {
            System.out.println(erro);
        } finally {
            // Fecha a conexão
            conexao.close();
        }
    }
}