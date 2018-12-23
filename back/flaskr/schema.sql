USE PGPI_grupo02;

DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS incidencia;
DROP TABLE IF EXISTS elementoInventario;
DROP TABLE IF EXISTS elementoIncidencia;
DROP TABLE IF EXISTS cambio;

CREATE TABLE estado(
    id INTEGER PRIMARY KEY,
    estado VARCHAR (30)
);

CREATE TABLE usuario(
    nick VARCHAR(50) PRIMARY KEY,
    email VARCHAR(50),
    password VARCHAR(50),
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    biografia VARCHAR(200),
    fotoPerfil VARCHAR(200)
);

CREATE TABLE incidencia(
    id INTEGER PRIMARY KEY,
    comentario VARCHAR(200),
    prioridad INTEGER,
    tiempoEstimado INTEGER,
    descripcion VARCHAR(200),
    estado INTEGER REFERENCES estado(id),
    tecnicoAsignado VARCHAR(50) REFERENCES usuario(nick),
    cliente VARCHAR(50) REFERENCES usuario(nick)
);

CREATE TABLE elementoInventario(
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(200),
    fechaAdquisicion INTEGER
);

CREATE TABLE elementoIncidencia(
    incidencia INTEGER REFERENCES incidencia(id),
    elemento INTEGER references elementoInventario(id)
);

CREATE TABLE cambio(
    fecha DATE PRIMARY KEY,
    estado INTEGER REFERENCES estado(id),
    tecnico VARCHAR(50) REFERENCES tecnico(id),
    incidencia INTEGER REFERENCES incidencia(id)
);
