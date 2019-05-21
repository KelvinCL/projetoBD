CREATE TABLE cliente (
	cpf CHAR(11),
	nome VARCHAR(50) NOT NULL,
	sexo CHAR(1),
	endereco VARCHAR(100),
    email VARCHAR(50),
	data_nascimento DATE,
	PRIMARY KEY (cpf)
);

CREATE TABLE avaliacao (
    id INT,
    nota INT,
    dt_avaliacao DATE,
    comentario VARCHAR(255),
    cpf_cliente CHAR(11),
    PRIMARY KEY(id, cpf_cliente),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
);  

CREATE TABLE produto (
    id INT,
    nome VARCHAR(50),
    tipo VARCHAR(50),
    descricao VARCHAR(255),
    valor INT,
    PRIMARY KEY(id)
);

CREATE TABLE funcionario (
    cpf CHAR(11),
    nome VARCHAR(50) NOT NULL,
    data_nascimento DATE,
    salario INT,
    funcao VARCHAR(20),
    PRIMARY KEY (cpf)
);

CREATE TABLE quarto (
	numero INT,
    tipo VARCHAR(50),
    vista VARCHAR(50),
    valor_diaria INT,
    PRIMARY KEY (numero)
);

--- entidade fraca ---

CREATE TABLE dependente (
	cpf_dependente CHAR(11),
    cpf_cliente CHAR(11),
    data_nascimento DATE,
    nome VARCHAR(50),
    PRIMARY KEY (cpf_dependente,cpf_cliente),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
);


-- relacionamentos ---

CREATE TABLE equipamento (
    id INT,
    equip VARCHAR(25),
    numero_quarto INT,
    PRIMARY KEY (id,numero_quarto),
    FOREIGN KEY (numero_quarto) REFERENCES quarto(numero)
);

CREATE TABLE tel_cliente (
	telefone VARCHAR(20),
	cpf_cliente CHAR(11),
	PRIMARY KEY (telefone, cpf_cliente),
	FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
);

CREATE TABLE reserva_quarto (
	dia_checkin DATE,
    dia_checkout DATE,
    cpf_cliente CHAR(11),
    numero_quarto INT,
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
    FOREIGN KEY (numero_quarto) REFERENCES quarto(numero),
    PRIMARY KEY (cpf_cliente, numero_quarto, dia_checkin, dia_checkout)
);

CREATE TABLE hospeda_quarto (
	dia_checkin DATE,
    dia_checkout DATE,
    cpf_cliente CHAR(11),
    numero_quarto INT,
    PRIMARY KEY (cpf_cliente, numero_quarto),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
    FOREIGN KEY (numero_quarto) REFERENCES quarto(numero)
);

CREATE TABLE mantem_funcionario (
	data_manutencao DATE,
    tipo VARCHAR(50),
    observacao VARCHAR(255),
    cpf_funcionario CHAR(11),
    numero_quarto INT,
    PRIMARY KEY (numero_quarto, cpf_funcionario),
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionario(cpf),
    FOREIGN KEY (numero_quarto) REFERENCES quarto(numero)
);

CREATE TABLE vende_produto (
	data_venda DATE,
    quantidade INT,
    numero_quarto INT,
    id_produto INT,
    PRIMARY KEY (numero_quarto,id_produto),
    FOREIGN KEY (numero_quarto) REFERENCES quarto(numero),
    FOREIGN KEY (id_produto) REFERENCES produto(id) 
);
