/* Projeto Aula1 27-08: */
CREATE DATABASE DBProjetoAula2

USE DBProjetoAula2

CREATE TABLE TBEstado (
    IDUF VARCHAR(2) PRIMARY KEY,
    NomeEstado VARCHAR(50)
);

CREATE TABLE TBCidade (
    IDCidade INT PRIMARY KEY,
    NomeCidade VARCHAR(50),
    CodUF VARCHAR(2)
);

CREATE TABLE TBCliente (
    IDCliente INT PRIMARY KEY,
    NomeCliente VARCHAR(50),
    Telefone BIGINT,
    CPF BIGINT,
    RG BIGINT,
    CodCidade INT
);

CREATE TABLE TBGaragem (
    IDGaragem INT PRIMARY KEY,
    NomeGaragem VARCHAR(50),
    Proprietario VARCHAR(50),
    Observacao VARCHAR(MAX),
    Endereco VARCHAR(50),
    Telefone BIGINT,
    CodCidade INT
);

CREATE TABLE TBNegocio (
    IDNegocio INT PRIMARY KEY,
    Data DATE,
    Valor DECIMAL(10,2),
    CodCliente INT,
    CodVeiculo INT,
    CodGaragem INT,
    CodVendedor INT,
    Comissao DECIMAL(5,2),
    Observacao VARCHAR(MAX)
);

CREATE TABLE TBGaragemVeiculo (
    CodGaragem INT,
    CodVeiculo INT,
    DataEntrada DATE,
    DataSaida DATE,
    PrecoVenda DECIMAL(10,2),
    Observacao VARCHAR(MAX),
    PRIMARY KEY (CodGaragem, CodVeiculo)
);

CREATE TABLE TBPais (
    IDPais INT PRIMARY KEY,
    NomePais VARCHAR(50)
);

CREATE TABLE TBVeiculo (
    IDVeiculo INT PRIMARY KEY,
    Descricao VARCHAR(MAX),
    Ano INT,
    Modelo VARCHAR(50),
    Renavam VARCHAR(15),
    Placa VARCHAR(8),
    PrecoTabela DECIMAL(10,2),
    CodPais INT,
    CodFrabicante INT
);

CREATE TABLE TBFabricante (
    IDFabricante INT PRIMARY KEY,
    NomeFrabicante VARCHAR(50),
    Observacao VARCHAR(MAX),
    CodPais INT
);

CREATE TABLE TBVendedor (
    IDVendedor INT PRIMARY KEY,
    Nome VARCHAR(50),
    DataAdmissao DATE,
    Email VARCHAR(50),
    Telefone BIGINT,
    TaxaComissao DECIMAL(5,2),
    Observacao VARCHAR(MAX),
    CodCidade INT
);
 
ALTER TABLE TBCidade ADD CONSTRAINT FK_TBCidade_1
    FOREIGN KEY (CodUF)
    REFERENCES TBEstado (IDUF);
 
ALTER TABLE TBCliente ADD CONSTRAINT FK_TBCliente_1
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBGaragem ADD CONSTRAINT FK_TBGaragem_1
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBNegocio ADD CONSTRAINT FK_TBNegocio_1
    FOREIGN KEY (CodCliente)
    REFERENCES TBCliente (IDCliente);
 
ALTER TABLE TBNegocio ADD CONSTRAINT FK_TBNegocio_2
    FOREIGN KEY (CodVendedor)
    REFERENCES TBVendedor (IDVendedor);
 
ALTER TABLE TBNegocio ADD CONSTRAINT FK_TBNegocio_3
    FOREIGN KEY (CodGaragem, CodVeiculo)
    REFERENCES TBGaragemVeiculo (CodGaragem, CodVeiculo);
 
ALTER TABLE TBGaragemVeiculo ADD CONSTRAINT FK_TBGaragemVeiculo_1
    FOREIGN KEY (CodGaragem)
    REFERENCES TBGaragem (IDGaragem);
 
ALTER TABLE TBGaragemVeiculo ADD CONSTRAINT FK_TBGaragemVeiculo_2
    FOREIGN KEY (CodVeiculo)
    REFERENCES TBVeiculo (IDVeiculo);
 
ALTER TABLE TBVeiculo ADD CONSTRAINT FK_TBVeiculo_1
    FOREIGN KEY (CodPais)
    REFERENCES TBPais (IDPais);
 
ALTER TABLE TBVeiculo ADD CONSTRAINT FK_TBVeiculo_2
    FOREIGN KEY (CodFrabicante)
    REFERENCES TBFabricante (IDFabricante);
 
ALTER TABLE TBFabricante ADD CONSTRAINT FK_TBFabricante_1
    FOREIGN KEY (CodPais)
    REFERENCES TBPais (IDPais);
 
ALTER TABLE TBVendedor ADD CONSTRAINT FK_TBVendedor_1
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);