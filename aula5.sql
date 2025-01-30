-- 01. Atualizar dados
-- ATENCAO: SQLiteOnline nao valida chave estrangeiras por default

-- para mudar essa configuracao no SQLite (evita apagar um registro que e referenciado como foreign key em outra tabela):
pragma foreign_keys = on;

select * from produtos where id = 31;
update produtos set preco = 13.0 where id = 31;

select * from produtos where lower(nome) like '%croissant%';
update produtos set descricao = 'Croissant recheado com amendoas' where id = 28

-- 02. Excluir dados
select * from colaboradores where id = 3;
delete from colaboradores where id = 3;

select * from clientes where id = 27;
-- so funcionara se na criacao das tabelas relacionadas, foi utilizada o ON DELETE CASCADE
delete from clientes where id = 27;


-- 03. Checar se todos os comandos vao ser executados corretamente antes de dar o commit
begin TRANSACTION;
update pedidos set status = 'Concluído' where status = 'Em Andamento';
select * from pedidos;

rollback; -- Volta para o ponto do Begin Transaction

commit; -- Acoes da transacao sao aplicadas ao banco de dados