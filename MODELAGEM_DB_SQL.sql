-- =========================== CRIANDO O SCHEMA ===========================
CREATE SCHEMA BIBLIOTECA;

-- =========================== CRIANDO AS TABELAS =========================
CREATE TABLE LIVROS(
    ID_LIVRO INT NOT NULL,
    NOME_LIVRO VARCHAR(100) NOT NULL,
    AUTORIA VARCHAR(100) NOT NULL,
    EDITORA VARCHAR(100) NOT NULL,
    CATEGORIA VARCHAR(100) NOT NULL,
    PRECO DECIMAL(5, 2) NOT NULL,

    PRIMARY KEY (ID_LIVRO)
);

CREATE TABLE ESTOQUE (
    ID_LIVRO INT NOT NULL,
    QTD_ESTOQUE INT NOT NULL,
 
    PRIMARY KEY (ID_LIVRO)
);


CREATE TABLE VENDAS (
    ID_PEDIDO INT NOT NULL,
    ID_VENDEDOR INT NOT NULL,
    ID_LIVRO INT NOT NULL,
    QTD_VENDIDA INT NOT NULL,
    DATA_VENDA DATE NOT NULL,

    PRIMARY KEY (ID_VENDEDOR,ID_PEDIDO)
);


CREATE TABLE VENDEDORES (
    ID_VENDEDOR INT NOT NULL,
    NOME_VENDEDOR VARCHAR(255) NOT NULL,

    PRIMARY KEY (ID_VENDEDOR)
);

-- ======================================================
-- ALTERANDO AS TABELAS PARA ADICIONAR UMA CHAVE ESTRANGEIRA
-- criando uma restricao e adicionando a chave
ALTER TABLE ESTOQUEA ADD CONSTRAINT CE_ESTOQUE_LIVROS;
FOREIGN KEY (ID_LIVRO);
REFERENCES LIVROS (ID_LIVRO);
-- GERANDO UM ERRO SEMPRE QUE ALTERAR UM LIVRO QUE ESTA 
-- NA TABELA ESTOQUE MAS NÃO ESTIVER NA TABELA LIVROS
ON DELETE NO ACTION;
ON UPDATE NO ACTION;

-- =========================== INSERINDO DADOS ===========================
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO LIVROS VALUES(
    1,
    "Percy Jackson",
    "Rick Riordan",
    "Intrinseca",
    "Aventura",
    34.65
);

-- =========================== INSERINDO DIVERSOS DADOS EM UM UNICO COMANDO ===========================

INSERT INTO LIVROS VALUES
(2, 'A Volta ao Mundo em 80 Dias', 'Júlio Verne', 'Principis', 'Aventura', 21.99),
(3, 'O Cortiço', 'Aluísio de Azevedo', 'Panda Books', 'Romance', 47.8),
(4, 'Dom Casmurro', 'Machado de Assis', 'Via Leitura', 'Romance', 19.90),
(5, 'Memórias Póstumas de Brás Cubas', 'Machado de Assis', 'Antofágica', 'Romance', 45),
(6, 'Quincas Borba', 'Machado de Assis', 'L&PM Editores', 'Romance', 48.5),
(7, 'Ícaro', 'Gabriel Pedrosa', 'Ateliê', 'Poesia', 36),
(8, 'Os Lusíadas', 'Luís Vaz de Camões',  'Montecristo', 'Poesia', 18.79),
(9, 'Outros Jeitos de Usar a Boca', 'Rupi Kaur', 'Planeta', 'Poesia', 34.8);


INSERT INTO VENDEDORES VALUES
(1,'Paula Rabelo'),
(2,'Juliana Macedo'),
(3,'Roberto Barros'),
(4,'Barbara Jales');

INSERT INTO VENDAS VALUES 
(1, 3, 7, 1, '2020-11-02'),
(2, 4, 8, 2, '2020-11-02'),
(3, 4, 4, 3, '2020-11-02'),
(4, 1, 7, 1, '2020-11-03'),
(5, 1, 6, 3, '2020-11-03'),
(6, 1, 9, 2, '2020-11-04'),
(7, 4, 1, 3, '2020-11-04'),
(8, 1, 5, 2, '2020-11-05'),
(9, 1, 2, 1, '2020-11-05'),
(10, 3, 8, 2, '2020-11-11'),
(11, 1, 1, 4, '2020-11-11'),
(12, 2, 10, 10, '2020-11-11'),
(13, 1, 12, 5, '2020-11-18'),
(14, 2, 4, 1, '2020-11-25'),
(15, 3, 13, 2,'2021-01-05'),
(16, 4, 13, 1, '2021-01-05'),
(17, 4, 4, 3, '2021-01-06'),
(18, 2, 12, 2, '2021-01-06');

INSERT INTO ESTOQUE VALUES
(1,  7),
(2,  10),
(3,  2),
(8,  4),
(10, 5),
(11, 3),
(12, 3);

-- =========================== INSERINDO DADOS EM ORDEM ESPECIFICADA ===========================
INSERT INTO LIVROS (CATEGORIA, AUTORIA, NOME_LIVRO, EDITORA, ID_LIVRO, PREÇO)
VALUES
('Biografia', 'Malala Yousafzai', 'Eu sou Malala', 'Companhia das Letras', 11, 22.32),
('Biografia', 'Michelle Obama', 'Minha história', 'Objetiva',12, 57.90),
('Biografia', 'Anne Frank', 'Diário de Anne Frank', 'Pe Da Letra', 13, 34.90);

-- =========================== SELEÇÃO DE DADOS ===========================
SELECT * FROM LIVROS;

SELECT NOME_LIVRO FROM LIVROS;

SELECT ID_LIVRO AS "Cod do Livro" FROM LIVROS;

-- =========================== FILTROS ===========================

-- AND, NOT, OR, >, <, <> (diferente), 
SELECT * FROM LIVROS
WHERE CATEGORIA = 'BIOGRAFIA';

SELECT * FROM LIVROS
WHERE CATEGORIA = 'ROMANCE' AND PRECO > 50;

-- REMOVENDO DUPLICADOS E ORDENANDO EM ORDEM CRESCENTE
SELECT DISTINCT ID_LIVRO FROM VENDAS
WHERE ID_VENDEDOR = 1
ORDER BY ID_LIVRO;

-- =========================== REMOCAO DE LINHAS ===========================

DELETE FROM LIVROS WHERE ID_LIVRO = 8;

-- =========================== ALTERACAO DE VALORES ===========================

UPDATE LIVROS SET PRECO = 0.9*PRECO;

-- =========================== FILTROS MULTI-TABELAS ===========================

SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, VENDAS.QTD_VENDIDA
FROM VEMDAS, VENDEDORES

-- SOMATORIA DE LIVROS VENDIDOS / AGRUPAMENTO P SOMA
SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, SUM(VENDAS.QTD_VENDIDA)
FROM VEMDAS, VENDEDORES
WHERE VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR
GROUP BY VENDAS.ID_VENDEDOR;

-- =========================== UNIAO DE TABELAS ===========================

-- inner: somente o que estão em ambas as tabelas
-- left: inclui na tabela da esquerda o que há de igual na tabela da direita
-- right: inclui na tabela da direita o que há de igual na tabela da esquerda
-- outer: mantem somente os exclusivos de cada tabela
-- cross: produto cartesiano (todas as possiblidades de combinações) das linhas de uma tabela com a outra

SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, SUM(VENDAS.QTD_VENDIDA)
FROM VEMDAS INNER JOIN VENDEDORES
ON VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR
GROUP BY VENDAS.ID_VENDEDOR; 

SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR
FROM VEMDAS LEFT JOIN VENDEDORES
ON VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR
WHERE VENDAS.QTD_VENDIDA IS NULL;

-- =====================================================================
-- =====================================================================
-- PARA OS TRECHOS ABAIXO, ASSUMA QUE ESTAMOS EM OUTRO PROJETO
-- A TABELA "tabelapedidos" FOI IMPORTADA DE UM ARQUIVO PARA O SQLITE

-- =========================== INSERINDO VALORES COM SELECT ===========================
CREATE TABLE tabelapedidosgold (
    ID_pedido_gold INT PRIMARY KEY,
    Data_Do_Pedido_gold DATE,
    Status_gold VARCHAR(50),
    Total_Do_Pedido_gold DECIMAL(10, 2),
    Cliente_gold INT,
    Data_De_Envio_Estimada_gold DATE,
    FOREIGN KEY (cliente_gold) REFERENCES tabelaclientes(id_cliente)
); 

INSERT INTO tabelapedidosgold(ID_pedido_gold,
                              Data_Do_Pedido_gold,
                              Status_gold,
                              Total_Do_Pedido_gold,
                              cliente_gold,
                              Data_De_Envio_Estimada_gold)
SELECT id, data_do_pedido, status, total_do_pedido, cliente, data_de_envio_estimada
FROM tabelapedidos
WHERE total_do_pedido >= 400;

-- =========================== FILTRO LIKE ===========================
-- BUSCA TODOS OS CURSOS QUE INICIAM COM "Ciência"
SELECT * FROM Treinamento
WHERE curso LIKE "Ciência %";

-- =========================== CONDICAO IN ===========================
-- TRÁS TODAS AS INFORMAÇÕES DOS CURSOS EM UMA LISTA 
SELECT * FROM Treinamento
WHERE curso IN ('Ciência da Computação', 'Engenharia de Materiais', 'Engenharia Biomédica', 'Matemática Computacional')

-- =========================== AGG FUNCS ===========================
SELECT mes, MAX(faturamento_bruto) FROM faturamento;

SELECT mes, MIN(faturamento_bruto) FROM faturamento;

SELECT AVG(despesas) FROM faturamento;

SELECT COUNT(*) FROM HistoricoEmprego
WHERE datatermino NOT NULL;

-- =========================== HAVING ===========================
-- COMO WHERE FUNCIONA SOMENTE PARA REGISTROS UNICOS, ENTÃO, PARA AGRUPAMENTOS, PODEMOS USAR HAVING:
SELECT instituicao, COUNT(curso)
FROM Treinamento
GROUP BY instituicao
HAVING COUNT(curso) > 2;

-- =========================== REMOCAO DE ESPAÇOS DO INICIO E FIM DE STRINGS ===========================
SELECT TRIM(nome) FROM tabela;

-- =========================== REPLACE ===========================
SELECT REPLACE(saudacao, 'hello', 'hi') FROM tabela;

-- =========================== CONSULTA DE DATAS ===========================
SELECT id_colaborador, STRFTIME('%Y/%m', data_inicio) FROM Licencas;

-- DIFERENÇA ENTRE DATAS
SELECT id_colaborador, JULIANDAY(datatermino) - JULIANDAY(datacontratacao) FROM HistoricoEmprego
WHERE datatermino IS NOT NULL;

-- RETORNAR A DATA ATUAL - O MESMO É VALIDO PARA TIME e DATETIME
SELECT DATE('now');
-- RETORNA 10 DIAS ATRÁS
SELECT DATE('now', '-10 days');

-- =========================== CONSULTAS NUMÉRICAS ===========================
-- ARREDONDANDO COM DUAS CASA DECIMAIS
SELECT AVG(faturamento_bruto), ROUND(AVG(faturamento_bruto), 2) FROM faturamento;

-- ARREDONDAMENTO PRA CIMA OU PARA BAIXO
SELECT CEIL(faturamento_bruto), CEIL(despesas) FROM faturamento;
SELECT FLOOR(faturamento_bruto), FLOOR(despesas) FROM faturamento;

-- ELEVAR NUMEROS A POTENCIA
SELECT POWER(2, 3); -- 2^3 = 8
SELECT SQRT(16); -- Raiz de 16
SELECT ABS(-5); -- Retorna o absoluto no caso de -5 seria 5

-- =========================== CONVERSÃO DE TIPO DE DADO ===========================
SELECT('O faturamento bruto médio foi ' || CAST(ROUND(AVG(faturamento_bruto), 2) AS TEXT))
FROM faturamento;

-- =========================== EXPRESSAO CASE ===========================
SELECT id_colaborador, cargo, salario,
CASE
    WHEN salario < 3000 THEN 'Baixo'
    WHEN salario BETWEEN 3000 AND 6000 THEN 'Médio'
    ELSE 'Alto'
END AS categoria_salario
FROM HistoricoEmprego;

-- =========================== RENAME ===========================
ALTER TABLE HistoricoEmprego RENAME TO CargosColaboradores;

-- =======================================================================================================
-- ====================== A PARTIR DE AGORA, SERÁ UTILIZADO NOMEMCLATURA GERAL ===========================
-- =======================================================================================================

-- =========================== OPERADORES INTER TABELAS ===========================
-- RETORNA APENAS REGISTROS DISTINTOS ENTRE AS TABELAS
SELECT coluna1, coluna2, coluna3 FROM tabela1
UNION
SELECT coluna1, coluna2, coluna3 FROM tabela2

-- RETORNA TODOS OS REGISTROS MESMO QUE ESTEJAM REPETIDOS ENTRE AS TABELAS
SELECT coluna1, coluna2, coluna3 FROM tabela1
UNION ALL
SELECT coluna1, coluna2, coluna3 FROM tabela2

-- RETORNA TODAS AS LINHAS PRESENTES NA TABELA 1, AUSENTES NA TABELA2
SELECT * FROM tabela1
EXCEPT
SELECT * FROM tabela2;

-- RETORNA TODAS AS LINHAS PRESENTES NA TABELA 1 E NA TABELA 2 AO MESMO TEMPO
SELECT * FROM tabela1
INTERSECT
SELECT * FROM tabela2;

-- =========================== SUBCONSULTAS ===========================
SELECT coluna1, coluna2 FROM tabela1 WHERE coluna1 = (SELECT coluna1 FROM tabela2 WHERE coluna2 = 1)
SELECT coluna1, coluna2 FROM tabela1 WHERE coluna1 IN (SELECT coluna1 FROM tabela2 WHERE coluna2 = 1)

-- =========================== VIEWS ===========================
CREATE VIEW viewCurso AS 
SELECT coluna3, coluna4 FROM tabela1

-- =========================== TRIGGER ===========================
CREATE TRIGGER triggerCurso
AFTER INSERT ON tabela1
FOR EACH ROW
BEGIN
    DELETE FROM tabela3;
    INSERT INTO tabela3 (coluna3, coluna4)
    SELECT coluna3, coluna4 FROM tabela3
END;

-- =========================== TRANSAÇÕES ===========================
-- CAMADA DE SEGURANÇA PARA ROLLBACK CASO HAJA PROBLEMAS
-- EXECUTAR LINHA A LINHA
BEGIN TRANSACTION; -- START TRANSACTION tem o mesmo efeito

UPDATE tabela1 SET coluna1 = 'TESTE'

SELECT coluna1 FROM tabela1 -- APOS VERIFICAR SE O VALOR FOI ATUALIZADO CORRETAMENTE:

-- CASO HAJA PROBLEMAS:
ROLLBACK;

-- CASO A ALTERAÇÃO TENHA SIDO FEITA DE MANEIRA CORRETA?
COMMIT;

-- ===================================================================