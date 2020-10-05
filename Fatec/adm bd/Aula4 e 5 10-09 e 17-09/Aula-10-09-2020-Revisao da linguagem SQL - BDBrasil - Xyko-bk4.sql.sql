/*
Faculdade de Tecnologia de Rio Preto - SP.
Disciplina: Administração de Banco de Dados (ADM BD).
Data: 10/09/2020
-------------------------------------------------------------------------
Objetivo: fazer uma Revisão da linguagem SQL, comandos: 
Insert, Update, Delete de dados (Registros).
Consultas de dados (Select);
Criar visões (views)
-------------------------------------------------
Bando de Dados de estudo de caso: BDBrasil
--------------------------------------------------
Dba: Prof. Xyko.
*/
--------------------------------------------------------
/*
Exercício 1) Restaurar o Backup do BDBrasil para estudo da Linguagem SQL
*/
-- fazer com o botão direito do mouse (faz quase toda gestão do BD)
----------------------------------------------------------------------------------------

/*
Exercício 2) Abrir o BDBrasil para trabalhar
*/
Use BDBrasil
-----------------------------------------------------
/*
Exercício 3) Saber quais estados já estão cadastrados
*/
Select * 
from TBEstado
--------------------------
/*
Exercício 4) Cadastrar os estados de:
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
			('CE', 'Ceará', 15000000, 1, 1, 23500000)
-----------------------------------------------------------------
/*
Exercício 5) Listar os dados cadastrados nos Estados
*/
Select * 
from TBEstado
-------------------------------------------------------
/*
Exercício 6) Cadastrar  mais algumas cidades Paras os estados
do AC, DF, CE, SE, PE
*/
Insert into TBCidade
Values (16, 'AC', 'Rio Branco', 10000000),
		(17, 'DF', 'Brasília', 30000000),
		(18, 'CE', 'Fortaleza', 15000000),
		(19, 'SE', 'Aracaju', 45000000),
		(20, 'PE', 'Recife', 20000000)
----------------------------------------------
/*
Exercício 7) uso do like ('S%'), like '[a-g]%
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
Exercício 8) Uso do between (intervalo)
*/

Select *
From TBCidade c
Where c.OrcamentoAnual between 10000000 and 30000000
Order by 4 desc -- ordem decrescente
--------------------------------------------------
/*
     Exercício 9) Uso do in (conjunto)
*/

Select *
From TBCidade c
Where c.CodUF in ('BA','SP', 'RJ')
Order by 2

-----------------------------------------------------
/*
     Exercício 10) Uso do inner join
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
  Exercício 11) uso de funções de agregação: sum(), count(), avg()
  -- tem que utilizar group by (fazer o agrupamento)
*/

-- 11.1)Sem inner join
Select		r.IDRegiao		[Código Região],
			r.NomeRegiao	Região,
			-- campos construídos
			count(e.CodRegiao)			[Quantidade de Estados por Região],
			sum(e.ArrecadacaoTributos)	[Arrecadação total de tributos]
From		TBRegiao	r,
			TBEstado	e
-- relacionamento (PK = FK)
Where		(r.IDRegiao = e.CodRegiao)
group by	r.IDRegiao, r.NomeRegiao
order by	4 desc

-- 11.2)Com inner join
Select		r.IDRegiao		[Código Região],
			r.NomeRegiao	Região,
			-- campos construídos
			count(e.CodRegiao)			[Quantidade de Estados por Região],
			sum(e.ArrecadacaoTributos)	[Arrecadação total de tributos]
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
Exercício 12) fazer UPDate dados
*/
-- 12.1)
Select * from TBCidade
UPDATE	TBCidade
set		NomeCidade = 'São João do Bom Jardim',
		OrcamentoAnual = 2000000
Where IDcidade = 2

-- 12.2)
Select * from TBEstado
UPDATE	TBEstado
set		ArrecadacaoTributos = (ArrecadacaoTributos*1.10)

-----------------------------------------------------------------
/*
Exercício 13) fazer uso de Delete para registros
*/
-- não apaga SP, porque SP tem cidades cadastradas
Delete TBEstado
Where IDUF = 'SP'


Select * from TBCidade

Delete TBCidade
Where IDcidade = 11
-------------------------------------------------



/*Aula de 17-09-2020
Continuação de Revisão da Linguagem SQL
trabalhar com visões (views)

Exercício 14) Criar uma Tabela TBTeste
*/

Create TABLE TBTeste
(
	IDTeste			int not null primary key,
	NomeTeste		varchar(40) not null,
	DataTeste		datetime not null
)
--------------------------------------------------
/*
Exercício 15) Trocar o nome de uma Tabela
	tocar nome usando sp_RENAME
	cuidado ao usar esse comando pois, caso a tabela esteja
ligada com outras tabelas e/ou operações, elas irão parar de funcionar
*/
sp_RENAME 'TBTeste' ,'TBTeste1' 

-------------------------------------------------
/*
Exercício 16) Alterando uma tabela e Inserindo um novo campo
	campo observação varchar(max)
	toda alteração é de três tipos
	adicionar algo, modificar ou excluir
*/

Alter table TBTeste1
add Observacao varchar(max)

Select * from TBTeste1
-------------------------------------------------------------------
/*
Exercício 17) Alterando uma tabela e Inserindo um relacionamento
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
 Exercício 18) Excluir tabela TBCidade1	como TBCidade1 não está relacionada (exporta sua PK)
nenhuma outra tabela será excluída
*/
Drop table TBCidade1
------------------------------------------------------
/*
 -- Exercício 19)
 Como excluir (deletar/apagar) um registro
	registro da TBCidade
	como Cidade não exporta sua PK para nenhuma tabela
	posso excluir qualquer cidade
 --------------------------------------------
 */
 -- mostrar o conteúdo de TBCidade
 Select * from TBCidade
 ------------------------------------
 -- para deletar registros
 -- tenho que escrever condição de deletar
 -- não aceita alias (apelido)
 
 delete from TBCidade
 where idcidade = 15
 ------------------------------------------
 -- testando
 Select * from TBcidade
 ----------------------------------

 /*
 Exercício 20
 Tentar apagar o Estado de São São Paulo
 -- São tem uma cidade Cadastrada
 -- não deleta (apaga)
 -- graças a jesus
 */
 delete from TBEstado
 where IDUF = 'SP'
 ---------------------------------------------------
 /*
    Parte 2: consultas complexas que envolvem mais de duas tabelas
	-- tem que fazer os relacionamentos entre as tabelas
	
	2.1) criar visões (views) - tabelas virtuais
	-- executar as visões

	Mostrar/retornar por região (id, nome região) (existem)
	construir campos/atributos: total de arrecadação de tributos
	qtde de estados por região
*/

-- sem join(mais lento e mais antigo)
Select		r.IDRegiao		[Código da Região],
			r.NomeRegiao	Região,
			count(e.CodRegiao)			[Qtde Estados por Região],
			sum(e.ArrecadacaoTributos)			[Arrecadação de Tributos]

from		TBRegiao r,
			TBEstado e
-- relacionamento (pk=fk)
where		(r.IDRegiao = e.CodRegiao)
group by r.IDRegiao, r.NomeRegiao
order by 4 desc

-- criando visão(view) ou seja, criando uma tabela virtual
Create view	VMostraTributosRegiao
AS
	Select		r.IDRegiao					[Código da Região],
				r.NomeRegiao				Região,
				count(e.CodRegiao)			[Qtde Estados por Região],
				sum(e.ArrecadacaoTributos)	[Arrecadação de Tributos]

	from		TBRegiao r,
				TBEstado e
	-- relacionamento (pk=fk)
	where		(r.IDRegiao = e.CodRegiao)
	group by	r.IDRegiao, r.NomeRegiao
--mostrar  a execução da view

Select * from VMostraTributosRegiao
order by 4 desc

/* 
Fazer o exercício 2.1
usando join
*/
--nova view
Create view VMostraTributosRegiao1
As
	Select		r.IDRegiao					[Código da Região],
				r.NomeRegiao				Região,
				count(e.CodRegiao)			[Qtde Estados por Região],
				sum(e.ArrecadacaoTributos)	[Arrecadação de Tributos]

	from		TBRegiao r
	join		TBEstado e
	-- relacionamento (pk=fk)
	on		(r.IDRegiao = e.CodRegiao)
	group by	r.IDRegiao, r.NomeRegiao

Select * from VMostraTributosRegiao1
order by 4 desc

/* 2.2) Mostrar a arrecadação de tributtos por estado
	sobre a perspectiva do estado
	apenas uma tabela
*/

Select	IDUF						[UF],
		NomeEstado					Estado,
		sum(e.ArrecadacaoTributos)	[Arrecadação de Tributos por Estado]
from TBEstado e
group by IDUF, NomeEstado
order by 3 desc

-- criar uma view para o exercício 2.2

Create view VArrecadacaoTributoEstado
As
	Select	IDUF						[UF],
			NomeEstado					Estado,
			sum(e.ArrecadacaoTributos)	[Arrecadação de Tributos por Estado]
	from TBEstado e
	group by IDUF, NomeEstado


Select * from VArrecadacaoTributoEstado
order by 3 desc