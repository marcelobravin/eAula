package Dominio;

/**
 *
 * @author Mark
 */
public class Materia extends ObjectDomain{
    private String nome;
    private int area;
    private String descricao;

    public int getArea() {
        return area;
    }

    public void setArea(int area) {
        this.area = area;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}