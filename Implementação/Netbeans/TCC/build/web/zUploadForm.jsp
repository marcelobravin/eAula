<%-- 
    Document   : upLoadForm
    Created on : 08/09/2012, 00:46:07
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
    <head>
        <title>Upload Imagem</title>
        <%@ include file="frames/imports.jsp"%>
        <script src="arquivos/jquery_002.js"></script>
	<script type="text/javascript" src="arquivos/jValidation.js"></script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Criação de Conteúdo - Aula: <%=request.getParameter("aulaId")%></h1>
            <div id="conteudo">
                
                <center>                    
                    <h2>Imagem</h2>
                    <form action="ControleExercicio?inserirImagem" method="post" enctype="multipart/form-data" class="conteiner">
                        <input type="hidden" name="aulaId" id="aulaId" value="<%=request.getParameter("aulaId")%>" />
                        <!-- Botões do formulário -->
                        
                        
                        <p>
                            <label>
                                Título:
                            </label>
                            <input type="text" id="titulo" name="titulo">
                        </p>

        
                        <p>
                            <label class="obrigatorio">
                                Imagem:
                            </label>
                            <input type="file" name="arquivo" accept="image/*" />
			</p>
                        
                        <p>
                            <label>
                                Legenda:
                            </label>
                            <input type="text" id="legenda" name="legenda">
                        </p>
        


                        
                     
                        
			

                        <!-- Fim do formulario -->
                        <input type="submit" value="Enviar" />
                        <input type="reset" value="Limpar" />
                    </form>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>