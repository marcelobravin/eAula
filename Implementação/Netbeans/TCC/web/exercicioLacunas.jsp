<%-- 
    Document   : exercicioLacunas
    Created on : 14/12/2011, 17:38:00
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Exercício - Lacunas</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript" src="arquivos/autogrow.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){

                // inicializa conteudo
                var conteudo = "",
                    i = 1;

                $('form input[value="Adicionar"]').click(function(){
                    i++;
                    conteudo = "<li>";
                    conteudo += "<input type='text' value='Pré-texto"+i+"' name='pre_texto[]' onClick='this.select()'>";
                    conteudo += "&nbsp;";
                    conteudo += "<input type='text' value='resposta"+i+"' name='resposta[]' onClick='this.select()'>";
                    conteudo += "&nbsp;";
                    conteudo += "<input type='text' value='Pós-texto"+i+"' name='pos_texto[]' onClick='this.select()'>";
                    conteudo += "&nbsp;";
                    conteudo += "<a href='javascript:void(0)' title='Remove essa alternativa'>X</a>";
                    conteudo += "</li>";


                    // Habilita botões 'remover'
                    if (i == 2) {
                        $('input[value="Remover todos"]').removeAttr('disabled');
                        $('input[value="Remover último"]').removeAttr('disabled');
                    }

                    $(conteudo).appendTo('form ol');
                    return false;
                });



                $('form input[value="Remover todos"]').click(function () {
                    i = 1;
                    $('li').next().remove();
                    desabilitar();
                    return false;
                });


                $('form input[value="Remover último"]').click(function () {
                    if (i>=1) {
                        $("form ol li:last-child").remove();
                        i--;

                        if (i==1) {
                            desabilitar();
                        }
                    }
                    return false;
                });



                $('form a[title="Remove essa alternativa"]').live("click", function () {
                    $(this).parent().remove();
                    i--;
                    if (i==1) {
                        desabilitar();
                    }
                    return false;
                });


                // Desabilita botões 'remover'
                function desabilitar() {
                    $('input[value="Remover todos"]').attr('disabled', 'disabled');
                    $('input[value="Remover último"]').attr('disabled', 'disabled');
                }
            });
        </script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Criação de Exercício - Aula: <%=request.getParameter("aulaId")%></h1>
            
            
            <div id="conteudo">
                
                <center>
                    
                    <h2>Exercício - Lacunas</h2>
                    <form name="cadastro" action="ControleExercicio" method="post" class="conteiner" style="width:65%">
                        
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        <input type="hidden" name="provaId" id="provaId" value="<%=request.getParameter("provaId")%>" />
                        <!-- Botões do formulário -->

                        <p>
                            Ignorar caracteres maiúsculos? CHECKBOX
                            <input type="radio" id="maiusculos" name="maiusculos" checked="checked" />Sim
                            <input type="radio" id="maiusculos" name="maiusculos" />Não
                        </p>
                        
                        <p>
                            Ignorar acentos? CHECKBOX
                            <input type="radio" id="acentos" name="acentos" onClick="disableDica()" checked="checked" />Sim
                            <input type="radio" id="acentos" name="acentos" onClick="enableDica()" />Não
                        </p>




                        <input type="text" value="Preencha as lacunas" id="pergunta" name="pergunta" onClick="this.select()">
			
			<p>
                            <input type="button" value="Adicionar" />
                            <input type="button" value="Remover todos" disabled="disabled" />
                            <input type="button" value="Remover último" disabled="disabled" />
			</p>
			
			<ol type="a">
                            <li>
                                <input type="text" value="Pré-texto1" name="pre_texto[]" onClick="this.select()">
                                <input type="text" value="resposta1" name="resposta[]" onClick="this.select()">
                                <input type="text" value="Pós-texto1" name="pos_texto[]" onClick="this.select()">
                            </li>
			</ol>


                        <!-- Fim do formulario -->
                        <input type="submit" name="inserirLacunas" value="Salvar" />
                        <input type="reset" value="Limpar" onClick="resetar();" />
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>        
    </body>
</html>