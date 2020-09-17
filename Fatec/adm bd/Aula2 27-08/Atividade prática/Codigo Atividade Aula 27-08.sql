/* Lógico_1: */

CREATE DATABASE DBAula2

USE DBAula2

CREATE TABLE TBEstado (
    IDUF VARCHAR(2) PRIMARY KEY,
    Nome VARCHAR(50)
);

CREATE TABLE TBCidade (
    IDCidade INT PRIMARY KEY,
    Nome VARCHAR(50),
    CodUF VARCHAR(2)
);

CREATE TABLE TBPessoa (
    IDPessoa INT PRIMARY KEY,
    Nome VARCHAR(50),
    DataNasc DATE,
    Sexo VARCHAR(1),
    Telefone VARCHAR(12),
    Email VARCHAR(50),
    Endereco VARCHAR(50),
    CodCidade INT
);

CREATE TABLE TBCliente (
    CodCliente INT PRIMARY KEY,
    LimiteCreditos DECIMAL(10,2),
    RG VARCHAR(15),
    CPF VARCHAR(18)
);

CREATE TABLE TBVendedor (
    CodVendedor INT PRIMARY KEY,
    Salario DECIMAL(10,2),
    Matricula VARCHAR(50),
    RG VARCHAR(15),
    CPF VARCHAR(18)
);

CREATE TABLE TBFornecedor (
    CodFornecedor INT PRIMARY KEY,
    CNPJ VARCHAR(18)
);

CREATE TABLE TBPedido (
    IDPedido INT PRIMARY KEY,
    Data DATE,
    Observacao VARCHAR(MAX),
    CodCliente INT,
    CodVendedor INT,
    CodSituacao INT
);

CREATE TABLE TBCategoria (
    IDCategoria INT PRIMARY KEY,
    Nome VARCHAR(50),
    Modelo VARCHAR(50)
);

CREATE TABLE TBProduto (
    IDProduto INT PRIMARY KEY,
    Nome VARCHAR(50),
    Preco DECIMAL(10,2),
    Marca VARCHAR(50),
    CodFornecedor INT,
    CodCategoria INT
);

CREATE TABLE TBItensPedido (
    CodProduto INT,
    CodPedido INT,
    ValorVenda DECIMAL(10,2),
    Quantidade INT,
    PRIMARY KEY (CodProduto, CodPedido)
);

CREATE TABLE TBSituacao (
    IDSituacao INT PRIMARY KEY,
    Status VARCHAR(20)
);
 
ALTER TABLE TBCidade ADD CONSTRAINT FK_TBCidade_1
    FOREIGN KEY (CodUF)
    REFERENCES TBEstado (IDUF);
 
ALTER TABLE TBPessoa ADD CONSTRAINT FK_TBPessoa_1
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBCliente ADD CONSTRAINT FK_TBCliente_0
    FOREIGN KEY (CodCliente)
    REFERENCES TBPessoa (IDPessoa);
 
ALTER TABLE TBVendedor ADD CONSTRAINT FK_TBVendedor_1
    FOREIGN KEY (CodVendedor)
    REFERENCES TBPessoa (IDPessoa);
 
ALTER TABLE TBFornecedor ADD CONSTRAINT FK_TBFornecedor_1
    FOREIGN KEY (CodFornecedor)
    REFERENCES TBPessoa (IDPessoa);
 
ALTER TABLE TBPedido ADD CONSTRAINT FK_TBPedido_1
    FOREIGN KEY (CodCliente)
    REFERENCES TBCliente (CodCliente);
 
ALTER TABLE TBPedido ADD CONSTRAINT FK_TBPedido_2
    FOREIGN KEY (CodVendedor)
    REFERENCES TBVendedor (CodVendedor);
 
ALTER TABLE TBPedido ADD CONSTRAINT FK_TBPedido_3
    FOREIGN KEY (CodSituacao)
    REFERENCES TBSituacao (IDSituacao);
 
ALTER TABLE TBProduto ADD CONSTRAINT FK_TBProduto_1
    FOREIGN KEY (CodFornecedor)
    REFERENCES TBFornecedor (CodFornecedor);
 
ALTER TABLE TBProduto ADD CONSTRAINT FK_TBProduto_2
    FOREIGN KEY (CodCategoria)
    REFERENCES TBCategoria (IDCategoria);
 
ALTER TABLE TBItensPedido ADD CONSTRAINT FK_TBItensPedido_1
    FOREIGN KEY (CodPedido)
    REFERENCES TBPedido (IDPedido);
 
ALTER TABLE TBItensPedido ADD CONSTRAINT FK_TBItensPedido_2
    FOREIGN KEY (CodProduto)
    REFERENCES TBProduto (IDProduto);