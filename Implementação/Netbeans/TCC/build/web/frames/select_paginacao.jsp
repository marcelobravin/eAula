<%-- 
    Document   : select_paginacao
    Created on : 14/04/2012, 13:46:58
    Author     : Mark
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>


                            <input type="hidden" id="paginaAtual" value="0">
                            
                            
                            <span class="floatRight">
                                <i><%= j %> resultados encontrados</i>
                                <select id="paginas" class="floatight" style="color: black;" name="m">
                                    <option value="2">2 por página</option>
                                    <option value="10" selected="selected">10 por página</option>
                                    <option value="20">20 por página</option>
                                    <option value="30">30 por página</option>
                                    <option value="0">Todos</option>
                                </select>
                            </span>