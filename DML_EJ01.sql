/*
PROYECTO: Sistema de Gestión de Rodajes Cinematográficos
VERSIÓN: 1.0 (Versionado para GitHub)
DESCRIPCIÓN: Script integral de manipulación de datos (DML).
Incluye carga inicial, lógica de negocio, manejo de errores y limpieza.
AUTOR: Sebastian Acaro, Mauricio Guevara, Erick Lopez y Santiago Mora
*/

-- =============================================
-- 1. CONFIGURACIÓN DE ENTORNO Y LIMPIEZA
-- =============================================
SET LINESIZE 160;
SET PAGESIZE 50;

-- Limpieza de datos en orden inverso a las FK para evitar errores de integridad
DELETE FROM PARTICIPACION;
DELETE FROM PELICULA;
DELETE FROM ACTOR;
DELETE FROM DIRECTOR;
DELETE FROM ESTADO_RODAJE;
DELETE FROM GENERO_PELICULA;
COMMIT;

-- =============================================
-- 2. INSERCIÓN DE CATÁLOGOS (Tablas Independientes)
-- =============================================

-- GENERO_PELICULA
INSERT INTO GENERO_PELICULA VALUES (1, 'Drama',      'Narrativas emocionales profundas');
INSERT INTO GENERO_PELICULA VALUES (2, 'Acción',     'Secuencias de alto impacto visual');
INSERT INTO GENERO_PELICULA VALUES (3, 'Thriller',   'Suspenso y tensión psicológica');
INSERT INTO GENERO_PELICULA VALUES (4, 'Documental', 'Narrativa basada en hechos reales');

-- ESTADO_RODAJE
INSERT INTO ESTADO_RODAJE VALUES (1, 'Pre-producción',  'Etapa de planificación y casting');
INSERT INTO ESTADO_RODAJE VALUES (2, 'En rodaje',       'Filmación activa en locaciones');
INSERT INTO ESTADO_RODAJE VALUES (3, 'Post-producción', 'Edición, sonido y efectos visuales');
INSERT INTO ESTADO_RODAJE VALUES (4, 'Finalizada',      'Película completamente terminada');
INSERT INTO ESTADO_RODAJE VALUES (5, 'Suspendida',      'Producción detenida temporalmente');

-- =============================================
-- 3. CARGA DE ENTIDADES PRINCIPALES
-- =============================================

-- DIRECTORES
INSERT INTO DIRECTOR VALUES (1, 'Alejandro Fuentes', 'México',    'a.fuentes@cinemax.com',  18);
INSERT INTO DIRECTOR VALUES (2, 'Sofía Restrepo',    'Colombia',  's.restrepo@cinemax.com', 12);
INSERT INTO DIRECTOR VALUES (3, 'Marco Valdez',      'Ecuador',   'm.valdez@cinemax.com',    7);
INSERT INTO DIRECTOR VALUES (4, 'Isabel Quiroga',    'Argentina', 'i.quiroga@cinemax.com',   9);

-- ACTORES
INSERT INTO ACTOR VALUES (1, 'Carlos Ibáñez',  'México',    'c.ibanez@actors.com',   1800.00);
INSERT INTO ACTOR VALUES (2, 'Laura Mendoza',  'Colombia',  'l.mendoza@actors.com',  2200.00);
INSERT INTO ACTOR VALUES (3, 'Renata Vásquez', 'Ecuador',   'r.vasquez@actors.com',  1500.00);
INSERT INTO ACTOR VALUES (4, 'Diego Palomino', 'Perú',      'd.palomino@actors.com', 1200.00);
INSERT INTO ACTOR VALUES (5, 'Camila Ríos',    'Venezuela', 'c.rios@actors.com',     1950.00);

-- =============================================
-- 4. OPERACIONES DE PELÍCULAS Y PARTICIPACIONES
-- =============================================

-- PELÍCULAS
INSERT INTO PELICULA VALUES (1, 'El último horizonte', 4500000, DATE '2025-01-10', DATE '2025-06-30', 1, 1, 2);
INSERT INTO PELICULA VALUES (2, 'Código Rojo',         7200000, DATE '2025-03-01', DATE '2025-09-15', 2, 2, 2);
INSERT INTO PELICULA VALUES (3, 'Sombras del Norte',   2100000, DATE '2025-07-01', DATE '2025-11-30', 3, 3, 1);
INSERT INTO PELICULA VALUES (4, 'Marea Oscura',        3000000, DATE '2025-08-01', DATE '2025-12-31', 3, 4, 1);

-- PARTICIPACIONES
INSERT INTO PARTICIPACION VALUES (1, 1, 'Protagonista',         45);
INSERT INTO PARTICIPACION VALUES (1, 3, 'Antagonista',          30);
INSERT INTO PARTICIPACION VALUES (2, 2, 'Protagonista',         60);
INSERT INTO PARTICIPACION VALUES (2, 4, 'Personaje secundario', 20);
INSERT INTO PARTICIPACION VALUES (3, 1, 'Personaje secundario', 25);
INSERT INTO PARTICIPACION VALUES (3, 3, 'Protagonista',         50);
INSERT INTO PARTICIPACION VALUES (3, 5, 'Inspectora Vargas',    35);

COMMIT;

-- =============================================
-- 5. ACTUALIZACIONES (UPDATES)
-- =============================================

-- P4: Actualizar correo institucional de Marco Valdez
UPDATE DIRECTOR
SET    correo_director = 'm.valdez.new@cinemax.com'
WHERE  nombre_director = 'Marco Valdez';

-- P5: Sombras del Norte pasa al estado En rodaje
UPDATE PELICULA
SET    id_estado_rodaje_per = (
           SELECT id_estado_rodaje FROM ESTADO_RODAJE
           WHERE  nombre_estado = 'En rodaje'
       )
WHERE  titulo_pelicula = 'Sombras del Norte';

-- P6: Reajuste de tarifa mínima para actores por debajo de 1500.00
UPDATE ACTOR
SET    tarifa_diaria = 1500.00
WHERE  tarifa_diaria < 1500.00;

COMMIT;

-- =============================================
-- 6. ELIMINACIONES JERÁRQUICAS (DELETES)
-- =============================================

-- P7: Dar de baja a Diego Palomino (eliminando dependencias primero)
DELETE FROM PARTICIPACION
WHERE id_actor_per = (SELECT id_actor FROM ACTOR WHERE nombre_actor = 'Diego Palomino');

DELETE FROM ACTOR
WHERE nombre_actor = 'Diego Palomino';

-- P8: Eliminar género Acción con toda su cadena de dependencias
DELETE FROM PARTICIPACION
WHERE id_pelicula_per IN (
    SELECT id_pelicula FROM PELICULA
    WHERE  id_genero_per = (SELECT id_genero FROM GENERO_PELICULA WHERE nombre_genero = 'Acción')
);

DELETE FROM PELICULA
WHERE id_genero_per = (SELECT id_genero FROM GENERO_PELICULA WHERE nombre_genero = 'Acción');

DELETE FROM GENERO_PELICULA
WHERE nombre_genero = 'Acción';

COMMIT;

-- =============================================
-- 7. SECCIÓN DE PRUEBAS DE ERRORES (Comentadas)
-- =============================================
/*
-- ERROR A: Check fecha_fin_rodaje > fecha_inicio_rodaje
INSERT INTO PELICULA VALUES (5, 'Tormenta Interior', 5000000, DATE '2025-12-01', DATE '2025-06-01', 1, 1, 1);

-- ERROR B: Check correo de actor sin '@'
INSERT INTO ACTOR VALUES (6, 'Pedro Alonso', 'España', 'pedroalonso.com', 3000);

-- ERROR C: PK compuesta duplicada en PARTICIPACION
INSERT INTO PARTICIPACION VALUES (1, 1, 'Narrador', 10);

-- ERROR D: UPDATE sin WHERE (catastrófico, Oracle no lo bloquea)
-- UPDATE ACTOR SET tarifa_diaria = 0;
-- ROLLBACK;

-- ERROR E: Check tarifa negativa en UPDATE
-- UPDATE ACTOR SET tarifa_diaria = -500 WHERE nombre_actor = 'Carlos Ibáñez';
*/