-- Bonus track modulo 1
create database Libreria;

create table Libreria.puestos (
puesto_id smallint primary key not null,
descripcion varchar(50)
);

create table Libreria.autores (
autor_id varchar(11) primary key not null,
apellido varchar(40),
nombre varchar(20),
telefono varchar(12),
direccion varchar(40),
ciudad varchar(20),
provincia char(2),
c_postal char(5),
estado tinyint(1)
);

create table Libreria.locales (
local_id char(4) primary key not null,
nombre varchar(40),
direccion varchar(40),
ciudad varchar(20),
provincia char(2),
c_postal char(5)
);

create table Libreria.libros (
libro_id varchar(6) primary key not null,
titulo varchar(80),
categoria char(12),
editorial_id char(4)primary key not null,
precio double,
comentarios varchar(200),
fecha_publicacion datetime
);

create table Libreria.empleados (
empleado_id char(9) primary key not null,
nombre varchar(20),
apellido varchar(30),
puesto_id smallint primary key not null,
editorial_id char(4) primary key not null,
fecha_ingreso datetime
);

create table Libreria.ventas (
local_id char(4) primary key not null,
factura_nro varchar(20),
fecha datetime,
cantidad smallint,
forma_pago varchar(12),
libro_id varchar(6)
);

create table Libreria.libroautor (
autor_id varchar(11) primary key not null,
libro_id varchar(6) primary key not null
);

create table Libreria.editoriales (
editorial_id char(4) primary key not null,
nombre varchar(40),
ciudad varchar(20),
provincia char(2),
pais varchar(30)
);
