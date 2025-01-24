/* Você é um professor e deseja identificar o aluno que obteve a maior nota em sua disciplina. Você tem duas tabelas em seu banco de dados: "Alunos" e "Notas".
A tabela "Notas" registra as notas dos alunos em sua disciplina. Seu desafio é encontrar o aluno com a maior nota.

Tabela "Alunos":
    ID_aluno (chave primária)
    Nome
    Curso

Tabela "Notas":
    ID_nota (chave primária)
    ID_aluno (chave estrangeira)
    Nota

Seu desafio é criar uma consulta SQL que retorne o nome do aluno que obteve a maior nota em sua disciplina.
*/

select * from Alunos where ID_aluno =
(select ID_aluno from Notas
ORDER BY Nota DESC LIMIT 1);

-- OU:
select *
FROM Alunos
where ID_aluno =
(SELECT ID_aluno
 from Notas
 where Nota =
 	(SELECT MAX(Nota)
     from Notas)
)