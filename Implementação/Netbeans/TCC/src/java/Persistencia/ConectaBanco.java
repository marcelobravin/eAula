package Persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Mark
 */
public class ConectaBanco {
    public static Connection getConexao() throws ClassNotFoundException, SQLException {
        
        String driver = "org.postgresql.Driver";
        
        String host = "jdbc:postgresql://127.0.0.1:5432/PFC";
        String usuario = "postgres";
        String senha = "m4rkn3ss";
        //String senha = "senha";
        
        
        try {
            // Define driver de conexão
            Class.forName(driver);
            
            // Cria conexão
            Connection conexao = DriverManager.getConnection(host, usuario, senha);
            return conexao;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}