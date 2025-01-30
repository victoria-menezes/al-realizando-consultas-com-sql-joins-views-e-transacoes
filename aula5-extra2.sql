/* 
ESSE EXERCICIO UTILIZA A DATABASE AtividadeEscola.db

Contexto

Agora, vamos avançar na exploração do nosso banco de dados,
abordando consultas mais complexas e avançadas que envolvem subconsultas, JOIN, views.
Essas técnicas são poderosas e podem ser úteis para lidar com requisitos complexos em sistemas de gerenciamento escolar.*/



-- Consulta 1: Buscar o nome do professor e a turma que ele é orientador
select pr.Nome_Professor, t.Nome_Turma
from Professores pr inner join Turmas t
on pr.ID_Professor = t.ID_Professor_Orientador;

-- SOLUCAO FORNECIDA:
SELECT 	nome_professor, nome_turma 
FROM Professores P 
JOIN Turmas T ON P.ID_Professor = T.ID_Professor_Orientador;


-- Consulta 2: Retornar o nome e a nota do aluno que possui a melhor nota na disciplina de Matemática
select a.Nome_Aluno, n.Nota as maior_nota
from Alunos a inner join Notas n on a.ID_Aluno = n.ID_Aluno
inner join Disciplinas d on n.ID_Disciplina = d.ID_Disciplina
where d.Nome_Disciplina = 'Matemática'
order by n.Nota desc
limit 1;

-- SOLUCAO FORNECIDA:
SELECT nome_aluno, MAX(nota)  as maior_nota
FROM Alunos A
JOIN Notas N ON A.ID_Aluno = N.ID_Aluno
JOIN Disciplinas D ON D.ID_Disciplina = N.ID_Disciplina 
WHERE N.ID_Disciplina = 1;


-- Consulta 3: Identificar o total de alunos por turma
select t.nome_turma, count(ta.ID_Aluno)
from Turma_Alunos ta inner join Turmas t
on ta.ID_Turma = t.ID_Turma
group by t.nome_turma
order by t.ID_Turma asc;

-- SOLUCAO FORNECIDA:
SELECT nome_turma, COUNT(TA.ID_Turma) Total_alunos_turma
FROM Turmas T
JOIN Turma_Alunos TA
ON T.ID_Turma = TA.ID_Turma
GROUP BY nome_turma;


-- Consulta 4: Listar os Alunos e as disciplinas em que estão matriculados
select a.Nome_Aluno, d.Nome_Disciplina
from Alunos a inner join Turma_Alunos ta
on a.ID_Aluno = ta.ID_Aluno
inner join Turma_Disciplinas td
on td.ID_Turma = ta.ID_Turma
inner join Disciplinas d
on td.ID_Disciplina = d.ID_Disciplina
order by a.Nome_Aluno;

-- SOLUCAO FORNECIDA:
SELECT A.Nome_Aluno, D.Nome_Disciplina
from Alunos A 
join Turma_Alunos TA on A.ID_Aluno = TA.ID_Aluno
join Turma_Disciplinas TD on TA.ID_Turma = TD.ID_Turma
join Disciplinas D ON D.ID_Disciplina = TD.ID_Disciplina;


-- Consulta 5: Criar uma view que apresenta o nome, a disciplina e a nota dos alunos */
create view vw_aluno_disciplna_nota as
select a.Nome_Aluno, d.Nome_Disciplina, n.Nota
from Alunos a inner join Notas n
on a.ID_Aluno = n.ID_Aluno
inner join Disciplinas d
on n.ID_Disciplina = d.ID_Disciplina
order by a.Nome_Aluno;

-- SOLUCAO FORNECIDA:
CREATE VIEW AlunosDisciplinaNota AS
SELECT nome_aluno, nome_disciplina, nota 
FROM Alunos A
JOIN Notas N
ON A.ID_Aluno = N.ID_Aluno
Join Disciplinas D
On N.ID_Disciplina = D.ID_Disciplina
order by A.Nome_Aluno;