<%-- 
    Document   : select_cidades
    Created on : 18/12/2011, 18:42:43
    Author     : Mark
--%>

<%@page import="Dominio.Cidade"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
ArrayList<Cidade> listaCidade = (ArrayList<Cidade>) request.getAttribute("resultado");
String cidades = "";


for (Cidade cidade : listaCidade) {
     
    cidades += "<option value='";
    cidades += cidade.getId();
    cidades += "'>";
    cidades += cidade.getNome();
    cidades += "</option>";
}
%>
        
<label class="obrigatorio">
    Cidade:
</label>
<select name="campoCidade" id="campoCidade">
        <%= cidades%>
</select>     