/*

 Inform�tica para Neg�cios
 Disciplina: ADM BD
 Data: 24/09/2020
 ------------------------------

 (envolve mais de 2 tabela)
 -- criar Vis�es (tabela virtual)
 -- reduz a complexiada da consulta para seu usu�rio
 -------------------------------------------------


 */
 ------------------------------------

 USE BDPedidoFatec
 /*

 Criar uma vis�o (view)
 Mostrar os Dados das compras dos Fornercedores
 ID, Nome (existem).
 -- construir (fun��es de agrega��o)
 Quantas compras fez de cada fornecedor;
 Qual o Tatal destas compras
 */

 -- l�gica da consulta

 f.ForNome Fornecedor,
 count (distinct i.CmpCodigo) [Qtde Compras Fornecedor],
 Sum (i.ICQtde * i.ICValor) [Total Compras]
 from TBFornecedor f
 join TBCompra c
 on (f.IDFornecedor = c.ForCodigo)
 join TBItensCompra i
 on (c.IDcompra = i.CmpCodigo)
 group by f.IDFornecedor, f.ForNome




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


 Select * from VMostraCompraFornecedor
