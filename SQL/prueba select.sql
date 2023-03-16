-- trabajando con select
use Argentina;
select * from provincias;
select * from localidades as ciudades order by departamento_id;
select nombre from localidades as ciudades order by id desc;
select nombre from localidades order by id limit 9 offset 45;
select id, nombre as ciudades from localidades;
select nombre from localidades where nombre like '%ce%';
select id,nombre from localidades where id > 25;
select id,nombre from localidades where id < 25;
select id,nombre from localidades where id = 25;
select 1=2;
