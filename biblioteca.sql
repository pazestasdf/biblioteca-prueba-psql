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
ISBN VARCHAR(15) PRIMARY KEY,
titulo VARCHAR,
cod_autor VARCHAR,
paginas VARCHAR,
nombre_autor VARCHAR,
apellido_autor VARCHAR,
nacimiento_muerte DATE,
tipo_autor VARCHAR,
dias_prestamo INTEGER
);
--crear tabla historial prestamos
CREATE TABLE prestamos(
id_prestamo SERIAL PRIMARY KEY,
id_socio INTEGER NOT NULL REFERENCES socios(id),
id_libro VARCHAR REFERENCES libros(ISBN),
socio VARCHAR (255),
libro VARCHAR (255),
fecha_prestamos DATE,
fecha_devolucion DATE
);
--inserción de registros
\copy socios(rut, nombre, apellido, direccion, telefono) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/socios.csv' csv header;
\copy libros(ISBN,titulo,paginas,cod_autor,nombre_autor,apellido_autor,nacimiento_muerte,tipo_autor,dias_prestamo) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/libros.csv' csv header;
\copy prestamos(socio,libro,fecha_prestamos,fecha_devolucion) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/historialprestamos.csv' csv header;