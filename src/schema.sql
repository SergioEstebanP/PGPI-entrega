USE PGPI_grupo02;

DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS tipo_usuario;
DROP TABLE IF EXISTS categoria_incidencia;
DROP TABLE IF EXISTS elemento_inventario;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS incidencia;
DROP TABLE IF EXISTS cambio;


CREATE TABLE estado(
    id INTEGER PRIMARY KEY,
    estado VARCHAR (50)
);


/* Valores para tipo de ususario:
    [0, supervisor]
    [1, tecnico]
    [2, cliente]
 */
CREATE TABLE tipo_usuario(
    id INTEGER PRIMARY KEY,
    tipo_usuario VARCHAR(20)
);

CREATE TABLE categoria_incidencia(
    id INTEGER PRIMARY KEY,
    categoria VARCHAR(40)
);

CREATE TABLE elemento_inventario(
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(200)
);

CREATE TABLE usuario(
    nick VARCHAR(50) PRIMARY KEY,
    email VARCHAR(50),
    password VARCHAR(50),
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    biografia VARCHAR(200),
    fotoPerfil VARCHAR(200),
    tipo INTEGER REFERENCES tipo_usuario(id) 
);

CREATE TABLE incidencia(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    comentario VARCHAR(500),
    prioridad INTEGER,
    tiempoEstimado INTEGER,
    descripcion VARCHAR(500),
    fecha DATE,
    estado INTEGER REFERENCES estado(id),
    tecnicoAsignado VARCHAR(50) REFERENCES usuario(nick),
    reportadaPor VARCHAR(50) REFERENCES usuario(nick),
    categoria INTEGER REFERENCES categoria_incidencia(id),
    elementoInventario INTEGER REFERENCES elemento_inventario(id)
);

CREATE TABLE cambio(
    fecha DATETIME PRIMARY KEY,
    estado INTEGER REFERENCES estado(id),
    tecnico VARCHAR(50) REFERENCES usuario(nick),
    incidencia INTEGER REFERENCES incidencia(id) 
);

/* Poblando la tabla: estado */
INSERT INTO estado (id, estado) VALUES (0, 'Abierta');
INSERT INTO estado (id, estado) VALUES (1, 'Asignada a un técnico');
INSERT INTO estado (id, estado) VALUES (2, 'Solicitado cierre por el cliente');
INSERT INTO estado (id, estado) VALUES (3, 'Solicitado cierre por el técnico');
INSERT INTO estado (id, estado) VALUES (4, 'Cerrada sin solución');
INSERT INTO estado (id, estado) VALUES (5, 'Cerrada con solución');

/* Poblando la tabla: tipo_usuario */
INSERT INTO tipo_usuario (id, tipo_usuario) VALUES (0, 'supervisor');
INSERT INTO tipo_usuario (id, tipo_usuario) VALUES (1, 'tecnnico');
INSERT INTO tipo_usuario (id, tipo_usuario) VALUES (2, 'cliente');

/* Poblando la tabla: categoria_incidencia */
INSERT INTO categoria_incidencia (id, categoria) VALUES (0, 'Hardware');
INSERT INTO categoria_incidencia (id, categoria) VALUES (1, 'Problemas con las comunicaciones');
INSERT INTO categoria_incidencia (id, categoria) VALUES (2, 'Software básico');
INSERT INTO categoria_incidencia (id, categoria) VALUES (3, 'Software de aplicaciones');
INSERT INTO categoria_incidencia (id, categoria) VALUES (4, 'Otros');

/* Poblando la tabla: usuario */
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Supervisor', 'supervisor@mail.com', 'password', 'Manolo', 'Garcia', 'Biografia del supervisor Manolo Garcia', 'fotoPerfil', 0);

INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico 1', 'tecnico1@mail.com', 'password', 'Juan', 'Olmos', 'Biografia del tecnico 1 Juan Olmos', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico 2', 'tecnico2@mail.com', 'password', 'Marta', 'Gutierrez', 'Biografia del tecnico 2', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico 3', 'tecnico3@mail.com', 'password', 'Jose', 'Martinez', 'Biografia del tecnico 3', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico 4', 'tecnico4@mail.com', 'password', 'Maria', 'Bigorruezo', 'Biografia del tecnico 4', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico 5', 'tecnico5@mail.com', 'password', 'Feranda', 'Vals', 'Biografia del tecnico 5', 'fotoPerfil', 1);

INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Cliente 1', 'cliente1@mail.com', 'password', 'Patricia', 'Pellejero', 'Biografia del cliente 1', 'fotoPerfil', 2);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Cliente 2', 'cliente2@mail.com', 'password', 'Pablo', 'Arguedas', 'Biografia del cliente 2', 'fotoPerfil', 2);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Cliente 3', 'cliente3@mail.com', 'password', 'Alvaro', 'Perez', 'Biografia del cliente 3', 'fotoPerfil', 2);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Cliente 4', 'cliente4@mail.com', 'password', 'Jose Ignacio', 'Galindo', 'Biografia del cliente 4', 'fotoPerfil', 2);
