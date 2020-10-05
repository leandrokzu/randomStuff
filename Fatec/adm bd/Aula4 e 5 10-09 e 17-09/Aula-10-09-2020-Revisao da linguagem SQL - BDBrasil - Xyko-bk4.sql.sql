/*
Faculdade de Tecnologia de Rio Preto - SP.
Disciplina: Administra��o de Banco de Dados (ADM BD).
Data: 10/09/2020
-------------------------------------------------------------------------
Objetivo: fazer uma Revis�o da linguagem SQL, comandos: 
Insert, Update, Delete de dados (Registros).
Consultas de dados (Select);
Criar vis�es (views)
-------------------------------------------------
Bando de Dados de estudo de caso: BDBrasil
--------------------------------------------------
Dba: Prof. Xyko.
*/
--------------------------------------------------------
/*
Exerc�cio 1) Restaurar o Backup do BDBrasil para estudo da Linguagem SQL
*/
-- fazer com o bot�o direito do mouse (faz quase toda gest�o do BD)
----------------------------------------------------------------------------------------

/*
Exerc�cio 2) Abrir o BDBrasil para trabalhar
*/
Use BDBrasil
-----------------------------------------------------
/*
Exerc�cio 3) Saber quais estados j� est�o cadastrados
*/
Select * 
from TBEstado
--------------------------
/*
Exerc�cio 4) Cadastrar os estados de:
Sergipe (SE) - NE(1), 
Acre (AC) -NO (3), 
Pernambuco (PE) - NE (1), 
Distrito Federal (DF)-CO(6)
Ceara (CE) - NE(1)
*/
Insert into TBEstado
Values		('AC', 'Acre', 1000000, 6, 3, 30000000),
			('PE', 'Pernambuco', 3000000, 1, 1, 45000000)
--------------------------------------------------------------------
Insert into TBEstado
Values	('DF', 'Distrito Federal', 12000000, 1, 6, 25000000),
			('CE', 'Cear�', 15000000, 1, 1, 23500000)
-----------------------------------------------------------------
/*
Exerc�cio 5) Listar os dados cadastrados nos Estados
*/
Select * 
from TBEstado
-------------------------------------------------------
/*
Exerc�cio 6) Cadastrar  mais algumas cidades Paras os estados
do AC, DF, CE, SE, PE
*/
Insert into TBCidade
Values (16, 'AC', 'Rio Branco', 10000000),
		(17, 'DF', 'Bras�lia', 30000000),
		(18, 'CE', 'Fortaleza', 15000000),
		(19, 'SE', 'Aracaju', 45000000),
		(20, 'PE', 'Recife', 20000000)
----------------------------------------------
/*
Exerc�cio 7) uso do like ('S%'), like '[a-g]%
Listar os dados das Cidades Cadastradas
*/
-- 7.1) Checar as cidades
Select * 
from TBCidade

-- 7.2) Fazer uso do comando like
Select *
From TBCidade c
Where c.NomeCidade like '[a-j]%'
Order by 3

-- 7.3)
Select *
From TBCidade c
Where c.NomeCidade like '[j-r]%'
Order by 3
-------------------------------------------------------
/*
Exerc�cio 8) Uso do between (intervalo)
*/

Select *
From TBCidade c
Where c.OrcamentoAnual between 10000000 and 30000000
Order by 4 desc -- ordem decrescente
--------------------------------------------------
/*
     Exerc�cio 9) Uso do in (conjunto)
*/

Select *
From TBCidade c
Where c.CodUF in ('BA','SP', 'RJ')
Order by 2

-----------------------------------------------------
/*
     Exerc�cio 10) Uso do inner join
*/
-- 10.1) Sem inner join
Select	r.NomeRegiao Regiao,
		e.NomeEstado Estado
From	TBRegiao r,
		TBEstado e
Where	(r.IDRegiao = e.CodRegiao)
Order by 1

-- 10.2) Com inner join
Select	r.NomeRegiao Regiao,
		e.NomeEstado Estado
From	TBRegiao r
Join	TBEstado e
On	(r.IDRegiao = e.CodRegiao)
Order by 1

------------------------------------------------------------------------
/*
  Exerc�cio 11) uso de fun��es de agrega��o: sum(), count(), avg()
  -- tem que utilizar group by (fazer o agrupamento)
*/

-- 11.1)Sem inner join
Select		r.IDRegiao		[C�digo Regi�o],
			r.NomeRegiao	Regi�o,
			-- campos constru�dos
			count(e.CodRegiao)			[Quantidade de Estados por Regi�o],
			sum(e.ArrecadacaoTributos)	[Arrecada��o total de tributos]
From		TBRegiao	r,
			TBEstado	e
-- relacionamento (PK = FK)
Where		(r.IDRegiao = e.CodRegiao)
group by	r.IDRegiao, r.NomeRegiao
order by	4 desc

-- 11.2)Com inner join
Select		r.IDRegiao		[C�digo Regi�o],
			r.NomeRegiao	Regi�o,
			-- campos constru�dos
			count(e.CodRegiao)			[Quantidade de Estados por Regi�o],
			sum(e.ArrecadacaoTributos)	[Arrecada��o total de tributos]
From		TBRegiao	r
join		TBEstado	e
-- relacionamento (PK = FK)
on		(r.IDRegiao = e.CodRegiao)
group by	r.IDRegiao, r.NomeRegiao
order by	4 desc

/* 11.3) Fazer uma consulta sem inner join
Que retorna: ID e Nome estado (existem);
Contar quantas economias tem por estado;
Totalizar Valor Economia por Estado
*/
Select		e.IDUF						UF,
			e.NomeEstado				[Nome do Estado],
			count(ee.CodEconomia)		[Qtde de Economias no Estado],
			sum(ee.ValorEconomiaAnual)	[Total de Economia por Estado]
From		TBEstado e,
			TBEstadoEconomia ee
-- relacionamento (pk=fk)
Where		(e.IDUF = ee.CodUF)
group by	e.IDUF, e.NomeEstado
order by	2

-- 11.4) Com join
Select		e.IDUF						UF,
			e.NomeEstado				[Nome do Estado],
			count(ee.CodEconomia)		[Qtde de Economias no Estado],
			sum(ee.ValorEconomiaAnual)	[Total de Economia por Estado]
From		TBEstado e
join		TBEstadoEconomia ee
-- relacionamento (pk=fk)
on			(e.IDUF = ee.CodUF)
group by	e.IDUF, e.NomeEstado
order by	2
-----------------------------------------------------------------------
/*
Exerc�cio 12) fazer UPDate dados
*/
-- 12.1)
Select * from TBCidade
UPDATE	TBCidade
set		NomeCidade = 'S�o Jo�o do Bom Jardim',
		OrcamentoAnual = 2000000
Where IDcidade = 2

-- 12.2)
Select * from TBEstado
UPDATE	TBEstado
set		ArrecadacaoTributos = (ArrecadacaoTributos*1.10)

-----------------------------------------------------------------
/*
Exerc�cio 13) fazer uso de Delete para registros
*/
-- n�o apaga SP, porque SP tem cidades cadastradas
Delete TBEstado
Where IDUF = 'SP'


Select * from TBCidade

Delete TBCidade
Where IDcidade = 11
-------------------------------------------------



/*Aula de 17-09-2020
Continua��o de Revis�o da Linguagem SQL
trabalhar com vis�es (views)

Exerc�cio 14) Criar uma Tabela TBTeste
*/

Create TABLE TBTeste
(
	IDTeste			int not null primary key,
	NomeTeste		varchar(40) not null,
	DataTeste		datetime not null
)
--------------------------------------------------
/*
Exerc�cio 15) Trocar o nome de uma Tabela
	tocar nome usando sp_RENAME
	cuidado ao usar esse comando pois, caso a tabela esteja
ligada com outras tabelas e/ou opera��es, elas ir�o parar de funcionar
*/
sp_RENAME 'TBTeste' ,'TBTeste1' 

-------------------------------------------------
/*
Exerc�cio 16) Alterando uma tabela e Inserindo um novo campo
	campo observa��o varchar(max)
	toda altera��o � de tr�s tipos
	adicionar algo, modificar ou excluir
*/

Alter table TBTeste1
add Observacao varchar(max)

Select * from TBTeste1
-------------------------------------------------------------------
/*
Exerc�cio 17) Alterando uma tabela e Inserindo um relacionamento
de chave estrangeira
*/
 CREATE TABLE TBCidade1 (
 IDcidade int NOT NULL primary key,
 CodUF char(2) NOT NULL,
 NomeCidade varchar(40) NOT NULL,
 OrcamentoAnual decimal (10, 2) NULL,
 -- relacionamento com a tabela TBESTADO
 FOREIGN KEY(CodUF) REFERENCES TBEstado (IDUF)
 )
-----------------------------------------------------

/*
 Exerc�cio 18) Excluir tabela TBCidade1	como TBCidade1 n�o est� relacionada (exporta sua PK)
nenhuma outra tabela ser� exclu�da
*/
Drop table TBCidade1
------------------------------------------------------
/*
 -- Exerc�cio 19)
 Como excluir (deletar/apagar) um registro
	registro da TBCidade
	como Cidade n�o exporta sua PK para nenhuma tabela
	posso excluir qualquer cidade
 --------------------------------------------
 */
 -- mostrar o conte�do de TBCidade
 Select * from TBCidade
 ------------------------------------
 -- para deletar registros
 -- tenho que escrever condi��o de deletar
 -- n�o aceita alias (apelido)
 
 delete from TBCidade
 where idcidade = 15
 ------------------------------------------
 -- testando
 Select * from TBcidade
 ----------------------------------

 /*
 Exerc�cio 20
 Tentar apagar o Estado de S�o S�o Paulo
 -- S�o tem uma cidade Cadastrada
 -- n�o deleta (apaga)
 -- gra�as a jesus
 */
 delete from TBEstado
 where IDUF = 'SP'
 ---------------------------------------------------
 /*
    Parte 2: consultas complexas que envolvem mais de duas tabelas
	-- tem que fazer os relacionamentos entre as tabelas
	
	2.1) criar vis�es (views) - tabelas virtuais
	-- executar as vis�es

	Mostrar/retornar por regi�o (id, nome regi�o) (existem)
	construir campos/atributos: total de arrecada��o de tributos
	qtde de estados por regi�o
*/

-- sem join(mais lento e mais antigo)
Select		r.IDRegiao		[C�digo da Regi�o],
			r.NomeRegiao	Regi�o,
			count(e.CodRegiao)			[Qtde Estados por Regi�o],
			sum(e.ArrecadacaoTributos)			[Arrecada��o de Tributos]

from		TBRegiao r,
			TBEstado e
-- relacionamento (pk=fk)
where		(r.IDRegiao = e.CodRegiao)
group by r.IDRegiao, r.NomeRegiao
order by 4 desc

-- criando vis�o(view) ou seja, criando uma tabela virtual
Create view	VMostraTributosRegiao
AS
	Select		r.IDRegiao					[C�digo da Regi�o],
				r.NomeRegiao				Regi�o,
				count(e.CodRegiao)			[Qtde Estados por Regi�o],
				sum(e.ArrecadacaoTributos)	[Arrecada��o de Tributos]

	from		TBRegiao r,
				TBEstado e
	-- relacionamento (pk=fk)
	where		(r.IDRegiao = e.CodRegiao)
	group by	r.IDRegiao, r.NomeRegiao
--mostrar  a execu��o da view

Select * from VMostraTributosRegiao
order by 4 desc

/* 
Fazer o exerc�cio 2.1
usando join
*/
--nova view
Create view VMostraTributosRegiao1
As
	Select		r.IDRegiao					[C�digo da Regi�o],
				r.NomeRegiao				Regi�o,
				count(e.CodRegiao)			[Qtde Estados por Regi�o],
				sum(e.ArrecadacaoTributos)	[Arrecada��o de Tributos]

	from		TBRegiao r
	join		TBEstado e
	-- relacionamento (pk=fk)
	on		(r.IDRegiao = e.CodRegiao)
	group by	r.IDRegiao, r.NomeRegiao

Select * from VMostraTributosRegiao1
order by 4 desc

/* 2.2) Mostrar a arrecada��o de tributtos por estado
	sobre a perspectiva do estado
	apenas uma tabela
*/

Select	IDUF						[UF],
		NomeEstado					Estado,
		sum(e.ArrecadacaoTributos)	[Arrecada��o de Tributos por Estado]
from TBEstado e
group by IDUF, NomeEstado
order by 3 desc

-- criar uma view para o exerc�cio 2.2

Create view VArrecadacaoTributoEstado
As
	Select	IDUF						[UF],
			NomeEstado					Estado,
			sum(e.ArrecadacaoTributos)	[Arrecada��o de Tributos por Estado]
	from TBEstado e
	group by IDUF, NomeEstado


Select * from VArrecadacaoTributoEstado
order by 3 desc