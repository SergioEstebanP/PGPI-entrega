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

/* Poblando la tabla: elemento_inventario */
INSERT INTO elemento_inventario (id, nombre) VALUES (0, 'Sin asignar');
INSERT INTO elemento_inventario (id, nombre) VALUES (1, 'PC 1');
INSERT INTO elemento_inventario (id, nombre) VALUES (2, 'PC 2');
INSERT INTO elemento_inventario (id, nombre) VALUES (3, 'PC 3');
INSERT INTO elemento_inventario (id, nombre) VALUES (4, 'PC 4');
INSERT INTO elemento_inventario (id, nombre) VALUES (5, 'PC 5');
INSERT INTO elemento_inventario (id, nombre) VALUES (6, 'Base de datos');
INSERT INTO elemento_inventario (id, nombre) VALUES (7, 'Switch principal');
INSERT INTO elemento_inventario (id, nombre) VALUES (8, 'Switch secundario');
INSERT INTO elemento_inventario (id, nombre) VALUES (9, 'Router');
INSERT INTO elemento_inventario (id, nombre) VALUES (10,'Servidor de correo electrónico');
INSERT INTO elemento_inventario (id, nombre) VALUES (11,'Aplicación interna');
INSERT INTO elemento_inventario (id, nombre) VALUES (12,'Teléfono móvil de empresa');

/* Poblando la tabla: usuario */
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Supervisor', 'supervisor@mail.com', 'password', 'Manolo', 'Garcia', 'Biografia del supervisor Manolo Garcia', 'fotoPerfil', 0);

INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico1', 'tecnico1@mail.com', 'password', 'Juan', 'Olmos', 'Biografia del tecnico 1 Juan Olmos', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico2', 'tecnico2@mail.com', 'password', 'Marta', 'Gutierrez', 'Biografia del tecnico 2', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico3', 'tecnico3@mail.com', 'password', 'Jose', 'Martinez', 'Biografia del tecnico 3', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico4', 'tecnico4@mail.com', 'password', 'Maria', 'Bigorruezo', 'Biografia del tecnico 4', 'fotoPerfil', 1);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Tecnico5', 'tecnico5@mail.com', 'password', 'Feranda', 'Vals', 'Biografia del tecnico 5', 'fotoPerfil', 1);

INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Cliente1', 'cliente1@mail.com', 'password', 'Patricia', 'Pellejero', 'Biografia del cliente 1', 'fotoPerfil', 2);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Cliente2', 'cliente2@mail.com', 'password', 'Pablo', 'Arguedas', 'Biografia del cliente 2', 'fotoPerfil', 2);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Cliente3', 'cliente3@mail.com', 'password', 'Alvaro', 'Perez', 'Biografia del cliente 3', 'fotoPerfil', 2);
INSERT INTO usuario (nick, email, password, nombre, apellidos, biografia, fotoPerfil, tipo) VALUES ('Cliente4', 'cliente4@mail.com', 'password', 'Jose Ignacio', 'Galindo', 'Biografia del cliente 4', 'fotoPerfil', 2);


/* Poblando la tabla: incidencias */ 
INSERT INTO `incidencia` VALUES (1,'El ordenador de la sala principal no arranca','Comprobar primero si es un error de software, del sistema operativo y en caso contrario comprobar si hay algún error de firmware o de hardware. La placa base suele jugar un papel crítico en este tipo de fallos. ',2,2,'El ordenador de la sala principal, donde están sentados los  técnicos no funciona de manera correcta. Al arrancar en windows da un pantallazo azul y se apaga automáticamente. ','2019-01-06',1,'Tecnico1','Cliente1',0,1),(2,'El ordenador de Joaquín esta ardiendo','',0,0,'Cuando me fui a por el café, toda la oficina estaba en orden, pero al volver había 1 ordenador ardiendo y no se que ha pasado, pido una llamada a los bomberos cuanto antes, o que se enciendan los aspersores contra incendios.  ','2019-01-02',0,'Sin asignar','Cliente1',0,3),(3,'La LAN de empleados está caída','Comprobar si el switch está encendido y, en caso de estarlo, reiniciarlo. Si no se soluciona tomar medidas oportunas',7,0,'No funciona la red dentro de la LAN de empleados, probablemente debido al switch secundario.','2019-01-06',1,'Tecnico1','Cliente1',1,8),(4,'El wifi está caído en todo el edificio','',0,0,'No funciona internet al conectarse mediante wifi. Sin embargo, por cable todo va correctamente.','2019-01-03',0,'Sin asignar','Cliente1',1,0),(5,'El correo electrónico no me va.','Comprobar el servidor de correo electrónico interno',8,0,'Esta mañana cuando llegue a la oficina, encendí el ordenador pero no me dejaba acceder a mi cuenta de correo electrónico que uso todos los días. No se que pasa, a ver si un técnico de help desk puede ayudarme. ','2019-01-04',2,'Tecnico2','Cliente2',3,10),(6,'La aplicación interna no funciona correctamente','Los problemas relacionados con los credenciales, a nivel de aplicación interna suelen ser problemas del servidor. ',5,0,'La aplicación de la empresa da un fallo al hacer login con mi usuario y contraseña habituales','2019-01-02',3,'Tecnico4','Tecnico1',3,11),(7,'No me deja registrar incidencias','Es imposible. La aplicación de registro de incidencias es perfecta. Comprobar de todos modos.',2,0,'Al abrir esta mañana la aplicación de registro de incidencias, la misma no me permitía abrir nuevas incidencias. Sí que me dejaba ver todas, pero no abrirlas. ','2018-12-14',5,'Tecnico3','Cliente2',3,11),(8,'El móvil de la empresa no se conecta a la red','',0,0,'El móvil que me ha suministrado la empresa no me permite hacer llamadas telefónicas ni conectarse a la red de Internet vía datos móviles ','2019-01-04',0,'Sin asignar','Tecnico2',1,0),(9,'Fallo al arrancar el sistema','Comprobar parámetros de arranque.',9,0,'El sistema falla en la fase de arranque','2019-01-04',4,'Tecnico1','Cliente3',2,1),(10,'El switch de la red troncal no esta funcionando','',0,0,'Hemos detectado una caída continuada del switch principal del backbone. Menos mal que tenemos redundancia, pero aun así un técnico debería de echarle un vistazo en el menor tiempo posible. ','2019-01-06',0,'Sin asignar','Tecnico2',0,7),(11,'El ordenador de Joaquín está en llamas','Ya sabemos que Joaquín es un pirómano, y que está yendo a terapia. Tendremos más cuidado con él las próximas veces. ',10,0,'Cuando he entrado esta mañana en la oficina estaba el ordenador de Joaquín ardiendo, otra vez.','2019-01-02',2,'Tecnico2','Cliente1',4,3);
