CREATE TABLE USUARIO(
COD_USER INT NOT NULL,
EMAIL VARCHAR(50),
SENHA VARCHAR(25),
NOME VARCHAR(20),
SOBRENOME VARCHAR(20),
TELEFONE1 BIGINT,
TELEFONE2 BIGINT,
TIPO VARCHAR(15),
PRIMARY KEY(COD_USER)
);

CREATE TABLE CLIENTE(
COD_CLI INT NOT NULL,
COD_USER INT,
PONTUACAO INT,
PRIMARY KEY(COD_CLI),
FOREIGN KEY(COD_USER) REFERENCES USUARIO(COD_USER)
);

CREATE TABLE FUNCIONARIO(
COD_FUN INT NOT NULL,
COD_USER INT,
HORARIO1 TIME,
HORARIO2 TIME,
HORARIO3 TIME,
PRIMARY KEY(COD_FUN),
FOREIGN KEY(COD_USER) REFERENCES USUARIO(COD_USER)
);

CREATE TABLE SERVICO(
COD_SER INT NOT NULL,
TIPO VARCHAR(40),
VALOR FLOAT,
DESCRICAO VARCHAR(50),
DURACAO TIME,
NOME VARCHAR(40),
PRIMARY KEY(COD_SER)
);

CREATE TABLE AGENDA(
COD_CLI INT NOT NULL,
COD_FUN INT NOT NULL,
COD_SER INT NOT NULL,
STATUS VARCHAR(20),
HORA TIME,
DATA DATE,
FOREIGN KEY(COD_CLI) REFERENCES CLIENTE(COD_CLI),
FOREIGN KEY(COD_FUN) REFERENCES FUNCIONARIO(COD_FUN),
FOREIGN KEY(COD_SER) REFERENCES SERVICO(COD_SER)
);

CREATE TABLE AVALIA_SERVICO(
COD_CLI INT NOT NULL,
COD_SER INT NOT NULL,
COMENTARIO VARCHAR(150),
TIPO VARCHAR(20),
FOREIGN KEY(COD_CLI) REFERENCES CLIENTE(COD_CLI),
FOREIGN KEY(COD_SER) REFERENCES SERVICO(COD_SER)
);

CREATE TABLE AVALIA_FUNCIONARIO(
COD_CLI INT NOT NULL,
COD_FUN INT NOT NULL,
COMENTARIO VARCHAR(200),
TIPO VARCHAR(20),
FOREIGN KEY(COD_CLI) REFERENCES CLIENTE(COD_CLI),
FOREIGN KEY(COD_FUN) REFERENCES FUNCIONARIO(COD_FUN)
);

CREATE TABLE PRODUTO(
COD_PRO INT NOT NULL,
NOME VARCHAR(50),
PRECO FLOAT,
MARCA VARCHAR(50),
ESTOQUE INT,
PRIMARY KEY(COD_PRO)
);

CREATE TABLE PAGAMENTO(
COD_PAG INT NOT NULL,
COD_PRO INT NOT NULL,
COD_SER INT NOT NULL,
TIPO VARCHAR(30),
PRIMARY KEY(COD_PAG),
FOREIGN KEY(COD_PRO) REFERENCES PRODUTO(COD_PRO),
FOREIGN KEY(COD_SER) REFERENCES SERVICO(COD_SER)	
);

CREATE TABLE PRODUTO_PAGAMENTO(
COD_PRO INT NOT NULL,
COD_PAG INT NOT NULL,
DATA DATE,
HORA TIME,
FOREIGN KEY(COD_PRO) REFERENCES PRODUTO(COD_PRO),
FOREIGN KEY(COD_PAG) REFERENCES PAGAMENTO(COD_PAG)
);

CREATE TABLE CARTAO(
COD_PAG INT NOT NULL,
TIPO_CARTAO VARCHAR(10),
BANDEIRA VARCHAR(20),
FOREIGN KEY(COD_PAG) REFERENCES PAGAMENTO(COD_PAG)
);

CREATE TABLE PIX(
COD_PAG INT NOT NULL,
TIPO_CHAVE VARCHAR(15),
FOREIGN KEY(COD_PAG) REFERENCES PAGAMENTO(COD_PAG)
);

CREATE TABLE SERVICO_PAGAMENTO(
COD_SER INT NOT NULL,
COD_PAG INT NOT NULL,
FOREIGN KEY(COD_SER) REFERENCES SERVICO(COD_SER),
FOREIGN KEY(COD_PAG) REFERENCES PAGAMENTO(COD_PAG)
);

--- POVOAMENTO ---

INSERT INTO USUARIO (COD_USER, EMAIL, SENHA, NOME, SOBRENOME, TELEFONE1, TELEFONE2, TIPO)
VALUES
(1, 'user1@example.com', 'senha123', 'João', 'Silva', 123456789, 987654321, 'Cliente'),
(2, 'user2@example.com', 'senha456', 'Maria', 'Souza', 987654321, 123456789, 'Cliente'),
(3, 'user3@example.com', 'senha789', 'Carlos', 'Oliveira', 111222333, NULL, 'Cliente'),
(4, 'user4@example.com', 'senha101', 'Ana', 'Pereira', 555666777, 888999000, 'Cliente'),
(5, 'user5@example.com', 'senha112', 'Pedro', 'Cunha', 999888777, 111000222, 'Cliente'),
(6, 'user6@example.com', 'senha223', 'Fernanda', 'Lima', 444555666, NULL, 'Cliente'),
(7, 'user7@example.com', 'senha334', 'Ricardo', 'Almeida', 333444555, 666777888, 'Cliente'),
(8, 'user8@example.com', 'senha445', 'Mariana', 'Costa', 222333444, NULL, 'Cliente'),
(9, 'user9@example.com', 'senha556', 'Gabriel', 'Santos', 111222333, 888777666, 'Cliente'),
(10, 'user10@example.com', 'senha667', 'Amanda', 'Martins', 999888777, NULL, 'Cliente'),
(11, 'user11@example.com', 'senha778', 'Diego', 'Rodrigues', 888777666, 555444333, 'Cliente'),
(12, 'user12@example.com', 'senha889', 'Camila', 'Ferreira', 777666555, NULL, 'Cliente'),
(13, 'user13@example.com', 'senha990', 'Lucas', 'Gomes', 666555444, 333222111, 'Cliente'),
(14, 'user14@example.com', 'senha001', 'Isabela', 'Rocha', 555444333, NULL, 'Cliente'),
(15, 'user15@example.com', 'senha112', 'Eduardo', 'Pinto', 444333222, 111000222, 'Funcionario'),
(16, 'user16@example.com', 'senha223', 'Fernando', 'Mendes', 333222111, NULL, 'Funcionario'),
(17, 'user17@example.com', 'senha334', 'Larissa', 'Araújo', 222111000, 666777888, 'Funcionario'),
(18, 'user18@example.com', 'senha445', 'Roberto', 'Carvalho', 111000222, NULL, 'Funcionario'),
(19, 'user19@example.com', 'senha556', 'Tatiane', 'Nunes', 999888777, 888999000, 'Funcionario'),
(20, 'user20@example.com', 'senha667', 'Luciana', 'Barbosa', 777888999, NULL, 'Funcionario'),
(21, 'user21@example.com', 'senha778', 'Marcos', 'Lopes', 666777888, 555666777, 'Funcionario'),
(22, 'user22@example.com', 'senha889', 'Carolina', 'Azevedo', 555666777, NULL, 'Funcionario'),
(23, 'user23@example.com', 'senha990', 'Vinícius', 'Farias', 444555666, 111222333, 'Funcionario'),
(24, 'user24@example.com', 'senha001', 'Juliana', 'Cruz', 333444555, NULL, 'Funcionario'),
(25, 'user25@example.com', 'senha002', 'Felipe', 'Lima', 222333444, 888999000, 'Funcionario');

INSERT INTO CLIENTE(COD_CLI, COD_USER, PONTUACAO)
VALUES
(101,1,20),
(102,2,40),
(103,3,10),
(104,4,60),
(105,5,70),
(106,6,100),
(107,7,30),
(108,8,70),
(109,9,80),
(110,10,00),
(111,11,90),
(112,12,30),
(113,13,40),
(114,14,70),
(115,15,60);

INSERT INTO FUNCIONARIO(COD_FUN, COD_USER, HORARIO1, HORARIO2, HORARIO3)
VALUES
(201,16,'08:00:00','10:00:00','13:00:00'),
(202,17,'08:00:00','10:00:00','13:00:00'),
(203,18,'08:00:00','10:00:00','13:00:00'),
(204,19,'08:00:00','10:00:00','13:00:00'),
(205,20,'10:00:00','13:00:00','15:00:00'),
(206,21,'10:00:00','13:00:00','15:00:00'),
(207,22,'10:00:00','13:00:00','15:00:00'),
(208,23,'13:00:00','15:00:00','17:00:00'),
(209,24,'13:00:00','15:00:00','17:00:00'),
(210,25,'13:00:00','15:00:00','17:00:00');

INSERT INTO SERVICO (COD_SER, TIPO, VALOR, DESCRICAO, DURACAO, NOME)
VALUES
(1000, 'Corte de Cabelo', 30.00, 'Corte de cabelo padrão', '01:00:00', 'Corte Padrão'),
(1001, 'Coloração', 50.00, 'Coloração de cabelo', '02:00:00', 'Coloração'),
(1002, 'Massagem Relaxante', 80.00, 'Massagem para relaxamento', '01:30:00', 'Massagem Relaxante'),
(1003, 'Tratamento Facial', 60.00, 'Tratamento facial rejuvenescedor', '02:30:00', 'Tratamento Facial'),
(1004, 'Design de Sobrancelha', 15.00, 'Design de sobrancelha', '00:30:00', 'Design de Sobrancelha'),
(1005, 'Barba', 20.00, 'Barba tradicional', '00:30:00', 'Barba Tradicional'),
(1006, 'Escova', 25.00, 'Escova para alisamento', '01:00:00', 'Escova para Alisamento'),
(1007, 'Penteado para Eventos', 45.00, 'Penteado elaborado para eventos especiais', '01:45:00', 'Penteado para Eventos'),
(1008, 'Corte de Cabelo Degradê', 40.00, 'Corte moderno em degradê', '01:15:00', 'Corte Degradê'),
(1009, 'Lavagem do Cabelo', 15.00, 'Lavagem e tratamento capilar', '00:30:00', 'Lavagem do Cabelo');

INSERT INTO AGENDA (COD_CLI, COD_FUN, COD_SER, STATUS, HORA, DATA)
VALUES
(101, 201, 1000, 'Agendado', '10:00:00', '2023-11-15'),
(105, 205, 1005, 'Confirmado', '14:30:00', '2023-11-16'),
(111, 208, 1007, 'Cancelado', '16:00:00', '2023-11-17'),
(108, 204, 1009, 'Agendado', '11:30:00', '2023-11-18'),
(113, 210, 1001, 'Confirmado', '13:45:00', '2023-11-19'),
(115, 202, 1008, 'Agendado', '09:15:00', '2023-11-20'),
(107, 209, 1002, 'Confirmado', '15:00:00', '2023-11-21'),
(104, 206, 1008, 'Agendado', '12:00:00', '2023-11-22'),
(106, 209, 1004, 'Cancelado', '17:30:00', '2023-11-23'),
(110, 203, 1003, 'Agendado', '08:45:00', '2023-11-24');

INSERT INTO AVALIA_SERVICO (COD_CLI, COD_SER, COMENTARIO, TIPO)
VALUES
(107, 1008, 'Ótimo serviço! Profissional muito habilidoso.', 'Positiva'),
(109, 1000, 'Adorei o resultado! Voltarei com certeza.', 'Positiva'),
(104, 1008, 'Infelizmente, não fiquei satisfeito com o serviço.', 'Negativa'),
(105, 1001, 'Excelente atendimento! Recomendo a todos.', 'Positiva'),
(113, 1009, 'Muito profissionalismo. Serviço de alta qualidade.', 'Positiva'),
(110, 1009, 'Não atendeu às expectativas. Esperava mais.', 'Negativa'),
(113, 1002, 'Serviço impecável! Voltarei para mais tratamentos.', 'Positiva'),
(115, 1006, 'Achei o serviço mediano. Pode melhorar.', 'Neutra'),
(101, 1004, 'Cancelaram meu agendamento sem aviso. Insatisfeito.', 'Negativa'),
(114, 1005, 'Serviço rápido e eficiente. Gostei muito!', 'Positiva');

INSERT INTO AVALIA_FUNCIONARIO (COD_CLI, COD_FUN, COMENTARIO, TIPO)
VALUES
(101, 210, 'Excelente profissional! Atencioso e competente.', 'Positiva'),
(107, 206, 'O atendimento foi ótimo, mas o serviço poderia ser melhor.', 'Neutra'),
(113, 203, 'Funcionário muito prestativo. Gostei do atendimento.', 'Positiva'),
(109, 210, 'Não recomendo. Serviço deixou a desejar.', 'Negativa'),
(115, 209, 'Atendimento rápido e eficaz. Muito satisfeito.', 'Positiva'),
(106, 204, 'O funcionário não parecia muito experiente. Pode melhorar.', 'Negativa'),
(110, 207, 'Profissional dedicado. Recomendo!', 'Positiva'),
(102, 201, 'Senti falta de mais cordialidade. Atendimento foi frio.', 'Negativa'),
(108, 206, 'Funcionário cancelou meu agendamento sem motivo aparente.', 'Negativa'),
(111, 209, 'Atendimento excelente! Funcionário muito simpático.', 'Positiva');

INSERT INTO PRODUTO (COD_PRO, NOME, PRECO, MARCA, ESTOQUE)
VALUES
(1101, 'Shampoo para Barba', 18.99, 'BeardMaster', 30),
(1102, 'Óleo para Barba', 24.50, 'BarbaLux', 25),
(1103, 'Sabonete Esfoliante para Rosto', 12.99, 'GentlemanCare', 40),
(1104, 'Creme de Barbear Hidratante', 15.50, 'SmoothShave', 35),
(1105, 'Pomada Modeladora para Cabelo', 22.99, 'BarberStyle', 20),
(1106, 'Loção Pós-Barba', 19.75, 'CoolMint', 30),
(1107, 'Escova para Barba', 8.99, 'BarbaGroom', 15),
(1108, 'Tesoura para Aparar Barba', 34.99, 'TrimMaster', 10),
(1109, 'Kit Barba Completo', 49.99, 'BarberKit', 12),
(1110, 'Cera Modeladora para Bigode', 14.99, 'StacheStyle', 18),
(1111, 'Minoxidil para Barba', 29.99, 'BeardGrow', 15),
(1112, 'Maquininha de Corte Profissional', 99.99, 'ClipPro', 8);

INSERT INTO PAGAMENTO (COD_PAG, COD_PRO, COD_SER, TIPO)
VALUES
(1201, 1101, 1000, 'Cartão'),
(1202, 1102, 1001, 'Cartão'),
(1203, 1103, 1002, 'Cartão'),
(1204, 1104, 1003, 'Cartão'),
(1205, 1105, 1004, 'Cartão'),
(1206, 1106, 1005, 'Cartão'),
(1207, 1107, 1006, 'Cartão'),
(1208, 1108, 1007, 'Cartão'),
(1209, 1109, 1008, 'Cartão'),
(1210, 1110, 1009, 'Cartão'),
(1211, 1111, 1000, 'Pix'),
(1212, 1112, 1001, 'Pix'),
(1213, 1101, 1002, 'Pix'),
(1214, 1102, 1003, 'Pix'),
(1215, 1103, 1004, 'Pix'),
(1216, 1104, 1005, 'Pix'),
(1217, 1105, 1006, 'Pix'),
(1218, 1106, 1007, 'Pix'),
(1219, 1107, 1008, 'Pix'),
(1220, 1108, 1009, 'Pix'),
(1221, 1109, 1000, 'Dinheiro'),
(1222, 1110, 1001, 'Dinheiro'),
(1223, 1111, 1002, 'Dinheiro'),
(1224, 1112, 1003, 'Dinheiro'),
(1225, 1101, 1004, 'Dinheiro');

INSERT INTO PRODUTO_PAGAMENTO (COD_PRO, COD_PAG, DATA, HORA)
VALUES
(1101, 1201, '2023-11-15', '10:30:00'),
(1102, 1202, '2023-11-16', '14:45:00'),
(1103, 1203, '2023-11-17', '16:20:00'),
(1104, 1204, '2023-11-18', '11:10:00'),
(1105, 1205, '2023-11-19', '13:55:00'),
(1106, 1206, '2023-11-20', '09:30:00'),
(1107, 1207, '2023-11-21', '15:40:00'),
(1108, 1208, '2023-11-22', '12:15:00'),
(1109, 1209, '2023-11-23', '17:05:00'),
(1110, 1210, '2023-11-24', '08:50:00'),
(1111, 1211, '2023-11-25', '11:30:00'),
(1112, 1212, '2023-11-26', '14:20:00'),
(1101, 1213, '2023-11-27', '16:45:00'),
(1102, 1214, '2023-11-28', '10:00:00'),
(1103, 1215, '2023-11-29', '12:30:00'),
(1104, 1216, '2023-11-30', '15:15:00'),
(1105, 1217, '2023-12-01', '09:45:00'),
(1106, 1218, '2023-12-02', '11:55:00'),
(1107, 1219, '2023-12-03', '14:10:00'),
(1108, 1220, '2023-12-04', '17:30:00'),
(1109, 1221, '2023-12-05', '08:15:00'),
(1110, 1222, '2023-12-06', '12:00:00'),
(1111, 1223, '2023-12-07', '13:40:00'),
(1112, 1224, '2023-12-08', '16:00:00'),
(1101, 1225, '2023-12-09', '09:00:00');

INSERT INTO SERVICO_PAGAMENTO (COD_SER, COD_PAG)
VALUES
(1000, 1201),
(1001, 1202),
(1002, 1203),
(1003, 1204),
(1004, 1205),
(1005, 1206),
(1006, 1207),
(1007, 1208),
(1008, 1209),
(1009, 1210),
(1000, 1211),
(1001, 1212),
(1002, 1213),
(1003, 1214),
(1004, 1215),
(1005, 1216),
(1006, 1217),
(1007, 1218),
(1008, 1219),
(1009, 1220),
(1000, 1221),
(1001, 1222),
(1002, 1223),
(1003, 1224),
(1004, 1225);

INSERT INTO CARTAO (COD_PAG, TIPO_CARTAO, BANDEIRA)
VALUES
(1201, 'Débito', 'Visa'),
(1202, 'Crédito', 'Mastercard'),
(1203, 'Débito', 'Elo'),
(1204, 'Crédito', 'American Express'),
(1205, 'Débito', 'Visa'),
(1206, 'Crédito', 'Mastercard'),
(1207, 'Débito', 'Elo'),
(1208, 'Crédito', 'American Express'),
(1209, 'Débito', 'Visa'),
(1210, 'Crédito', 'Mastercard');

INSERT INTO PIX (COD_PAG, TIPO_CHAVE)
VALUES
(1211, 'CPF'),
(1212, 'E-mail'),
(1213, 'Telefone'),
(1214, 'CNPJ'),
(1215, 'CPF'),
(1216, 'E-mail'),
(1217, 'Telefone'),
(1218, 'CNPJ'),
(1219, 'CPF'),
(1220, 'E-mail');

CREATE VIEW VISAO AS
SELECT
    A.COD_CLI AS ID_CLIENTE,
    U.NOME AS NOME_CLIENTE,
    U.EMAIL AS EMAIL_CLIENTE,
    S.NOME AS NOME_SERVICO,
    A.STATUS AS STATUS_AGENDAMENTO,
    A.HORA AS HORARIO_AGENDAMENTO,
    A.DATA AS DATA_AGENDAMENTO,
    AV.COMENTARIO AS COMENTARIO_AVALIACAO_SERVICO,
    AV.TIPO AS TIPO_AVALIACAO_SERVICO
FROM
    AGENDA A
JOIN
    CLIENTE C ON A.COD_CLI = C.COD_CLI
JOIN
    USUARIO U ON C.COD_USER = U.COD_USER
JOIN
    SERVICO S ON A.COD_SER = S.COD_SER
LEFT JOIN
    AVALIA_SERVICO AV ON A.COD_CLI = AV.COD_CLI AND A.COD_SER = AV.COD_SER;

CREATE OR REPLACE FUNCTION OBTER_AGENDA_CLIENTE(p_cod_cli INT, p_data DATE)
RETURNS TABLE (
    NOME_SERVICO VARCHAR(40),
    STATUS VARCHAR(20),
    HORA TIME
) AS $$
BEGIN
    RETURN QUERY
    SELECT SERVICO.NOME, AGENDA.STATUS, AGENDA.HORA
    FROM AGENDA
    JOIN SERVICO ON AGENDA.COD_SER = SERVICO.COD_SER
    WHERE AGENDA.COD_CLI = p_cod_cli AND AGENDA.DATA = p_data;

END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM OBTER_AGENDA_CLIENTE(101, '2023-11-15');

--- TRIGGER ---
-- ADICIONA UMA TAXA DE 5% SE O PAGAMENTO FOR FEITO NO CARTÃO --
CREATE OR REPLACE FUNCTION ADICIONAR_TAXA_CARTAO()
RETURNS TRIGGER AS $$
DECLARE
    NEW_TIPO VARCHAR(30);
BEGIN
    IF TG_OP = 'INSERT' THEN
        -- Verifica o tipo de pagamento
        SELECT TIPO INTO NEW_TIPO
        FROM PAGAMENTO
        WHERE COD_PAG = NEW.COD_PAG;

        -- Adiciona uma taxa se o pagamento for feito com cartão
        IF NEW_TIPO = 'Cartão' THEN
            NEW.VALOR := NEW.VALOR + (NEW.VALOR * 0.05); -- Adiciona 5% de taxa
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

-- Criação da Trigger
CREATE TRIGGER TRIG_ADICIONAR_TAXA_CARTAO
BEFORE INSERT ON PAGAMENTO
FOR EACH ROW
EXECUTE FUNCTION ADICIONAR_TAXA_CARTAO();
