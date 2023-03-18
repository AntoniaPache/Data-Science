create database sce;
use sce;

CREATE TABLE `Alumnos` (
   `ID` INT NOT NULL auto_increment,
   `Nombre` VARCHAR(50) NOT NULL,
   `Apellido` VARCHAR(55) NOT NULL,
   `email` VARCHAR(255) NOT NULL,
   `provincia_id` INT NOT NULL,
   PRIMARY KEY (`ID`)
);

CREATE TABLE `Provincia` (
   `ID` int primary key NOT NULL,
   `Nombre` varchar
); 

CREATE TABLE `Cursos` (
   `id` INT NOT NULL AUTO_INCREMENT,
   `Nombre` VARCHAR(100) NOT NULL,
   `Descripcion` VARCHAR(255) NOT NULL,
   `Precio` DOUBLE NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `alumno_curso` (
   `AlumnoID` INT NOT NULL,
   `CursoID` INT NOT NULL,
   `Nombre_curso` VARCHAR(100) NOT NULL,
   `id_compra` INT,
   `importe` DOUBLE NOT NULL,
   PRIMARY KEY (`id_compra`)
);


ALTER TABLE `Provincia` ADD CONSTRAINT `FK_037392d6-a2b0-4b9c-8c18-3d5f0ca56718` FOREIGN KEY (`ID`) REFERENCES `Alumnos`(`provincia_id`);

ALTER TABLE `alumno_curso` ADD CONSTRAINT `FK_55496536-f6e6-46d1-b703-dce17a666f84` FOREIGN KEY (`AlumnoID`) REFERENCES `Alumnos`(`ID`);

ALTER TABLE `alumno_curso` ADD CONSTRAINT `FK_55eacccf-c3b6-441b-8a5b-57fe3efe89ed` FOREIGN KEY (`CursoID`) REFERENCES `Cursos`(`id`);

ALTER TABLE `alumno_curso` ADD CONSTRAINT `FK_1fe71a1d-e90d-4b9b-a4f7-3237fbef45e9` FOREIGN KEY (`Nombre_curso`) REFERENCES `Cursos`(`Nombre`);

ALTER TABLE `alumno_curso` ADD CONSTRAINT `FK_0f605a3f-2428-4ff3-a68e-8bad5832e310` FOREIGN KEY (`importe`) REFERENCES `Cursos`(`Precio`);
