DROP TABLE IF EXISTS usuarios CASCADE;
CREATE TABLE usuarios (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50),
	status NUMERIC(1), -- 0 bloqueado, 1 ativo, 2 aprovação
	cpf NUMERIC(11), --PRIMARY KEY, UNIQUE MELHOR
	sexo BOOLEAN, -- 0 fem, 1 masc
	profissao VARCHAR(20),
	email VARCHAR(30),
	escolaridade VARCHAR(20), --NUMERIC(1), -- 0 nenhum, 1 básico, 2 médio, 3 bacharel/tecnólogo, 4 mestre, 5 doutor
	senha VARCHAR(20), --NOT NULL,
	privilegios NUMERIC(1), -- 0 estudante, 1 professor, 2 revisor, 3 admin
	
	dataNascimento VARCHAR(10),
	dataCadastro DATE,
	
	--cidade VARCHAR(50), --foreign key?
	id_cidade INTEGER REFERENCES cidades (id),
	--uf VARCHAR(2), --foreign key?
	id_uf INTEGER REFERENCES estados (id),
	--tipoLogradouro VARCHAR(11), -- COLOCAR ABREVIAÇÃO varchar(3)
	id_tipoLogradouro INTEGER REFERENCES logradouros (id),
	logradouro VARCHAR(80),	
	numero NUMERIC(5),	
	cep NUMERIC(8)
	--dataAcesso TIMESTAMP -- última vez q acessou o sistema
 );
 
 

DROP TABLE IF EXISTS aulas CASCADE;
CREATE TABLE aulas (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(30),-- NOT NULL,
	descricao VARCHAR(255),
	id_autor INTEGER REFERENCES usuarios (id),
	--area VARCHAR(20),
	--materia VARCHAR(20),
	id_disciplina INTEGER REFERENCES disciplinas (id),
	restrita BOOLEAN, --0Pública 1Restrita
	senha VARCHAR(20),
	--requisitos VARCHAR(20),
	dataCriacao DATE,
	dataAtualizacao TIMESTAMP, -- última vez q acessou o sistema default now();
	utilizacoes NUMERIC(3),
	votos NUMERIC(3),
	--media NUMERIC(3,2),
	media NUMERIC(3),
	conclusoes NUMERIC(3),
	aprovacao BOOLEAN
 );
 
 
 




DROP TABLE IF EXISTS materias CASCADE;
CREATE TABLE materias (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(35),
	area NUMERIC(1), -- FK
	descricao VARCHAR(255)
);


DROP TABLE IF EXISTS disciplinas CASCADE;
CREATE TABLE disciplinas (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(20),
	descricao VARCHAR(255),
	id_materia INTEGER REFERENCES materias (id)
);





--/////////////////////////////////////////////////////////////////////
DROP TABLE IF EXISTS e_radio_respostas CASCADE;
CREATE TABLE e_radio_respostas (
	id SERIAL PRIMARY KEY,
	pergunta_id NUMERIC(11) NOT NULL,
	texto VARCHAR(255) NOT NULL
);
 

 DROP TABLE IF EXISTS e_radio_perguntas CASCADE;
CREATE TABLE e_radio_perguntas (
	id SERIAL PRIMARY KEY,
	texto VARCHAR(255) NOT NULL,
	resposta NUMERIC(2) NOT NULL
);
 
 
 
 
 
 
 
 
DROP TABLE IF EXISTS e_checkbox_perguntas CASCADE;
CREATE TABLE e_checkbox_perguntas (
	id SERIAL PRIMARY KEY,
	texto VARCHAR(255) NOT NULL
);
 
 
DROP TABLE IF EXISTS e_checkbox_respostas CASCADE;
CREATE TABLE e_checkbox_respostas (
	id SERIAL PRIMARY KEY,
	pergunta_id NUMERIC(11) NOT NULL,
	alternativa VARCHAR(255) NOT NULL,
	correta BOOLEAN NOT NULL
);
 
 
 
 
 
 
 
 
 DROP TABLE IF EXISTS e_lacuna_perguntas CASCADE;
 CREATE TABLE e_lacuna_perguntas (
	id SERIAL PRIMARY KEY,
	texto VARCHAR(255) NOT NULL
);


DROP TABLE IF EXISTS e_lacuna_respostas CASCADE;
CREATE TABLE e_lacuna_respostas (
	id SERIAL PRIMARY KEY,
	pergunta_id NUMERIC(11) NOT NULL,
	pre_texto VARCHAR(255) NOT NULL,
	resposta VARCHAR(255) NOT NULL,
	pos_texto VARCHAR(255) NOT NULL
);

 
 
 
 
 

DROP TABLE IF EXISTS conteudo CASCADE;
CREATE TABLE conteudo (
	id SERIAL PRIMARY KEY,
	id_aula NUMERIC, -- FK
	posicao NUMERIC,
	tipo_exercicio VARCHAR(20),
	id_exercicio NUMERIC
);





DROP TABLE IF EXISTS textos CASCADE;
CREATE TABLE textos (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(35),
	texto VARCHAR(255)
);















 --ATUALIZAR
DROP TABLE IF EXISTS provas CASCADE;
CREATE TABLE provas (
	id SERIAL PRIMARY KEY,
	duracao NUMERIC,
	retorno NUMERIC,
	randomOrder BOOLEAN
);
 

DROP TABLE IF EXISTS conteudo_prova CASCADE;
CREATE TABLE conteudo_prova (
	id SERIAL PRIMARY KEY,
	id_prova NUMERIC, -- NOVO
	posicao NUMERIC,
	tipo_exercicio VARCHAR(20),
	id_exercicio NUMERIC
);














DROP TABLE IF EXISTS arquivos CASCADE;
CREATE TABLE arquivos (
	id SERIAL PRIMARY KEY,
	tipo VARCHAR(35), --imagem, audio, video
	nome VARCHAR(255),
	titulo VARCHAR(35),
	legenda VARCHAR(255)
);















DROP TABLE IF EXISTS progresso CASCADE;
CREATE TABLE progresso (
	id SERIAL PRIMARY KEY,
	id_aula INTEGER REFERENCES aulas (id),	
	id_usuario INTEGER REFERENCES usuarios (id),
	posicao NUMERIC(3)
);




DROP TABLE IF EXISTS votos CASCADE;
CREATE TABLE votos (
	id SERIAL PRIMARY KEY,
	id_aula INTEGER REFERENCES aulas (id),	
	id_usuario INTEGER REFERENCES usuarios (id),
	nota NUMERIC(1)
);




DROP TABLE IF EXISTS mensagens CASCADE;
CREATE TABLE mensagens (
	id SERIAL PRIMARY KEY,
	id_remetente INTEGER REFERENCES usuarios (id),
	id_alvo INTEGER REFERENCES usuarios (id),	
	conteudo VARCHAR(255),
	data_hora TIMESTAMP,
	--status BOOLEAN, -- 0 fem, 1 masc
);