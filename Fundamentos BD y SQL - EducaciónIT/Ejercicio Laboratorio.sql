
-- creacion base de datos y tablas

drop database if exists Laboratorio;

create database Laboratorio;
use Laboratorio;

create table Laboratorio.Articulos (
ArticuloID integer primary key not null auto_increment unique,
Nombre varchar(50) not null,
Precio double,
Stock integer);

create table Laboratorio.Clientes (
ClienteID integer primary key not null auto_increment unique,
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



-- punto 6
Insert into Facturas (Letra, Numero, ClienteID, ArticuloID, Fecha, Monto) values ('A','1',default,default, '2020_03_15','55.5');
insert into Facturas (Letra, Numero, ClienteID, ArticuloID, Fecha, Monto) values ('B','2',default,default,'2020_02_09','66.6');
insert into Facturas (Letra, numero, ClienteID, ArticuloID, Fecha, Monto) values ('C','3',default,default,'2020_04_22','77.7');
insert into Facturas (Letra, Numero, ClienteID, ArticuloID, Fecha, Monto) values ('D','4',default,default,'2020_02_09','88.8');
insert into Facturas (Letra, numero, ClienteID, ArticuloID, Fecha, Monto) values ('E','5',default,default,'2020_04_22','99.9');

insert into Articulos (ArticuloID, Nombre, Precio, Stock) values (default,'Vacunas','220','100');
insert into Articulos (ArticuloID, Nombre, Precio, Stock) values (default,'Reactivos','95','110');
insert into Articulos (ArticuloID, Nombre, Precio, Stock) values (default,'gotas','40','120');
insert into Articulos (ArticuloID, Nombre, Precio, Stock) values (default,'remedios','45','130');
insert into Articulos (ArticuloID, Nombre, Precio, Stock) values (default,'vendas','60','150');

insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Fernando','Fernandez','222','Argentina', null);
insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Elena','Ramirez','234','Argentina', null);
insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Sara','Hernandez','942','Brasil', null);
insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Joaquin','Fernandez','292','Chile', 'estudiante');
insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Federico','Henry','902','Argentina', 'jubilado'); 

-- modulo 2 del ej de laboratorio

select Nombre, Precio from Articulos where Precio > 100;
select Nombre, Precio from Articulos where Precio >= 20 and Precio <=40;
select Nombre, Precio from Articulos where Precio between 40 and 60;
Select Nombre, Precio, Stock from Articulos where Precio = 20 and Stock > 30;
select Nombre, Precio from Articulos where Precio=12 or Precio=20 or Precio=30;
select Nombre, Precio from Articulos where Precio in (12,20,30);
select Nombre, Precio from Articulos where Precio not in (12,20,30);

select Nombre, Precio, Stock from Articulos order by Precio desc;

select ArticuloID, Nombre, Precio, Stock, Precio * 0.21 as 'iva' from Articulos;

select ArticuloID, Nombre, Precio, Stock, 3 as 'cantidad de cuotas', (Precio / 3)*1.05 as 'valor de cuota' from Articulos;

-- modulo 3 del ej de laboratorio parte 1 DML

insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Sara','Herrera','200','Argentina', null);
insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Cornelio','Saavedra','444','Mexico', null);
insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Carlos','Gonzales','999','Argentina', null);
insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Horacio','Nitales','115','Argentina', null);
insert into Clientes (ClienteID, Nombre, Apellido, Cuit, Direccion, Comentarios) values (default,'Liliana','Hernandez','156','Peru', 'jubilado');

select* from Clientes;
update Clientes set Nombre = 'Jose' where ClienteID='10';
update Clientes set Nombre='Pablo', Apellido='Fuentes' where ClienteID='8';

SET SQL_SAFE_UPDATES = 0;-- evita el error 1175, desactiva el modo seguro que impide la modificación sin clave

update Clientes set Comentarios='' where Comentarios is null;

delete from Clientes where Apellido='Perez';
delete from Clientes where Cuit='%0';

update Articulos set Precio= precio*1.2 where Precio <= 50;
update Articulos set Precio= precio*1.15 where Precio > 50;
update Articulos set Precio= precio*0.95 where Precio > 200;
delete from Articulos where Stock < 0;
select * from Articulos;

SET SQL_SAFE_UPDATES = 1; -- Restaura el modo seguro

-- modulo 3 del ej Laboratorio practica

select Direccion, count(Direccion) as cantidad from Clientes group by Direccion;

select group_concat(Nombre), Apellido, Cuit, Direccion, Comentarios, count(Nombre) as cantidad 
from Clientes
group by Nombre
having cantidad > 1;

select ClienteID, Nombre, Apellido from Clientes where Nombre = 'Liliana';

delete from Clientes where ClienteID = '11';-- borrado de codigo duplicado

Insert into Facturas (Letra, Numero, ClienteID, ArticuloID, Fecha, Monto) values ('A','9',default,default,'2021_03_05','101');
Insert into Facturas (Letra, Numero, ClienteID, ArticuloID, Fecha, Monto) values ('C','8',default,default,'2021_04_26','28');


-- Ej Laboratorio modulo 3 parte 2 Funciones
select max(monto) as 'monto maximo factura' from Facturas;
select min(monto) as 'monto minimo factura' from Facturas;
select min(monto) from facturas where fecha between '2020_01_01' and '2020_12_31';
select avg(monto) as 'monto promedio factura' from Facturas;
select count(monto) as cantidad_facturas from Facturas;
select monto from Facturas where monto between 30 and 70;

select Year(fecha) as 'año', count(fecha) as 'cant de facturados' from Facturas group by Year(fecha);

select Letra, Numero, round(sum(monto),0) as SumaMontoPorLetra
from Facturas
group by Letra;

-- Ej Laboratorio modulo 4 parte 1
alter table Facturas add constraint fk_articulo foreign key (ArticuloID) references Articulos(ArticuloID);
alter table Facturas add constraint fk_cliente foreign key (ClienteID) references Clientes(ClienteID);
alter table Articulos add column Descripcion varchar(150);
alter table Articulos drop Descripcion;

insert into Facturas (Letra, Numero, ClienteID, ArticuloID, Fecha, Monto) values ('A','5',5,5,'2021_09_08','250');
alter table Clientes add column CPostal varchar (4);
alter table Clientes drop CPostal;

insert into Facturas (Letra, Numero, ClienteID, ArticuloID, Fecha, Monto) values ('B','4',1,2,'2021_09_08','250');
insert into Facturas (Letra, Numero, ClienteID, ArticuloID, Fecha, Monto) values ('C','1',3,1,'2021_09_08','250');

select *
from Facturas as f
join Clientes as c
on f.ClienteID=c.ClienteID;

select * from Clientes, Articulos;