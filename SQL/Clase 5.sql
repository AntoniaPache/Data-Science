use Argentina;

select count(*) as 'cantidad de provincias' from Provincias;
-- Consultar ID, nombre de la pcia y cant de deptos
select provincias.id, provincias.nombre, count(*) 'departamentos' 
from provincias, departamentos 
where provincias.id = departamentos.provincia_id
group by provincias.nombre
order by provincias.nombre desc;
-- trabajando con in (para evitar and u or)
select * from Provincias
where nombre in('San Luis','Tucuman');

-- Join y Qüerit
