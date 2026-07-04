

/* Contar alumnos por ciudad */

select ciudad, count(*) as cantidad_alumnos
from alumnos
group by ciudad;


select ciudad, avg(edad) as edad_promedio_ciudad
from alumnos
group by ciudad;

/* Alumnos por ciudad y por edad*/

select ciudad, edad, count(*) as cantidad
from alumnos
group by ciudad, edad;


select ciudad, count(*) as mayores
from alumnos
where edad >= 18
group by ciudad;

select ciudad, count(*) as cantidad
from alumnos
group by ciudad
having count(*) > 1;

select ciudad, count(*) as cantidad, avg(edad) as edad_prom
from alumnos
group by ciudad
having count(*) > 1 and avg(edad) >= 20;

select ciudad, count(*) as total
from alumnos
group by ciudad;

select ciudad, avg(edad) as edad_prom
from alumnos
group by ciudad;

select ciudad, count(*)
from alumnos
group by ciudad
having  count(*)> 1;

select ciudad, min(edad)
from alumnos
group by ciudad
having min(edad) >= 18;

//////////////////////////////////////////////////////////////////////////
inner join /* Devuelve solo las filas que coinciden 
en ambas tablas*/
left join /* Devuelve todas las filas de la tabla
 izquierda y las coincidencias
 de la tabla derecha (o NULL si no hay coincideancias)*/
right join /*Devuelve las filas de la tabla derecha
y las coincidentes de la tabla izquierda (o NULL si no hay coincidencias)*/


create table cursos (
id INT,
curso varchar(50)
);

insert into cursos (id, curso) values
(1, 'Matemáticas'),
(2, 'Historia'),
(3, 'Inglés');

create table inscripciones (
alumno_id int,
curso_id int
);

insert into inscripciones (alumno_id, curso_id) values
(1, 1), -- Ana en Matemáticas
(1, 3), -- Ana en Inglés
(2, 2), -- Juan en Historia
(3, 1), -- Laura en Matemáticas
(4, 3); -- Pedro en Inglés

/* LECCIÓN 1.9: JOINS, combinando tablas en SQL*/

select a.nombre, c.curso
from inscripciones i
inner join alumnos a on i.alumno_id = a.id
inner join cursos c on i.curso_id = c.id;


/////////////////////////////////////////////////////////////////////////////

/* LECCIÓN 1.10: Sub consultas. */

select max(edad) from alumnos;

select nombre, edad
from alumnos
where edad = (select max(edad) from alumnos);


delete from alumnos;

insert into alumnos values
(1, 'Ana', 20, 'Buenos Aires'),
(2, 'Juan', 17, 'Ciudad de México'),
(3, 'Laura', 22, 'Madrid'),
(4, 'Pedro', 18, 'Madrid');

create table alumnos(
  id int primary key,
 nombre varchar(50),
 edad int,
 ciudad varchar(50)
);

select ciudad, promedio
from (
select ciudad, avg(edad) as promedio
from alumnos
group by ciudad
) as sub
where promedio > 18;

select nombre, edad,
 (select avg(edad) from alumnos) as promedio_general
from alumnos;

select nombre
from alumnos
where id in (
 select alumno_id
 from inscripciones
 where curso_id = (
  select id from cursos
  where curso = 'Inglés'
 )
);

select curso
from cursos
where id in (
 select curso_id
 from inscripciones
 group by curso_id
 having count(*) > 1
);

select nombre, edad
from alumnos
where edad = (select min(edad) from alumnos);

select ciudad, promedio
from (
 select ciudad, avg(edad) as promedio
 from alumnos
 group by ciudad
 ) as sub;

select nombre
from alumnos
where id in(
 select alumno_id
 from inscripciones
 where curso_id = (
select id from cursos where curso = 'Matemáticas'
 )
);
///////////////////////////////////////////////////////////////////////

/* Lección 1.11: Vistas en SQL*/

create view alumnos_mayores as
select nombre, edad, ciudad
from alumnos
where edad >= 18;

select*
from alumnos_mayores

create view vista_alumnos_cursos as
select a.nombre, c.curso
from inscripciones i
inner join alumnos a on i.alumno_id = a.id
inner join cursos c on i.curso_id = c.id;


select* 
from vista_alumnos_cursos;

create view alumnos_por_curso as
select c.curso, count(i.alumno_id) as cantidad_alumnos
from cursos c
left join inscripciones i on  c.id = i.curso_id
group by c.curso;

select*
from alumnos_por_curso;


create view vista_madrid as
select*
from alumnos
where ciudad = 'Madrid';

select*
from vista_madrid;

create view alumnos_historia as
select a.nombre
from alumnos a
join inscripciones i on a.id = i.alumno_id
join cursos c on i.curso_id = c.id
where c.curso = 'Historia';

select* 
from alumnos_historia;

create view edad_promedio_por_ciudad as
select ciudad, avg(edad) as promedio
from alumnos
group by ciudad;

select*
from edad_promedio_por_ciudad;

/////////////////////////////////////////////////////////////////////////////////

/* Lecciòn 1.12: Funciones de texto y fecha */

select nombre, upper(nombre) as nombre_mayus
from alumnos;

select nombre, lower(nombre) as nombre_minus
from alumnos;

select concat(nombre, '-', ciudad) as alumno_info
from alumnos;

select nombre, length(nombre) as cantidad_letras
from alumnos;

select nombre, substring(ciudad, 1, 5) as ciudad_corta
from alumnos;

/* Fechas */

now() Fecha y hora actual
curdate() devuelve solo la fecha actual
year(fecha) devuelve el año
month(
day()
datediff(fecha1, fecha2) diferencia entre dos fechas


create table profesores(
id int,
nombre varchar(50),
fecha_contratación date
);

insert into profesores (id, nombre, fecha_contratación) values
(1, 'Marta', '2020-03-15'),
(2, 'Roberto', '2018-07-01'),
(3, 'Sofía', '2022-11-20');

select nombre, extract (year from fecha_contratación) as año
from profesores;

select nombre, extract(month from fecha_contratación) as mes,
extract(day from fecha_contratación) as día
from profesores;

select nombre, (
current_date - fecha_contratación) as días_antiguedad
from profesores;

select nombre, upper(nombre) as nombre_mayus
from alumnos;

select nombre, length(nombre) as longitud_nombre
from alumnos;

select concat(nombre, '--', ciudad) as alumno_info
from alumnos;

select nombre, extract(year from fecha_contratación) as año_contratación
from profesores;

select nombre, (
current_date - fecha_contratación) as días_laborando
from profesores
where nombre = 'Roberto';

////////////////////////////////////////////////////////////////////////////////////////////////

/*Lección 1.13: Funciones INSERT, UPDATE y DELETE*/


insert into alumnos values
(5, 'Carla', 19, 'Lima');

insert into alumnos values
(6, 'Diego', 21, 'Bogotá'),
(7, 'Lucía', 20, 'Santiago');

/* Para actulizar información con update
 siempre se debe usar el where, de lo contrario, se actualizará toda la tabla*/

 La sintaxis es la siguente:

 update nombre de la tabla
 set columna = nuevo valor
 where condición

 update alumnos
 set edad = 18
 where nombre = 'Juan';


update alumnos
set ciudad = 'Barcelona'
where ciudad = 'Madrid';

/* El delete sirve para eliminar filas de una tabla */

La sintaxis es la siguiente:
delete from nombre tabla
where condición

delete from alumnos
where nombre = 'Carla';


delete from alumnos
where edad < 18;

/* Si el delete se ejecuta sin el where, se borrará toda la tabla */

insert into alumnos values
(8, 'María', 21, 'Buenos Aires');

select*
from alumnos;

insert into alumnos values
(9, 'José', 20, 'Lima'),
(10, 'Paula', 23, 'Bogotá');


update alumnos
set ciudad = 'Montevideo'
where nombre = 'María';

delete from alumnos
where ciudad = 'Lima';
/////////////////////////////////////////////////////////////////////////

/*Lección 1.14 Creación y modificación de tablas (Create y alter table)*/

create table empleados (
 id int,
 nombre varchar(50),
 salario decimal(10,2),
 fecha_contratación date
);

insert into empleados values
(1, 'Marta', 2500.5, '2020-03-15'),
(2, 'Roberto', 3000.0, '2018-07-01'),
(3, 'Sofía', 2800.75, '2022-11-20');


select*
from empleados;

alter table empleados add column ciudad varchar(50);

update empleados set ciudad = 'Madrid' where id = 1;
update empleados set ciudad = 'Barcelona' where id = 2;
update empleados set ciudad = 'Sevilla' where id =3;


alter table empleados rename column ciudad to localidad;

alter table empleados drop column localidad;

alter table empleados alter column nombre type varchar(100);


create table productos (
 id int,
 nombre varchar(50),
 precio decimal(10,2),
 stock int
);

insert into productos values
(1, 'Laptop', 25000.6, 10),
(2, 'Mouse', 600.7, 50),
(3, 'Teclado', 978.9, 30);

select*
from productos;

alter table productos add column categoría varchar(50);
update productos set categoría = 'T' where id = 1;
update productos set categoría = 'M' where id = 2;
update productos set categoría = 'Tec' where id = 3;

alter table productos rename precio to precio_unitario;

alter table productos drop column stock;

//////////////////////////////////////////////////////////////////////////////
/* Lección 1.15: Claves y restricciones en SQL*/

primary key: identifica de forma única cada fila.
foreign key: conecta tablas entre sí.
not null: Impide valores vacíos.
unique: Evita duplicados.
default: Define un valor por defecto.

create table departamentos (
id int primary key,
nombre varchar(50) not null
);

create table empleados (
id int primary key,
nombre varchar(50) not null,
email varchar(100) unique,
salario decimal(10,2) default 1000.00,
departamento_id int,
foreign key (departamento_id) references departamentos(id)
);

insert into departamentos (id, nombre) values
(1, 'Recursos Humanos');

insert into empleados (id, nombre, departamento_id) values
(1, 'Laura', 1);

create table categorias (
id int primary key,
nombre varchar(60) not null
);

create table productos (
id int primary key,
nombre varchar(50) not null,
precio decimal(10,2) default 10,
categoria_id int,
foreign key (categoria_id) references categorias(id)
);


insert into categorias (id, nombre) values
(1, 'Tecnología');

insert into productos (id, nombre, categoria_id) values
(1, 'Mouse', 1);

insert into categorias (id, nombre) values
(1, 'Ropa'); /* Intento fallido. Dos categorías con el mismo id*/

insert into productos (id, nombre, precio, categoria_id) values
(2, 'Teclado', 456.8, 'R');
/* Arroja error porque la categoría no existe */

///////////////////////////////////////////////////////////////////////////////////

/* Lección 1.16: índices y optimización básica*/

La sintaxis básica es

cretae index nombre_indice
on nombre_tabla(columna);

Para crear índices únicos:
create unique index nombre_índice
on nombre_tabla (columna);

create table empleados (
id int primary key,
nombre varchar(50),
ciudad varchar(50),
salario decimal(10,2)
);

insert into empleados (id, nombre, ciudad, salario) values
(1, 'Ana', 'Madrid', 2500.00),
(2, 'Juan', 'Barcelona', 2200.00),
(3, 'Laura', 'Sevilla', 2700.00),
(4, 'Pedro', 'Madrid', 2000.00);

select*
from empleados
where ciudad = 'Madrid';


create index idx_ciudad 
on empleados(ciudad);


alter table empleados add column email varchar(100);

create unique index idx_email
on empleados(email);

create index idx_ciudad_salario
on empleados(ciudad, salario);

select*
from empleados
where ciudad = 'Madrid' and salario > 2200;

drop index idx_ciudad;


create index indice on
empleados(ciudad);


select*
from empleados
where ciudad = 'Barcelona';


create index indice_email
on empleados(email);

insert into empleados values
(5, 'Juancho', 'Berlín', 2340.00, juancho@gamail.com)
(6, 'Maribel', 'Venezia', 2800.0, juancho@gamail.com);
///////////////////////////////////////////////////////////////////////////

/* Transacciones en SQL: */

create table cuentas (
id int primary key,
titular varchar(100),
saldo decimal(12,2)
);

insert into cuentas (id, titular, saldo) values
(1, 'Ana', 1000.0),
(2, 'Juan', 500.0);

start transaction;

update cuentas
set saldo = saldo - 200
where titular = 'Ana';


update cuentas
set saldo = saldo + 200
where titular = 'Juan';

commit;

select*
from cuentas;
rollback;

update cuentas
set saldo = saldo - 600
where titular = 'Juan';

start transaction;

insert into cuentas (id, titular, saldo) values
(3, 'Laura', 300.0);
update cuentas
set saldo = saldo + 50
where titular = 'Juan';

delete from cuentas
where titular = 'Ana';

rollback;


start transaction;

update cuentas
set saldo = saldo - 100
where titular = 'Juan';

update cuentas
set saldo = saldo + 100
where titular = 'Ana';

select*
from cuentas;

rollback;

start transaction;

update cuentas
set saldo = saldo - 100
where titular = 'Juan';

update cuentas
set saldo = saldo + 100
where titular = 'Gabriel';
rollback;

start transaction;
insert into cuentas (id, titular, saldo) values
(3, 'Laura', 300.00);
commit;

start transaction;
delete from cuentas 
where titular = 'Laura';
rollback;

/////////////////////////////////////////////////////////////
/* Lección 18: CASE y funciones de ventana: */
 La función CASE permite crear condiciones
 dentro de una consulta.

 Las funciones de ventana (row_number, rank, partition by) permiten analizar
 datos fila por fila dentro de un conjunto.

 create table ventas (
id int,
vendedor varchar(60),
monto decimal (10, 2),
ciudad varchar(50)
 );

insert into ventas (id, vendedor, monto, ciudad) values
(1, 'Ana', 500.0, 'Madrid'),
(2, 'Juan', 800, 'Madrid'),
(3, 'Laura', 300, 'Barcelona'),
(4, 'Pedro', 900, 'Madrid'),
(5, 'Sofía', 400, 'Barcelona'),
(6, 'Diego', 700, 'Madrid');

select vendedor, monto,
 case
  when monto >= 700 then 'Alta'
  else 'Baja'
 end as categoria
from ventas;

select vendedor, monto,
 case
  when monto >= 800 then 'Muy alta'
  when monto >= 500 then 'Media'
  else 'Baja'
 end as categoria
from ventas;

/* Las funciones de ventana no agrupan como group by*/
Numerar filas con row_number

select vendedor, monto,
 row_number() over (order by monto desc) as posicion
from ventas; 

select vendedor, monto,
 rank () over(order by monto desc) as rankin
from ventas;
Con ranking, si dos observaciones poseen el mismo valor
serán identificados con el mismo ranking.

partition by para separar grupos

select vendedor, ciudad, monto,
 row_number() over(partition by ciudad order by monto desc)
as pos_ciudad
from ventas;

select vendedor, monto,
 case 
  when monto >=600 then 'Bien'
  when monto < 600 then 'No bien'
 end as tipo_venta
from ventas;

select vendedor, monto,
 rank() over(order by monto desc) 
 as ranking
from ventas;
 
select vendedor, ciudad, monto,
 row_number() over(partition by ciudad order by monto desc)
 as pos_ciudad
from ventas
order by monto desc;

/* Lección 1.19: Proyecto-- Base de datos biblioteca*/

--PASO 1: Creación de base de datos.

-- Table autores--
create table autores (
id int primary key,
nombre varchar(100),
nacionalidad varchar(50)
);

-- Tabla de libros --
create table libros (
id int primary key,
título varchar(150),
id_autor int,
año_publicación int,
disponible boolean,
foreign key (id_autor) references autores(id)
);

create table préstamos (
id int primary key,
id_libro int,
nombre_usuario varchar(100),
fecha_préstamo date,
fecha_devolución date,
foreign key (id_libro) references libros(id)
);

-- PASO 2: Insertar datos en tablas.

--Autores--
insert into autores (id, nombre, nacionalidad) values
(1, 'Gabriel García Márquez', 'Colombiana'),
(2, 'Miguel de Cervantes', 'Española'),
(3, 'Jane Austen', 'Británica');


-- Libros --
insert into libros (id, título, id_autor, año_publicación, disponible) values
(1, 'Cien años de soledad', 1, 1967, true),
(2, 'El quijote', 2, 1605, false),
(3, 'Orgullo y prejuicio', 3, 1813, true);

-- Préstamos --

insert into préstamos (id, id_libro, nombre_usuario, fecha_préstamo, fecha_devolución) values
(1, 2, 'Laura', '2025-08-08', null),
(2, 1, 'Pedro', '2025-07-15', '2025-07-30');

select l.título, a.nombre as autores
from libros l
inner join autores a on l.id_autor = a.id;

select l.título, p.nombre_usuario, p.fecha_préstamo
from préstamos p
inner join libros l on p.id_libro = l.id
where p.fecha_devolución is null;

-- Contar cuántos libros escribió cada autor

select a.nombre as autor, count(l.id) as libros_escritos
from autores a
left join libros l on a.id = l.id_autor
group by a.nombre;

-- Ranking de usuarios con más préstamos

select nombre_usuario, count(*) as cantidad_préstamos
from préstamos
group by nombre_usuario
order by cantidad_préstamos desc;



---- EJERCICIO:

select título, disponible
from libros
where disponible = 'true';

select p.nombre_usuario, l.título, a.nombre as autor
from préstamos p
inner join libros l on p.id_libro = l.id
inner join autores a on l.id_autor = a.id;

select min(año_publicación) as más_antiguo,
max(año_publicación) as más_reciente
from libros;

select a.nacionalidad, count(l.id) as cantidad_libros
from autores a
inner join libros l on a.id = l.id_autor
group by a.nacionalidad;

insert into préstamos (id, id_libro, nombre_usuario, fecha_préstamo, fecha_devolución) values
(3, 3, 'Carlos', '2026-06-17', null );

----------------------------------------------------------------------------------------------------------------------------
--------- EXAMEN FINAL -----------------------------------------------------------
--------------------------------------------------------------------------------------------


-- Consulta 1:
select l.título, a.nombre as autor
from libros l
inner join autores a on l.id_autor = a.id;

-- Consulta 2:

select l.título, p.nombre_usuario, p.fecha_préstamo
from préstamos p
inner join libros l on p.id_libro = l.id
where p.fecha_devolución is null;

-- Consulta 3:

select a.nacionalidad, count(l.título) as cantidad_libros
from libros l
inner join autores a on l.id_autor = a.id
group by a.nacionalidad;

-- Consulta 4:
select min(año_publicación) as más_antiguo,
max(año_publicación) as más_reciente
from libros;

-- Consulta 5:

select p.nombre_usuario, count(l.título) as libros_prestados
from préstamos p
left join libros l on p.id_libro = l.id
group by p.nombre_usuario;

-- Consulta 6:

insert into préstamos (id, id_libro, nombre_usuario, fecha_préstamo,
fecha_devolución) values
(4, 3, 'Carlos', current_date, null);

delete 
from préstamos
where id = 3;
/* Se eliminó por duplicado */

-- Cosulta 7:
create view vista_libros_disponibles as
select título
from libros
where disponible = true;

select*
from vista_libros_disponibles;

-- Consulta 8:

select título
from libros 
where año_publicación = (
 select max (año_publicación) as libro_más_reciente
 from libros);

-- Consulta 9:

update libros
set disponible = true
where título = 'El quijote';

select*
from libros;

-- Consulta 10:

begin;/* Inicia cambios */

update libros
set disponible = false
where título = 'Cien años de soledad';

insert into préstamos (id, id_libro, nombre_usuario, 
fecha_préstamo, fecha_devolución) values
(3, 1, 'Juan', current_date, null);
commit; /* Confirma cambios*/

rollback /* Revierte cambios */

select*from libros;





















 

 
















