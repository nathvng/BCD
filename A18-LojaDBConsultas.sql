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

select  id_nf, id_item, cod_prod, valor_unit from tb_vendas
where desconto is null;

select  id_nf, id_item, cod_prod, valor_unit, (valor_unit - (valor_unit*(desconto/100))) AS "Valor Vendido" from tb_vendas
where desconto is not null;

update tb_vendas
modify column desconto not null to 0;