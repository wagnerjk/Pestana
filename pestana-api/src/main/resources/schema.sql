drop table if exists vaga;
drop table if exists veiculo;
drop table if exists pessoa;

CREATE TABLE pessoa (
	pessoa_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    apartamento INT NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(11) NOT NULL
);

CREATE TABLE veiculo (
	veiculo_id INT NOT NULL AUTO_INCREMENT,
    pessoa_id INT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    placa VARCHAR(7) NOT NULL,
    ano INT NOT NULL,
    PRIMARY KEY (veiculo_id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoa (pessoa_id)
        ON UPDATE  RESTRICT  ON DELETE  CASCADE
);

CREATE TABLE vaga (
	vaga_id INT NOT NULL PRIMARY KEY,
    veiculo_id INT UNIQUE,
    FOREIGN KEY (veiculo_id) REFERENCES veiculo (veiculo_id)
        ON UPDATE  RESTRICT  ON DELETE  CASCADE
);

CREATE
    DEFINER = CURRENT_USER
    TRIGGER  `veiculo_vaga`
 AFTER INSERT ON `veiculo` FOR EACH ROW
    INSERT INTO vaga (veiculo_id) VALUES (new.veiculo_id);

CREATE
    DEFINER = CURRENT_USER
    TRIGGER  `vaga_increment`
BEFORE INSERT ON `vaga` FOR EACH ROW
    SET
        @vagas_count = (SELECT COUNT(vaga_id)),
        new.vaga_id = IF(@vagas_count > 200, NULL,
        (@vagas_count + 1));