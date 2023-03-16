use Argentina;
select departamentos.id 'codigo depto', departamentos.provincia_id 'pcia del depto', departamentos.nombre 'npmbre departamento', 
localidades.id 'codigo localidad', localidades.departamento_id 'depto de localidad', localidades.nombre 'nombre localidad',
provincias.id 'codigo pcia', provincias.nombre 'nombre pcia'
from departamentos,localidades,provincias;