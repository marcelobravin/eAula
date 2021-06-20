package Persistencia;

import Dominio.ObjectDomain;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Mark
 */
public interface IDAO {
     public void cadastrar(ObjectDomain objeto) throws SQLException, ClassNotFoundException;
     public ArrayList<ObjectDomain> listar() throws SQLException, ClassNotFoundException;
     public ObjectDomain localizarPorId(int id) throws SQLException, ClassNotFoundException;
     public void atualizar(ObjectDomain objeto) throws SQLException, ClassNotFoundException;
     public void excluir(ObjectDomain objeto) throws SQLException, ClassNotFoundException;
}