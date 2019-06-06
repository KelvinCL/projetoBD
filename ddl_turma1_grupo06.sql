--entidade regular: regra 1--
CREATE TABLE cliente (
    cpf CHAR(11),
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(1),
    endereco VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL,
    data_nascimento DATE NOT NULL,
    PRIMARY KEY (cpf)
);


-- atributo multivalorado: regra 6 --
CREATE TABLE tel_cliente (
    telefone VARCHAR(20),
    cpf_cliente CHAR(11),
    PRIMARY KEY (telefone, cpf_cliente),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)	
);

--- entidade fraca ---

CREATE TABLE dependente (
    cpf_dependente CHAR(11),
    cpf_cliente CHAR(11),
    data_nascimento DATE,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (cpf_dependente,cpf_cliente),
    FOREIGN KEY(cpf_cliente) REFERENCES cliente(cpf)
);

--entidade regular: regra 1--
CREATE TABLE avaliacao (
    id INT,
    nota FLOAT NOT NULL,
    dt_avaliacao DATE NOT NULL,
    comentario VARCHAR(255),
    cpf_cliente CHAR(11),
    PRIMARY KEY(id)
);  

--relacionamento 1..1: regra 3
ALTER TABLE cliente
ADD id_aval INT
ADD CONSTRAINT id_aval_fk FOREIGN KEY (id_aval) REFERENCES avaliacao(id);

--entidade regular: regra 1--
CREATE TABLE quarto (
    numero INT,
    tipo VARCHAR(50) NOT NULL,
    vista VARCHAR(50),
    valor_diaria FLOAT NOT NULL,
    PRIMARY KEY (numero)
);


--atributo multivalorado: regra 6--
CREATE TABLE equipamento (
    id INT,
    equip VARCHAR(25) NOT NULL,
    numero_quarto INT,
    PRIMARY KEY (id,numero_quarto),
    FOREIGN KEY (numero_quarto) REFERENCES quarto(numero)
);

--relacionamento m..n: regra 5--

CREATE TABLE hospeda_quarto (
    dia_checkin DATE NOT NULL,
    dia_checkout DATE NOT NULL,
    cpf_cliente CHAR(11),
    numero_quarto INT,
    PRIMARY KEY (cpf_cliente, numero_quarto),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
    FOREIGN KEY (numero_quarto) REFERENCES quarto(numero)
);

--relacionamento 1..N: regra 4--

ALTER TABLE quarto
ADD cpf_cliente CHAR(11) NOT NULL
ADD dia_checkin DATE NOT NULL
ADD dia_checkout DATE NOT NULL
ADD CONSTRAINT cpf_cliente_fk
FOREIGN KEY(cpf_cliente) REFERENCES cliente(cpf);

--entidade regular: regra 1--
CREATE TABLE funcionario (
    cpf CHAR(11),
    nome VARCHAR(50) NOT NULL,
    data_nascimento DATE NOT NULL,
    salario FLOAT NOT NULL,
    funcao VARCHAR(20) NOT NULL,
    PRIMARY KEY (cpf)
);


--entidade regular: regra 1--
CREATE TABLE produto (
    id INT,
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    descricao VARCHAR(255),
    valor INT NOT NULL,
    PRIMARY KEY(id)
);

--relacionamento m..n: regra 5--

CREATE TABLE vende_produto (
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL,
    numero_quarto INT,
    id_produto INT,
    PRIMARY KEY (numero_quarto,id_produto),
    FOREIGN KEY (numero_quarto) REFERENCES quarto(numero),
    FOREIGN KEY (id_produto) REFERENCES produto(id) 
);

--relacionamento 1..N: regra 4--
ALTER TABLE quarto
ADD cpf_func CHAR(11)
ADD data_manutencao DATE NOT NULL
ADD tipo_manutencao VARCHAR(50) NOT NULL
ADD observacao_manutencao VARCHAR(50)
ADD CONSTRAINT cpf_func_fk FOREIGN KEY(cpf_func) REFERENCES funcionario(cpf);

DROP TABLE cliente CASCADE CONSTRAINT;
DROP TABLE funcionario CASCADE CONSTRAINT;
DROP TABLE produto CASCADE CONSTRAINT;
DROP TABLE quarto CASCADE CONSTRAINT;

DROP TABLE dependente;
DROP TABLE avaliacao;
DROP TABLE equipamento;
DROP TABLE tel_cliente;
DROP TABLE vende_produto;
DROP TABLE hospeda_quarto;
