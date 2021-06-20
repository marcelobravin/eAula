package Dominio;

/**
 *
 * @author Mark
 */
public class Cidade extends ObjectDomain {
    
    String uf;
    String nome;
    
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }
}