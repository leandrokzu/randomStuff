/*
 Fatec Rio Preto - SP
 Inform�tica para Neg�cios
 Disciplina: ADM BD
 Data: 24/09/2020
 ------------------------------
 Objetivo/Finalidade: trabalhar com consultas complexas
 (envolve mais de 2 tabela)
 -- criar Vis�es (tabela virtual)
 -- reduz a complexiada da consulta para seu usu�rio
 -------------------------------------------------
 BD estudo de caso pr�tico: BDPedidoFatec
 ---------------------------------------------------
 */
 ------------------------------------

 USE BDPedidoFatec
 /*
 Exerc�cio 1)
 Criar uma vis�o (view)
 Mostrar os Dados das compras dos Fornercedores
 ID, Nome (existem).
 -- construir (fun��es de agrega��o)
 Quantas compras fez de cada fornecedor;
 Qual o Tatal destas compras
 */
 ------------------------------
 -- l�gica da consulta
 Select f.IDFornecedor [C�digo Fornecedor],
 f.ForNome Fornecedor,
 count (distinct i.CmpCodigo) [Qtde Compras Fornecedor],
 Sum (i.ICQtde * i.ICValor) [Total Compras]
 from TBFornecedor f
 join TBCompra c
 on (f.IDFornecedor = c.ForCodigo)
 join TBItensCompra i
 on (c.IDcompra = i.CmpCodigo)
 group by f.IDFornecedor, f.ForNome
 ------------------------------------------------------



-- criar uma vis�o (view)
 Create view VMostraCompraFornecedor
 As
 Select f.IDFornecedor [C�digo Fornecedor],
 f.ForNome Fornecedor,
 count (distinct i.CmpCodigo) [Qtde Compras Fornecedor],
 Sum (i.ICQtde * i.ICValor) [Total Compras]
 from TBFornecedor f
 join TBCompra c
 on (f.IDFornecedor = c.ForCodigo)
 join TBItensCompra i
 on (c.IDcompra = i.CmpCodigo)
 group by f.IDFornecedor, f.ForNome
 -------------------------------------------------------
 -- executar a vis�o
 Select * from VMostraCompraFornecedor
 --------------------------------------------------------- /* Exerc�cio 2)Fazer uma vis�o na �tica da compra dos produtos Id, nome produto qtde de compras feitas valor total das  compras  */ Select		p.PrdCodigo			as	[C�digo Produto],			p.PrdCodigo			as	Produto,			count(i.CmpCodigo)		[Qtde de Compras],			sum(ICQtde * i.ICValor)[Valor total de Compras] from		TBProduto			p join		TBItensCompra		i on			(p.PrdCodigo = i.PrdCodigo) group by	 p.PrdCodigo, p.PrdDescricao-----------------------------------------------teste para o produto 1 Select * from TBItensCompra	i where   i.PrdCodigo = 1 --------------------------------------------- -- criar view Create view VMostraProdutoCompra as	  Select	p.PrdCodigo			as	[C�digo Produto],				p.PrdCodigo			as	Produto,				count(i.CmpCodigo)		[Qtde de Compras],				sum(ICQtde * i.ICValor)[Valor total de Compras]	  from		TBProduto			p	  join		TBItensCompra		i	  on		(p.PrdCodigo = i.PrdCodigo)	  group by	p.PrdCodigo, p.PrdDescricaoSelect * from VMostraProdutoCompra /* Exerc�cio 3)Fazer uma vis�o na �tica da compra dos produtos Id, nome produto qtde de compras feitas valor total das  compras  */ Select		p.PrdCodigo					as  [C�digo Produto],			p.PrdDescricao				as  Produto,			count(i.PedCodigo)				[Qtde de Vendas],			sum(i.IpeQtde*i.IpeValor)		[Total de Vendas] from		TBProduto			p join		TBItensPedido		i on			(p.PrdCodigo = i.PrdCodigo) group by	p.PrdCodigo, PrdDescricao---------------------------------------------- criar a vis�oCreate view VMostraProdutoVendaas	 Select		p.PrdCodigo					as  [C�digo Produto],				p.PrdDescricao				as  Produto,				count(i.PedCodigo)				[Qtde de Vendas],				sum(i.IpeQtde*i.IpeValor)		[Total de Vendas]	 from		TBProduto			p	 join		TBItensPedido		i	 on			(p.PrdCodigo = i.PrdCodigo)	 group by	p.PrdCodigo, PrdDescricao--------------------------------------------- Select * from VMostraProdutoVenda --------------------------------------------  /* Exerc�cio 4)Fazer uma vis�o na �tica dos Pedidos i, data pedido -- campos calculados total pedido qtde produtos por pedido */ Create view VMostraPedidos As	 Select		p.PedCodigo			as				[C�digo Pedido],				p.PedData			as				Data,				count(i.PrdCodigo)								[Qtde de Produtos],				sum(i.IpeQtde*i.IpeValor)			[Total Pedido]	 From		TBPedido		p	 join		TBItensPedido	i	 -- relacionamento (TBPedido e TBItensPedido)	 On			(p.PedCodigo = i.PedCodigo)	 group by	p.PedCodigo, p.PedData------------------------------------------ executar a vis�o Select * From VMostraPedidos order by 2 desc /* Exerc�cio 5) Fazer uma vis�o na �tica dos Pedidos por vendedor. Retornar: Id, Nome Vendedor -- campos calculados Total dos pedidos Qtde pedid comiss�o vendedor em 2% */ Create View VMostrarVendas As	 Select	v.VedCodigo					as		[C�digo do vendedor],			v.VedNome					as		[Nome do vendedor],			count(distinct i.PedCodigo)			[Qtde de pedidos],			sum(i.IpeQtde*i.IpeValor)			[Total da Venda],			(sum(i.IpeQtde*i.IpeValor)*0.02)	[Comiss�o do Vendedor]	 From	TBVendedor	v	 Join	TBPedido	p	 On		(v.VedCodigo = p.VedCodigo) --relacionamento 1	 Join	TBItensPedido i	 On		(p.PedCodigo = i.PedCodigo) --relacionamento 2	 group by	v.VedNome, v.VedCodigo-------------------------------------------------- executar a vis�oSelect * From VMostrarVendas-------------------------------------------------/*Exerc�cio 6) Fazer uma vis�o na �tica do clienteRetornar:Id, Nome Cliente-- campos calculosTotal dos PedidosQtde de PedidosM�dia dos Pedidos*/Create View VPedidosClientesAs	Select	c.CliCodigo						[C�digo Cliente],			c.CliNome						Cliente,			count(distinct i.PedCodigo)		[Quantidade Pedidos],			sum(i.IpeQtde*i.IpeQtde)		[Total da Venda],			(sum(i.IpeQtde*i.IpeQtde)/count(distinct i.PedCodigo))			[M�dia dos Pedidos]	From	TBCliente		c	Join	TBPedido		p	On		(c.CliCodigo = p.CliCodigo) --relacionamento 1	Join	TBItensPedido	i	On		(p.PedCodigo = i.PedCodigo) --relacionamento 2	group by c.CliNome, c.CliCodigo------------------------------------------------executar a vis�oSelect * From VPedidosClientes