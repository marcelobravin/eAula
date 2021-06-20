package Dominio;

/**
 *
 * @author Mark
 */
public class ExercicioLacunas extends Exercicio {

    String[] preTexto;
    String[] resposta;
    String[] posTexto;

    public String[] getPosTexto() {
        return posTexto;
    }

    public void setPosTexto(String[] posTexto) {
        this.posTexto = posTexto;
    }

    public String[] getPreTexto() {
        return preTexto;
    }

    public void setPreTexto(String[] preTexto) {
        this.preTexto = preTexto;
    }

    public String[] getResposta() {
        return resposta;
    }

    public void setResposta(String[] resposta) {
        this.resposta = resposta;
    }

}