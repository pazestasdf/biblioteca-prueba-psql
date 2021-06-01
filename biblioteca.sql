DROP DATABASE IF EXISTS biblioteca;
-- Crear base de datos
CREATE DATABASE biblioteca;

-- Entrar a base de datos
\c biblioteca

-- CREACION DE TABLAS

-- 1. Crear Tabla Socio
CREATE TABLE socio( 
rut VARCHAR(10) PRIMARY KEY, 
nombre VARCHAR(100), 
apellido VARCHAR(100), 
direccion VARCHAR(150) UNIQUE, 
telefono VARCHAR(10) UNIQUE
);

-- 2. Crear Tabla Libro
CREATE TABLE libro(
isbn VARCHAR(13) PRIMARY KEY,
titulo VARCHAR(100),
paginas INTEGER,
dias_prestamo INTEGER
);

-- 3. Crear Tabla Prestamo
CREATE TABLE prestamo(
id SERIAL PRIMARY KEY,
rut_socio VARCHAR(10),
isbn VARCHAR(13),
fecha_prestamo DATE,
fecha_devolucion DATE
);

-- 4. Crear Tabla Autor
CREATE TABLE autor(
cod_autor SERIAL PRIMARY KEY,
nombre_autor VARCHAR(50),
apellido_autor VARCHAR(50),
nacimiento DATE,
muerte DATE
);

-- 5. Crear Tabla Libro_Autor
CREATE TABLE libro_autor(
isbn VARCHAR(13),
cod_autor INTEGER,
tipo_autor VARCHAR(20)
);

-- AGREGA LLAVES FORANEAS

ALTER TABLE prestamo ADD foreign key (rut_socio) references socio(rut);
ALTER TABLE prestamo ADD foreign key (isbn) references libro(isbn);
ALTER TABLE libro_autor ADD foreign key (isbn) references libro(isbn);
ALTER TABLE libro_autor ADD foreign key (cod_autor) references autor(cod_autor);

-- INSERTAR REGISTROS
\copy socio(rut, nombre, apellido, direccion, telefono) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/socios.csv' csv header;
\copy libro(isbn,titulo,paginas,dias_prestamo) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/libros.csv' csv header;
\copy prestamo(rut_socio,isbn,fecha_prestamo,fecha_devolucion) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/historialprestamos.csv' csv header;
\copy autor(cod_autor,nombre_autor,apellido_autor,nacimiento,muerte) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/autor.csv' NULL AS 'null' csv header;
\copy libro_autor(isbn,cod_autor,tipo_autor) FROM '/Users/mariapazcarrascoojeda/Desktop/basesdatos/prueba/libro_autor.csv' csv header;

--Consultas
--a. Mostrar todos los libros que posean menos de 300 páginas. (0.5 puntos)
SELECT * FROM libro WHERE paginas < 300;
--b. Mostrar todos los autores que hayan nacido después del 01-01-1970.(0.5 puntos)
SELECT * FROM autor WHERE nacimiento > '01-01-1970';
--c. ¿Cuál es el libro más solicitado? (0.5 puntos).
SELECT count(p.isbn), l.titulo FROM prestamo p
INNER JOIN libro l ON p.isbn = l.isbn
group by l.titulo
limit 1;
--d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.(0.5 puntos)
SELECT p.rut_socio, (((p.fecha_devolucion - p.fecha_prestamo)-7)*100) as MULTA from prestamo p
WHERE (p.fecha_devolucion - p.fecha_prestamo) > 7;