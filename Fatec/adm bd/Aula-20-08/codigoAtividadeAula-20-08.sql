/* atividadeAula-20-08: */
CREATE DATABASE DBAula1

USE DBAula1

CREATE TABLE TBCargo (
    IDCargo int PRIMARY KEY,
    NomeCargo varchar(40),
    DescricaoCargo varchar(40)
);

CREATE TABLE TBEstado (
    IDUF varchar(2) PRIMARY KEY,
    NomeEstado varchar(50)
);

CREATE TABLE TBCidade (
    IDCidade int PRIMARY KEY,
    NomeCidade varchar(50),
    CodUF varchar(2)
);

CREATE TABLE TBFuncionario (
    IDFuncionario int PRIMARY KEY,
    NomeFuncionario int,
    Sexo varchar(1),
    DataNascimento date,
    Salario decimal(10,2),
    Endereco varchar(50),
    CodCidade int,
    CodSupervisor int,
    CodDepartamento int,
    CodCargo int
);

CREATE TABLE TBDepartamento (
    IDDepartamento int PRIMARY KEY,
    NomeDepartamento varchar(50),
    QuantidadeFuncionario int,
    CodigoGerente int,
    DataInicioGerente date
);

CREATE TABLE TBDependente (
    IDDependente int PRIMARY KEY,
    NomeDependente varchar(50),
    Sexo varchar(1),
    DataNascimento date,
    Parentesco varchar(40),
    CodFuncionario int
);

CREATE TABLE TBTrabalho (
    CodProjeto int,
    CodFuncionario int,
    QuantidadeHoras int,
    DataInicio date,
    DataFim date,
    Observacao varchar(100)
);

CREATE TABLE TBProjeto (
    IDProjeto int PRIMARY KEY,
    NomeProjeto varchar(50),
    DataProjeto date,
    DescricaoProjeto varchar(200),
    CodDepartamento int
);
 
ALTER TABLE TBCidade ADD CONSTRAINT FK_TBCidade_1
    FOREIGN KEY (CodUF)
    REFERENCES TBEstado (IDUF);
 
ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_1
    FOREIGN KEY (CodCargo)
    REFERENCES TBCargo (IDCargo);
 
ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_2
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_3
    FOREIGN KEY (CodDepartamento)
    REFERENCES TBDepartamento (IDDepartamento);
 
ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_4
    FOREIGN KEY (CodSupervisor)
    REFERENCES TBFuncionario (IDFuncionario);
 
ALTER TABLE TBDepartamento ADD CONSTRAINT FK_TBDepartamento_1
    FOREIGN KEY (CodigoGerente)
    REFERENCES TBFuncionario (IDFuncionario);
 
ALTER TABLE TBDependente ADD CONSTRAINT FK_TBDependente_1
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (IDFuncionario);
 
ALTER TABLE TBTrabalho ADD CONSTRAINT FK_TBTrabalho_0
    FOREIGN KEY (CodProjeto)
    REFERENCES TBProjeto (IDProjeto);
 
ALTER TABLE TBTrabalho ADD CONSTRAINT FK_TBTrabalho_1
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (IDFuncionario);
 
ALTER TABLE TBProjeto ADD CONSTRAINT FK_TBProjeto_1
    FOREIGN KEY (CodDepartamento)
    REFERENCES TBDepartamento (IDDepartamento);