<%-- 
    Document   : atualizarAula
    Created on : 01/12/2011, 16:38:54
    Author     : Mark
--%>

<%@page import="Dominio.Disciplina"%>
<%@page import="Dominio.Aula" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <% Aula aula = (Aula) request.getAttribute("aula");%>
    <title>Atualizar Aula</title>
    <%@ include file="frames/imports.jsp"%>
    
    <script src="arquivos/jquery_002.js"></script>
    <script type="text/javascript" src="arquivos/jValidation.js"></script>
    <script type="text/javascript" src="arquivos/jSwitchDiv.js"></script>     
    <script type="text/javascript" src="arquivos/jLoadXml.js"></script>
    <head>
       
            <%
                // CONTROLE DE ACESSO
                Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
                if (usr2 != null) {
                    if (usr2.getPrivilegios() >= 2) {
                        if (usr2.getId() != aula.getIdAutor()) {
                            request.setAttribute("mensagem", "Você não pode editar aulas de outros usuários!<br />Você: "+usr2.getId()+"<br>Autor: "+ aula.getIdAutor());
            %>
                <jsp:forward page="loginInvalido.jsp"></jsp:forward>
            <%
                       }
                    } else {
                        request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!<br />Sua permissão: " + usr2.getPrivilegios());
                        %>
                            <jsp:forward page="loginInvalido.jsp"></jsp:forward>
                        <%
                    }
                } else {
                    request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
                    %>
                        <jsp:forward page="loginInvalido.jsp"></jsp:forward>
                    <%
                }
            %>




        <script type="text/javascript">
        function enableSenha(value) {
            if (value == 0){
                document.getElementById("campoSenha").disabled = true;
                document.getElementById("txtSenha").style.color = 'gray';
                document.getElementById("campoSenha").value = '';
            } else {
                document.getElementById("campoSenha").disabled = false;
                document.getElementById("txtSenha").style.color = 'black';
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
                    
                    // Variável recebe texto até o número de caracteres válidos
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




            num = 1;
            function adicionarCampo() {
                var reqs = "";
                if (num == 1) {
                    reqs += "<div id='questao"+num+"'>";
                    document.getElementById("RemoverTodos").disabled = false;
                    document.getElementById("RemoverUltimo").disabled = false;
                }
                reqs += "\n"
                /*
                reqs += "<select name='requisito"+num+"'>";
                reqs += "\n"
                reqs += "<option value='0'>Selecione..</option>";
                reqs += "\n"
                reqs += "<option value='1'>As mesmas opções de disciplina</option>";
                reqs += "\n"
                reqs += "</select>";
                */
               
                reqs += "<label class='obrigatorio'>Requisito "+ num +"</label>";
                reqs += "<input type='text'>";
                reqs += "\n"
                reqs += "</p>";
                reqs += "\n"
                reqs += "<p>Nível: ";
                reqs += "\n"
                reqs += "<select name='nivel"+num+"'>";
                reqs += "\n"
                reqs += "<option value='1'>Básico</option>";
                reqs += "\n"
                reqs += "<option value='2'>Médio</option>";
                reqs += "\n"
                reqs += "<option value='3'>Avançado</option>";
                reqs += "\n"
                reqs += "</select>";
                reqs += "\n"
                reqs += "</p>";
                reqs += "\n"
                reqs += "</div>";
                reqs += "\n"
                reqs += "<div id='questao"+(num+1)+"'>";
                reqs += "\n"
                reqs += "</div>";

                if (num == 1) {
                    document.getElementById("camposExtras").innerHTML += reqs;
                    num++;
                } else {
                    document.getElementById("questao"+num).innerHTML = reqs;
                    num++;
                }
            }




            function removerTodos() {
                num = 1;
                document.getElementById("camposExtras").innerHTML = "";
                document.getElementById("RemoverTodos").disabled = true;
                document.getElementById("RemoverUltimo").disabled = true;
            }



            function removerUltimo() {
                if(num >2) {
                    num--;
                    document.getElementById("questao"+num).innerHTML = "";
                } else {
                    removerTodos();
                }
            }

            // FUNÇÃO AUXILIAR CHAMADA NO BOTÃO LIMPAR
            function resetar() {
                enableSenha(0);
                enableMat(0);
                enableCriarDisc(0);
            }
        </script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Atualização de Aula</h1>
       

            <div id="conteudo">
                
                <center>
                    
                    <form name="cadastro" action="ControleAula" method="post" class="conteiner">
                        <fieldset>
                            <legend>Dados da aula</legend>
                            <input type="hidden" name="id" id="id" value="<%=aula.getId()%>">
                            
                            
                            
                            
                            <p>
                                <label class="obrigatorio">
                                    Título:
                                </label>
                                
                                <input type="text" name="titulo" maxlength="70" value="<%=aula.getTitulo()%>" onFocus="SwitchDiv(1, 'toolTip7')" onBlur="SwitchDiv(0, 'toolTip7')" />
                                <span class="toolTipLocation">
                                    <div id="toolTip7" class="toolTip">
                                        Insira o título da aula
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>
                            
                            <p>
                                <label class="obrigatorio">
                                    Descrição:
                                </label>
                                
                                <textarea id="descricao" name="descricao" maxlength="255" onKeyUp="conta()" onLoad="conta()" onKeyDown="conta()" onFocus="SwitchDiv(1, 'toolTip8')" onBlur="SwitchDiv(0, 'toolTip8')" ><%=aula.getDescricao()%></textarea>
                                <span class="toolTipLocation">
                                    <div id="toolTip8" class="toolTip">
                                        Descreva a aula utilizando até 255 caracteres
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                                <input type="text" name="caracteres" value="255" disabled="disabled">
                            </p>
                            
                            <!--Campo area------------------------------------------->
                            <p>
                                <label class="obrigatorio">
                                    Área:
                                </label>
                                
                                <select id="area" name="area" onChange="loadDiv('FiltroOpcoes?area='+this.value, 'selectMateria')">
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
                                    <label class="obrigatorio">
                                        <span id="labelMateria" class="gray">
                                            Matéria:
                                        </span>
                                    </label>
                                    
                                    <select name="materia" id="materia" disabled="disabled" onChange="loadDiv('FiltroOpcoes?materia='+this.value, 'selectDisciplina')">
                                    </select>                    
                                </div>
                            </p>
                            
                            
                           

                            <!--Campo disciplina------------------------------------------->
                            <p>
                                <div id="selectDisciplina">
                                    <label class="obrigatorio">
                                        <span id="labelDisciplina" class="gray">
                                            Disciplina:
                                        </span>
                                    </label>
                                    
                                    <select id="disciplina" disabled="disabled">
                                    </select>                    
                                </div>
                            </p>


                            <!--Campo criar disciplina------------------------------------------->
                            <p>
                                
                                <label>
                                    <span id="labelCriarDisc" class="gray">
                                        Criar nova disciplina:
                                    </span>
                                </label>
                                
                                <input type="text" name="criarDisc" id="criarDisc" maxlength="20" disabled="disabled" />
                            </p>


                            <!--Campo descricao------------------------------------------->
                            <p>
                                <label>
                                    <span id="labelCriarDiscDesc" class="gray">
                                        Descrição:
                                    </span>
                                </label>
                                
                                <textarea name="criarDiscDesc" id="criarDiscDesc" disabled="disabled"></textarea>
                            </p>


                             <!--Campo tipoAula------------------------------------------->
                            <p>
                                <label class="obrigatorio">
                                    Tipo de aula:
                                </label>
                                
                                <span onMouseOver="SwitchDiv(1, 'toolTip12');" onMouseOut="SwitchDiv(0, 'toolTip12')">
                                    <input type="radio" name="restrita" value="false" id="false" onClick="enableSenha(0)" checked="checked" />
                                    <label for="false">Pública</label>
                                    <input type="radio" name="restrita" value="true" id="true" onClick="enableSenha(1)" />
                                    <label for="true">Restrita</label>
                                </span>
                                <span class="toolTipLocation">
                                    <div id="toolTip12" class="toolTip">
                                        Define se a aula solicitará senha ou não para ser utilizada
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <p>
                                <label>
                                    <span id="txtSenha" class="gray">
                                        Senha:
                                    </span>
                                </label>
                                
                                <input id="campoSenha" type="text" name="senha" size="20" maxlength="20" disabled="disabled" onFocus="SwitchDiv(1, 'toolTip10')" onBlur="SwitchDiv(0, 'toolTip10')" />
                                <span class="toolTipLocation">
                                    <div id="toolTip10" class="toolTip">
                                        Insira a senha necessária para que a aula seja utilizada
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>
                        </fieldset>






                        <fieldset>
                            <legend>Opcionais</legend>
                            <p>
                                <label>
                                    Pré-requisitos:
                                </label>
                                <input type="button" value="Adicionar" onclick="adicionarCampo()" />
                                <input type="button" id="RemoverTodos" value="RemoverTodos" onclick="removerTodos()" disabled="disabled" />
                                <input type="button" id="RemoverUltimo" value="RemoverÚltimo" onclick="removerUltimo()" disabled="disabled" />
                            </p>
                            <span id="camposExtras"></span>
                        </fieldset>


                        <input type="submit" name="atualizar" value="Atualizar aula" />
                        <input type="reset" value="Limpar" onClick="resetar()" />
                    </form>
                </center>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>