package Dominio;

/**
 *
 * @author Mark
 */
public class ExercicioMEscolha extends Exercicio {
    
    String[] alternativa;
    boolean[] correta;

    public String[] getAlternativa() {
        return alternativa;
    }

    public void setAlternativa(String[] alternativa) {
        this.alternativa = alternativa;
    }

    public boolean[] getCorreta() {
        return correta;
    }

    public void setCorreta(boolean[] correta) {
        this.correta = correta;
    }
}