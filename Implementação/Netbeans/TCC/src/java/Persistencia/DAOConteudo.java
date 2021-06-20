package Persistencia;

import Dominio.Conteudo;
import Dominio.ObjectDomain;
import Dominio.Progresso;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Mark
 */
public class DAOConteudo {
    
    // variavel de instancia que define a conexão com o BD
    private Connection conexao;
    
    //ao ser instanciado cria conexao com o banco
    public DAOConteudo() {
        Conectar();
        /*
        try {
            this.conexao = ConectaBanco.getConexao();
        } catch (Exception erro) {
            // dar tratamento melhor para o erro
            //System.out.print(erro);
            throw new RuntimeException(erro);
        }
         * 
         */
    }
    
    
    
    public final void Conectar() {
        try {
            this.conexao = ConectaBanco.getConexao();
        } catch (Exception erro) {
            // dar tratamento melhor para o erro
            //System.out.print(erro);
            throw new RuntimeException(erro);
        }
    }
    

    
    
    public void cadastrar(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        // converte objeto para aula
        Conteudo conteudo = (Conteudo) objeto;
        
        try {
            
            // Recupera id da pergunta inserida
            String sql = "SELECT id FROM ";
            //String sql = "SELECT MAX(id) FROM ";
            
            if (conteudo.getExercicioTipo().equals("texto")) {                
                sql += "textos";
            } else if (conteudo.getExercicioTipo().equals("arquivo")) {
                sql += "arquivos";
            } else if (conteudo.getExercicioTipo().equals("prova")) {
                sql += "e_provas";
            } else {
                sql += "e_";
                sql += conteudo.getExercicioTipo();
                sql += "_perguntas";
            }
            
            PreparedStatement stmt = conexao.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            int key = -1;
            while (rs.next()) {
                key = rs.getInt("id");
            }
            conteudo.setIdExercicio(key);
            
            
            
            
            
            // posição de conteudo
            sql = "SELECT MAX(posicao) FROM conteudo WHERE id_aula=?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, conteudo.getIdAula());
            rs = stmt.executeQuery();
            
            int pagina = 0;
            while (rs.next()) {
                pagina = rs.getInt("max");
            }
            conteudo.setPagina(++pagina);
            
            
            
            // SQL de inserção de conteudo
            sql = "INSERT INTO conteudo(id_aula, tipo_exercicio, id_exercicio, posicao) VALUES(?,?,?,?)";
            stmt = conexao.prepareStatement(sql);
           
            stmt.setInt(1, conteudo.getIdAula());
            stmt.setString(2, conteudo.getExercicioTipo());
            stmt.setInt(3, conteudo.getIdExercicio());            
            stmt.setInt(4, conteudo.getPagina());
            stmt.execute();
            
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    public void cadastrarCP(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        // converte objeto para aula
        Conteudo conteudo = (Conteudo) objeto;
        
        try {
            // Recupera id da pergunta inserida            
            String sql = "SELECT id FROM e_"+ conteudo.getExercicioTipo() +"_perguntas";
            
            
            PreparedStatement stmt = conexao.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            int key = -1;
            while (rs.next()) {
                key = rs.getInt("id");
            }
            conteudo.setIdExercicio(key);
            
            
            
            
            
            // posição de conteudo
            sql = "SELECT MAX(posicao) FROM e_provas_conteudo WHERE id_prova=?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, conteudo.getIdAula());
            rs = stmt.executeQuery();
            
            int pagina = 0;
            while (rs.next()) {
                pagina = rs.getInt("max");
            }
            conteudo.setPagina(++pagina);
            
            
            
            // SQL de inserção de conteudo
            sql = "INSERT INTO e_provas_conteudo(id_prova, tipo_exercicio, id_exercicio, posicao) VALUES(?,?,?,?)";
            stmt = conexao.prepareStatement(sql);
           
            stmt.setInt(1, conteudo.getIdAula());
            stmt.setString(2, conteudo.getExercicioTipo());
            stmt.setInt(3, conteudo.getIdExercicio());            
            stmt.setInt(4, conteudo.getPagina());
            stmt.execute();
            
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    


    public ArrayList<Conteudo> listar(int aulaId) throws SQLException, ClassNotFoundException {
        
        ArrayList lista = new ArrayList();
        
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM conteudo WHERE id_aula=? ORDER BY posicao");
        sql.setInt(1, aulaId);
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();

        while(resultado.next()){
            //cria um novo aula a cada loop
            Conteudo cont = new Conteudo();

            //seta atributos do conteudo
            cont.setIdAula(resultado.getInt("id_aula"));
            cont.setIdExercicio(resultado.getInt("id_exercicio"));
            cont.setExercicioTipo(resultado.getString("tipo_exercicio"));

            // insere aula na lista
            lista.add(cont);
        }
        // Finaliza
        resultado.close();
        conexao.close();
        return lista;
    }
    
    
    
    
    
    
    public ArrayList<Conteudo> listarCP(int aulaId) throws SQLException, ClassNotFoundException {
        
        ArrayList lista = new ArrayList();
        
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM e_provas_conteudo WHERE id_prova=?  ORDER BY posicao");
        sql.setInt(1, aulaId);
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();

        while(resultado.next()){
            
            //cria um novo aula a cada loop
            Conteudo cont = new Conteudo();
            
            //seta atributos do conteudo
            cont.setIdAula(resultado.getInt("id_prova"));
            cont.setIdExercicio(resultado.getInt("id_exercicio"));
            cont.setExercicioTipo(resultado.getString("tipo_exercicio"));
            
            // insere aula na lista
            lista.add(cont);
       }
        resultado.close();
        conexao.close();
        return lista;
    }
    
    
    
    
    
    
    
    

    public Conteudo localizar(Conteudo cont) throws SQLException, ClassNotFoundException {
        
        // SQL de consulta
        PreparedStatement sql = conexao.prepareStatement("SELECT * FROM conteudo WHERE id_aula=? AND posicao=?");
        
        sql.setInt(1, cont.getIdAula());
        sql.setInt(2, cont.getPagina());
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet resultado = sql.executeQuery();

        while(resultado.next()){
            
            //seta atributos do conteudo
            //cont.setId(resultado.getInt("id"));// nem precisa
            //cont.setIdAula(resultado.getInt("id_aula"));
            cont.setIdExercicio(resultado.getInt("id_exercicio"));
            cont.setExercicioTipo(resultado.getString("tipo_exercicio"));
            
       }
        resultado.close();
        conexao.close();

        return cont;
    }
    
    
    
    
    
    
    
    
    
    
    
    public void excluir(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        // converte objeto para aula
        Conteudo conteudo = (Conteudo) objeto;
        
        try {
            
            String sql = "DELETE FROM ";
            PreparedStatement stmt;
            
            if (conteudo.getExercicioTipo().equals("texto") || conteudo.getExercicioTipo().equals("arquivo")) {
                sql += conteudo.getExercicioTipo();
                sql += "s";
                sql += " WHERE id=";
                sql += conteudo.getIdExercicio();

                stmt = conexao.prepareStatement(sql);
                stmt.execute();
            } else if (conteudo.getExercicioTipo().equals("prova")) {
                sql += "e_";
                sql += conteudo.getExercicioTipo();
                sql += "s";
                sql += " WHERE id=";
                sql += conteudo.getIdExercicio();

                stmt = conexao.prepareStatement(sql);
                stmt.execute();
                
                
                
                // Monta sql e realiza exclusão da pergunta
                sql = "DELETE FROM e_provas_conteudo WHERE id_prova=" +conteudo.getIdExercicio();

                stmt = conexao.prepareStatement(sql);
                stmt.execute();
                
            } else {
                // Monta sql e realiza exclusão das respostas
                sql += "e_";
                sql += conteudo.getExercicioTipo();
                sql += "_respostas";
                sql += " WHERE pergunta_id=";
                sql += conteudo.getIdExercicio();

                stmt = conexao.prepareStatement(sql);
                stmt.execute();




                // Monta sql e realiza exclusão da pergunta
                sql = "DELETE FROM ";
                sql += "e_";
                sql += conteudo.getExercicioTipo();
                sql += "_perguntas";
                sql += " WHERE id=";
                sql += conteudo.getIdExercicio();

                stmt = conexao.prepareStatement(sql);
                stmt.execute();
            }
            
            
            
            
            
            
            
            
            
            
            
            
            // atualizar o resto da lista
            // Recupera posição do conteudo removido
            sql = "SELECT posicao FROM conteudo WHERE tipo_exercicio=? AND id_exercicio=?";
            stmt = conexao.prepareStatement(sql);
            
            stmt.setString(1, conteudo.getExercicioTipo());
            stmt.setInt(2, conteudo.getIdExercicio());
            
            ResultSet rs = stmt.executeQuery();
            
            int posicao = 0;
            while (rs.next()) {
                posicao = rs.getInt("posicao");
            }
            
            
            
             //Atualiza posicoes do conteudo a frente
            sql = "UPDATE conteudo SET posicao=posicao-1 WHERE posicao>? AND id_aula=?";
            stmt = conexao.prepareStatement(sql);

            stmt.setInt(1, posicao);
            stmt.setInt(2, conteudo.getIdAula());
            stmt.executeUpdate();
            
            
            
            
            
            
            
            
            
            
            
            
            // Monta sql e realiza exclusão das respostas
            sql = "DELETE FROM conteudo WHERE tipo_exercicio=? AND id_exercicio=?";
            stmt = conexao.prepareStatement(sql);
                        
            stmt.setString(1, conteudo.getExercicioTipo());
            stmt.setInt(2, conteudo.getIdExercicio());
            stmt.execute();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public void excluirCP(ObjectDomain objeto) throws SQLException, ClassNotFoundException {
        // converte objeto para aula
        Conteudo conteudo = (Conteudo) objeto;
        
        try {
            
            String sql = "DELETE FROM ";
            PreparedStatement stmt;
            
            
            // if (x || y)
            if (conteudo.getExercicioTipo().equals("texto")) {
                sql += conteudo.getExercicioTipo();
                sql += "s";
                sql += " WHERE id=";
                sql += conteudo.getIdExercicio();

                stmt = conexao.prepareStatement(sql);
                stmt.execute(); 
            } else {
                // Monta sql e realiza exclusão das respostas
                sql += "e_";
                sql += conteudo.getExercicioTipo();
                sql += "_respostas";
                sql += " WHERE pergunta_id=";
                sql += conteudo.getIdExercicio();

                stmt = conexao.prepareStatement(sql);
                stmt.execute();




                // Monta sql e realiza exclusão da pergunta
                sql = "DELETE FROM ";
                sql += "e_";
                sql += conteudo.getExercicioTipo();
                sql += "_perguntas";
                sql += " WHERE id=";
                sql += conteudo.getIdExercicio();

                stmt = conexao.prepareStatement(sql);
                stmt.execute();
            }
            
            
            
            
            // atualizar o resto da lista
            // Recupera posição do conteudo removido
            sql = "SELECT posicao FROM e_provas_conteudo WHERE tipo_exercicio=? AND id_exercicio=?";
            stmt = conexao.prepareStatement(sql);
            
            stmt.setString(1, conteudo.getExercicioTipo());
            stmt.setInt(2, conteudo.getIdExercicio());
            
            ResultSet rs = stmt.executeQuery();
            
            int posicao = 0;
            while (rs.next()) {
                posicao = rs.getInt("posicao");
            }
            
            
            
             //Atualiza posicoes do conteudo a frente
            sql = "UPDATE e_provas_conteudo SET posicao=posicao-1 WHERE posicao>? AND id_prova=?";
            stmt = conexao.prepareStatement(sql);

            stmt.setInt(1, posicao);
            stmt.setInt(2, conteudo.getIdAula());
            stmt.executeUpdate();
            
            
            
            
            
            
            // Monta sql e realiza exclusão das respostas
            sql = "DELETE FROM e_provas_conteudo WHERE tipo_exercicio=? AND id_exercicio=?";
            stmt = conexao.prepareStatement(sql);
                        
            stmt.setString(1, conteudo.getExercicioTipo());
            stmt.setInt(2, conteudo.getIdExercicio());
            stmt.execute();
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        
    public void reposicionar(ObjectDomain objeto, boolean praCima) throws SQLException, ClassNotFoundException {
        // converte objeto para aula
        Conteudo conteudo = (Conteudo) objeto;
        
        try {
            
            String sql = "";
            PreparedStatement stmt;
            
            
            // Recupera posição do conteudo a ser movido
            sql = "SELECT posicao FROM conteudo WHERE tipo_exercicio=? AND id_exercicio=?";
            stmt = conexao.prepareStatement(sql);
            
            stmt.setString(1, conteudo.getExercicioTipo());
            stmt.setInt(2, conteudo.getIdExercicio());
            
            ResultSet rs = stmt.executeQuery();
            
            int posicao = 0;
            while (rs.next()) {
                posicao = rs.getInt("posicao");
            }
            
            if (praCima) {
                //Atualiza posicoes do conteudo a frente
                sql = "UPDATE conteudo SET posicao=posicao+1 WHERE posicao=?-1 AND id_aula=?";
                stmt = conexao.prepareStatement(sql);
                stmt.setInt(1, posicao);
                stmt.setInt(2, conteudo.getIdAula());
                stmt.executeUpdate();


                //sql = "UPDATE conteudo SET posicao=posicao-1 WHERE posicao>? AND id_aula=?";
                sql = "UPDATE conteudo SET posicao=posicao-1 WHERE tipo_exercicio=? AND id_exercicio=?";
                stmt = conexao.prepareStatement(sql);
                stmt.setString(1, conteudo.getExercicioTipo());
                stmt.setInt(2, conteudo.getIdExercicio());
                stmt.executeUpdate();
            } else {
                //Atualiza posicoes do conteudo a frente
                sql = "UPDATE conteudo SET posicao=posicao-1 WHERE posicao=?+1 AND id_aula=?";
                stmt = conexao.prepareStatement(sql);
                stmt.setInt(1, posicao);
                stmt.setInt(2, conteudo.getIdAula());
                stmt.executeUpdate();


                //sql = "UPDATE conteudo SET posicao=posicao-1 WHERE posicao>? AND id_aula=?";
                sql = "UPDATE conteudo SET posicao=posicao+1 WHERE tipo_exercicio=? AND id_exercicio=?";
                stmt = conexao.prepareStatement(sql);
                stmt.setString(1, conteudo.getExercicioTipo());
                stmt.setInt(2, conteudo.getIdExercicio());
                stmt.executeUpdate();
            }
            


            
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
       
    public void progredir(Progresso conteudo) throws SQLException {
        
        try {            
            String sql = "";
            PreparedStatement stmt;
            
            if (conteudo.getPosicao() == 1) {
                sql = "INSERT INTO progresso (id_aula, id_usuario, posicao) VALUES(?,?,?)";
                stmt = conexao.prepareStatement(sql);

                stmt.setInt(1, conteudo.getId_aula());                
                stmt.setInt(2, conteudo.getId_usuario());
                stmt.setInt(3, conteudo.getPosicao());
                stmt.execute();
            } else {
                sql = "UPDATE progresso SET posicao=? WHERE id_aula=? AND id_usuario=?";
                stmt = conexao.prepareStatement(sql);
                stmt.setInt(1, conteudo.getPosicao());
                stmt.setInt(2, conteudo.getId_aula());
                stmt.setInt(3, conteudo.getId_usuario());
                stmt.executeUpdate();
            }
            
        } catch(Exception erro) {
            System.out.println(erro);
        } finally {
            conexao.close();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public int localizar(Progresso cont) throws SQLException {
        int num = 0;
        
        // SQL de consulta
        String sql = "SELECT posicao FROM progresso WHERE id_aula=? AND id_usuario=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);        
        stmt.setInt(1, cont.getId_aula());
        stmt.setInt(2, cont.getId_usuario());
        
        //executa a consulta e quarda o resultado em um ResultSet
        ResultSet rs = stmt.executeQuery();

        while(rs.next()){
            num = rs.getInt("posicao");
        }
        
        
        rs.close();
        conexao.close();
        return num;
    }
    
    
    
    
    
    
    
    
    
    
    

}