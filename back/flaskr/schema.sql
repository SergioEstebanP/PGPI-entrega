USE PGPI_grupo02;

DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS tipoUsuario;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS incidencia;
DROP TABLE IF EXISTS elementoInventario;
DROP TABLE IF EXISTS elementoIncidencia;
DROP TABLE IF EXISTS cambio;

CREATE TABLE estado(
    id INTEGER PRIMARY KEY,
    estado VARCHAR (30)
);

CREATE TABLE tipoUsuario(
    id INTEGER PRIMARY KEY,
    tipoUsuario VARCHAR(20)
);

CREATE TABLE usuario(
    nick VARCHAR(50) PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    biografia VARCHAR(200),
    fotoPerfil VARCHAR(200),
    tipo INTEGER REFERENCES tipoUsuario(id) NOT NULL
);

CREATE TABLE incidencia(
    id INTEGER PRIMARY KEY,
    comentario VARCHAR(200),
    prioridad INTEGER,
    tiempoEstimado INTEGER,
    descripcion VARCHAR(200) NOT NULL,
    estado INTEGER REFERENCES estado(id) NOT NULL,
    tecnicoAsignado VARCHAR(50) REFERENCES usuario(nick),
    cliente VARCHAR(50) REFERENCES usuario(nick) NOT NULL,
    categoria VARCHAR(20) NOT NULL
);

CREATE TABLE elementoInventario(
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(200),
    fechaAdquisicion INTEGER
);

CREATE TABLE elementoIncidencia(
    incidencia INTEGER REFERENCES incidencia(id) NOT NULL,
    elemento INTEGER REFERENCES elementoInventario(id) NOT NULL
);

CREATE TABLE cambio(
    fecha DATE PRIMARY KEY,
    estado INTEGER REFERENCES estado(id),
    tecnico VARCHAR(50) REFERENCES tecnico(id) NOT NULL,
    incidencia INTEGER REFERENCES incidencia(id) NOT NULL
);
