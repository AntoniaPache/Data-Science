-- creacion base de datos y tablas

drop database if exists Laboratorio;

create database Laboratorio;
use Laboratorio;

create table Laboratorio.Articulos (
ArticuloID integer primary key not null unique,
Nombre varchar(50) not null,
Precio double,
Stock integer);

create table Laboratorio.Clientes (
ClienteID integer primary key not null unique,
Nombre varchar(50),
Apellido varchar(50),
Cuit char(16),
Direccion varchar(50),
Comentarios varchar(50)
);

create table Laboratorio.Facturas (
Letra char,
Numero integer,
ClienteID integer,
ArticuloID integer,
Fecha date,
Monto double,
primary key (Letra,Numero)
);

show databases;
show tables;
describe Clientes;
describe Facturas;
describe Articulos;
show collation;
show charset;

-- creando al usario del laboatorio/no ejecutado o cambiado para su publicación

-- create user 'cientifico'@'localhost' identified by '1a2z3r$4t5h6';
-- grant all privileges on laboratorio to 'cientifico'@'localhost';
-- flush privileges;

-- probando modificaciones en las tablas

alter table Facturas
change ClienteID IDcliente integer,
change ArticuloID IDarticulo integer,
modify Monto double unsigned;

alter table Articulos
change ArticuloID IDarticulo integer,
modify Nombre varchar(75) not null,
modify Precio double unsigned not null,
modify Stock integer unsigned not null;

alter table Clientes
change ClienteID IDcliente integer,
modify Nombre varchar(30) not null,
modify Apellido varchar(35) not null,
change Comentarios Observaciones varchar(255);

-- insertar registros

insert into Facturas
values ('A',28,14,335,'2021-03-18',1589.50),
('A',39,26,157,'2021-04-12',979.75),
('B',8,17,95,'2021-04-25',513.35),
('B',12,5,411,'2021-05-03',2385.7),
('B',19,50,157,'2021-05-26',979.75);

insert into Articulos
values(95, 'Webcam y microfono Plug & Play',513.35,39),
(157,'Apple Airpods pro',979.75,152),
(335,'Lavasecarropas automatico Samsung',1589.50,12),
(411,'Gloria Trevi CD',2385.7,2);

insert into Clientes
values(5,'Santiago','Gonzales',23-24582359-9,'Uriburu 558 - 7ºA','VIP'),
(14,'Gloria','Fernandez',23-35965852-5,'Constitución 323','GBA'),
(17,'Gonzalo','Lopez',23-33587416-0,'Arias 2624','GBA'),
(26,'Carlos','Garcia',23-42321230-9,'Pasteur 322 - 2ºC','VIP'),
(50,'Micaela','Altieri',23-22885566-5,'Santamarina 1255','GBA');

-- cargado archivo csv clientes_neptuno
select * from clientes_neptuno;

alter table clientes_neptuno
modify IDCliente varchar(5) primary key,
modify NombreCompania varchar(100) not null,
modify Pais varchar(15) not null;

alter table Clientes rename Contactos;
-- cargado archivo csv clientes

alter table Clientes
modify Cod_cliente varchar(7) primary key,
modify Empresa varchar(100) not null,
modify Ciudad varchar(25) not null,
modify Telefono int unsigned,
modify Responsable varchar(30);

-- cargado archivo csv pedidos

alter table pedidos
modify numero_pedido integer primary key,
modify codigo_cliente varchar(7) not null,
modify fecha_pedido date not null,
modify forma_pago enum ('aplazado','contado','tarjeta'),
modify enviado enum ('si','no');

-- cargado archivo csv productos

alter table productos
modify cod_producto integer primary key,
modify seccion varchar(20) not null,
modify nombre varchar(40) not null,
modify importado enum ('falso', 'verdadero'),
modify origen varchar(25) not null,
modify dia int unsigned not null,
modify mes int unsigned not null,
modify ano int unsigned not null;

-- Consultas

select * from clientes_neptuno;
select nombrecompania, ciudad, pais from clientes_neptuno;
select nombrecompania, ciudad, pais from clientes_neptuno order by pais;
select nombrecompania, ciudad, pais from clientes_neptuno order by pais, ciudad;
select nombrecompania, ciudad, pais from clientes_neptuno order by pais, ciudad limit 10;
select nombrecompania, ciudad, pais from clientes_neptuno order by pais, ciudad limit 5 offset 10;

select * from nacimientos;
select * from nacimientos where nacionalidad = 'extranjera';
select * from nacimientos where edad_madre < 18 order by edad_madre;
select * from nacimientos where edad_madre = edad_padre;
select * from nacimientos where edad_padre-edad_madre < 40;
select * from nacimientos where semanas < 20 order by semanas desc;
select * from nacimientos where sexo='femeninio' and nacionalidad='extranjera' and estado_civil_madre='soltera' and edad_madre>40;
select * from nacimientos where comuna in (1101, 3201, 5605, 8108, 9204, 13120, 15202) order by comuna;
select * from nacimientos where hijos_total > 10;
select fecha, left(sexo,1) as 'Sexo', left(tipo_parto,1) as 'Tipo' from nacimientos;
select sexo, fecha, tipo_parto, atenc_part, local_part, substring(fecha,4,2) as Mes from nacimientos order by Mes;
select sexo, fecha, tipo_parto, replace(nacionalidad,'chilena','ciudadana') as nacionalidad from nacimientos;

select * from clientes_neptuno;
select * from clientes_neptuno where pais='argentina';
select * from clientes_neptuno where pais <> 'argentina' order by pais;
select * from clientes_neptuno where pais='argentina' or pais='brasil' or pais='venezuela' order by pais, ciudad;
select * from clientes_neptuno where semanas between 20 and 25 order by semanas;
select * from clientes_neptuno where IDCliente like 'C%';
select * from clientes_neptuno where Ciudad like 'B____';
select IDCliente, NombreCompania, concat_ws('-', direccion, ciudad, pais) as 'ubicacion'  from clientes_neptuno;
select IDCliente, upper(NombreCompania) Empresa, concat_ws('-', direccion, ciudad, pais) as 'ubicacion'  from clientes_neptuno;
select lower(IDCliente) Codigo, upper(NombreCompania) Empresa, concat_ws('-', direccion, ciudad, pais) as 'Ubicacion'  from clientes_neptuno;
select *, upper(concat(left(ciudad,1), left(pais,1), right(pais,2))) as Codigo from clientes_neptuno;

