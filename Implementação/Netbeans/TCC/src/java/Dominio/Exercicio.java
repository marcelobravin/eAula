package Dominio;

/**
 *
 * @author Mark
 */
public class Exercicio extends ObjectDomain {
    
    // acho q dá pra tirar perguntaId e usar id para relacionar perguntas e respostas
    int perguntaId;
    String titulo;

    public int getPerguntaId() {
        return perguntaId;
    }

    public void setPerguntaId(int perguntaId) {
        this.perguntaId = perguntaId;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }
}