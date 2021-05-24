DROP DATABASE IF EXISTS biblioteca;
--crear base de datos
CREATE DATABASE biblioteca;
--entrar a base de datos
\c biblioteca
--crear tabla socios
CREATE TABLE socios(
id SERIAL PRIMARY KEY, 
rut VARCHAR(255) NOT NULL, 
nombre VARCHAR, 
apellido VARCHAR, 
direccion VARCHAR NOT NULL UNIQUE, 
telefono VARCHAR UNIQUE
);
--crear tabla libros
CREATE TABLE libros(
isbn VARCHAR(15) PRIMARY KEY,
titulo VARCHAR,
paginas VARCHAR,
dias_prestamo INTEGER
);
--crear tabla autor
CREATE TABLE autor(
cod_autor INTEGER PRIMARY KEY,
id_libro VARCHAR,
nombre_autor VARCHAR,
apellido_autor VARCHAR,
nacimiento DATE,
muerte DATE,
tipo_autor VARCHAR
);
--crear tabla historial prestamos
CREATE TABLE prestamos(
id_prestamo SERIAL PRIMARY KEY,
id_socio INTEGER NOT NULL,
id_libro VARCHAR,
socio VARCHAR (255),
libro VARCHAR (255),
fecha_prestamo DATE,
fecha_devolucion DATE
);
ALTER TABLE autor ADD foreign key (id_libro) references libros(isbn);
ALTER TABLE prestamos ADD foreign key (id_socio) references socios(id);
ALTER TABLE prestamos ADD foreign key (id_libro) references libros(isbn);

--inserción de registros
\copy socios(rut, nombre, apellido, direccion, telefono) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/socios.csv' csv header;
\copy libros(isbn,titulo,paginas,dias_prestamo) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/libros.csv' csv header;
\copy autor(cod_autor,id_libro,nombre_autor,apellido_autor,nacimiento,muerte,tipo_autor) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/autor.csv' csv header;
\copy prestamos(id_socio,id_libro,socio,libro,fecha_prestamo,fecha_devolucion) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/historialprestamos.csv' csv header;
