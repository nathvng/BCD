-- Criando o Banco de Dados
CREATE DATABASE livraria;

-- Usando o Banco de Dados
USE livraria;

-- Criando Tabela CLIENTE
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(45),
    cpf VARCHAR(11),
    rg VARCHAR(11),
    email VARCHAR(45)
);

-- Criando Tabela CLIENTES_ENDERECO
CREATE TABLE clientes_endereco (
    id_endereco INT PRIMARY KEY,
    rua VARCHAR(45),
    numero INT,
    estado VARCHAR(45),
    cidade VARCHAR(45),
    CLIENTE_id_cliente INT,
    FOREIGN KEY (CLIENTE_id_cliente) REFERENCES cliente(id_cliente)
);

-- Criando Tabela CLIENTES_TELEFONES
CREATE TABLE clientes_telefones (
    id_telefone INT PRIMARY KEY,
    telefone VARCHAR(15),
    CLIENTE_id_cliente INT,
    FOREIGN KEY (CLIENTE_id_cliente) REFERENCES cliente(id_cliente)
);

-- Criando Tabela PEDIDO
CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY,
    valor DECIMAL(10, 2),
    data DATE,
    CLIENTE_id_cliente INT,
    FOREIGN KEY (CLIENTE_id_cliente) REFERENCES cliente(id_cliente)
);

-- Criando Tabela ITEM_PEDIDO
CREATE TABLE item_pedido (
    quantidade INT,
    valor DECIMAL(10, 2),
    PEDIDO_id_pedido INT,
    LIVRO_id_livro INT,
    FOREIGN KEY (PEDIDO_id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (LIVRO_id_livro) REFERENCES livro(id_livro)
);

-- Criando Tabela LIVRO
CREATE TABLE livro (
    id_livro INT PRIMARY KEY,
    titulo VARCHAR(45),
    categoria VARCHAR(45),
    isbn VARCHAR(13),
    ano DATE,
    valor DECIMAL(10, 2),
    autor VARCHAR(45),
    EDITORA_id_editora INT,
    FOREIGN KEY (EDITORA_id_editora) REFERENCES editora(id_editora)
);

-- Criando Tabela ESTOQUE
CREATE TABLE estoque (
    quantidade INT,
    LIVRO_id_livro INT,
    FOREIGN KEY (LIVRO_id_livro) REFERENCES livro(id_livro)
);

-- Criando Tabela EDITORA
CREATE TABLE editora (
    id_editora INT PRIMARY KEY,
    nome_ed VARCHAR(45),
    nome_contato VARCHAR(45),
    email VARCHAR(45),
    contato VARCHAR(45)
);