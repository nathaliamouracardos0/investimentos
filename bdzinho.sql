DROP TABLE IF EXISTS roles cascade;
create table roles (
	id SERIAL NOT NULL PRIMARY KEY,
    role VARCHAR(20) NOT NULL,
    created TIMESTAMP NOT NULL,
    modified TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS users cascade;
create table users (
	id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password  VARCHAR(255) NOT NULL,
    roles_id INT NOT NULL,
    created TIMESTAMP NOT NULL,
    modified TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS contas_a_pagar cascade;
create table contas_a_pagar (
    id SERIAL NOT NULL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    classe_financeira_id INT NOT NULL,
    users_id INT NOT NULL,
    vencimento DATE NOT NULL
);

DROP TABLE IF EXISTS contas_a_receber cascade;
create table contas_a_receber (
    id SERIAL NOT NULL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    classe_financeira_id INT NOT NULL,
    users_id INT NOT NULL,
    vencimento DATE NOT NULL
);

DROP TABLE IF EXISTS classe_financeira cascade;
create table classe_financeira (
    id SERIAL NOT NULL PRIMARY KEY,
    classe_financeira_id INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    tipo CHAR(1) NOT NULL, --A | S
    tipo_classe CHAR(1) NOT NULL -- R | D | T
);

DROP TABLE IF EXISTS contas_a_pagar_classe_financeira cascade;
create table contas_a_pagar_classe_financeira (
    classe_financeira_id INT NOT NULL,
    contas_a_pagar_id INT NOT NULL,
    valor FLOAT NOT NULL
);

DROP TABLE IF EXISTS contas_a_receber_classe_financeira cascade;
create table contas_a_receber_classe_financeira (
    classe_financeira_id INT NOT NULL,
    contas_a_receber_id INT NOT NULL,
    valor FLOAT NOT NULL
);

DROP TABLE IF EXISTS conta_corrente cascade;
create table conta_corrente (
    id SERIAL NOT NULL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    users_id INT NOT NULL,
    banco_id INT NOT NULL,
    tipo_conta_corrente_id INT NOT NULL,
    agencia INT NOT NULL,
    conta INT NOT NULL
);

DROP TABLE IF EXISTS tipo_conta_corrente cascade;
create table tipo_conta_corrente (
    id SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    se_banco BOOLEAN NOT NULL
);

DROP TABLE IF EXISTS banco cascade;
create table banco (
    id SERIAL NOT NULL PRIMARY KEY,
    numero INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cnpj INT NOT NULL,
    site VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS mov_financeira cascade;
create table mov_financeira (
    id SERIAL NOT NULL PRIMARY KEY,
    conta_corrente_id INT NOT NULL,
    classe_financeira_id INT NOT NULL,
    users_id INT NOT NULL,
    data DATE NOT NULL,
    tipo_liquidacao_id INT NOT NULL,
    valor FLOAT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    contas_a_pagar_id INT NOT NULL,
    contas_a_receber_id INT NOT NULL
);

DROP TABLE IF EXISTS tipo_liquidacao cascade;
create table tipo_liquidacao (
    id SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

--chaves estrangeiras

-- tabela users
ALTER TABLE users
ADD CONSTRAINT users_roles_fk
FOREIGN KEY (roles_id) REFERENCES roles(id);

-- tabela contas_a_pagar
ALTER TABLE contas_a_pagar
ADD CONSTRAINT contas_a_pagar_classe_financeira_fk
FOREIGN KEY (classe_financeira_id) REFERENCES classe_financeira(id);

ALTER TABLE contas_a_pagar
ADD CONSTRAINT contas_a_pagar_users_fk
FOREIGN KEY (users_id) REFERENCES users(id);

--tabela contas_a_receber
ALTER TABLE contas_a_receber
ADD CONSTRAINT contas_a_receber_classe_financeira_fk
FOREIGN KEY (classe_financeira_id) REFERENCES classe_financeira(id);

ALTER TABLE contas_a_receber
ADD CONSTRAINT contas_a_receber_users_fk
FOREIGN KEY (users_id) REFERENCES users(id);

--tabela contas_a_pagar_classe_financeira
ALTER TABLE contas_a_pagar_classe_financeira
ADD CONSTRAINT contas_a_pagar_classe_financeira_classe_financeira_fk
FOREIGN KEY (classe_financeira_id) REFERENCES classe_financeira(id);

ALTER TABLE contas_a_pagar_classe_financeira
ADD CONSTRAINT contas_a_pagar_classe_financeira_contas_a_pagar_fk
FOREIGN KEY (contas_a_pagar_id) REFERENCES contas_a_pagar(id);

--tabela contas_a_receber_classe_financeira
ALTER TABLE contas_a_receber_classe_financeira
ADD CONSTRAINT contas_a_receber_classe_financeira_classe_financeira_fk
FOREIGN KEY (classe_financeira_id) REFERENCES classe_financeira(id);

ALTER TABLE contas_a_receber_classe_financeira
ADD CONSTRAINT contas_a_receber_classe_financeira_contas_a_receber_fk
FOREIGN KEY (contas_a_receber_id) REFERENCES contas_a_receber(id);

-- tabela classe_financeira

ALTER TABLE classe_financeira
ADD CONSTRAINT classe_financeira_classe_financeira_fk
FOREIGN KEY (classe_financeira_id) REFERENCES classe_financeira(id);

-- tabela conta_corrente

ALTER TABLE conta_corrente
ADD CONSTRAINT conta_corrente_users_fk
FOREIGN KEY (users_id) REFERENCES users(id);

ALTER TABLE conta_corrente
ADD CONSTRAINT conta_corrente_banco_fk
FOREIGN KEY (banco_id) REFERENCES banco(id);

ALTER TABLE conta_corrente
ADD CONSTRAINT conta_corrente_tipo_conta_corrente_fk
FOREIGN KEY (tipo_conta_corrente_id) REFERENCES tipo_conta_corrente(id);

-- tabela mov_financeira

ALTER TABLE mov_financeira
ADD CONSTRAINT mov_financeira_conta_corrente_fk
FOREIGN KEY (conta_corrente_id) REFERENCES conta_corrente(id);

ALTER TABLE mov_financeira
ADD CONSTRAINT mov_financeira_classe_financeira_fk
FOREIGN KEY (classe_financeira_id) REFERENCES classe_financeira(id);

ALTER TABLE mov_financeira
ADD CONSTRAINT mov_financeira_users_fk
FOREIGN KEY (users_id) REFERENCES users(id);

ALTER TABLE mov_financeira
ADD CONSTRAINT mov_financeira_tipo_liquidacao_fk
FOREIGN KEY (tipo_liquidacao_id) REFERENCES tipo_liquidacao(id);

ALTER TABLE mov_financeira
ADD CONSTRAINT mov_financeira_contas_a_pagar_fk
FOREIGN KEY (contas_a_pagar_id) REFERENCES contas_a_pagar(id);

ALTER TABLE mov_financeira
ADD CONSTRAINT mov_financeira_contas_a_receber_fk
FOREIGN KEY (contas_a_receber_id) REFERENCES contas_a_receber(id);


