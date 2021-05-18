CREATE TABLE Pessoa (
	pessoa_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    apartamento INT NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(11) NOT NULL
);

CREATE TABLE Veiculo (
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

CREATE TABLE Vaga (
	vaga_id INT NOT NULL PRIMARY KEY,
    veiculo_id INT UNIQUE,
    FOREIGN KEY (veiculo_id) REFERENCES veiculo (veiculo_id)
        ON UPDATE  RESTRICT  ON DELETE  CASCADE
);

DELIMITER $$
USE `pestana`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `vaga_increment` BEFORE INSERT ON `vagas` FOR EACH ROW BEGIN
	SELECT count(vaga_id) INTO @contalinhas from vagas;
    
    IF @contalinhas < 200 THEN
		set new.vaga_id = @contalinhas + 1;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
USE `pestana`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `veiculo_vaga` AFTER INSERT ON `veiculo` FOR EACH ROW BEGIN
	insert into vaga (veiculo_id) values (new.veiculo_id);
END$$
DELIMITER ;