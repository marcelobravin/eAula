<%-- 
    Document   : header
    Created on : 29/10/2011, 23:59:22
    Author     : Mark
--%>
            <%@page import="Dominio.Usuario"%>
            <div>
                <span id="logo">eAula</span>
                <div id="painelLogin">
                    <p class="floatRight">
                        <img src="arquivos/imagens/bandeira_pt.gif" />
                        <img src="arquivos/imagens/bandeira_en.gif" />
                        <img src="arquivos/imagens/bandeira_es.gif" />
                        <img src="arquivos/imagens/bandeira_de.gif" />
                        <img src="arquivos/imagens/bandeira_jp.gif" />
                    </p>
                    <%
                        String box = "";
                        String box2 = "";
                        //String acesso = "";
                        Usuario usr = (Usuario) request.getSession().getAttribute("user");
                        //request.getSession().setAttribute("user", usr);

                        // Se a sess�o estiver vazia apresenta op��o de login
                        if (usr == null) {
                            
                            box += "<form id='login' action='Login?acao=login' method='post'>";
                            box += "<span class='branco'>Nome</span>";
                            box += "<input type='text' name='login' maxlength='70' />";
                            box += "<span class='branco'>Senha</span>";
                            box += "<input type='text' name='senha' maxlength='70' />";
                            box += "<input type='submit' name='adentrar' value='Entrar' />";
                            box += "<a accesskey='s' href='esqueciSenha.jsp' title='Clique aqui se voc� esqueceu seu login ou senha'>Esqueci a <u>s</u>enha</a>";
                            box += "</form>";
                            box2 += "<a accesskey='p' href='cadastroUsuario.jsp' title='Clique aqui para criar seu perfil de usu�rio'>Cadastrar <u>p</u>erfil</a>";
                        }
                        // Se a sess�o estiver aberta apresenta tipo de usu�rio e op��o de logout
                        else {

                            //pega o nome de usu�rio que est� registrado na sess�o
                            String opcoesEstudante = "";
                            String opcoesProfessor = "";
                            String opcoesAdministrador = "";

                            //opcoesEstudante += "<a accesskey='i' href='#' title='Clique aqui para ver as aulas que voc� j� iniciou'>Aulas <u>i</u>niciadas</a>";
                            //opcoesEstudante += "<a accesskey='m' href='#' title='Clique aqui para ver suas mensagens'>Mensagens</a>";
                            //opcoesEstudante += ";

                            opcoesProfessor += "<a accesskey='c' href='cadastroAula.jsp' title='Clique aqui para criar uma nova aula'><u>C</u>riar aula</a>";
                            opcoesProfessor += "<a accesskey='e' href='minhasAulas.jsp' title='Clique aqui para editar aulas criadas por voc�'><u>E</u>ditar aulas</a>";

                            opcoesAdministrador += "<a accesskey='l' href='ControleUsuario?listar' title='Clique aqui para gerenciar usu�rios do sistema'><u>L</u>istar usu�rios</a>";
                            opcoesAdministrador += "<a accesskey='d' href='ControleDisc?listar' title='Clique aqui para gerenciar disciplinas das aulas'>Editar <u>d</u>isciplinas</a>";

                            

                            box += "<div id='login' class='branco'>";
                            //Estabelece op��es conforme permiss�es de acesso
                            
                            
                            switch(usr.getPrivilegios()) {
                                case 1:
                                    box2 += opcoesEstudante;
                                break;
                                
                                case 2:
                                    box2 += opcoesEstudante;
                                    box2 += opcoesProfessor;
                                break;
                                
                                case 3:
                                    box2 += opcoesEstudante;
                                    box2 += opcoesProfessor;
                                    box2 += opcoesAdministrador;
                                break;
                            }
                            
                      
                            
                            box += "<a href='ControleUsuario?meLocalizarPorID' title='Clique aqui para editar seu perfil de usu�rio'>";
                            box += usr.getNome();
                            box += "</a>";
                            
                            
                            box += " <a href='ControleMensagem?listar' title='Clique aqui para ver suas mensagens' id='mensagem'></a>";
                            
                            //box += " Id:";
                            //box += usr.getId();
                            box += "<input type='hidden' value='"+ usr.getId() +"' id='userId'>";
                            /*
                            box += " Privilegios:";
                            box += usr.getPrivilegios();
                            */


                            

                            // log out
                            box += "<a accesskey='s' href='Login?acao=logout' title='Clique aqui para sair do sistema'><input type='reset' name='sair' value='Sair' /></a>";
                            box += "</div>";
                            
                        }
                    %>
                    <%= box %>
                </div>


                <div class="menu">
                    <a accesskey="h" href="home.jsp" title="Clique aqui para retornar � p�gina inicial"><u>H</u>ome</a>
                    <a accesskey="a" href="ControleAula?listar" title="Clique aqui para procurar aulas">Pesquisar <u>a</u>ulas</a>
                    <!-- Exibe op��es conforme permiss�es de acesso-->
                    <%= box2 %>
                </div>
            </div>