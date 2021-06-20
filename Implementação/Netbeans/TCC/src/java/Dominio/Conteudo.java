package Dominio;

/**
 *
 * @author Mark
 */
public class Conteudo extends ObjectDomain {
    private int idAula;
    private int idExercicio;
    private String exercicioTipo;
    private int pagina;

    public int getPagina() {
        return pagina;
    }

    public void setPagina(int pagina) {
        this.pagina = pagina;
    }

    public String getExercicioTipo() {
        return exercicioTipo;
    }

    public void setExercicioTipo(String exercicioTipo) {
        this.exercicioTipo = exercicioTipo;
    }

    public int getIdAula() {
        return idAula;
    }

    public void setIdAula(int idAula) {
        this.idAula = idAula;
    }

    public int getIdExercicio() {
        return idExercicio;
    }

    public void setIdExercicio(int idExercicio) {
        this.idExercicio = idExercicio;
    }
}