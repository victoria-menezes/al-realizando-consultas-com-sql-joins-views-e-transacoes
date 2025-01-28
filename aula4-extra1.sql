/* Utilizando as tabelas de clientes, pedidos e itensPedidos do Serenatto,
crie uma consulta que busque o total dos pedidos feitos por cada cliente.
A tabela "Clientes" contém informações sobre os clientes, enquanto a tabela "Pedidos" registra informações sobre os pedidos feitos por esses clientes.
Em ItensPedidos, você encontra as informações de quantidade vendida de cada produto e o preço unitário.

Seu desafio é criar uma consulta SQL que retorne o nome de cada cliente e o valor total dos pedidos que cada um deles comprou.
*/

select c.nome, sum(ip.preco_unitario)
from clientes c join pedidos p
on c.id = p.id_cliente
join itens_pedidos ip
on ip.id_pedido = p.id
group by c.nome;

--RESPOSTA FORNECIDA:
SELECT c.nome AS NomeCliente, SUM(ip.preco_unitario) AS SomaTotalPedidos
FROM clientes c
INNER JOIN pedidos p 
ON c.id = p.id_cliente
INNER JOIN itens_pedidos ip
On p.id = ip.id_pedido
GROUP BY c.Nome;
