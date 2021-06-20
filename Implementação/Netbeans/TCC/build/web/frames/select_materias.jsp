<%-- 
    Document   : zmaterias
    Created on : 27/12/2011, 15:59:58
    Author     : Mark
--%>

<%@page import="Dominio.Materia"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ArrayList<Materia> listaMateria = (ArrayList<Materia>) request.getAttribute("resultado");
    String materias = "";
    String descricoesMat = "";
    int i = 1;
    
    // Itera pelas matérias
    for (Materia materia : listaMateria) {
        
        // Constrói as opções
        materias += "<option value='";
        materias += materia.getId();
        materias += "'";
        materias += "onMouseOver='SwitchDiv(1, &apos;descricaoMat"+i+"&apos;)' onMouseOut='SwitchDiv(0, &apos;descricaoMat"+i+"&apos;)'>";
        materias += materia.getNome();
        materias += "</option>";
        
        // Constrói os tooltips contendo as descrições
        descricoesMat += "<div id='descricaoMat"+i+"' class='toolTip'>";
        descricoesMat += materia.getDescricao();
        descricoesMat += "<span class='hint-pointer'>&nbsp;</span>";
        descricoesMat += "</div>";
        i++;
    }
%>

<label class="obrigatorio">
    Matéria:
</label>

<select id="materia" name="materia" onChange="loadDiv('FiltroOpcoes?materia='+this.value, 'selectDisciplina')">
        <option value="">Selecione..</option>
        <%= materias %>
</select>

<span class="toolTipLocation">
    <%= descricoesMat %>
</span>