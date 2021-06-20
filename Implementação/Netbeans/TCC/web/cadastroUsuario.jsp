<%-- 
    Document   : cadastroUsuario
    Created on : 30/10/2011, 01:11:02
    Author     : Mark
--%>

<%@page import="Dominio.Cidade"%>
<%@page import="Dominio.Estado"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Persistencia.DAOFrames"%>
<%@page import="Dominio.Logradouro"%>
<%@page import="Dominio.Usuario"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Cadastro de Usuário</title>
        <%@ include file="frames/imports.jsp"%>
        <script src="arquivos/jquery_002.js"></script>
	<script type="text/javascript" src="arquivos/jValidation.js"></script>
        <script type="text/javascript" src="arquivos/jSwitchDiv.js"></script>
        <script type="text/javascript" src="arquivos/jLoadXml.js"></script>
        <%
            // CONTROLE DE ACESSO
            Usuario usr2 = (Usuario) request.getSession().getAttribute("user");
            if (usr2 != null) {
                request.setAttribute("mensagem", "Você não tem permissão para acessar essa página!");
        %>
                <jsp:forward page="loginInvalido.jsp"></jsp:forward>
        <%
            }
        %>
        
    </head>
    <%                                   
        // Instancia DAO e solicita lista de estados
        DAOFrames dao = new DAOFrames();
        ArrayList<Estado> lista = dao.listarEstados();
        ArrayList<Logradouro> listaLogradouro = dao.listarLogradouros();
        dao.fecharConexao();
    %>
     
    <%
        dao = new DAOFrames();
        //ArrayList<Cidade> listaCidades = dao.listar(usuario.getEnd().getUf());       
    %>
    <body>
         <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Cadastro de Usuário</h1>

            <div id="conteudo">
                
                <center>
                    <form name="cadastro" action="ControleUsuario" method="post" class="conteiner">
                        <i>Campos com asterisco (*) são de preenchimento obrigatório.</i>
                        
                        
                        <fieldset>
                            <legend>Informações básicas</legend>
                            <p>
                                <label class="obrigatorio">
                                    Nome:
                                </label>
                                <input type="text" name="nome" size="40" maxlength="70" onKeyUp="validaNome()" onFocus="SwitchDiv(1, 'toolTip1')" onBlur="SwitchDiv(0, 'toolTip1')" />
                                <span class="toolTipLocation">
                                    <div id="toolTip1" class="toolTip">
                                        Insira o nome completo sem abreviações
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    Sexo:
                                </label>
                                <label><input type="radio" name="sexo" value="masculino" onClick="validaSexo()" />Masculino</label>
                                <label><input type="radio" name="sexo" value="feminino" onClick="validaSexo()" />Feminino</label>
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    CPF:
                                </label>
                                <input type="text" id="cpf" name="cpf" maxlength="11" onKeyup="validaCpf()" onFocus="SwitchDiv(1, 'toolTip2')" onBlur="SwitchDiv(0, 'toolTip2')" />
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
                                <input type="text" name="dc" value="" size="10" maxlength="10" onKeyUp="validaNasc()" onFocus="SwitchDiv(1, 'toolTip3')" onBlur="SwitchDiv(0, 'toolTip3')" /><a title="Clique aqui para selecionar a data" href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.cadastro.dc);return false;" HIDEFOCUS><img class="iluminar" name="popcal" align="absmiddle" src="arquivos/WeekPicker/calbtn.gif" width="34" height="22" alt="calendario"></a>
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
                                <input type="text" name="profissao" />
                            </p>

                            <p>
                                <label class="obrigatorio">
                                    Escolaridade:
                                </label>
                                <select name="escolaridade">                                    
                                    <option value="1">Ensino básico</option>
                                    <option value="2">Ensino médio</option>
                                    <option value="3">Bacharel</option>
                                    <option value="4">Mestre</option>
                                    <option value="5">Doutor</option>
                                </select>
                            </p>                
                            
                            

                            <p>
                                <label class="obrigatorio">
                                    Email:
                                </label>
                                <input type="text" name="email" size="20" maxlength="50" onKeyUp="validaEmail()" onFocus="SwitchDiv(1, 'toolTip4')" onBlur="SwitchDiv(0, 'toolTip4')" />
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
                                <input type="password" name="senha" onKeyUp="validaSenha()" onFocus="SwitchDiv(1, 'toolTip6')" onBlur="SwitchDiv(0, 'toolTip6')" />
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
                                    <option value="0">Selecione...</option>
                                    <%  
                                        // Itera pelos estados
                                        for (Estado estado : lista) {
                                            // Define valor do estado como o 'uf' recebido do BD
                                            out.print("<option value='" + estado.getId() + "'");
                                            
                                           
                                            
                                            // Imprime valor do estado e finaliza opção
                                            out.print(">"+estado.getNome() + "</option>\n");
                                        }
                                    %>
                                </select>
                            </p>



                             <p>
                                <div name="conteudo2" id="conteudo2">
                                    <label class="obrigatorio">
                                        <span id="labelCidade" class="gray">Cidade:</span>
                                    </label>
                                    <select name="campoCidade" id="campoCidade" disabled="disabled">
                                    </select>
                                </div>
                            </p>









                            <p>
                                <label class="obrigatorio">
                                    CEP:
                                </label>
                                <input id="cep" name="cep" type="text" size="8" maxlength="8" class="inputs" onKeyUp="getEndereco()">
                            </p>
                            
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
                                            
                                            
                                            
                                            // Imprime valor do estado e finaliza opção
                                            out.print(">"+logradouro.getNome() + "</option>\n");
                                        }
                                    %>
                                </select>
                            </p>
                            
                            <p>
                                <label class="obrigatorio">
                                    Logradouro:
                                </label>
                                <input id="logradouro" name="logradouro" type="text" />
                            </p>
                            
                            <p>
                                <label class="obrigatorio">
                                    Número:
                                </label>
                                <input id="numero" name="numero" type="text" />
                            </p>
                            <p>
                                <label class="obrigatorio">
                                    Bairro:
                                </label>
                                <input id="bairro" name="bairro" type="text" />
                            </p>
                        </fieldset>

                        
                        <fieldset>
                            <legend>Informações adicionais</legend>
                            <p>
                                <label class="obrigatorio">
                                    Tipo de usuário:
                                </label>
                                <span onMouseOver="SwitchDiv(1, 'toolTip8')" onMouseOut="SwitchDiv(0, 'toolTip8')">
                                    
                                    <label>
                                        <input type="radio" name="tipoUsuario" value="1" checked="checked" />
                                        Estudante
                                    </label>
                                    
                                    <label>
                                        <input type="radio" name="tipoUsuario" value="2" />
                                        Professor
                                    </label>
                                </span>
                                <span class="toolTipLocation">
                                    <div id="toolTip8" class="toolTip">
                                        Selecione professor se quiser criar aulas
                                        <span class="hint-pointer">&nbsp;</span>
                                    </div>
                                </span>
                            </p>





                            <label class="obrigatorio">
                                Captcha:
                            </label>
                            <p><img src="kaptcha.jpg" /></p>
                            <input type="text" name="kaptcha" onKeyUp="validaKaptcha()" onFocus="SwitchDiv(1, 'toolTip9')" onBlur="SwitchDiv(0, 'toolTip9')" />
                            <span class="toolTipLocation">
                                <div id="toolTip9" class="toolTip">
                                    Digite os caracteres da imagem acima
                                    <span class="hint-pointer">&nbsp;</span>
                                </div>
                            </span>
                            
                            <p>
                                <input type="checkbox" checked="checked">Li e aceitei os <a href="termos.jsp" target="blank">termos de uso</a>
                            </p>
                        </fieldset>

                        <input type="submit" name="inserir" value="Cadastrar" />
                        <input type="reset" value="Limpar" onClick="loadDiv('FiltroOpcoes?uf=', 'conteudo2')" />
                    </form>

                    <noscript><div class="error errorBox"><strong>ERROR:</strong> JavaScript is not enabled.  You must enable JavaScript to use the application.</div></noscript>
                    <!--  PopCalendar(tag name and id must match) Tags should sit at the page bottom -->
                    <iframe width="199" height="178" name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="arquivos/WeekPicker/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; top:-500px; left:-500px;">
                    </iframe>
                </center>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>