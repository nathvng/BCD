DROP DATABASE db_faculdadesesi;

CREATE DATABASE IF NOT EXISTS db_faculdadesesi;

USE db_faculdadesesi;

CREATE TABLE Cursos (
    id_curso BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    carga_horaria DOUBLE,
    nivel_dificuldade VARCHAR(50)
    );