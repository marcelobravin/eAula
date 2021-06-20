package Tarefa;

import Dominio.Aula;
import Persistencia.DAOAula;

/**
 *
 * @author Mark
 */
public class Tarefa {

    // tarefa a ser executada
    public void executarTarefa(int valor) {
        try {
            
            //executar limpeza nas aulas que não estão sendo acessadas
            String titulo = "aula automatica" + valor;
            
            //seta atributos na aula a ser salva
            Aula aula = new Aula();
            aula.setTitulo(titulo);
            
            // Instancia um objeto DAOAula chama método inserir
            DAOAula daoAula = new DAOAula();
            daoAula.cadastrar(aula);
        } catch(Exception erro) {
            throw new RuntimeException(erro);
        }
    }
}