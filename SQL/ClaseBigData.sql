create database SQLpractica;
use SQLpractica;

CREATE TABLE escuelas(id INT(11) NOT NULL AUTO_INCREMENT,
                      nombre VARCHAR(45) DEFAULT NULL,
                      localidad VARCHAR(45) DEFAULT NULL,
                      provincia VARCHAR(45) DEFAULT NULL,
                      capacidad INT(11) DEFAULT NULL,
                      PRIMARY KEY(id)); 

CREATE TABLE alumnos(id INT(11) NOT NULL AUTO_INCREMENT,
                     id_escuela INT(11) DEFAULT NULL,
                     legajo INT(11) DEFAULT NULL,
                     nombre VARCHAR(45) DEFAULT NULL,
                     nota DECIMAL(10,0) DEFAULT NULL,
                     grado INT(11) DEFAULT NULL,
                     email VARCHAR(45) NOT NULL,                     
                     PRIMARY KEY(id),
                     FOREIGN KEY(id_escuela) REFERENCES escuelas(id)
                     );
                  
INSERT INTO escuelas VALUES
(1, 'Normal 1', 'Quilmes', 'Buenos Aires', 250),
(2, 'Gral. San Martín','San Salvador', 'Jujuy', 100),
(3, 'Belgrano', 'Belgrano','Córdoba', 150),
(4, 'EET Nro 2', 'Avellaneda', 'Buenos Aires', 500),
(5, 'Esc.Nro 2 Tomás Santa Coloma', 'Capital Federal', 'Buenos Aires', 250);
  
INSERT INTO alumnos VALUES
(NULL,2,1000,'Ramón Mesa',8,1,'rmesa@rmail.com'),
(NULL,2,1002,'Tamara Smith',8,1,''),
(NULL,1,101,'Juan Pérez', 10,3,''),
(NULL,1,105,'Pietra González',9,3,''),
(NULL, 5,190, 'Roberto Luis Sánchez',8,3,'robertoluissanchez@rumail.com'),
(NULL, 4,106, 'Martina Bossio', NULL,3,''),
(NULL, 4,100, 'Jaime Jaramillo',3,1,'jj2021@pirimail.com'),
(NULL, 4, 1234,'Susana Gómez',6,2,'');
