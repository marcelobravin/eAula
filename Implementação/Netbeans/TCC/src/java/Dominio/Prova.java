package Dominio;

/**
 *
 * @author Mark
 */
public class Prova extends ObjectDomain {
    private int duracao = 0;
    private int retorno = 0;
    private boolean randomOrder = false;

    public int getDuracao() {
        return duracao;
    }

    public void setDuracao(int duracao) {
        this.duracao = duracao;
    }

    public boolean isRandomOrder() {
        return randomOrder;
    }

    public void setRandomOrder(boolean randomOrder) {
        this.randomOrder = randomOrder;
    }

    public int getRetorno() {
        return retorno;
    }

    public void setRetorno(int retorno) {
        this.retorno = retorno;
    }
    
    
}
