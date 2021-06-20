package Tarefa;

import Dominio.Aula;
import Dominio.Endereco;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author Mark
 */

public class TesteObj {
    int id = 1;
    String nome = "zé";
    float valor;
    Long longo = 1L;
    // da problema qdo bool = null e descartar = false
    Boolean sexo = true;

    public Boolean getSexo() {
        return sexo;
    }

    public void setSexo(Boolean sexo) {
        this.sexo = sexo;
    }

    public Long getLongo() {
        return longo;
    }

    public void setLongo(Long longo) {
        this.longo = longo;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }


}