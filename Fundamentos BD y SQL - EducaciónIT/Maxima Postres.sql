create database M_Postres;
use M_Postres;

create table Productos (
ProductoID integer not null primary key auto_increment,
Nombre varchar(50) not null,
Precio integer(4) not null
);

insert into Productos (ProductoID,Nombre,Precio) values (default,'Chocotorta',450);
insert into Productos (ProductoID,Nombre,Precio) values (default,'Tiramisu',500);
insert into Productos (ProductoID,Nombre,Precio) values (default,'Postre Frutilla',300);
insert into Productos (ProductoID,Nombre,Precio) values (default,'postre durazno',350);

create table Clientes (
ClienteID integer not null primary key auto_increment,
Nombre varchar(50) not null,
Apellido varchar(50) not null
);

insert into Clientes (ClienteID,Nombre,Apellido) values (default,'Florencia','Rodriguez');
insert into Clientes (ClienteID,Nombre,Apellido) values (default,'Elena','Deluca');
insert into Clientes (ClienteID,Nombre,Apellido) values (default,'Pilar','Gonzalez');

create table producto_cliente (
ProductoID integer,
ClienteID integer,
Direccion varchar (80),
Fecha_Entrega datetime
);

CREATE USER 'Maxima'@'localhost' IDENTIFIED BY '12345';
GRANT ALL PRIVILEGES ON * . * TO 'Maxima'@'localhost';


alter table producto_cliente 
add constraint fk_producto 
foreign key (ProductoID) 
references Productos(ProductoID);

alter table producto_cliente 
add constraint fk_cliente 
foreign key (ClienteID) 
references Clientes(ClienteID);