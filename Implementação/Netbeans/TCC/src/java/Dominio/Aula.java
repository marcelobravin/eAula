package Dominio;

import java.sql.Timestamp;

/**
 *
 * @author Mark
 */
public class Aula extends ObjectDomain {
    String titulo = "";
    String descricao = "";
    int idAutor = 0;
    int idDisciplina = 0;
    boolean restrita = false;
    String senha = "";
    int utilizacoes = 0;
    int conclusoes = 0;
    int votos = 0;
    int media = 0;
    boolean aprovacao = false;
    Timestamp dataCriacao = null;
    Timestamp dataAtualizacao = null;

    public boolean isAprovacao() {
        return aprovacao;
    }

    public void setAprovacao(boolean aprovacao) {
        this.aprovacao = aprovacao;
    }

    public int getConclusoes() {
        return conclusoes;
    }

    public void setConclusoes(int conclusoes) {
        this.conclusoes = conclusoes;
    }

    public Timestamp getDataAtualizacao() {
        return dataAtualizacao;
    }

    public void setDataAtualizacao(Timestamp dataAtualizacao) {
        this.dataAtualizacao = dataAtualizacao;
    }

    public Timestamp getDataCriacao() {
        return dataCriacao;
    }

    public void setDataCriacao(Timestamp dataCriacao) {
        this.dataCriacao = dataCriacao;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getIdAutor() {
        return idAutor;
    }

    public void setIdAutor(int idAutor) {
        this.idAutor = idAutor;
    }

    public int getIdDisciplina() {
        return idDisciplina;
    }

    public void setIdDisciplina(int idDisciplina) {
        this.idDisciplina = idDisciplina;
    }

    public int getMedia() {
        return media;
    }

    public void setMedia(int media) {
        this.media = media;
    }

    public boolean isRestrita() {
        return restrita;
    }

    public void setRestrita(boolean restrita) {
        this.restrita = restrita;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public int getUtilizacoes() {
        return utilizacoes;
    }

    public void setUtilizacoes(int utilizacoes) {
        this.utilizacoes = utilizacoes;
    }

    public int getVotos() {
        return votos;
    }

    public void setVotos(int votos) {
        this.votos = votos;
    }
}