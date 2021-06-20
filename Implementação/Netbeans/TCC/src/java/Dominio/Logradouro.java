package Dominio;

/**
 *
 * @author Markness
 */
public class Logradouro extends ObjectDomain{
    private String nome;
    private String abreviacao;

    public String getAbreviacao() {
        return abreviacao;
    }

    public void setAbreviacao(String abreviacao) {
        this.abreviacao = abreviacao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}