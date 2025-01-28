-- 01. calcular o valor total dos pedidos sem modificar a estrutura da tabela
--preco_unitario ja esta multiplicado pela qtde
select p.id as id_pedido, c.nome, sum(ip.preco_unitario) as valor_total, p.data_hora, p.status from pedidos p
JOIN itens_pedidos ip ON ip.id_pedido = p.id
join clientes c on p.id_cliente = c.id
group by c.nome, p.id
order by cast(p.id as int) asc;

--RESPOSTA FORCENIDA:
select p.id, c.nome, p.data_hora, SUM(ip.preco_unitario) as valor_total
from clientes c
join pedidos p on c.id = p.id_cliente
join itens_pedidos ip on p.id = ip.id_pedido
group by p.id, c.nome;

-- 02. criando views
create view view_valor_total_pedido as
select p.id as id_pedido, c.nome, sum(ip.preco_unitario) as valor_total, p.data_hora, p.status from pedidos p
JOIN itens_pedidos ip ON ip.id_pedido = p.id
join clientes c on p.id_cliente = c.id
group by c.nome, p.id
order by cast(p.id as int) asc;

select * from view_valor_total_pedido;


-- 03. fazendo consultas com views
select nome from view_valor_total_pedido;

select * from view_valor_total_pedido
where valor_total > 10 and valor_total < 14;

select * from view_valor_total_pedido
where strftime('%m', data_hora) = '08';


-- 04. criando trigger
-- trigger: utilizado para automatizar certas acoes
select DATE(data_hora) as dia, sum(preco_unitario) as faturamento_diario
from pedidos p join itens_pedidos ip
on p.id = ip.id_pedido
group by dia
order by dia;

create table faturamento_diario (
  dia date,
  faturamento_total decimal(10,2)
);
 
select * from faturamento_diario;

create trigger tgr_calcularFaturamentoDiario
after insert on itens_pedidos
for each row
BEGIN
	DELETE FROM faturamento_diario; -- deleta o que ja tem la, para inserir novamente sem repeticoes
    INSERT INTO faturamento_diario(dia, faturamento_total)
      select DATE(data_hora) as dia, sum(preco_unitario) as faturamento_diario
      from pedidos p join itens_pedidos ip
      on p.id = ip.id_pedido
      group by dia
      order by dia;
END;
-- calcula faturamento diario apos um insert na tabela de itens_pedidos


-- 05. executando trigger

INSERT INTO Pedidos(id, id_cliente, data_hora, status) VALUES
(451, 27, '2023-10-07 14:30:00', 'Em Andamento'),
(452, 28, '2023-10-07 14:35:00', 'Em Andamento');

INSERT INTO itens_pedidos(id_pedido, id_produto, quantidade, preco_unitario) VALUES 
(451, 14, 1, 6.0),
(451, 13, 1, 7.0),
(452, 10, 1, 5.0),
(452, 31, 1, 12.50);

select * from faturamento_diario;
