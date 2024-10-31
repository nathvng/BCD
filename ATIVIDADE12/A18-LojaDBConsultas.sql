-- Por Nathália Venega
create database if not exists lojaDB;

use lojaDB;

create table if not exists tb_vendas(
id_nf int,
id_item int,
cod_prod int,
valor_unit decimal (4,2),
quantidade int,
desconto decimal(4,2)
);

insert into tb_vendas (id_nf, id_item, cod_prod, valor_unit, quantidade, desconto) values
(1, 1, 1, 25.00, 10, 05.00),
(1, 2, 2, 13.50, 3, null),
(1, 3, 3, 15.00, 2, null),
(1, 4, 4, 10.00, 1, null),
(1, 5, 5, 30.00, 1, null),
(2, 1, 3, 15.00, 4, null),
(2, 2, 4, 10.00, 5, null),
(2, 3, 5, 30.00, 7, null),
(3, 1, 1, 25.00, 5, null),
(3, 2, 4, 10.00, 4, null),
(3, 3, 5, 30.00, 5, null),
(3, 4, 2, 13.50, 7, null),
(4, 1, 5, 30.00, 10, 15.00),
(4, 2, 4, 10.00, 12, 05.00),
(4, 3, 1, 25.00, 13, 05.00),
(4, 4, 2, 13.50, 15, 05.00),
(5, 1, 3, 15.00, 3, null),
(5, 2, 5, 30.00, 6, null),
(6, 1, 1, 25.00, 22, 15.00),
(6, 2, 3, 15.00, 25, 20.00),
(7, 1, 1, 25.00, 10, 03.00),
(7, 2, 2, 13.50, 10, 04.00),
(7, 3, 3, 15.00, 10, 04.00),
(7, 4, 5, 30.00, 10, 01.00);

/* 1. Pesquise os itens que foram vendidos sem desconto. As colunas presentes no resultado da consulta são: ID_NF,
ID_ITEM, COD_PROD E VALOR_UNIT.*/
select  id_nf, id_item, cod_prod, valor_unit from tb_vendas
where desconto is null;

/* 2. Pesquise os itens que foram vendidos com desconto. As colunas presentes no resultado da consulta são:
ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT E O VALOR VENDIDO.
OBS: O valor vendido é igual ao VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)).*/
select  id_nf, id_item, cod_prod, valor_unit, (valor_unit - (valor_unit*(desconto/100))) AS "Valor Vendido" from tb_vendas
where desconto is not null;

-- 3. Altere o valor do desconto (para zero) de todos os registros onde este campo é nulo.
UPDATE tb_vendas 
SET 
    desconto = 0
WHERE
    desconto IS NULL;

/* 4. Pesquise os itens que foram vendidos. As colunas presentes no resultado da consulta são: ID_NF, ID_ITEM,
COD_PROD, VALOR_UNIT, VALOR_TOTAL, DESCONTO, VALOR_VENDIDO.
OBS: O VALOR_TOTAL é obtido pela fórmula:
QUANTIDADE * VALOR_UNIT.
O VALOR_VENDIDO é igual a VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)).*/

select  ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE * VALOR_UNIT AS "VALOR TOTAL", DESCONTO, VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)) AS VALOR_VENDIDO
from tb_vendas;

/*5. Pesquise o valor total das NF e ordene o resultado do maior valor para o menor. As colunas presentes no
resultado da consulta são: ID_NF, VALOR_TOTAL.
OBS: O VALOR_TOTAL é obtido pela fórmula: QUANTIDADE * VALOR_UNIT. Agrupe o
resultado da consulta por ID_NF.*/

select ID_NF, SUM(QUANTIDADE * VALOR_UNIT) AS VALOR_TOTAL
from tb_vendas
group by ID_NF
order by VALOR_TOTAL desc;

/*6. Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor. As colunas presentes no
resultado da consulta são: ID_NF, VALOR_VENDIDO. OBS: O VALOR_TOTAL é obtido pela fórmula:
QUANTIDADE * VALOR_UNIT.
O VALOR_VENDIDO é igual a VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)). Agrupe o resultado da consulta
por ID_NF.*/

select ID_NF, SUM(QUANTIDADE * (VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)))) AS VALOR_VENDIDO
from tb_vendas
group by id_nf
order by VALOR_VENDIDO desc;

select * from tb_vendas;

/* 7. Consulte o produto que mais vendeu no geral. As colunas presentes no resultado da consulta são:
COD_PROD, QUANTIDADE.
Agrupe o resultado da consulta por COD_PROD. */

select COD_PROD, QUANTIDADE AS QUANTIDADE_TOTAL
from tb_vendas
where COD_PROD
order by QUANTIDADE_TOTAL;

/* 8. Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto. As colunas presentes no
resultado da consulta são: ID_NF, COD_PROD, QUANTIDADE. Agrupe o resultado da consulta por ID_NF,
COD_PROD. */

select ID_NF, COD_PROD, QUANTIDADE
from tb_vendas
where QUANTIDADE > 10;

/* 9. Pesquise o valor total das NF, onde esse valor seja maior que 500, e ordene o resultado do maior valor para o
menor. As colunas presentes no resultado da consulta são: ID_NF, VALOR_TOT.
OBS: O VALOR_TOTAL é obtido pela fórmula: Soma da QUANTIDADE * VALOR_UNIT. Agrupe o
resultado da consulta por ID_NF. */

select ID_NF, SUM(QUANTIDADE * VALOR_UNIT) AS VALOR_TOTAL
from tb_vendas
group by id_nf
having VALOR_TOTAL > 500
order by VALOR_TOTAL desc;

/* 10. Qual o valor médio dos descontos dados por produto. As colunas presentes no resultado da consulta são:
COD_PROD, MÉDIA. Agrupe o resultado da consulta por COD_PROD. */

select COD_PROD, AVG(DESCONTO) AS MÉDIA
from tb_vendas
group by cod_prod;

/* 11. Qual o menor, maior e o valor médio dos descontos dados por produto. As colunas presentes no resultado da
consulta são: COD_PROD, MENOR, MAIOR, MEDIA. Agrupe o resultado da consulta por COD_PROD. */

select COD_PROD, AVG(VALOR_UNIT * (DESCONTO / 100)) AS VALOR_MEDIO
from tb_vendas
group by cod_prod;

/* 12. Quais as NF que possuem mais de 3 itens vendidos. As colunas presentes no resultado da consulta são: ID_NF,
QTD_ITENS.
OBS: NÃO ESTÁ RELACIONADO A QUANTIDADE VENDIDA DO ITEM E SIM A QUANTIDADE DE ITENS POR NOTA
FISCAL.
Agrupe o resultado da consulta por ID_NF. */

select ID_NF, SUM(QUANTIDADE) AS QTD_ITENS
from tb_vendas
group by id_nf;