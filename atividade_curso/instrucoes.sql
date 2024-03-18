-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS sistema_vendas;
USE sistema_vendas;
drop database sistema_vendas;
-- Tabela Categoria
CREATE TABLE IF NOT EXISTS Categoria (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR (100) NOT NULL,
    Descricao TEXT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT (1) DEFAULT 1
);

-- Tabela FormaPagamento
CREATE TABLE IF NOT EXISTS FormaPagamento (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1
);

-- Tabela Produto
CREATE TABLE IF NOT EXISTS Produto (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10,2) NOT NULL,
    CategoriaID INT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1,
    INDEX idx_nome (Nome), -- Adiciona indrice nas colunas Nome e Descricao
    CONSTRAINT fk_categoria_produto FOREIGN KEY (CategoriaID) REFERENCES Categoria(Id)
);

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Telefone VARCHAR(20),
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1,
    INDEX idx_nome (Nome)
);

-- Tabela Pedido
CREATE TABLE IF NOT EXISTS Pedido (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    DataPedido DATETIME,
    FormaPagamentoId INT,
    Status VARCHAR(50),
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    FOREIGN KEY (ClienteId) REFERENCES Cliente(Id),
    FOREIGN KEY (FormaPagamentoId) REFERENCES FormaPagamento(Id)
);

-- Tabela ItemPedido
CREATE TABLE IF NOT EXISTS ItemPedido (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    PedidoId INT,
    ProdutoId INT,
    Quantidade INT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    FOREIGN KEY (PedidoId) REFERENCES Pedido(Id),
    FOREIGN KEY (ProdutoId) REFERENCES Produto(Id)
);

-- Tabela GrupoUsuario
CREATE TABLE IF NOT EXISTS GrupoUsuario (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1
);

-- Tabela Permissao
CREATE TABLE IF NOT EXISTS Permissao (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    Ativo TINYINT(1) DEFAULT 1
);

-- Tabela PermissaoGrupo
CREATE TABLE IF NOT EXISTS PermissaoGrupo (
    PermissaoID INT,
    GrupoUsuarioID INT,
    PRIMARY KEY (PermissaoID, GrupoUsuarioID),
    FOREIGN KEY (PermissaoID) REFERENCES Permissao(Id),
    FOREIGN KEY (GrupoUsuarioID) REFERENCES GrupoUsuario(Id)
);

-- Tabela Usuario
CREATE TABLE IF NOT EXISTS Usuario (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    NomeUsuario VARCHAR(50) NOT NULL,
    Senha VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    GrupoUsuarioID INT,
    Ativo TINYINT(1) DEFAULT 1,
    DataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    DataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UsuarioAtualizacao INT,
    UNIQUE (NomeUsuario), -- Restrição UNIQUE na coluna NomeUsuario
    UNIQUE (Email), -- Restrição UNIQUE na coluna Email
    FOREIGN KEY (GrupoUsuarioID) REFERENCES GrupoUsuario(Id)
);

-- 0. Crie ao menos 5 registros para cada tabela, ignorando o gerenciamento de usuários. Um dos clientes deverá ter o seu nome

-- Inserts para a tabela Categoria
INSERT INTO Categoria (Nome, Descricao, UsuarioAtualizacao)
VALUES 
    ('Eletrônicos', 'Produtos eletrônicos diversos', 1),
    ('Roupas', 'Roupas masculinas e femininas', 1),
    ('Alimentos', 'Diversos tipos de alimentos', 1),
    ('Livros', 'Livros de diversos gêneros', 1),
    ('Acessórios', 'Acessórios para diversos fins', 1);

-- Inserts para a tabela FormaPagamento
INSERT INTO FormaPagamento (Nome, Descricao, UsuarioAtualizacao)
VALUES 
    ('Cartão de Crédito', 'Pagamento via cartão de crédito', 1),
    ('Dinheiro', 'Pagamento em dinheiro', 1),
    ('Transferência Bancária', 'Pagamento via transferência bancária', 1),
    ('Pix', 'Pagamento via Pix', 1),
    ('Boleto Bancário', 'Pagamento via boleto bancário', 1);

-- Inserts para a tabela Produto
INSERT INTO Produto (Nome, Descricao, Preco, CategoriaID, UsuarioAtualizacao)
VALUES 
    ('Smartphone', 'Telefone inteligente', 999.99, 1, 1),
    ('Camiseta', 'Camiseta casual', 29.99, 2, 1),
    ('Arroz', 'Arroz branco tipo 1', 5.99, 3, 1),
    ('1984', 'Livro de George Orwell', 19.99, 4, 1),
    ('Relógio', 'Relógio de pulso', 49.99, 5, 1);

-- Inserts para a tabela Cliente
INSERT INTO Cliente (Nome, Email, Telefone, UsuarioAtualizacao)
VALUES 
    ('João Silva', 'joao@example.com', '123456789', 1),
    ('Maria Souza', 'maria@example.com', '987654321', 1),
    ('Carlos Oliveira', 'carlos@example.com', '456789123', 1),
    ('Ana Santos', 'ana@example.com', '321654987', 1),
    ('Pedro Costa', 'pedro@example.com', '789123456', 1);

-- Inserts para a tabela Pedido
INSERT INTO Pedido (ClienteID, DataPedido, FormaPagamentoId, Status, UsuarioAtualizacao)
VALUES 
    (1, '2024-03-15 10:00:00', 1, 'Em processamento', 1),
    (2, '2024-03-15 11:00:00', 2, 'Pago', 1),
    (3, '2024-03-15 12:00:00', 3, 'Aguardando confirmação', 1),
    (4, '2024-03-15 13:00:00', 4, 'Enviado', 1),
    (5, '2024-03-15 14:00:00', 5, 'Entregue', 1);

-- Inserts para a tabela ItemPedido
INSERT INTO ItemPedido (PedidoId, ProdutoId, Quantidade, UsuarioAtualizacao)
VALUES 
    (1, 1, 2, 1),
    (2, 3, 1, 1),
    (3, 5, 3, 1),
    (4, 2, 2, 1),
    (5, 4, 1, 1);

-- 0. Crie ao menos 5 registros para cada tabela, ignorando o gerneciamento de usuários. Um dos clientes deverá ter o seu nome

-- Inserts para a tabela Categoria
INSERT INTO Categoria (Nome, Descricao, UsuarioAtualizacao)
VALUES 
    ('Eletrônicos', 'Produtos eletrônicos diversos', 1),
    ('Roupas', 'Roupas masculinas e femininas', 1),
    ('Alimentos', 'Diversos tipos de alimentos', 1),
    ('Livros', 'Livros de diversos gêneros', 1),
    ('Acessórios', 'Acessórios para diversos fins', 1);

-- Inserts para a tabela FormaPagamento
INSERT INTO FormaPagamento (Nome, Descricao, UsuarioAtualizacao)
VALUES 
    ('Cartão de Crédito', 'Pagamento via cartão de crédito', 1),
    ('Dinheiro', 'Pagamento em dinheiro', 1),
    ('Transferência Bancária', 'Pagamento via transferência bancária', 1),
    ('Pix', 'Pagamento via Pix', 1),
    ('Boleto Bancário', 'Pagamento via boleto bancário', 1);

-- Inserts para a tabela Produto
INSERT INTO Produto (Nome, Descricao, Preco, CategoriaID, UsuarioAtualizacao)
VALUES 
    ('Smartphone', 'Telefone inteligente', 999.99, 1, 1),
    ('Camiseta', 'Camiseta casual', 29.99, 2, 1),
    ('Arroz', 'Arroz branco tipo 1', 5.99, 3, 1),
    ('1984', 'Livro de George Orwell', 19.99, 4, 1),
    ('Relógio', 'Relógio de pulso', 49.99, 5, 1);

-- Inserts para a tabela Cliente
INSERT INTO Cliente (Nome, Email, Telefone, UsuarioAtualizacao)
VALUES 
    ('João Silva', 'joao@example.com', '123456789', 1),
    ('Maria Souza', 'maria@example.com', '987654321', 1),
    ('Carlos Oliveira', 'carlos@example.com', '456789123', 1),
    ('Ana Santos', 'ana@example.com', '321654987', 1),
    ('Pedro Costa', 'pedro@example.com', '789123456', 1);

-- Inserts para a tabela Pedido
INSERT INTO Pedido (ClienteID, DataPedido, FormaPagamentoId, Status, UsuarioAtualizacao)
VALUES 
    (1, '2024-03-15 10:00:00', 1, 'Em processamento', 1),
    (2, '2024-03-15 11:00:00', 2, 'Pago', 1),
    (3, '2024-03-15 12:00:00', 3, 'Aguardando confirmação', 1),
    (4, '2024-03-15 13:00:00', 4, 'Enviado', 1),
    (5, '2024-03-15 14:00:00', 5, 'Entregue', 1);

-- Inserts para a tabela ItemPedido
INSERT INTO ItemPedido (PedidoId, ProdutoId, Quantidade, UsuarioAtualizacao)
VALUES 
    (1, 1, 2, 1),
    (2, 3, 1, 1),
    (3, 5, 3, 1),
    (4, 2, 2, 1),
    (5, 4, 1, 1);

-- 1. Atualizar o nome de um cliente:

UPDATE Cliente
SET Nome = 'Junin do Pneu'
WHERE ID = 1;

-- 2. Deletar um produto:

DELETE FROM produto
WHERE ID = 2;

-- 3. Alterar a categoria de um produto:

UPDATE Produto
SET CategoriaID = 2
WHERE ID = 1;

-- 4. Inserir um novo cliente:

INSERT INTO cliente (Nome, Email, Telefone, UsuarioAtualizacao)
VALUES ('Novo Cliente', 'cliente@mail.com', '40028922', 1);

-- 5. Inserir um novo pedido:

INSERT INTO PEDIDO (ClienteID, DataPedido, FormaPagamentoId, Status, UsuarioAtualizacao)
VALUES (5, '2024-03-15 14:00:00', 5, 'Entregue', 1);

-- 6. Atualizar o preço de um produto:

UPDATE Produto
SET Preco = 59.99
WHERE ID = 3;

-- DQL - Sem Joins
-- 1. Selecione todos os registros da tabela Produto:

SELECT * FROM Produto;  

-- 2. Selecione apenas o nome e o preço dos produtos da tabela Produto:

SELECT Nome, Preco FROM Produto;

-- 3. Selecione os produtos da tabela Produto ordenados por preço, do mais barato para o mais caro:

SELECT * FROM Produto ORDER BY Preco ASC;

-- 4. Selecione os produtos da tabela Produto ordenados por preço, do mais caro para o mais barato:

SELECT * FROM Produto ORDER BY Preco DESC;

-- 5. Selecione os nomes distintos das categorias da tabela Categoria:

SELECT DISTINCT Nome FROM Categoria;

-- 6. Selecione os produtos da tabela Produto cujo preço esteja entre $10 e $50:

SELECT * FROM Produto WHERE Preco BETWEEN 10 AND 50;

-- 7. Selecione os produtos da tabela Produto, mostrando o nome como "Nome do Produto" e o preço como "Preço Unitário":

SELECT Nome AS "Nome do Produto", Preco AS "Preço Unitário" FROM Produto;

-- 8. Selecione os produtos da tabela Produto, adicionando uma coluna calculada "Preço Total" multiplicando a quantidade pelo preço:

SELECT *, Quantidade * Preco AS "Preço Total" FROM ItemPedido;

-- 9. Selecione os produtos da tabela Produto, mostrando apenas os 10 primeiros registros:

SELECT * FROM Produto LIMIT 10;

-- 10. Selecione os produtos da tabela Produto, pulando os primeiros 5 registros e mostrando os 10 seguintes:

SELECT * FROM Produto LIMIT 5, 10;

