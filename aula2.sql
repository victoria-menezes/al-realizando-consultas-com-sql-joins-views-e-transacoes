-- 01. Unindo tabelas com UNION
select nome, rua, bairro, cidade, estado, cep from colaboradores
UNION all
select nome, rua, bairro, cidade, estado, cep from fornecedores;

-- 02. Qual o nome do cliente que fez o primeiro pedido registrado?
select nome, telefone from clientes
where id = (
  select id_cliente from pedidos
  order by data_hora
  asc limit 1);

-- 03. Subconsultas com IN
-- WHERE retorna apenas um resultado, IN retorna todos os resultados que se aplicam
select nome from clientes
where id IN 
(select id_cliente from pedidos
 where strftime('%m', data_hora) = '01');
 
-- 04. Subconsultas com HAVING
-- Saber a média de preço dos produtos
select avg(preco) from produtos;

-- Saber os produtos com o preço maior do que a média
select nome, preco from produtos
group by nome, preco
having preco > 
	(select avg(preco) from produtos);