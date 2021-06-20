package Tarefa;

/**
 *
 * @author Mark
 */
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

/**
 *
 * 
 * Bibliotecas TimerTask e Timer
 * 
 * java.util.TimerTask: irá representar a tarefa a ser agendada. É uma classe abstrata que implementa a interface Runnable, assim, devemos criar uma sub-classe que implemente o método run().
 * java.util.Timer: irá representar o agendador de tarefas através de uma Thread.
 */

public class Agendamento {
    int contador = 0;
    
    // Inicia thread e chama método tarefa
    public static void main(String[] args) {
        Agendamento a = new Agendamento();
        a.tarefa();
    }


    private void tarefa() {
        // Pega instancia de Calendar e define hora-alvo
        Calendar c = Calendar.getInstance();
        c.set(Calendar.HOUR_OF_DAY, 23);
        c.set(Calendar.MINUTE, 59);
        c.set(Calendar.SECOND, 59);

        // Date pega hora-alvo
        Date time = c.getTime();

        final Timer t = new Timer();
        
        //agenda instanciamento e método que contém a tarefa a ser executada
        t.schedule(new TimerTask() {
            @Override
            public void run() {
                new Tarefa().executarTarefa(contador);
                t.cancel();
            }
            
        // Executa tarefa quando o horario do servidor for igual á hora-alvo
        }, time );
    }
}