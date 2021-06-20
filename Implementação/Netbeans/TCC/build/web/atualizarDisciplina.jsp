<%-- 
    Document   : atualizarDisciplina
    Created on : 15/12/2011, 04:33:01
    Author     : Mark
--%>

<%@page import="Dominio.Disciplina"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <title>Atualizar disciplina</title>
    <%@ include file="frames/imports.jsp"%>    
    <script src="arquivos/jquery_002.js"></script>
    <script type="text/javascript" src="arquivos/jValidation.js"></script>
    
    <% Disciplina disciplina = (Disciplina) request.getAttribute("disciplina");%>
    <head>
            <title>Atualizar Disciplina</title>
            <%
                // CONTROLE DE ACESSO
                Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
                if (usr2 != null) {
                    if (usr2.getPrivilegios() <= 2) {
                    request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!<br />Sua permissão: " + usr2.getPrivilegios());
            %>
                <jsp:forward page="loginInvalido.jsp"></jsp:forward>
            <%
                    }
                } else{
                    request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
                    %>
                        <jsp:forward page="loginInvalido.jsp"></jsp:forward>
                    <%
                }
            %>
        
        
        <script type="text/javascript">
            function conta(){
                document.forms[0].caracteres.value = 255-(document.forms[0].descricao.value.length);
            }
        </script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Atualização de Disciplina</h1>
       

            <div id="conteudo">
                <center>
                    
                    <form name="cadastro" action="ControleDisc" method="post" class="conteiner">
                        <h2>
                            <%= disciplina.getNome() %>
                        </h2>
                        <fieldset>
                            <legend>Dados da disciplina</legend>
                            <input type="hidden" name="id" id="id" value="<%=disciplina.getId()%>">
                            <p>
                                
                                <label class="obrigatorio">
                                    Título:
                                </label>
                                
                                <input type="text" name="nome" maxlength="70" value="<%=disciplina.getNome()%>" onFocus="SwitchDiv(1, 'toolTip7')" onBlur="SwitchDiv(0, 'toolTip7')" />
                                <span class="toolTipLocation">
                                    <div id="toolTip7" class="toolTip">
                                        Insira o título da disciplina
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>
                            <p>
                                <label class="obrigatorio">
                                    Descrição:
                                </label>                                
                                
                                <textarea cols="40" rows="3" name="descricao" maxlength="255" onKeyDown="conta()" onFocus="SwitchDiv(1, 'toolTip8')" onBlur="SwitchDiv(0, 'toolTip8')" ><%=disciplina.getDescricao()%></textarea>
                                <span class="toolTipLocation">
                                    <div id="toolTip8" class="toolTip">
                                        Insira o descrição da disciplina utilizando até 255 caracteres
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                                <input type="text" name="caracteres" value="255" size="3" disabled="disabled">
                            </p>
                        </fieldset>


                        <input type="submit" name="atualizar" value="Atualizar disciplina" />
                        <input type="reset" value="Limpar" onClick="resetar()" />
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>
