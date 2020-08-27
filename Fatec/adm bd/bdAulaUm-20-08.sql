/* projeto-logico-aula1: */
--Criando o BD(pq a ferramenta não faz isso sozinha)
Create Database BdEscolaFatec
---------------------------------
-- abrir o BD
Use BdEscolaFatec
---------------------------------

CREATE TABLE TBEstado (
    IDUF Varchar(2) PRIMARY KEY,
    NomeEstado Varchar(50)
);

CREATE TABLE TBCidade (
    IDCidade int PRIMARY KEY,
    NomeCidade Varchar(50),
    Endereco Varchar(50),
    CodUF Varchar(2)
);

CREATE TABLE TBCurso (
    IDCurso int PRIMARY KEY,
    NomeCurso Varchar(50),
    CargaHoraria int
);

CREATE TABLE TBTurno (
    IDTurno int PRIMARY KEY,
    NomeTurno Varchar(50)
);

CREATE TABLE TBTurma (
    IDTurma int PRIMARY KEY,
    NomeTurma Varchar(50),
    Semestre int,
    Ano int,
    CodTurno int,
    CodCurso int
);

CREATE TABLE TBDisciplina (
    IDDisciplina int PRIMARY KEY,
    NomeDisciplina Varchar(50),
    CargaHoraria int,
    CodTurma int
);

CREATE TABLE TBProfessor (
    IDProfessor int PRIMARY KEY,
    NomeProfessor Varchar(50),
    DataNascimento date,
    CPF BigInt,
    Endereco Varchar(50),
    Email Varchar(40),
    Telefone BigInt,
    RG Varchar(50),
    Observacao Varchar(60),
    CodCidade int
);

CREATE TABLE TBAluno (
    IDAluno int PRIMARY KEY,
    NomeAluno Varchar(50),
    DataNascimento date,
    CPF BigInt,
    Endereco Varchar(50),
    Email Varchar(40),
    Telefone BigInt,
    RG Varchar(50),
    Observacao Varchar(60),
    CodCidade int
);

CREATE TABLE TBAtribuicao (
    IDAtribuicao int PRIMARY KEY,
    Data date,
    CodProfessor int,
    CodDisciplina int
);

CREATE TABLE TBAula (
    IDAula int PRIMARY KEY,
    Data date,
    Conteudo Varchar(max),
    CodAtribuicao int
);

CREATE TABLE TBAvalicao (
    IDAvalicao int PRIMARY KEY,
    NomeAvaliacao Varchar(50),
    Data date,
    CodAtribuicao int
);

CREATE TABLE TBMatricula (
    IDMatricula int PRIMARY KEY,
    Data date,
    CodTurma int,
    CodAluno int
);

CREATE TABLE TBNota (
    IDNota int PRIMARY KEY,
    Data date,
    CodMatricula int,
    CodAtribuicao int
);

CREATE TABLE TBFrequencia (
    IDFrequencia int PRIMARY KEY,
    Data date,
    CodMatricula int,
    CodAula int,
    Quantidade int
);
 
ALTER TABLE TBCidade ADD CONSTRAINT FK_TBCidade_1
    FOREIGN KEY (CodUF)
    REFERENCES TBEstado (IDUF);
 
ALTER TABLE TBTurma ADD CONSTRAINT FK_TBTurma_1
    FOREIGN KEY (CodTurno)
    REFERENCES TBTurno (IDTurno);
 
ALTER TABLE TBTurma ADD CONSTRAINT FK_TBTurma_2
    FOREIGN KEY (CodCurso)
    REFERENCES TBCurso (IDCurso);
 
ALTER TABLE TBDisciplina ADD CONSTRAINT FK_TBDisciplina_1
    FOREIGN KEY (CodTurma)
    REFERENCES TBTurma (IDTurma);
 
ALTER TABLE TBProfessor ADD CONSTRAINT FK_TBProfessor_1
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBAluno ADD CONSTRAINT FK_TBAluno_1
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBAtribuicao ADD CONSTRAINT FK_TBAtribuicao_1
    FOREIGN KEY (CodProfessor)
    REFERENCES TBProfessor (IDProfessor);
 
ALTER TABLE TBAtribuicao ADD CONSTRAINT FK_TBAtribuicao_2
    FOREIGN KEY (CodDisciplina)
    REFERENCES TBDisciplina (IDDisciplina);
 
ALTER TABLE TBAula ADD CONSTRAINT FK_TBAula_1
    FOREIGN KEY (CodAtribuicao)
    REFERENCES TBAtribuicao (IDAtribuicao);
 
ALTER TABLE TBAvalicao ADD CONSTRAINT FK_TBAvalicao_1
    FOREIGN KEY (CodAtribuicao)
    REFERENCES TBAtribuicao (IDAtribuicao);
 
ALTER TABLE TBMatricula ADD CONSTRAINT FK_TBMatricula_1
    FOREIGN KEY (CodAluno)
    REFERENCES TBAluno (IDAluno);
 
ALTER TABLE TBMatricula ADD CONSTRAINT FK_TBMatricula_2
    FOREIGN KEY (CodTurma)
    REFERENCES TBTurma (IDTurma);
 
ALTER TABLE TBNota ADD CONSTRAINT FK_TBNota_1
    FOREIGN KEY (CodMatricula)
    REFERENCES TBMatricula (IDMatricula);
 
ALTER TABLE TBNota ADD CONSTRAINT FK_TBNota_2
    FOREIGN KEY (CodAtribuicao)
    REFERENCES TBAtribuicao (IDAtribuicao);
 
ALTER TABLE TBFrequencia ADD CONSTRAINT FK_TBFrequencia_1
    FOREIGN KEY (CodAula)
    REFERENCES TBAula (IDAula);
 
ALTER TABLE TBFrequencia ADD CONSTRAINT FK_TBFrequencia_2
    FOREIGN KEY (CodMatricula)
    REFERENCES TBMatricula (IDMatricula);