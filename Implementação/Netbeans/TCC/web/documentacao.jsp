<%-- 
    Document   : documentacao
    Created on : 06/12/2011, 13:31:40
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Documento de Casos de Uso</title>
        <%@ include file="frames/imports.jsp"%>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Documento de Casos de Uso</h1>

            <div id="conteudo">
                
                <h2>Indice</h2>
                <ol>
                    <li><a href="#Introducao">Introdução</a></li>
                    <li><a href="#Ordem_de_Prioridade">Ordem de Prioridade</a></li>
                    <li>
                        <ol>
                            <li><a href="#Caso_de_Uso_1">Caso de Uso 1: Consultar Informações sobre Usuário</a></li>
                            <li><a href="#Caso_de_Uso_2">Caso de Uso 2: Cadastrar Informações sobre Usuário</a></li>
                            <li><a href="#Caso_de_Uso_3">Caso de Uso 3: Visualizar detalhes sobre Usuário</a></li>
                            <li><a href="#Caso_de_Uso_4">Caso de Uso 4: Edição de cadastro de Usuário</a></li>
                            <li><a href="#Caso_de_Uso_5">Caso de Uso 5: Exclusão de cadastro de Usuário</a></li>
                        </ol>
                    </li>
                </ol>



                <hr />
                <h1><a name="Introdução"></a>Introdução<a href="#Introdu%C3%A7%C3%A3o" class="section_anchor"></a></h1>
                <p>Esse documento descreve os casos de uso do sistema em detalhes. Permitindo um melhor entendimento do sistema aos envolvidos.</p>

                <hr />
                <h1><a name="Ordem_de_Prioridade"></a>Ordem de Prioridade<a href="#Ordem_de_Prioridade" class="section_anchor"></a></h1>
                <p>
                <ol>
                    <li>Consultar e cadastrar informações sobre Usuário</li>
                    <li>Consultar e cadastrar informações sobre Aluno</li>
                    <li>Visualizar as matérias por série/ano</li>
                    <li>Cadastrar turmas</li>
                    <li>Montar grade do curso</li>
                    <li>Realizar matriculas online</li>
                    <li>Permite realizar ocorências de alunos</li>
                    <li>Cadastrar requerimentos que poderão ser solicitados pelos pais e alunos.</li>
                </ol>
                </p>


                <hr />
                <h2><a name="Caso_de_Uso_1:_Consultar_Informações_sobre_Usuário"></a>Caso de Uso 1: Consultar Informações sobre Usuário<a href="#Caso_de_Uso_1:_Consultar_Informa%C3%A7%C3%B5es_sobre_Funcion%C3%A1rio" class="section_anchor"></a></h2>
                <h3><a name="1.1._Descrição"></a>1.1. Descrição<a href="#1.1._Descri%C3%A7%C3%A3o" class="section_anchor"></a></h3>
                <p>Descreve como um administrador pode consultar dados previamente inseridos sobre os Usuários da escola. </p>
                <h3><a name="1.2._Atores_Envolvidos"></a>1.2. Atores Envolvidos<a href="#1.2._Atores_Envolvidos" class="section_anchor"></a></h3>
                <ul><li>1.2.1 Administrador (Usuário da Escola a quem foi concedido acesso) </li></ul>
                <h3><a name="1.3._Pré-Condições"></a>1.3. Pré-Condições<a href="#1.3._Pr%C3%A9-Condi%C3%A7%C3%B5es" class="section_anchor"></a></h3>
                <ul><li>1.3.1. O sistema deve supor que não ocorrerão erros de conexão; </li>
                    <li>1.3.2. O sistema deve supor que não ocorrerão erros de conexão com o banco de dados. </li>
                    <li>1.3.3. Administrador já deve estar cadastrado no sistema e logado.  </li></ul>
                <h3><a name="1.4._Fluxo_Básico_de_Eventos"></a>1.4. Fluxo Básico de Eventos<a href="#1.4._Fluxo_B%C3%A1sico_de_Eventos" class="section_anchor"></a></h3>
                <ul><li>1.4.1. Administrador acessa área destinada a visualização dos dados. </li>
                    <li>1.4.2. Executa-se o caso de uso, listar Usuários cadastrados.</li>
                    <li>1.4.3. Para cada Usuário cadastrado exibem-se uns poucos dados e um link para o detalhamento. </li>
                    <li>1.4.4. Exibe-se um link para edição de dados daquele Usuário.</li>
                    <li>1.4.5. Exibe-se também um link para remoção daquele registro.</li>
                </ul>
                <h3><a name="1.5._Fluxos_Alternativos"></a>1.5. Fluxos Alternativos<a href="#1.5._Fluxos_Alternativos" class="section_anchor"></a></h3><ul><li>1.5.1.
                Caso não haja nenhum Usuário cadastrado, o sistema exibe uma mensagem dizendo que ainda não há nenhum dado cadastrado. </li>
                </ul>
                <h3><a name="1.6._Pós-Condições"></a>1.6. Pós-Condições<a href="#1.6._P%C3%B3s-Condi%C3%A7%C3%B5es" class="section_anchor"></a></h3>
                <ul><li>1.6.1. Conclusão bem-sucedida: Retorna uma página web contendo a lista de Usuários cadastrados no sistema. </li>
                </ul>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>