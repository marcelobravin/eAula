<%-- 
    Document   : cadastroUsuario
    Created on : 30/10/2011, 01:11:02
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <title>Cadastro</title>
    <%@ include file="frames/imports.jsp"%>
    <script src="arquivos/jquery_002.js"></script>
    <script type="text/javascript" src="arquivos/jValidation.js"></script>
    <script type="text/javascript" src="arquivos/jSwitchDiv.js"></script>
    <script type="text/javascript" src="arquivos/jLoadXml.js"></script>
    <head>
        <%
            // CONTROLE DE ACESSO
            if ("1".equals(session.getAttribute("privilegios"))) {
                request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!<br />Sua permissão: " + session.getAttribute("privilegios"));
        %>
                <jsp:forward page="loginInvalido.jsp"></jsp:forward>
        <%
            }
        %>
            
    <script type="text/javascript">
        function enableSenha(value) {
            if (value == 0){
                document.getElementById("senha").disabled = true;
                document.getElementById("labelSenha").style.color = 'gray';
                document.getElementById("senha").value = '';
            } else {
                document.getElementById("senha").disabled = false;
                document.getElementById("labelSenha").style.color = 'black';
            }
        }




            function enableCriarDisc(value) {
                if (value == 0){
                        document.getElementById("criarDisc").disabled = true;
                        document.getElementById("criarDisc").value = '';
                        document.getElementById("labelCriarDisc").style.color = 'gray';

                        document.getElementById("criarDiscDesc").disabled = true;
                        document.getElementById("criarDiscDesc").value = '';
                        document.getElementById("labelCriarDiscDesc").style.color = 'gray';
                } else {
                        document.getElementById("criarDisc").disabled = false;
                        document.getElementById("labelCriarDisc").style.color = 'black';

                        document.getElementById("criarDiscDesc").disabled = false;
                        document.getElementById("labelCriarDiscDesc").style.color = 'black';
                }
                document.getElementById("criarDisc").innerHTML = "";
            }


            function conta(){
                // Contabiliza número de caracteres disponíveis
                document.forms[0].caracteres.value = 255-(document.forms[0].descricao.value.length);
                
                // Se número de caracteres for ultrapassado
                if (document.forms[0].caracteres.value < 0) {
                    
                    // Variável recebe  texto até o número de caracteres válidos
                    var temp = document.forms[0].descricao.value.substr(0, 255)
                    
                    // Campo tem seu valor retornado ao número de caracteres válidos
                    document.forms[0].descricao.value = temp;
                    
                    // Aplica método recursivamente
                    conta();
                } else if (document.forms[0].caracteres.value == 0) {
                    document.getElementById("descricao").style.borderColor = 'orange';
                } else {
                    document.getElementById("descricao").style.borderColor = 'gray';
                }
            }
        </script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Cadastro de Aula</h1>
       

            <div id="conteudo">
                <center>
                    
                    <form name="cadastro" action="ControleAula" method="post" class="conteiner">
                        <fieldset>
                            <legend>Dados da aula</legend>

                            <!--Campo titulo------------------------------------------->
                            <p>
                                <label class="obrigatorio">
                                    Título:
                                </label>
                                <input type="text" name="titulo" size="20" maxlength="70" onFocus="SwitchDiv(1, 'toolTip7')" onBlur="SwitchDiv(0, 'toolTip7')" />
                                
                                <span class="toolTipLocation">
                                    <div id="toolTip7" class="toolTip">
                                        Insira o título da aula
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <!--Campo descricao------------------------------------------->
                            <p>
                                <label class="obrigatorio">
                                    Descrição:
                                </label>
                                
                                <textarea id="descricao" maxlength="255" onKeyUp="conta()" onKeyDown="conta()" onFocus="SwitchDiv(1, 'toolTip8')" onBlur="SwitchDiv(0, 'toolTip8')" ></textarea>
                                <span class="toolTipLocation">
                                    <div id="toolTip8" class="toolTip">
                                        Descreva a aula utilizando até 255 caracteres
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                                <input type="text" name="caracteres" value="255" size="1" disabled="disabled">
                            </p>

                            <!--Campo area------------------------------------------->
                            <p>
                                <label class="obrigatorio">
                                    Área:
                                </label>
                                <select name="area" size="1" onChange="loadDiv('FiltroOpcoes?area='+this.value, 'selectMateria')">
                                    <option value="">Selecione...</option>
                                    <option value="1" onMouseOver="SwitchDiv(1, 'toolTip1');" onMouseOut="SwitchDiv(0, 'toolTip1')">Ciências exatas</option>
                                    <option value="2" onMouseOver="SwitchDiv(1, 'toolTip2');" onMouseOut="SwitchDiv(0, 'toolTip2')">Ciências biológicas</option>
                                    <option value="3" onMouseOver="SwitchDiv(1, 'toolTip3');" onMouseOut="SwitchDiv(0, 'toolTip3')">Ciências humanas</option>
                                </select>
                                <span class="toolTipLocation">
                                    <div id="toolTip1" class="toolTip">
                                        Descrição ciências exatas
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>

                                    <div id="toolTip2" class="toolTip">
                                        Descrição ciências humanas
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>

                                    <div id="toolTip3" class="toolTip">
                                        Descrição ciências biomédicas
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>
                            
                            


                            <!--Campo materia------------------------------------------->
                            
                            <p>
                                <div id="selectMateria">
                                    <span id="labelMateria" class="gray">
                                        <label class="obrigatorio">                                        
                                            Matéria:
                                        </label>
                                    </span>
                                    
                                    <select name="materia" id="materia" disabled="disabled" onChange="loadDiv('FiltroOpcoes?materia='+this.value, 'selectDisciplina')">
                                    </select>                    
                                </div>
                            </p>
                            
                            
                           

                            <!--Campo disciplina------------------------------------------->
                            <p>
                                <div id="selectDisciplina">
                                    <span id="labelDisciplina" class="gray">
                                        <label class="obrigatorio">
                                            Disciplina:
                                        </label>
                                    </span>
                                    
                                    <select id="disciplina" disabled="disabled">
                                    </select>                    
                                </div>
                            </p>
                            

                            <!--Campo criar disciplina------------------------------------------->
                            <p>
                                <span id="labelCriarDisc" class="gray">
                                    <label class="obrigatorio">
                                        Criar nova disciplina:
                                    </label>
                                </span>
                                
                                <input type="text" name="criarDisc" id="criarDisc" size="20" maxlength="20" disabled="disabled" />
                            </p>


                            <!--Campo descricao------------------------------------------->
                            <p>

                                <span id="labelCriarDiscDesc" class="gray">
                                    <label class="obrigatorio">
                                        Descrição:
                                    </label>
                                </span>
                                
                                
                                <textarea name="criarDiscDesc" id="criarDiscDesc" disabled="disabled"></textarea>
                            </p>


                            <!--Campo tipoAula------------------------------------------->
                            <p>
                                <label class="obrigatorio">
                                    Tipo de aula:
                                </label>
                                
                                <span onMouseOver="SwitchDiv(1, 'toolTip12');" onMouseOut="SwitchDiv(0, 'toolTip12')">
                                    <label>
                                        <input type="radio" name="restrita" value="false" id="false" onClick="enableSenha(0)" checked="checked" />
                                        Pública
                                    </label>
                                    
                                    <label>
                                        <input type="radio" name="restrita" value="true" id="true" onClick="enableSenha(1)" />
                                        Restrita
                                    </label>
                                </span>
                                <span class="toolTipLocation">
                                    <div id="toolTip12" class="toolTip">
                                        Define se a aula solicitará senha ou não para ser utilizada
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <!--Campo senha------------------------------------------->
                            <p>                                
                                <span id="labelSenha" class="gray">
                                    <label>
                                        Senha:
                                    </label>
                                </span>
                                
                                
                                <input id="senha" type="text" name="senha" size="20" maxlength="20" disabled="disabled" onFocus="SwitchDiv(1, 'toolTip10')" onBlur="SwitchDiv(0, 'toolTip10')" />
                                <span class="toolTipLocation">
                                    <div id="toolTip10" class="toolTip">
                                        Insira a senha necessária para que a aula seja utilizada
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>
                        </fieldset>


                        <input type="submit" name="inserir" value="Criar aula" />
                        <input type="reset" value="Limpar" onClick="loadDiv('FiltroOpcoes?area=', 'selectMateria')" />
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>