USE PGPI_grupo02;

DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS tipoUsuario;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS incidencia;
DROP TABLE IF EXISTS elementoInventario;
DROP TABLE IF EXISTS elementoIncidencia;
DROP TABLE IF EXISTS cambio;

/* Valores para estado de la incidencia:
    [0, abierta]
    [1, asignada a un tecnico]
    [2, pendiente de cerrar]
    [3, cerrada con solucion]
    [4, cerrada sin solucion]
 */
CREATE TABLE estado(
    id INTEGER PRIMARY KEY,
    estado VARCHAR (30)
);

/* Valores para tipo de ususario:
    [0, supervisor]
    [1, tecnico]
    [2, cliente]
 */
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
    tipo INTEGER REFERENCES tipoUsuario(id) 
);

CREATE TABLE incidencia(
    id INTEGER PRIMARY KEY,
    titulo VARCHAR(100),
    comentario VARCHAR(200),
    prioridad INTEGER,
    tiempoEstimado INTEGER,
    descripcion VARCHAR(200) NOT NULL,
    estado INTEGER REFERENCES estado(id) ,
    tecnicoAsignado VARCHAR(50) REFERENCES usuario(nick),
    cliente VARCHAR(50) REFERENCES usuario(nick) 
);

CREATE TABLE elementoInventario(
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(200),
    fechaAdquisicion INTEGER
);

CREATE TABLE elementoIncidencia(
sergest@jair ~ $ cat schema.sql 
USE PGPI_grupo02;

DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS tipoUsuario;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS incidencia;
DROP TABLE IF EXISTS elementoInventario;
DROP TABLE IF EXISTS elementoIncidencia;
DROP TABLE IF EXISTS cambio;

/* Valores para estado de la incidencia:
    [0, abierta]
    [1, asignada a un tecnico]
    [2, pendiente de cerrar]
    [3, cerrada con solucion]
    [4, cerrada sin solucion]
 */
CREATE TABLE estado(
    id INTEGER PRIMARY KEY,
    estado VARCHAR (30)
);

/* Valores para tipo de ususario:
    [0, supervisor]
    [1, tecnico]
    [2, cliente]
 */
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
    tipo INTEGER REFERENCES tipoUsuario(id) 
);

CREATE TABLE incidencia(
    id INTEGER PRIMARY KEY,
    titulo VARCHAR(100),
    comentario VARCHAR(200),
    prioridad INTEGER,
    tiempoEstimado INTEGER,
    descripcion VARCHAR(200) NOT NULL,
    estado INTEGER REFERENCES estado(id) ,
    tecnicoAsignado VARCHAR(50) REFERENCES usuario(nick),
    reportadaPor VARCHAR(50) REFERENCES usuario(nick) 
);

CREATE TABLE elementoInventario(
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(200),
    fechaAdquisicion INTEGER
);

CREATE TABLE elementoIncidencia(
    incidencia INTEGER REFERENCES incidencia(id) ,
    elemento INTEGER REFERENCES elementoInventario(id) 
);

CREATE TABLE cambio(
    fecha DATE PRIMARY KEY,
    estado INTEGER REFERENCES estado(id) ,
    tecnico VARCHAR(50) REFERENCES usuario(nick) ,
    incidencia INTEGER REFERENCES incidencia(id) 
);

INSERT INTO estado (id, estado) VALUES (0, 'abierta');
INSERT INTO estado (id, estado) VALUES (1, 'asignada a un tecnico');
INSERT INTO estado (id, estado) VALUES (2, 'pendiente de cerrar');
INSERT INTO estado (id, estado) VALUES (3, 'cerrada sin solucion');
INSERT INTO estado (id, estado) VALUES (4, 'cerrada con solucion');

INSERT INTO tipoUsuario (id, tipoUsuario) VALUES (0, 'supervisor');
INSERT INTO tipoUsuario (id, tipoUsuario) VALUES (1, 'tecnnico');
INSERT INTO tipoUsuario (id, tipoUsuario) VALUES (2, 'cliente');

INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('supervisor', 'super@mail.com', 'password', 'super', 'visor', 'probando la biografia del supervisor', 'fotoPerfil', 0);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('tecnico', 'tecnico@mail.com', 'password', 'tec', 'nico', 'probando la biografia del tecnico', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('cliente', 'cliente@mail.com', 'password', 'clie', 'nte', 'probando la biografia del cliente', 'fotoPerfil', 2);

INSERT INTO incidencia (id, titulo, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnicoAsignado, clinte) VALUES (1, 'Probando la BBDD', 'prueba de la base de datos', 0, 4, 'descripcion de la incidencia', 0, 'tecnico', 'cliente');
INSERT INTO incidencia (id, titulo, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnicoAsignado, clinte) VALUES (2, 'Se ha roto el servidor', 'este problema se soluciona con otters', 0, 4, 'alguien le ha clavado un hacha al servidor principal de la aplicacion', 0, '', 'tecnico');


