<%-- 
    Document   : atualizar
    Created on : 30/10/2011, 01:13:06
    Author     : Mark
--%>

<%@page import="Dominio.Logradouro"%>
<%@page import="Dominio.Cidade"%>
<%@page import="Dominio.Estado"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Persistencia.DAOFrames"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@page import="Dominio.Usuario"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Atualizar cadastro</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/validaForm.js"></script>
        <script type="text/javascript" src="arquivos/jSwitchDiv.js"></script>
        <script type="text/javascript" src="arquivos/jLoadXml.js"></script>
        <%
            // CONTROLE DE ACESSO
            Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
            if (usr2 == null) {
                request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
        %>
                <jsp:forward page="loginInvalido.jsp"></jsp:forward>
        <%
            }
        %>
        
        
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript">
            function getEndereco() {
                // Se o campo CEP não estiver vazio
                if($.trim($("#cep").val()) != ""){
                    /*
Para conectar no serviço e executar o json, precisamos usar a função
getScript do jQuery, o getScript e o dataType:"jsonp" conseguem fazer o cross-domain, os outros
dataTypes não possibilitam esta interação entre domínios diferentes
Estou chamando a url do serviço passando o parâmetro "formato=javascript" e o CEP digitado no formulário
http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cep").val()
                     */
                    $.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cep").val(), function(){
                        // o getScript dá um eval no script, então Ã© sÃ³ ler!
                        //Se o resultado for igual a 1
					
                        if (resultadoCEP["tipo_logradouro"] != '') {
                            if (resultadoCEP["resultado"]) {
                                // troca o valor dos elementos
                                $("#rua").val(unescape(resultadoCEP["tipo_logradouro"]) + " " + unescape(resultadoCEP["logradouro"]));
                                $("#bairro").val(unescape(resultadoCEP["bairro"]));
                                $("#cidade").val(unescape(resultadoCEP["cidade"]));
                                $("#estado").val(unescape(resultadoCEP["uf"]));
                                $("#numero").focus();
                                document.cadastro.cep.style.borderColor = "lime";
                            }
                        }	
                    });
                }
            }
        </script>
    </head>
    
    <% Usuario usuario = (Usuario) request.getAttribute("usuario");%>
    <%                                   
        // Instancia DAO e solicita lista de estados
        DAOFrames dao = new DAOFrames();
        ArrayList<Estado> lista = dao.listarEstados();
        ArrayList<Logradouro> listaLogradouro = dao.listarLogradouros();
        dao.fecharConexao();
    %>
     
    <%
        dao = new DAOFrames();
        ArrayList<Cidade> listaCidades = dao.listar(usuario.getEnd().getIdUf());       
    %>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Atualizar cadastro de Usuário</h1>
           
            <div id="conteudo">
                <center>                    
                    adicionar opções caso privilégio seja de administrador

                    <form name="cadastro" action="ControleUsuario" method="post" class="conteiner" onSubmit="return validaForm()">
                        <i>Campos com asterisco (*) são de preenchimento obrigatório.</i>
                        <fieldset>
                            <legend>Informações básicas</legend>
                            <p>
                                <label class="obrigatorio">
                                    Nome:
                                </label>
                                <input type="text" name="nome" value="<%=usuario.getNome()%>" /><br />
                                <input type="hidden" name="id" id="id" value="<%=usuario.getId()%>" />
                                <span class="toolTipLocation">
                                    <div id="toolTip1" class="toolTip">
                                        Instrucao sobre como preencher o campo selecionado
                                    </div>
                                </span>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    Sexo:
                                </label>
                                
                                <%
                                    //marca como selecionado campo sexo conforme atributo do usuário
                                    String sexoValor = "";
                                    String sexoValor2 = "";
                                    if(usuario.getSexo()){
                                        sexoValor = "checked='checked'";
                                        sexoValor2 = "";
                                    } else {
                                        sexoValor = "";
                                        sexoValor2 = "checked='checked'";
                                    }
                                %>
                                
                                <label>
                                    <input type="radio" name="sexo" value="masculino" id="sexo" <%=sexoValor%> />
                                    Masculino
                                </label>
                                <label>
                                    <input type="radio" name="sexo" value="feminino" id="sexo" <%=sexoValor2%> />
                                    Feminino
                                </label>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    CPF:
                                </label>
                                
                                <input type="text" id="cpf" name="cpf" maxlength="11" onKeyup="validaCpf()" onFocus="SwitchDiv(1, 'toolTip2')" onBlur="SwitchDiv(0, 'toolTip2')" value="<%=usuario.getCpf()%>" />
                                <span class="toolTipLocation">
                                    <div id="toolTip2" class="toolTip">
                                        Insira o número completo de seu CPF (11 dígitos) sem hífen
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    Data de nascimento:
                                </label>
                                
                                <input type="text" name="dc" value="<%=usuario.getDataNascimento()%>" size="10" maxlength="10" onKeyUp="validaNasc()" onFocus="SwitchDiv(1, 'toolTip3')" onBlur="SwitchDiv(0, 'toolTip3')" /><a title="Clique aqui para selecionar a data" href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.cadastro.dc);return false;" HIDEFOCUS><img class="iluminar" name="popcal" align="absmiddle" src="arquivos/WeekPicker/calbtn.gif" width="34" height="22" alt="calendario"></a>
                                <span class="toolTipLocation">
                                    <div id="toolTip3" class="toolTip">
                                        Insira sua data de nascimento no formato dd/mm/aaaa
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    Profissão:
                                </label>
                                
                                <input type="text" name="profissao" value="<%=usuario.getProfissao()%>" />
                            </p>


                        
                            <p>
                                <label class="obrigatorio vermelho">
                                    Escolaridade:(arrumar)
                                </label>
                                <select name="escolaridade">
                                    <%
                                        String escolaridade1 = "";
                                        String escolaridade2 = "";
                                        String escolaridade3 = "";
                                        String escolaridade4 = "";
                                        String escolaridade5 = "";
                                        
                                        /*
                                        if (usuario.getEscolaridade().equals("1") || usuario.getEscolaridade().equals("")) {
                                            escolaridade1 = " selected='selected'";
                                        } else if (usuario.getEscolaridade().equals("2")) {
                                            escolaridade2 = " selected='selected'";
                                        } else if (usuario.getEscolaridade().equals("3")) {
                                            escolaridade3 = " selected='selected'";
                                        } else if (usuario.getEscolaridade().equals("4")) {
                                            escolaridade4 = " selected='selected'";
                                        } else if (usuario.getEscolaridade().equals("5")) {
                                            escolaridade5 = " selected='selected'";
                                        } else {
                                            
                                        }
 * */
                                    %>
                                    
                                    <option value="1"<%= escolaridade1%>>Ensino básico</option>
                                    <option value="2"<%= escolaridade2%>>Ensino médio</option>
                                    <option value="3"<%= escolaridade3%>>Bacharel</option>
                                    <option value="4"<%= escolaridade4%>>Mestre</option>
                                    <option value="5"<%= escolaridade5%>>Doutor</option>
                                </select>
                            </p>
                        
                        

                            <p>
                                <label class="obrigatorio">
                                    Email:
                                </label>
                                <input type="text" name="email" size="20" maxlength="50" onKeyUp="validaEmail()" onFocus="SwitchDiv(1, 'toolTip4')" onBlur="SwitchDiv(0, 'toolTip4')" value="<%=usuario.getEmail()%>"/>
                                <span class="toolTipLocation">
                                    <div id="toolTip4" class="toolTip">
                                        Insira um endereço eletrônico no formato: xxx@xxx.xxx
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    Confirme email:
                                </label>
                                <input type="text" name="emailConfirm" size="20" maxlength="50" onKeyUp="validaEmail()" onFocus="SwitchDiv(1, 'toolTip5')" onBlur="SwitchDiv(0, 'toolTip5')" />
                                <span class="toolTipLocation">
                                    <div id="toolTip5" class="toolTip">
                                        Confirme seu endereço de email
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    Senha:
                                </label>
                                <input type="password" name="senha" onKeyUp="validaSenha()" onFocus="SwitchDiv(1, 'toolTip6')" onBlur="SwitchDiv(0, 'toolTip6')" value="<%=usuario.getSenha()%>" />
                                <span class="toolTipLocation">
                                    <div id="toolTip6" class="toolTip">
                                        Pelo menos 6 caracteres contendo números e/ou letras
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    Confirme senha:
                                </label>
                                <input type="password" name="senhaConfirm" onKeyUp="validaSenha()" onFocus="SwitchDiv(1, 'toolTip7')" onBlur="SwitchDiv(0, 'toolTip7')" />
                                <span class="toolTipLocation">
                                    <div id="toolTip7" class="toolTip">
                                        Confirme sua senha
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>
                        </fieldset>



                        <fieldset>
                            <legend>Endereço</legend>
                            <p>
                                
                                <label class="obrigatorio">
                                    Estado:
                                </label>
                             
                                <select name="uf" size="1" onChange="loadDiv('FiltroOpcoes?uf='+this.value, 'conteudo2')">
                                    <option value="">Selecione...</option>
                                    <%  
                                        // Itera pelos estados
                                        for (Estado estado : lista) {
                                            // Define valor do estado como o 'uf' recebido do BD
                                            out.print("<option value='" + estado.getId() + "'");
                                            
                                            // Marca estado do usuário como 'selecionado'
                                            if (usuario.getEnd().getIdUf() == estado.getId()) {
                                                out.print(" selected='selected'");
                                            }
                                            
                                            // Imprime valor do estado e finaliza opção
                                            out.print(">"+estado.getNome() + "</option>\n");
                                        }
                                    %>
                                </select>
                            </p>



                             <p>
                                <div name="conteudo2" id="conteudo2">
                                    <label class="obrigatorio">
                                        Cidade:
                                    </label>
                                    <select name="campoCidade" id="campoCidade">
                                        <%  
                                        // Itera pelos estados
                                        for (Cidade cidade : listaCidades) {
                                            // Define valor do estado como o 'uf' recebido do BD
                                            out.print("<option value='" + cidade.getId() + "'");
                                            
                                            // Marca estado do usuário como 'selecionado'
                                            if (usuario.getEnd().getIdCidade() == cidade.getId()) {
                                                out.print(" selected='selected'");
                                            }
                                            
                                            // Imprime valor do estado e finaliza opção
                                            out.print(">"+cidade.getNome() + "</option>\n");
                                        }
                                    %>
                                    </select>
                                    reset deve limpar seleção de cidade                        
                                </div>
                            </p>


                            <p>
                                <label class="obrigatorio">
                                    CEP:
                                </label>
                                <input type="text" id="cep" name="cep" size="8" maxlength="8" value="<%=usuario.getEnd().getCep()%>" class="inputs" onKeyUp="getEndereco()">[pelo endereco preencher cep]</p>
                            <p>
                                
                                <label class="obrigatorio">
                                    Tipo de logradouro:
                                </label>
                                <select name="tipoLogradouro">
                                    <option value="">Selecione...</option>
                                    <%  
                                        // Itera pelos estados
                                        for (Logradouro logradouro : listaLogradouro) {
                                            // Define valor do estado como o 'uf' recebido do BD
                                            out.print("<option value='" + logradouro.getId() + "'");
                                            
                                            // Marca estado do usuário como 'selecionado'
                                            if (usuario.getEnd().getIdTipoLogradouro() == logradouro.getId()) {
                                                out.print(" selected='selected'");
                                            }
                                            
                                            // Imprime valor do estado e finaliza opção
                                            out.print(">"+logradouro.getNome() + "</option>\n");
                                        }
                                    %>
                                </select>
                            </p>
                            
                            <p>
                                <label class="obrigatorio">
                                    Logradouro:
                                </label> <input type="text" id="logradouro" name="logradouro" value="<%=usuario.getEnd().getLogradouro()%>" /></p>

                            <p>
                                <label class="obrigatorio">
                                    Número:
                                </label>
                                <input type="text" id="numero" name="numero" value="<%=usuario.getEnd().getNumero()%>" /></p>
                            <p>
                                <label class="obrigatorio">
                                    Bairro:
                                </label>
                                <input type="text" id="bairro" value="nada" /></p>
                        </fieldset>
                        
                        
                        <fieldset>
                            <legend>Informações adicionais</legend>
                            <p>
                                
                                <label class="obrigatorio">
                                    Tipo de usuário:
                                </label>
                                <%
                                    //marca como selecionado campo sexo conforme atributo do usuário
                                    String tipo0 = "";
                                    String tipo1 = "";
                                    String tipo2 = "";
                                    if(usuario.getPrivilegios() == 1){
                                        tipo0 = "checked='checked'";
                                    } else if(usuario.getPrivilegios() == 2){
                                        tipo1 = "checked='checked'";
                                    } else {
                                        tipo2 = "checked='checked'";
                                    }
                                %>

                                <span onMouseOver="SwitchDiv(1, 'toolTip8')" onMouseOut="SwitchDiv(0, 'toolTip8')">
                                    <label>
                                        <input type="radio" id="tipoUsuario" name="tipoUsuario" value="1" <%=tipo0%> />
                                        Estudante
                                    </label>
                                        
                                    <label>
                                        <input type="radio" id="tipoUsuario" name="tipoUsuario" value="2" <%=tipo1%> />
                                        Professor
                                    </label>
                                        
                                    <label>
                                        <input type="radio" id="tipoUsuario" name="tipoUsuario" value="3" <%=tipo2%> />
                                        Administrador
                                    </label>
                                    
                                    
                                    

                                </span>
                                <span class="toolTipLocation">
                                    <div id="toolTip8" class="toolTip">
                                        Selecione professor se quiser criar aulas
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>





                            <img src="kaptcha.jpg" /><br />
                            <input type="text" name="kaptcha" onKeyUp="validaKaptcha()" onFocus="SwitchDiv(1, 'toolTip9')" onBlur="SwitchDiv(0, 'toolTip9')" />

                            <span class="toolTipLocation">
                                <div id="toolTip9" class="toolTip">
                                    Digite os caracteres da imagem acima
                                    <span class="hint-pointer">&nbsp;</span>
                                </div>
                            </span>
                        
                        </fieldset>
                        <input type="submit" name="atualizar" value="Atualizar" />
                        <input type="reset" value="Resetar" onClick="loadDiv('FiltroOpcoes?uf=<%=usuario.getEnd().getIdUf()%>', 'conteudo2')" />
                    </form>


                    <noscript><div class="error errorBox"><strong>ERROR:</strong> JavaScript is not enabled.  You must enable JavaScript to use the application.</div></noscript>
                    <!--  PopCalendar(tag name and id must match) Tags should sit at the page bottom -->
                    <iframe width="199" height="178" name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="arquivos/WeekPicker/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; top:-500px; left:-500px;">
                    </iframe>
                </center>
                
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>