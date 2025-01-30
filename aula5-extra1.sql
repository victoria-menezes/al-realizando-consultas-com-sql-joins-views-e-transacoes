-- 1. Traga todos os dados da cliente Maria Silva.
select * from clientes where lower(nome) like 'maria silva'; 


-- 2. Busque o ID do pedido e o ID do cliente dos pedidos onde o status esteja como entregue.
select id as id_pedido, id_cliente from pedidos where lower(status) = 'entregue';


-- 3. Retorne todos os produtos onde o preço seja maior que 10 e menor que 15.
select * from produtos where preco between 10 and 15;


-- 4. Busque o nome e cargo dos colaboradores que foram contratados entre 2022-01-01 e 2022-06-31.
select nome, cargo from colaboradores where data_contratacao between '2022-01-1' and '2022-06-31';


-- 5. Recupere o nome do cliente que fez o primeiro pedido.
select nome from clientes
where id in
	(select id_cliente 
     from pedidos 
     order by data_hora asc limit 1);
     

-- 6. Liste os produtos que nunca foram pedidos.
select * from produtos
where id not in(
	select id_produto from itens_pedidos)
order by cast(id as int) asc;


-- 7. Liste os nomes dos clientes que fizeram pedidos entre 2023-01-01 e 2023-12-31.
select nome from clientes
where id in(
  select id_cliente from pedidos
  where data_hora between '2023-01-01' and '2023-12-31')
order by nome asc;

-- USANDO JOINS:
SELECT c.nome
FROM clientes c
INNER JOIN pedidos p ON c.id = p.id_cliente
where p.data_hora
between '2023-01-01' and '2023-12-31'
order by c.nome asc;


-- 8. Recupere os nomes dos produtos que estão em menos de 15 pedidos.
select p.nome
from produtos p inner join (
  select id_produto, count(id_produto) as total
  from itens_pedidos
  group by id_produto) x
on p.id = x.id_produto
where x.total < 15;

-- SOLUCAO FORNECIDA:
select p.nome, count(ip.id_pedido)
from produtos p inner join itens_pedidos ip
on p.id = ip.id_produto
group by p.nome
having count(ip.id_pedido) < 15;

-- 9. Liste os produtos e o ID do pedido que foram realizados pelo cliente "Pedro Alves" ou pela cliente "Ana Rodrigues".

select pr.nome, pe.id
from pedidos pe inner join clientes c
on pe.id_cliente = c.id
inner join itens_pedidos ip
on pe.id = ip.id_pedido
inner join produtos pr
on ip.id_produto = pr.id
where c.nome = 'Pedro Alves' OR c.nome = 'Ana Rodrigues'
order by cast(pe.id as int) asc;

-- SOLUCAO FORNECIDA:
SELECT p.nome, ip.id_pedido
FROM produtos AS p
INNER JOIN itens_pedidos AS ip ON P.id = IP.id_produto
INNER JOIN pedidos AS pd ON ip.id_pedido = pd.id
INNER JOIN clientes AS c ON pd.id_cliente = C.id
WHERE c.nome IN ('Pedro Alves', 'Ana Rodrigues')
order by cast(pd.id as int) asc;


-- 10. Recupere o nome e o ID do cliente que mais comprou(valor) no Serenatto.
select c.id, c.nome, sum(ip.preco_unitario) as total
from clientes c
inner join pedidos pe
on c.id = pe.id_cliente
inner join itens_pedidos ip
on pe.id = ip.id_pedido
group by c.nome
order by total desc
limit 1

-- SOLUCAO FORNECIDA:
SELECT p.id_cliente, c.nome, SUM(ip.preco_unitario) as Valortotal 
FROM clientes c 
INNER JOIN pedidos p ON c.id = p.id_cliente 
INNER JOIN itens_pedidos ip ON p.id = ip.id_pedido 
GROUP BY p.id_cliente 
ORDER BY Valortotal DESC 
LIMIT 1;

