CREATE TABLE IF NOT EXISTS clientes(
    idcliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome CHAR(100) NOT NULL,
    status INT(1) NOT NULL DEFAULT 1,
    --0 apagado, 1 ativado, 2 suspenso
    nota TEXT,
    --caso seja suspenso pode colocar o motivo aqui
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dateupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Cadastramos os clientes
INSERT INTO
    clientes(nome)
VALUES
    ('Isael Rolim Castelo Branco'),
    ('Debora Cabeça Marinho'),
    ('Emanuelle Vaz Caçoilo'),
    ('Alonso Graça Raposo'),
    ('Carlos Gameiro Carromeu');

CREATE TABLE IF NOT EXISTS atendentes(
    idatendente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome CHAR(100) NOT NULL,
    status INT(1) NOT NULL DEFAULT 1,
    --0 apagado, 1 ativado, 2 suspenso, 3 demitido
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dateupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO
    atendentes (nome)
VALUES
    ('Frederico Fortes Valadim'),
    ('Katerina Aveiro Lobo'),
    ('Yannick Padilha Beltrão');

CREATE TABLE IF NOT EXISTS mesas(
    idmesa INTEGER PRIMARY KEY AUTOINCREMENT,
    numcadeiras INT(3),
    --quantas cadeiras a mesa tem
    status INT(1) NOT NULL DEFAULT 1,
    --0 apagado, 1 ativado, 2 suspenso
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dateupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Cadastramos as mesas
ALTER TABLE
    mesas
ADD
    vip INT(1) NOT NULL DEFAULT 0;

--para diferenciar as mesas que sao VIP -0 nao e vip, 1 e vip
INSERT INTO
    mesas(numcadeiras)
VALUES
    (2),
    (4);

INSERT INTO
    mesas(numcadeiras, vip)
VALUES
    (8, 1);

CREATE TABLE IF NOT EXISTS reservas(
    idreserva INTEGER PRIMARY KEY AUTOINCREMENT,
    adicionalmesa INT(3) DEFAULT 0,
    --numero de mesas adicionais na reserva
    adicionalcadeira INT(3) DEFAULT 0,
    --numero de cadeiras adicionais na reserva
    nota TEXT,
    --caso o cliente tenha deixado uma nota sobre a reserva
    status INT(1) NOT NULL DEFAULT 1,
    --0 apagado, 1 ativado, 2 cancelado
    dateinicio TIMESTAMP NOT NULL,
    --foi reservado para qual data
    datefin TIMESTAMP NOT NULL,
    --foi resrvado por quanto tempo
    idcliente INTEGER,
    idatendente INTEGER,
    idmesa INTEGER,
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dateupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(idcliente) REFERENCES clientes(idcliente),
    FOREIGN KEY(idatendente) REFERENCES atendentes(idatendente),
    FOREIGN KEY(idmesa) REFERENCES mesas(idmesa)
);

CREATE TABLE IF NOT EXISTS pedidos(
    idpedido INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo CHAR(20) NOT NULL,
    status INT(1) NOT NULL DEFAULT 1,
    --0 Cancelado, 1 Activo, 2 Pausado, 3 Apagado,
    idcliente INTEGER,
    idreserva INTEGER,
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dataupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(idcliente) REFERENCES clientes(idcliente),
    FOREIGN KEY(idreserva) REFERENCES reservas(idreserva)
);

CREATE TABLE IF NOT EXISTS cardapios(
    idcardapio INTEGER PRIMARY KEY AUTOINCREMENT,
    nome CHAR(50) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    status INT(1) NOT NULL DEFAULT 1,
    --0 apagado, 1 ativado, 2 suspenso
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dataupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Cadastramos os cardapios
INSERT INTO
    cardapios(idcardapio, nome, valor)
VALUES
    (1, 'X-BURGER', 11.50),
    (2, 'X-SALADA', 12.50),
    (3, 'X-BACON', 13.00),
    (4, 'X-EGG', 13.50),
    (5, 'X-FRANGO', 13.50),
    (6, 'X-TUDO', 14.50),
    (7, 'XE-TUDO DE FRANGO', 14.50);

CREATE TABLE IF NOT EXISTS ingredientes(
    idingrediente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome CHAR(100) NOT NULL,
    descricao VARCHAR(200),
    status INT(1) NOT NULL DEFAULT 1,
    --0 apagado, 1 ativado, 2 suspenso
    datacreate TIMESTAMP DEFAULT CURRENT_TIMASTAMP,
    dateupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMPP
);

--Cadastramos os Ingredientes
INSERT INTO
    ingredientes(idingrediente, nome)
VALUES
    (1, 'Pão de hambúrguer'),
    (2, 'hambúrguer'),
    (3, 'queijo'),
    (4, 'milho'),
    (5, 'alface'),
    (6, 'bacon'),
    (7, 'maionese'),
    (8, 'ovo'),
    (9, 'tomate'),
    (10, 'filé de frango'),
    (11, 'batata palha'),
    (12, 'presunto'),
    (13, 'salsicha');

CREATE TABLE IF NOT EXISTS cardapios_ingredientes(
    idcardapioingrediente INTEGER PRIMARY KEY AUTOINCREMENT,
    idcardapio INTEGER,
    idingrediente INTEGER,
    datacreate TIMESTAMP DEFAULT CURRENT_TIMASTAMP,
    dateupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMPP,
    FOREIGN KEY(idingrediente) REFERENCES ingredientes(idingrediente),
    FOREIGN KEY(idcardapio) REFERENCES cardapios(idcardapio)
);

--Registramos os ingredientes dos cardapios
INSERT INTO
    cardapios_ingredientes(idcardapio, idingrediente)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (2, 5),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 6),
    (3, 5),
    (3, 7),
    (4, 1),
    (4, 2),
    (4, 3),
    (4, 8),
    (4, 5),
    (4, 7),
    (4, 9),
    (5, 1),
    (5, 10),
    (5, 5),
    (5, 9),
    (5, 4),
    (5, 11),
    (5, 7),
    (5, 12),
    (5, 3),
    (6, 1),
    (6, 2),
    (6, 13),
    (6, 3),
    (6, 4),
    (6, 11),
    (6, 8),
    (6, 5),
    (6, 9),
    (7, 1),
    (7, 2),
    (7, 13),
    (7, 3),
    (7, 4),
    (7, 11),
    (7, 8),
    (7, 5),
    (7, 9);

CREATE TABLE IF NOT EXISTS pedidos_cardapios(
    idpedidocardapio INTEGER PRIMARY KEY AUTOINCREMENT,
    quantia INT NOT NULL,
    nota TEXT,
    --caso deseja tirar algun ingrediente do cardapio no pedido
    ordem INTEGER NOT NULL DEFAULT 0,
    idcardapio INTEGER,
    idpedido INTEGER,
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dataupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(idcardapio) REFERENCES cardapios(idcardapio),
    FOREIGN KEY(idpedido) REFERENCES pedidos(idpedido)
);

CREATE TABLE IF NOT EXISTS produtos(
    idproduto INTEGER PRIMARY KEY AUTOINCREMENT,
    descricao VARCHAR(200),
    valor DECIMAL(10, 2) NOT NULL,
    status INT(1) NOT NULL DEFAULT 1,
    --0 apagado, 1 ativado, 2 suspenso
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dataupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Cadastramos os produtos e  asbebidas
INSERT INTO
    produtos (descricao, valor)
VALUES
    ('Refrigerante Lata Coca-Cola 600ml', 4.00),
    ('Refrigerante Lata FANTA 600ml', 5.00),
    ('Refrigerante 1 litro Coca-Cola', 7.00);

CREATE TABLE IF NOT EXISTS pedidos_produtos(
    idpedidoproduto INTEGER PRIMARY KEY AUTOINCREMENT,
    quantia INT NOT NULL,
    ordem INTEGER NOT NULL DEFAULT 0,
    idproduto INTEGER,
    idpedido INTEGER,
    datacreate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dataupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(idproduto) REFERENCES produtos(idproduto),
    FOREIGN KEY(idpedido) REFERENCES pedidos(idpedido)
);

-- Reservamos uma mesa para Isael Rolim Castelo Branco
INSERT INTO
    reservas(
        idreserva,
        nota,
        dateinicio,
        datefin,
        idcliente,
        idatendente,
        idmesa
    )
VALUES
    (
        1,
        'O cliente avisou que seu filho é cego, traz uma folha do cardápio com letras em braille',
        datetime('now', '+6 hours'),
        datetime('now', '+8 hours'),
        1,
        1,
        2
    );

-- Vamos supor que o cliente chegou e faz este pedido
-- Cadastramos o pedido
INSERT INTO
    pedidos (idpedido, codigo, idcliente, idreserva)
VALUES
    (1, ABS(RANDOM()), 1, 1);

-- Cadastramos os detalhes ou items desse pedido
INSERT INTO
    pedidos_cardapios (quantia, nota, ordem, idcardapio, idpedido)
VALUES
    (
        5,
        'Apenas um X-BURGER sem queijo para meu filho.',
        1,
        1,
        1
    );

INSERT INTO
    pedidos_produtos (ordem, quantia, idproduto, idpedido)
VALUES
    (2, 1, 3, 1),
    (3, 2, 2, 1),
    (4, 1, 1, 1);


-- 1.- ver os clienets cadastrados
SELECT 'ver os clienets cadastrados';
SELECT
    idcliente,
    nome,
    status
FROM
    clientes;

-- 2.- ver os atendentes cadastrados
SELECT
    idatendente,
    nome
FROM
    atendentes;

SELECT
    datetime('now'),
    datetime('now', '+2 hours');

-- 3.- Ver os cardapios de hoje que estao ativos
SELECT
    idcardapio,
    nome,
    valor
FROM
    cardapios
WHERE
    status = 1;

--- 4.- veja os produtos disponíveis bebidas, etc...
SELECT
    idproduto,
    descricao,
    valor
FROM
    produtos;

--- 5.- Ingredientes do primeiro cardápio
SELECT
    'CARDAPIO :' AS '',
    nome
FROM
    cardapios
WHERE
    idcardapio = 1
UNION
ALL
SELECT
    '          ' AS '',
    ing.nome
FROM
    cardapios ca
    LEFT JOIN cardapios_ingredientes cain ON ca.idcardapio = cain.idcardapio
    LEFT JOIN ingredientes ing ON cain.idingrediente = ing.idingrediente
WHERE
    ca.idcardapio = 1;

-- 6.- ver as reservas ativas 
SELECT
    idreserva,
    adicionalmesa,
    adicionalcadeira,
    re.nota AS 'Nota Reserva',
    re.status AS 'Status Reserva',
    dateinicio AS 'Entra na mesa',
    datefin AS 'Sai da mesa',
    cl.nome AS 'Nome do Cliente',
    at.nome AS 'Nome do Atendente',
    idmesa,
    (
        (
            strftime('%s', datefin) - strftime('%s', dateinicio)
        ) / 3600
    ) || ' Horas' AS 'Quanto Tempo'
FROM
    reservas re
    JOIN clientes cl ON re.idcliente = cl.idcliente
    JOIN atendentes at ON re.idatendente = at.idatendente
WHERE
    re.status = 1;

-- 7.- Ver os pedidos en andamento e a qual mesa pertece
SELECT
    pe.codigo AS 'Codigo de Barra',
    (
        CASE
            WHEN pe.status = 1 THEN 'En Andamento'
            ELSE 'Pedido Executado'
        END
    ) AS 'Status',
    (
        SELECT
            cl.nome
        FROM
            clientes cl
        WHERE
            cl.idcliente = pe.idcliente
    ) AS Cliente,
    (
        SELECT
            at.nome
        FROM
            atendentes at
        WHERE
            at.idatendente = re.idatendente
    ) AS Atendente
FROM
    pedidos pe
    JOIN reservas re ON pe.idreserva = re.idreserva
    JOIN mesas me ON re.idmesa = me.idmesa
WHERE
    pe.status = 1;

-- 8.- Ver os detalhes do pedido os pratos e para qual mesa foi feito o pedido qual o cliente e quem vai atender ele
SELECT
    idpedido,
    ordem,
    quantia,
    nota,
    descricao,
    valor,
    idmesa AS Mesa,
    vip AS VIP,
    (
        SELECT
            nome
        FROM
            clientes clie
        WHERE
            detalhes.idcliente = clie.idcliente
    ) AS Cliente,
    (
        SELECT
            nome
        FROM
            atendentes aten
        WHERE
            detalhes.idatendente = aten.idatendente
    ) AS Atendente
FROM
    (
        SELECT
            pe.idpedido,
            pe.idcliente,
            re.idatendente,
            peca.ordem,
            peca.quantia,
            peca.nota,
            ca.nome AS descricao,
            ca.valor,
            me.idmesa,
            me.vip
        FROM
            pedidos pe
            JOIN pedidos_cardapios peca ON pe.idpedido = peca.idpedido
            JOIN cardapios ca ON peca.idcardapio = ca.idcardapio
            LEFT JOIN reservas re ON pe.idreserva = re.idreserva
            LEFT JOIN mesas me ON re.idmesa = me.idmesa
        WHERE
            pe.idpedido = 1
        UNION
        ALL
        SELECT
            pe.idpedido,
            pe.idcliente,
            re.idatendente,
            pepro.ordem,
            pepro.quantia,
            '',
            pro.descricao,
            pro.valor,
            me.idmesa,
            me.vip
        FROM
            pedidos pe
            JOIN pedidos_produtos pepro ON pe.idpedido = pepro.idpedido
            JOIN produtos pro ON pepro.idproduto = pro.idproduto
            LEFT JOIN reservas re ON pe.idreserva = re.idreserva
            LEFT JOIN mesas me ON re.idmesa = me.idmesa
        WHERE
            pe.idpedido = 1
    ) AS detalhes
ORDER BY
    ordem ASC;

-- 9.- Valor total d o pedido
SELECT
    SUM(valor) AS 'Valor Total'
FROM
    (
        SELECT
            ca.valor
        FROM
            pedidos pe
            JOIN pedidos_cardapios peca ON pe.idpedido = peca.idpedido
            JOIN cardapios ca ON peca.idcardapio = ca.idcardapio
        WHERE
            pe.idpedido = 1
        UNION
        ALL
        SELECT
            pro.valor
        FROM
            pedidos pe
            JOIN pedidos_produtos pepro ON pe.idpedido = pepro.idpedido
            JOIN produtos pro ON pepro.idproduto = pro.idproduto
        WHERE
            pe.idpedido = 1
    )