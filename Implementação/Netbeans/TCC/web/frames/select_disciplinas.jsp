<%-- 
    Document   : select_disciplinas
    Created on : 27/12/2011, 21:01:40
    Author     : Mark
--%>

<%@page import="Dominio.Disciplina"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ArrayList<Disciplina> listaDisciplina = (ArrayList<Disciplina>) request.getAttribute("resultado");
    String disciplinas = "";
    String descricoesDisc = "";
    int j = 1;
    
    //IE não reconhece &#39; usar &#39;

    for (Disciplina disciplina : listaDisciplina) {
        
        disciplinas += "<option value='";
        disciplinas += disciplina.getId();
        disciplinas += "'";
        disciplinas += " onMouseOver='SwitchDiv(1, &#39;descricaoDisc"+j+"&#39;)' onMouseOut='SwitchDiv(0, &#39;descricaoDisc"+j+"&#39;)'>";
        disciplinas += disciplina.getNome();
        disciplinas += "</option>";
        
        
        descricoesDisc += "<div id='descricaoDisc"+j+"' class='toolTip'>";
        descricoesDisc += disciplina.getDescricao();
        descricoesDisc += "<span class='hint-pointer'>&nbsp;</span>";
        descricoesDisc += "</div>";
        j++;
    }
%>

<label class="obrigatorio">
    Disciplinas:
</label>

<select id="disciplina" name="disciplina" onChange="if (this.value != 0){enableCriarDisc(0)}else{enableCriarDisc(1)}">
        <option value="">Selecione..</option>
        <%= disciplinas %>
        <option class="opcaoEspecial" value="-1" onMouseOver="SwitchDiv(1, 'outros');" onMouseOut="SwitchDiv(0, 'outros')">Outros</option>
        <option class="opcaoEspecial" value="-2" onMouseOver="SwitchDiv(1, 'multi');" onMouseOut="SwitchDiv(0, 'multi')">Multidisciplinar</option>
        <option class="opcaoEspecial" value="0" onMouseOver="SwitchDiv(1, 'tooltipCriarDisc');" onMouseOut="SwitchDiv(0, 'tooltipCriarDisc')">Criar nova disciplina</option>
</select>
        
<span class="toolTipLocation">
    <%= descricoesDisc %>
    
    <div id="outros" class="toolTip">
        Caso a aula que você deseja criar não pertença a nenhuma das disciplinas anteriores
        <span class="hint-pointer">&nbsp;</span>
    </div>

    <div id="multi" class="toolTip">
        Caso a aula que você deseja criar pertença a duas ou mais disciplinas
        <span class="hint-pointer">&nbsp;</span>
    </div>

    <div id="tooltipCriarDisc" class="toolTip">
        Se não houver a disciplina que você quer, crie uma nova! colocar onselect em vez de onclick
        <span class="hint-pointer">&nbsp;</span>
    </div>
</span>