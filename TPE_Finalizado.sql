-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-09-27 16:20:36.483

-- tables
-- Table: Barrio
CREATE TABLE Barrio (
    id_barrio int  NOT NULL,
    nombre varchar(20)  NOT NULL,
    id_ciudad int  NOT NULL,
    CONSTRAINT Barrio_pk PRIMARY KEY (id_barrio)
);

-- Table: Categoria
CREATE TABLE Categoria (
    id_cat int  NOT NULL,
    nombre varchar(50)  NOT NULL,
    CONSTRAINT Categoria_pk PRIMARY KEY (id_cat)
);

-- Table: Ciudad
CREATE TABLE Ciudad (
    id_ciudad int  NOT NULL,
    nombre varchar(80)  NOT NULL,
    CONSTRAINT Ciudad_pk PRIMARY KEY (id_ciudad)
);

-- Table: Cliente
CREATE TABLE Cliente (
    id_cliente int  NOT NULL,
    saldo numeric(18,3)  NULL,
    CONSTRAINT Cliente_pk PRIMARY KEY (id_cliente)
);

-- Table: Comprobante
CREATE TABLE Comprobante (
    id_comp bigint  NOT NULL,
    id_tcomp int  NOT NULL,
    fecha timestamp  NULL,
    comentario varchar(2048)  NOT NULL,
    estado varchar(20)  NULL,
    fecha_vencimiento timestamp  NULL,
    id_turno int  NULL,
    importe numeric(18,5)  NOT NULL,
    id_cliente int  NOT NULL,
    CONSTRAINT pk_comprobante PRIMARY KEY (id_comp,id_tcomp)
);

-- Table: Direccion
CREATE TABLE Direccion (
    id_direccion int  NOT NULL,
    id_persona int  NOT NULL,
    calle varchar(50)  NOT NULL,
    numero int  NOT NULL,
    piso int  NULL,
    depto varchar(50)  NULL,
    id_barrio int  NOT NULL,
    CONSTRAINT Direccion_pk PRIMARY KEY (id_direccion,id_persona)
);

-- Table: Equipo
CREATE TABLE Equipo (
    id_equipo int  NOT NULL,
    nombre varchar(80)  NOT NULL,
    MAC varchar(20)  NULL,
    IP varchar(20)  NULL,
    AP varchar(20)  NULL,
    id_servicio int  NOT NULL,
    id_cliente int  NOT NULL,
    fecha_alta timestamp  NOT NULL,
    fecha_baja timestamp  NULL,
    tipo_conexion varchar(20)  NOT NULL,
    tipo_asignacion varchar(20)  NOT NULL,
    CONSTRAINT Equipo_pk PRIMARY KEY (id_equipo)
);

-- Table: LineaComprobante
CREATE TABLE LineaComprobante (
    nro_linea int  NOT NULL,
    id_comp bigint  NOT NULL,
    id_tcomp int  NOT NULL,
    descripcion varchar(80)  NOT NULL,
    cantidad int  NOT NULL,
    importe numeric(18,5)  NOT NULL,
    id_servicio int  NULL,
    CONSTRAINT pk_lineacomp PRIMARY KEY (nro_linea,id_comp,id_tcomp)
);

-- Table: Mail
CREATE TABLE Mail (
    id_persona int  NOT NULL,
    mail varchar(120)  NOT NULL,
    tipo varchar(20)  NOT NULL,
    CONSTRAINT Mail_pk PRIMARY KEY (id_persona,mail)
);

-- Table: Persona
CREATE TABLE Persona (
    id_persona int  NOT NULL,
    tipo varchar(10)  NOT NULL,
    tipodoc varchar(10)  NOT NULL,
    nrodoc varchar(10)  NOT NULL,
    nombre varchar(40)  NOT NULL,
    apellido varchar(40)  NOT NULL,
    fecha_nacimiento timestamp  NOT NULL,
    fecha_baja timestamp  NULL,
    CUIT varchar(20)  NULL,
    activo boolean  NOT NULL,
    CONSTRAINT pk_persona PRIMARY KEY (id_persona)
);

-- Table: Personal
CREATE TABLE Personal (
    id_personal int  NOT NULL,
    id_rol int  NOT NULL,
    CONSTRAINT Personal_pk PRIMARY KEY (id_personal)
);

-- Table: Rol
CREATE TABLE Rol (
    id_rol int  NOT NULL,
    nombre varchar(50)  NOT NULL,
    CONSTRAINT Rol_pk PRIMARY KEY (id_rol)
);

-- Table: Servicio
CREATE TABLE Servicio (
    id_servicio int  NOT NULL,
    nombre varchar(80)  NOT NULL,
    periodico boolean  NOT NULL,
    costo numeric(18,3)  NOT NULL,
    intervalo int  NULL,
    tipo_intervalo varchar(20)  NULL,
    activo boolean  NOT NULL DEFAULT true,
    id_cat int  NOT NULL,
    CONSTRAINT CHECK_0 CHECK (( tipo_intervalo in ( 'semana' , 'quincena' , 'mes' , 'bimestre' ) )) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT pk_servicio PRIMARY KEY (id_servicio)
);

-- Table: Telefono
CREATE TABLE Telefono (
    id_persona int  NOT NULL,
    carac int  NOT NULL,
    numero int  NOT NULL,
    CONSTRAINT Telefono_pk PRIMARY KEY (id_persona,carac,numero)
);

-- Table: TipoComprobante
CREATE TABLE TipoComprobante (
    id_tcomp int  NOT NULL,
    nombre varchar(30)  NOT NULL,
    tipo varchar(80)  NOT NULL,
    CONSTRAINT pk_tipo_comprobante PRIMARY KEY (id_tcomp)
);

-- Table: Turno
CREATE TABLE Turno (
    id_turno int  NOT NULL,
    desde timestamp  NOT NULL,
    hasta timestamp  NULL,
    dinero_inicio numeric(18,3)  NOT NULL,
    dinero_fin numeric(18,3)  NULL,
    id_personal int  NOT NULL,
    CONSTRAINT Turno_pk PRIMARY KEY (id_turno)
);

-- foreign keys
-- Reference: LineaComprobante_Servicio (table: LineaComprobante)
ALTER TABLE LineaComprobante ADD CONSTRAINT LineaComprobante_Servicio
    FOREIGN KEY (id_servicio)
    REFERENCES Servicio (id_servicio)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_barrio_ciudad (table: Barrio)
ALTER TABLE Barrio ADD CONSTRAINT fk_barrio_ciudad
    FOREIGN KEY (id_ciudad)
    REFERENCES Ciudad (id_ciudad)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_cliente_persona (table: Cliente)
ALTER TABLE Cliente ADD CONSTRAINT fk_cliente_persona
    FOREIGN KEY (id_cliente)
    REFERENCES Persona (id_persona)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_comprobante_cliente (table: Comprobante)
ALTER TABLE Comprobante ADD CONSTRAINT fk_comprobante_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente (id_cliente)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_comprobante_tipocomprobante (table: Comprobante)
ALTER TABLE Comprobante ADD CONSTRAINT fk_comprobante_tipocomprobante
    FOREIGN KEY (id_tcomp)
    REFERENCES TipoComprobante (id_tcomp)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_comprobante_turno (table: Comprobante)
ALTER TABLE Comprobante ADD CONSTRAINT fk_comprobante_turno
    FOREIGN KEY (id_turno)
    REFERENCES Turno (id_turno)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_direccion (table: Direccion)
ALTER TABLE Direccion ADD CONSTRAINT fk_direccion
    FOREIGN KEY (id_persona)
    REFERENCES Persona (id_persona)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_direccion_barrio (table: Direccion)
ALTER TABLE Direccion ADD CONSTRAINT fk_direccion_barrio
    FOREIGN KEY (id_barrio)
    REFERENCES Barrio (id_barrio)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_equipo_cliente (table: Equipo)
ALTER TABLE Equipo ADD CONSTRAINT fk_equipo_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES Cliente (id_cliente)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_equipo_servicio (table: Equipo)
ALTER TABLE Equipo ADD CONSTRAINT fk_equipo_servicio
    FOREIGN KEY (id_servicio)
    REFERENCES Servicio (id_servicio)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_lineacomprobante_comprobante (table: LineaComprobante)
ALTER TABLE LineaComprobante ADD CONSTRAINT fk_lineacomprobante_comprobante
    FOREIGN KEY (id_comp, id_tcomp)
    REFERENCES Comprobante (id_comp, id_tcomp)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_mail_persona (table: Mail)
ALTER TABLE Mail ADD CONSTRAINT fk_mail_persona
    FOREIGN KEY (id_persona)
    REFERENCES Persona (id_persona)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_personal_persona (table: Personal)
ALTER TABLE Personal ADD CONSTRAINT fk_personal_persona
    FOREIGN KEY (id_personal)
    REFERENCES Persona (id_persona)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_personal_rol (table: Personal)
ALTER TABLE Personal ADD CONSTRAINT fk_personal_rol
    FOREIGN KEY (id_rol)
    REFERENCES Rol (id_rol)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_personal_turno (table: Turno)
ALTER TABLE Turno ADD CONSTRAINT fk_personal_turno
    FOREIGN KEY (id_personal)
    REFERENCES Personal (id_personal)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_servicio_categoria (table: Servicio)
ALTER TABLE Servicio ADD CONSTRAINT fk_servicio_categoria
    FOREIGN KEY (id_cat)
    REFERENCES Categoria (id_cat)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: fk_telefono (table: Telefono)
ALTER TABLE Telefono ADD CONSTRAINT fk_telefono
    FOREIGN KEY (id_persona)
    REFERENCES Persona (id_persona)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

INSERT INTO Persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, CUIT, activo)
VALUES ('1','Cliente','DNI','39216947','Tobias','Romano','1994-04-05','1997-06-23',null,false);

INSERT INTO Persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, CUIT, activo)
VALUES ('2','Cliente','DNI','38216947','Tomas','Downlordi','1996-04-05',null,null,true);

INSERT INTO Persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, CUIT, activo)
VALUES ('3','Cliente','DNI','37216947','Felipe','Gonzalez','1995-04-05',null,null,true);

INSERT INTO Persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, CUIT, activo)
VALUES ('4','Cliente','DNI','36216947','Eduardo','Vibart','1998-04-05',null,null,true);

INSERT INTO Persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, CUIT, activo)
VALUES ('5','Personal','DNI','35216947','Willy','Barbagallo','1999-04-05',null,null,true);

INSERT INTO Persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, CUIT, activo)
VALUES ('6','Personal','DNI','34216947','Ricky','Martin','2000-04-05',null,null,true);

INSERT INTO Cliente
VALUES ( '1', '10000' );
INSERT INTO Cliente
VALUES ( '2', '15000' );
INSERT INTO Cliente
VALUES ( '3', '3000' );
INSERT INTO Cliente
VALUES ( '4', '45000' );

Insert into Categoria
values ( '1', 'Mantenimiento' );

Insert into Servicio
values ( '1', 'Reparacion', 'false', '10000.000', '5',null, 'true', '1' );
Insert into Servicio
values ( '2', 'Limpieza', 'true', '100.000', '5',null, 'false', '1');
insert into Servicio
values ( '3', 'Instalacion', 'true', '100.000', '5',null, 'true', '1' );
insert into Servicio
values ( '4', 'Formateo', 'true', '100.000', '5',null, 'true', '1' );

INSERT INTO Equipo (id_equipo, nombre, MAC, IP, AP, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES ('11','E1',null,203040,null,'1','1','2000-01-01',null,'PPTP','IP FIJA');
INSERT INTO Equipo (id_equipo, nombre, MAC, IP, AP, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES ('20','E20',null,203040,null,'1','2','2000-01-01',null,'PPTP','IP FIJA');
INSERT INTO Equipo (id_equipo, nombre, MAC, IP, AP, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES ('12','E2',null,null,null,'1','1','2001-01-01',null,'PPTP','IP FIJA');
INSERT INTO Equipo (id_equipo, nombre, MAC, IP, AP, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES ('13','E3',null,null,null,'2','2','2002-01-01',null,'PPTP','IP FIJA');
INSERT INTO Equipo (id_equipo, nombre, MAC, IP, AP, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES ('14','E4',null,null,null,'2','3','2003-01-01',null,'PPTP','IP FIJA');
INSERT INTO Equipo (id_equipo, nombre, MAC, IP, AP, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES ('15','E5',null,null,null,'3','3','2003-01-01','2021-09-27','PPTP','IP FIJA');
INSERT INTO Equipo (id_equipo, nombre, MAC, IP, AP, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES ('16','E6',null,null,null,'3','3','2003-01-01','2018-09-27','PPTP','IP FIJA');
INSERT INTO Equipo (id_equipo, nombre, MAC, IP, AP, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES ('17','E7',null,null,null,'4','3','2003-01-01','2018-09-27','PPTP','IP FIJA');

UPDATE Equipo set fecha_baja = '2021-09-27' where nombre = 'E1';
UPDATE Equipo set fecha_baja = '2021-09-24' where nombre = 'E2';
UPDATE Equipo set fecha_baja = '2020-09-27' where nombre = 'E3';
UPDATE Equipo set fecha_baja = '2018-09-27' where nombre = 'E4';



INSERT INTO Ciudad (id_ciudad, nombre)
VALUES ('1','Berazategui');
INSERT INTO Ciudad (id_ciudad, nombre)
VALUES ('2','Ituzaingo');

INSERT INTO Barrio (id_barrio, nombre, id_ciudad)
VALUES ('1','Batan','1');

INSERT INTO Barrio (id_barrio, nombre, id_ciudad)
VALUES ('2','Boca','2');

Insert into Direccion
values ('1', '1', 'Saavedra', '765', '5', '23', '1' );
Insert into Direccion
values ('2', '2', 'Uriburu', '1590', null, null, '2' );
Insert into Direccion
values ('3', '3', 'Bunge', '456', null, null, '2' );
Insert into Direccion
values ('4', '4', 'España', '765', '5', '23', '2' );


-- Ejercicio 1 --
-- a) Mostrar el listado de todos los clientes registrados en el sistema (id, apellido y nombre, tipo y
-- número de documento, fecha de nacimiento) junto con la cantidad de equipos registrados
-- que cada uno dispone, ordenado por apellido y nombre.--
select c.id_cliente, p.apellido, p.nombre, p.tipo, p.nrodoc, p.fecha_nacimiento, count(e.id_cliente) as "Can_equipos_registrados"
from cliente c
join persona p on (p.id_persona = c.id_cliente)
join equipo e on c.id_cliente = e.id_cliente
group by c.id_cliente, p.apellido, p.nombre, p.tipo, p.nrodoc, p.fecha_nacimiento
order by p.apellido, p.nombre;

-- b) Realizar un ranking (de mayor a menor) de la cantidad de equipos instalados y aún activos,
-- durante los últimos 24 meses, según su distribución geográfica, mostrando: nombre de
-- ciudad, id de la ciudad, nombre del barrio, id del barrio y cantidad de equipos. --
select c.nombre, c.id_ciudad, b.nombre, b.id_barrio, count(e.id_equipo) as "Cant.Equipos"
from equipo e
join direccion d on d.id_persona = e.id_cliente
join barrio b on b.id_barrio = d.id_barrio
join ciudad c on c.id_ciudad = b.id_ciudad
where (current_date - e.fecha_baja) <= '2 years'
group by c.nombre, c.id_ciudad, b.nombre, b.id_barrio
order by "Cant.Equipos" DESC;

-- c) Visualizar el Top-3 de los lugares donde se ha realizado la mayor cantidad de servicios
-- periódicos durante los últimos 3 años --
select c.nombre, c.id_ciudad, b.nombre, b.id_barrio, count(s.id_servicio) as "Cant.Servicios"
from Servicio s
join equipo e on s.id_servicio=e.id_servicio
join direccion d on d.id_persona = e.id_cliente
join barrio b on b.id_barrio = d.id_barrio
join ciudad c on c.id_ciudad = b.id_ciudad
where (current_date - e.fecha_baja) <= '3 years' and s.periodico=true
group by c.nombre, c.id_ciudad, b.nombre, b.id_barrio
order by "Cant.Servicios" DESC
limit 3;

-- d) Indicar el nombre, apellido, tipo y número de documento de los clientes que han contratado
-- todos los servicios periódicos cuyo intervalo se encuentra entre 5 y 10. --
select p.nombre, p.apellido, p.tipo, p.nrodoc
from cliente c
join persona p on p.id_persona = c.id_cliente
where NOT EXISTS(
    select s1.id_servicio
    from servicio s1
    where s1.periodico is true and (s1.intervalo between 5 and 10)
    except
    select s2.id_servicio
    from servicio s2
    join equipo e on s2.id_servicio = e.id_servicio
    where ((e.id_cliente=c.id_cliente) and (s2.intervalo between 5 and 10) and s2.periodico is true)
    );

--Ejercicio 2

--a) Si una persona está inactiva debe tener establecida una fecha de baja, la cual se debe
--controlar que sea al menos 18 años posterior a la de nacimiento.

ALTER TABLE Persona
ADD CONSTRAINT AlMenos18 CHECK ((activo is true) and ((fecha_baja - fecha_nacimiento) < '18 years'));
--Tipo de RI check de tupla: porque relaciona mas de un atributo dentro de la misma tupla.

--b) El importe de un comprobante debe coincidir con la suma de los importes de sus líneas (si
--las tuviera).
/*CREATE ASSERTION ImporteComprobante
CHECK NOT EXISTS (SELECT 1
                  FROM Comprobante c
                  JOIN lineacomprobante l on (c.id_comp = l.id_comp) and (c.id_tcomp = l.id_tcomp)
                  group by (l.id_comp, l.id_tcomp)
                  having (sum(l.importe)== c.importe)
                  );*/ --preguntar que pasa si lineacomprobante no existe, con el cero y eso
--Tipo de RI Generales (ASSERTION) ya que accede a atributos de distintas tablas.

--c)Un equipo puede tener asignada un IP, y en este caso, la MAC resulta requerida.
ALTER TABLE Equipo
ADD CONSTRAINT IpMac CHECK (ip is null and mac is null);
--Tipo de RI check de tupla: porque relaciona mas de un atributo dentro de la misma tupla.
--Como es una RI de tupla ya está implementada de la mejor manera

--d) Las IPs asignadas a los equipos no pueden ser compartidas entre clientes
ALTER TABLE Equipo
ADD CONSTRAINT IpCompartidas CHECK (1 >= (
    (select count(e.id_cliente)
    from equipo e
    group by (e.ip))
    ));
--Tipo de RI check de tabla: porque relaciona mas de un tupla dentro de la misma tabla.
CREATE OR REPLACE FUNCTION FN_IPS() RETURNS trigger AS $$
    DECLARE
        cant integer;
    BEGIN
        select count(distinct e.id_cliente) into cant
        from equipo e
        where e.ip is not null
        group by (e.ip);
        if (1 < (cant)) THEN
            RAISE EXCEPTION 'Esta Ip ya está asignada a un cliente';
        END if;
        RETURN NEW;
END $$ LANGUAGE 'plpgsql';

CREATE TRIGGER TR_IPS
AFTER INSERT OR UPDATE OF ip
ON equipo
FOR EACH ROW EXECUTE PROCEDURE FN_IPS();


--e)No se pueden instalar más de 25 equipos por Barrio.
/*CREATE ASSERTION MasDe25EquiposPorBarrio
CHECK NOT EXISTS (SELECT 1
                    FROM Barrio b
                    join direccion d on b.id_barrio = d.id_barrio
                    join persona p on d.id_persona = p.id_persona
                    join equipo e on p.id_persona = e.id_cliente
                    group by b.id_barrio
                    having (count(e.id_equipo)>25)
                  );*/
--Tipo de RI Generales (ASSERTION) ya que accede a atributos de distintas tablas.

CREATE OR REPLACE FUNCTION FN_MENOS_25_EQUIPOS_POR_BARRIO() RETURNS trigger AS $$
DECLARE
BEGIN
 if (EXISTS (SELECT 1
                    FROM Barrio b
                    join direccion d on b.id_barrio = d.id_barrio
                    join equipo e on d.id_persona = e.id_cliente
                    group by b.id_barrio
                    having (count(e.id_equipo)>25))) THEN
        RAISE EXCEPTION 'NO SE PUEDEN INSTALAR MAS DE 25 EQUIPOS POR BARRIO';
 END IF;
RETURN NEW;
END $$
LANGUAGE 'plpgsql';

CREATE TRIGGER TR_MENOS_25_EQUIPOS_POR_BARRIO1
AFTER INSERT OR UPDATE OF id_cliente
ON EQUIPO
FOR EACH ROW EXECUTE PROCEDURE FN_MENOS_25_EQUIPOS_POR_BARRIO();

CREATE TRIGGER TR_MENOS_25_EQUIPOS_POR_BARRIO2
AFTER INSERT OR UPDATE OF id_barrio
ON Direccion
FOR EACH ROW EXECUTE PROCEDURE FN_MENOS_25_EQUIPOS_POR_BARRIO();

--Ejercicio 3 Vistas:
/*
a. Realice una vista que contenga el saldo de cada uno de los clientes que tengan domicilio en
    la ciudad ‘X’.
 */
CREATE OR REPLACE VIEW cliente_domicilio_view as
    select c.saldo
    from cliente c
    where c.id_cliente in (
        select d.id_persona
        from direccion d
        where d.id_barrio in(
            select b.id_barrio
            from barrio b
            where b.id_ciudad in (
                select c1.id_ciudad
                from ciudad c1
                where c1.nombre = 'Berazategui'
            )
        )
    )
    with check option;

--Si es automaticamente actualizable porque tiene una sola tabla o vista en el from, no posee joins no tiene subconsultas en el select
-- y nno posee ninguana clausula como with, distinct, group by, having, limit u offset.
--ejemplos para wco:

--teniendo en cuenta estas tuplas ingresadas:
INSERT INTO Barrio (id_barrio, nombre, id_ciudad)
VALUES ('1','Batan','1');
Insert into Direccion
values ('1', '1', 'Saavedra', '765', '5', '23', '1' );
INSERT INTO Cliente
VALUES ( '1', '10000' );
INSERT INTO Cliente
VALUES ( '6', '65484' );


--ingresara debido al wco:
INSERT INTO Ciudad (id_ciudad, nombre)
VALUES ('1','Berazategui');

--No ingresara debido al wco:
INSERT INTO Ciudad (id_ciudad, nombre)
VALUES ('6','Juancito');


/*
 b. Realice una vista con la lista de servicios activos que posee cada cliente junto con el costo
    del mismo al momento de consultar la vista.
 */
create view servicios_clientes_view as
    select e.id_cliente, s.id_servicio,s.nombre, s.costo, s.periodico
    from servicio s
    join equipo e on e.id_servicio=s.id_servicio
    where s.activo is true;
--No es automaticamente actualizable ya que posee un join.create or replace view servicios_clientes_view as

create or replace function ServicioActivo() returns trigger AS $$
BEGIN
    if(tg_op='INSERT') then
        if (not exists(select e.id_equipo from equipo e
            where new.id_cliente =id_cliente)) then
            raise exception 'No existe el cliente ';
        else
            if (exists(select s.id_servicio
                from servicio s
                where new.id_servicio=id_servicio))then
                update servicio set nombre=new.nombre,periodico=new.periodico, costo=new.costo where id_servicio=new.id_servicio;
            else
                insert into servicio values (new.id_servicio,new.nombre,new.periodico, new.costo,null,null,true ,-1);--seteamos la nueva tupla como activa valor discernible para id_cat
            end if;
        end if;
        return new;
    end if;
    if(tg_op= 'UPDATE') then
        if (not exists(select e.id_equipo from equipo e
            where new.id_cliente=id_cliente)) then
            raise exception 'No existe el cliente ';
        else
            if (not exists(select s.id_servicio
                from servicio s
                where new.id_servicio=id_servicio))then
                raise exception 'No existe el servicio a actualizar.';
            else
                update servicio set nombre=new.nombre,periodico=new.periodico, costo=new.costo where id_servicio=new.id_servicio;
            end if;
        end if;
        return new;
    end if;
    if(tg_op = 'DELETE')then
        if (not exists(select s.id_servicio
                from servicio s
                where new.id_servicio=id_servicio))then
            raise exception 'No existe el servicio a borrar.';
        else
            delete from servicio where id_servicio = old.id_servicio;
        end if;
        return old;
    end if;
END $$
LANGUAGE 'plpgsql';

CREATE TRIGGER TG_servicios_clientes_view
INSTEAD OF INSERT OR UPDATE OR DELETE
ON servicios_clientes_view
 FOR EACH ROW EXECUTE PROCEDURE ServicioActivo();

--Caso en el cual el trigger es disparado:
UPDATE servicios_clientes_view set nombre='Aceite',costo=300,periodico=true where id_servicio=1;
--con este update lo que se hace es para la tupla de la vista con id_servicio=1 se le cambian los atributos que estan luego del 'set'.
--Esto hace que se dispare el trigger y cambie en la tabla de 'Servicios' el servicio con id_servicio=1 por los atributos dados.


/*
c. Realice una vista que contenga, por cada uno de los servicios periódicos registrados, el
    montoor  facturado mensualmente durante los últimos 5 años ordenado pservicio, año, mes y
    monto
 */
create or replace view servicios_periodicos_view as
    select s.id_servicio, sum(c.importe)
    from servicio s
    join lineacomprobante l on s.id_servicio = l.id_servicio
    join comprobante c on l.id_comp = c.id_comp
    where s.periodico is true and (current_date - c.fecha) < '5 years'
    group by s.id_servicio, extract(year from c.fecha),extract (month from(c.fecha))
    order by (s.id_servicio,extract(year from c.fecha),extract (month from(c.fecha)), sum(c.importe));
--No es automaticamente actualizable ya que posee un join, gorup by, sum


insert into tipocomprobante(id_tcomp, nombre, tipo) values (1,'hola','hola');

insert into comprobante(id_comp, id_tcomp, fecha, comentario, estado, fecha_vencimiento, id_turno, importe, id_cliente) values
(1,1,'01/01/2020','hola',null,null,null,10,1);
insert into comprobante(id_comp, id_tcomp, fecha, comentario, estado, fecha_vencimiento, id_turno, importe, id_cliente) values
(2,1,'11/01/2020','hola',null,null,null,10,1);

insert into lineacomprobante(nro_linea, id_comp, id_tcomp, descripcion, cantidad, importe, id_servicio) values
(1,1,1,'hola',10,10,2);
insert into lineacomprobante(nro_linea, id_comp, id_tcomp, descripcion, cantidad, importe, id_servicio) values
(2,2,1,'hola',10,10,2);


/*
 a. Proveer el mecanismo que crea más adecuado para que al ser invocado (una vez por mes),
tome todos los servicios que son periódicos y genere la/s factura/s correspondiente/s. Indicar si
se deben proveer parámetros adicionales para su generación. Explicar además cómo
resolvería el tema de la invocación mensual (pero no lo implemente).
 */

--a)
create or replace procedure generadorFacturas() as $$
declare
    idComprobante bigint;
    clienteActual int;
    i int; --contador para las lineas
    servicioActual record;
    importeMensual numeric(18,5);
    tipoComprobanteFactura int;
    tipoComprobanteRemito int;
begin
    if(exists(select t.id_tcomp from tipocomprobante t where t.tipo = 'factura'))then
        tipoComprobanteFactura:= (select t.id_tcomp from tipocomprobante t where t.tipo = 'factura');--caso en que la tabla tipo de comprobante esta cargada y para sacar el tipo factura realizamos una constulta;
    else
        tipoComprobanteFactura:=-1; --caso contrario asignamos valor por defecto.
    end if;

    if(exists(select t.id_tcomp from tipocomprobante t where t.tipo = 'remito')) then
        tipoComprobanteRemito:=(select t.id_tcomp from tipocomprobante t where t.tipo = 'remito');
    else
        tipoComprobanteRemito:=-2;
    end if;

    for clienteActual in (
        select id_cliente
        from equipo e
        join servicio s on e.id_servicio = s.id_servicio
        where s.periodico is true
        group by (id_cliente)
        ) loop

        idComprobante:= coalesce((select max(c.id_comp) from comprobante c),0)+1; --nuevo id_comprobante
        i:=1; --iterador para la linea del comprobante
        importeMensual:=0;


        for servicioActual in (
            select s.id_servicio, s.costo, count(s.id_servicio) as cantServicios
            from servicio s
            join equipo e on e.id_servicio = s.id_servicio
            where ( s.periodico is true and e.id_cliente = clienteActual)
            group by (s.id_servicio, s.costo)
            ) loop

            importeMensual:= importeMensual + servicioActual.costo * servicioActual.cantServicios;
            insert into lineacomprobante(nro_linea, id_comp, id_tcomp, descripcion, cantidad, importe, id_servicio) values
            (i,idComprobante,tipoComprobanteFactura,'Linea Comprobante automatica',servicioActual.cantServicios,servicioActual.costo,servicioActual.id_servicio);
            i:=i+1;

        end loop;

        importeMensual:= importeMensual + (select
                            from comprobante c
                            where c.id_tcomp = tipoComprobanteRemito and (c.id_cliente = clienteActual) and ((extract(month from c.fecha)) = (extract(month from current_date)-1))
                            );

        insert into comprobante(id_comp, id_tcomp, fecha, comentario, estado, fecha_vencimiento, id_turno, importe, id_cliente) values
        (idComprobante,tipoComprobanteFactura,current_date,'Comprobante automatico',null,null,null,importeMensual,clienteActual);

    end loop;

end;
$$ language 'plpgsql';

call generadorFacturas();--sentencia para ejecutar el procedimiento
--La manera de que se ejecute mensualmente seria generar un trigger que al detectar el cambio de mes mediante la funcion current_date, llame al procedimiento generadorFacturas()



--b)
/*
 b. Proveer el mecanismo que crea más adecuado para que al ser invocado retorne el inventario
consolidado de los equipos actualmente utilizados. Se necesita un listado que por lo menos
tenga: el nombre del equipo, el tipo, cantidad y si lo considera necesario puede agregar más
datos.
 */
create or replace view equipos_actualmente_utilizados_view as
    select e.nombre, e.tipo_asignacion, e.tipo_conexion, count(e.nombre)
    from equipo e
    where e.fecha_baja < current_date or e.fecha_baja is null
    group by (e.nombre, e.tipo_asignacion, e.tipo_conexion);

insert into equipo values (18,'E1',null,null,null,3,3,'2002-01-01',null,'PPTP', 'IP FIJA');

--c)
/*
c. Proveer el mecanismo que crea más adecuado para que al ser invocado entre dos fechas
cualesquiera dé un informe de los empleados junto con la cantidad de turnos resueltos por
localidad y los tiempos promedio y máximo del conjunto de cada uno.
 */

create or replace function crearInforme(fecha1 date, fecha2 date) returns table (
    id_empleado int, nombre varchar, turnosLocalidad int, tiemposPromedio numeric(18,3), tiemposMaximo numeric(18,3)
                                                                                ) language plpgsql as $$
    begin
        return query
            select p.id_persona, p.nombre, count(*), avg(t.hasta-t.desde), max(t.hasta-t.desde)
            from persona p
            join turno t on t.id_personal = p.id_persona
            join comprobante c on t.id_turno = c.id_turno
            join direccion d on p.id_persona = d.id_persona
            join barrio b on d.id_barrio = b.id_barrio
            where t.hasta is not null and (t.desde between fecha1 and fecha2) and (t.hasta between fecha1 and fecha2)
            group by p.id_persona, p.nombre, b.id_ciudad;
    end;
    $$