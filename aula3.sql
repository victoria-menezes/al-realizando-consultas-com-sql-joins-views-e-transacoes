-- 01. INNER JOIN: identificar, por nome, o cliente que fez cada pedido
select c.nome, p.id, p.data_hora
from clientes c
INNER JOIN pedidos p 
on c.id = p.id_cliente;

-- 02. RIGHT JOIN: identificar quais produtos foram ou nao vendidos em um determinado mes
-- traz todos os produtos, e retorna NULL se nao houver nenhum pedido no mes 10 
select pr.nome, x.id_produto, x.id_pedido
from (select ip.id_pedido, ip.id_produto
      from pedidos p inner join itens_pedidos ip
      on p.id = ip.id_pedido
      where strftime ('%m', p.data_hora) = '10') x
right join produtos pr
on pr.id = x.id_produto;

-- 03. LEFT JOIN: identificar quais clientes nao fizeram nenhum pedido em determinado mes
-- funcionalidade analoga ao right join, mas com a tabela anterior ao comando
select c.id, c.nome
from clientes c left join (
	select p.id, p.id_cliente
	from pedidos p
	where strftime ('%m', p.data_hora) = '10') x
on c.id = x.id_cliente
where x.id_cliente is null;


-- 04. FULL JOIN: existe algum pedido sem um cliente associado?
select c.nome, p.id from clientes c full join pedidos p
on c.id = p.id_cliente
where c.id is null