USE PGPI_grupo02;

DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS tipoUsuario;
DROP TABLE IF EXISTS elementoInventario;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS incidencia;
DROP TABLE IF EXISTS elementoIncidencia;
DROP TABLE IF EXISTS cambio;
DROP TABLE IF EXISTS categoriaIncidencia;


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

/* Valores para categoria de incidencia:
    [0, hardware]
    [1, problemas con las comunicaciones]
    [2, software basico]
    [3, software de aplicaciones]
 */
CREATE TABLE categoriaIncidencia(
    id INTEGER PRIMARY KEY,
    categoria VARCHAR(40)
);

CREATE TABLE elementoInventario(
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(200),
    fechaAdquisicion INTEGER
);

CREATE TABLE usuario(
    nick VARCHAR(50) PRIMARY KEY,
    email VARCHAR(50),
    password VARCHAR(50),
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    biografia VARCHAR(200),
    fotoPerfil VARCHAR(200),
    tipo INTEGER REFERENCES tipoUsuario(id) 
);

CREATE TABLE incidencia(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    comentario VARCHAR(200),
    prioridad INTEGER,
    tiempoEstimado INTEGER,
    descripcion VARCHAR(200),
    fecha DATE,
    estado INTEGER REFERENCES estado(id),
    tecnicoAsignado VARCHAR(50) REFERENCES usuario(nick),
    reportadaPor VARCHAR(50) REFERENCES usuario(nick),
    categoria INTEGER REFERENCES categoriaIncidencia(id)
);

CREATE TABLE elementoIncidencia(
    incidencia INTEGER REFERENCES incidencia(id),
    elemento INTEGER REFERENCES elementoInventario(id) 
);

CREATE TABLE cambio(
    fecha DATETIME PRIMARY KEY,
    estado INTEGER REFERENCES estado(id),
    tecnico VARCHAR(50) REFERENCES usuario(nick),
    incidencia INTEGER REFERENCES incidencia(id) 
);

/* Poblando la tabla: estado */
INSERT INTO estado (id, estado) VALUES (0, 'abierta');
INSERT INTO estado (id, estado) VALUES (1, 'asignada a un tecnico');
INSERT INTO estado (id, estado) VALUES (2, 'pendiente de cerrar cliente');
INSERT INTO estado (id, estado) VALUES (3, 'pendiente de cerrar tecnico');
INSERT INTO estado (id, estado) VALUES (4, 'cerrada sin solucion');
INSERT INTO estado (id, estado) VALUES (5, 'cerrada con solusion');

/* Poblando la tabla: tipoUsuario */
INSERT INTO tipoUsuario (id, tipoUsuario) VALUES (0, 'supervisor');
INSERT INTO tipoUsuario (id, tipoUsuario) VALUES (1, 'tecnnico');
INSERT INTO tipoUsuario (id, tipoUsuario) VALUES (2, 'cliente');

/* Poblando la tabla: usuario */
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('supervisor', 'super@mail.com', 'password', 'super', 'visor', 'probando la biografia del supervisor', 'fotoPerfil', 0);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('tecnico', 'tecnico@mail.com', 'password', 'tec', 'nico', 'probando la biografia del tecnico', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('cliente', 'cliente@mail.com', 'password', 'clie', 'nte', 'probando la biografia del cliente', 'fotoPerfil', 2);

/* Poblando la tabla: incidencia */
INSERT INTO incidencia (id, titulo, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnicoAsignado, reportadaPor) VALUES (1, 'Titulo 1', 'Comentario 1', 0, 4, 'Descripcion 1', 0, 'tecnico 1', 'cliente');
INSERT INTO incidencia (id, titulo, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnicoAsignado, reportadaPor) VALUES (2, 'Titulo 2', 'Comentario 2', 0, 4, 'Descripcion 2', 0, 'tecnico 2', 'cliente');
INSERT INTO incidencia (id, titulo, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnicoAsignado, reportadaPor) VALUES (3, 'Titulo 3', 'Comentario 3', 0, 4, 'Descripcion 3', 0, 'tecnico 3', 'cliente');
INSERT INTO incidencia (id, titulo, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnicoAsignado, reportadaPor) VALUES (4, 'Titulo 4', 'Comentario 4', 0, 4, 'Descripcion 4', 0, 'tecnico 4', 'cliente');
INSERT INTO incidencia (id, titulo, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnicoAsignado, reportadaPor) VALUES (5, 'Titulo 5', 'Comentario 5', 0, 4, 'Descripcion 5', 0, 'tecnico 5', 'cliente');
INSERT INTO incidencia (id, titulo, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnicoAsignado, reportadaPor) VALUES (6, 'Titulo 6', 'Comentario 6', 0, 4, 'Descripcion 6', 0, 'tecnico 6', 'cliente');

