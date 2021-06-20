<%-- 
    Document   : manual
    Created on : 03/12/2011, 11:27:55
    Author     : Mark
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" errorPage="erro.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 401//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Manual de Utilização de Software</title>
        <%@ include file="frames/imports.jsp"%>
        <script type="text/javascript" src="arquivos/jquery.js"></script>
        <script type="text/javascript"> 
            $(document).ready(function(){
            $(".flip1").click(function(){
                $(".panel1").slideToggle("slow");
              });
              
              $(".flip2").click(function(){
                $(".panel2").slideToggle("slow");
              });
              
              $(".flip3").click(function(){
                $(".panel3").slideToggle("slow");
              });
              
              $(".flip4").click(function(){
                $(".panel4").slideToggle("slow");
              });
              
              $(".flip5").click(function(){
                $(".panel5").slideToggle("slow");
              });
              
              $(".flip6").click(function(){
                $(".panel6").slideToggle("slow");
              });
              
              $(".flip6").click(function(){
                $(".panel6").slideToggle("slow");
              });
              
              
              
              
              
            });
            
            
        </script>
        
        
        <style type="text/css"> 
            div[class^="panel"], div[id^="texto"]
            {
                margin:0px;
                padding:5px;
                text-align:center;
                background:#00eecc;
                border:solid 1px gray;
           
                display:none;
            }
        </style>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        <style type="text/css">

    dl {

    }

    dd {
            margin: 0;
            padding: 1em 0;
    }

    dt {
            cursor: pointer;
            font-weight: bold;
            font-size: 1.5em;
            line-height: 2em;
            background: #e3e3e3;
            border-bottom: 1px solid #c5c5c5;
            border-top: 1px solid white;
    }

    dt:first-child {
            border-top: none
    }

    dt:nth-last-child(2) {
            border-bottom: none
    }

    .hide {
            display: none
    }
		</style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		
		<script type="text/javascript">
                    $(document).ready(function(){

                        $('dd').filter(':nth-child(n+4)').addClass('hide');

                        $('dl').on('click', 'dt', function(){
                        //$('dl').on('mouseenter', 'dt', function(){
                            $(this).next().slideDown(200).siblings('dd').slideUp(200);
                        });
                    });
		</script>
    </head>
    <body>
        <div class="body">
            <%@ include file="frames/header.jsp"%>
            <h1>Manual de utilização de software</h1>

            <div id="conteudo">
                <center>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
		<dl>
			<dt>horação?</dt>
			<dd>hora 1</dd>
                        
                        <dt>horação?</dt>
			<dd>hora 1</dd>
			
			<dt>horação?</dt>
			<dd>hora 1</dd>
		</dl>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    


                    <h2>O que é o eAula?
                        <div id="botao6" style="float: left;">
                            <a class="sinal_mais" onClick="interruptor(6,1)"></a>
                        </div>
                    </h2>

                    <div id="texto6" class="invisivel">
                            O eAula é um serviço de criação e utilização de aulas virtuais interativas.<br />
                            Ele foi feito para ser utilizado por qualquer pessoa que queira aprender ou ensinar algo.
                    </div>


                    <p class="flip1">
                        <a class="cursor">Qual é o custo do eAula?</a>
                    </p>
                    <div class="panel1">
                        <h2>Qual é o custo do eAula?</h2>
                        O eAula é totalmente gratuito. Para começar, basta visitar o site.
                    </div>



                    <p class="flip2">
                        <a class="cursor">Qual é o custo do eAula?</a>
                    </p>
                    <div class="panel2">
                        <h2>Qual é o custo do eAula?</h2>
                        O eAula é totalmente gratuito. Para começar, basta visitar o site.
                    </div>









                    <p class="flip3">
                        <a class="cursor">Como utilizo o eAula?</a>
                    </p>
                    <div class="panel3">
                        <h2>Como utilizo o eAula?</h2>
                        Qualquer pessoa é bem-vinda para utilizar o eAula!<br />
                        Para começar basta criar uma conta clicando em "Cadastrar perfil", é gratuito!
                    </div>








                    <p class="flip4">
                        <a class="cursor">Navegadores compatíveis</a>
                    </p>
                    <div class="panel4">
                        <h2>Navegadores compatíveis</h2>
                        É possível acessar o eAula por meio de um computador com Windows, Mac ou Linux.

                        <p>Recomendamos a utilização de um navegador compatível para obter todos os novos recursos do eAula:</p>
                            <ul>
                                <li>Versão recente mais estável do Google Chrome. Download: <a href="#">Windows</a> <a href="#">Mac</a> <a href="#">Linux</a></li>
                                <li>Firefox 3.6 ou superior. Download:  <a href="#">Windows</a> <a href="#">Mac</a> <a href="#">Linux</a></li>
                                <li>Internet Explorer 8.0 ou superior. Download:  <a href="#">Windows</a></li>
                                <li>Safari 4.0 ou superior. Download:  <a href="#">Windows</a> <a href="#">Mac</a></li>
                                <li>Opera: não testamos o Opera, mas acreditamos que ele funciona com todos os recursos do eAula. Download:  <a href="#">Windows</a> <a href="#">Mac</a> <a href="#">Linux</a></li>
                            </ul>
                        No entanto, há duas exceções, independentemente do tipo do seu navegador, você precisa:
                        <ol>
                            <li>Estar com os cookies ativados.</li>
                            <li>Estar com o JavaScript ativado (se for compatível com seu navegador).</li>
                        </ol>
                    </div>





                    <p class="flip5">
                        <a class="cursor">Como alterar as suas configurações</a>
                    </p>
                    <div class="panel5">
                        <h2>Como alterar as suas configurações</h2>
                        Para alterar seu perfil de usuário, basta clicar no link "Editar perfil" na parte superior de qualquer página do eAula.<br />
                        Você pode á qualquer momento mudar seu perfil de estudante para professor e vice-versa.
                    </div>





                    <p class="flip6">
                        <a class="cursor">Saída</a>
                    </p>
                    <div class="panel6">
                        <h2>Saída</h2>
                        Para terminar a sua sessão do eAula, basta clicar no botão "Sair" no canto superior direito.<br />
                        Sugerimos que você saia do eAula ao fim de cada sessão para garantir a segurança da sua conta.<br />
                        É muito importante fazer logout do eAula, principalmente se você utilizá-lo em computadores públicos.
                    </div>
                </center>
            </div>
            <%@ include file="frames/footer.jsp"%>
        </div>
    </body>
</html>