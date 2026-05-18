
-- =========================================================
-- SISTEMA DE GESTION DE LANZAMIENTOS ESPACIALES
-- SCRIPT COMPLETO
-- =========================================================

-- =========================================================
-- CREACION DE USUARIO
-- =========================================================

CREATE USER PEXPO2 IDENTIFIED BY PEXPO2;

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO PEXPO2;

CONNECT PEXPO2/PEXPO2;

-- =========================================================
-- CREACION DE TABLAS
-- =========================================================

CREATE TABLE TIPO_MISION (
    id_tipo_mision      NUMBER          PRIMARY KEY,
    nombre_tipo         VARCHAR2(50)    NOT NULL UNIQUE,
    descripcion_tipo    VARCHAR2(150)
);

CREATE TABLE ESTADO_MISION (
    id_estado_mision    NUMBER          PRIMARY KEY,
    nombre_estado       VARCHAR2(40)    NOT NULL UNIQUE,
    descripcion_estado  VARCHAR2(150)
);

CREATE TABLE NAVE (
    id_nave             NUMBER          PRIMARY KEY,
    codigo_nave         VARCHAR2(20)    NOT NULL UNIQUE,
    nombre_nave         VARCHAR2(80)    NOT NULL UNIQUE,
    capacidad_max       NUMBER(3)       NOT NULL,
    anio_fabricacion    NUMBER(4)       NOT NULL,

    CONSTRAINT chk_nave_capacidad
        CHECK (capacidad_max BETWEEN 1 AND 50),

    CONSTRAINT chk_nave_anio
        CHECK (anio_fabricacion >= 2000)
);

CREATE TABLE MISION (
    id_mision              NUMBER         PRIMARY KEY,
    nombre_mision          VARCHAR2(120) NOT NULL UNIQUE,
    destino                VARCHAR2(100) NOT NULL,
    fecha_lanzamiento      DATE          NOT NULL,
    fecha_retorno_est      DATE          NOT NULL,
    duracion_dias          NUMBER(5)     NOT NULL,
    id_tipo_mision_per     NUMBER        NOT NULL,
    id_nave_per            NUMBER        NOT NULL,
    id_estado_mision_per   NUMBER        NOT NULL,

    CONSTRAINT fk_mis_tipo
        FOREIGN KEY (id_tipo_mision_per)
        REFERENCES TIPO_MISION(id_tipo_mision),

    CONSTRAINT fk_mis_nave
        FOREIGN KEY (id_nave_per)
        REFERENCES NAVE(id_nave),

    CONSTRAINT fk_mis_estado
        FOREIGN KEY (id_estado_mision_per)
        REFERENCES ESTADO_MISION(id_estado_mision),

    CONSTRAINT chk_mis_fechas
        CHECK (fecha_retorno_est > fecha_lanzamiento),

    CONSTRAINT chk_mis_duracion
        CHECK (duracion_dias > 0)
);

CREATE TABLE ROL_TRIPULACION (
    id_rol_tripulacion NUMBER PRIMARY KEY,
    nombre_rol         VARCHAR2(50) NOT NULL UNIQUE,
    descripcion_rol    VARCHAR2(150)
);

CREATE TABLE ASTRONAUTA (
    id_astronauta         NUMBER PRIMARY KEY,
    codigo_astronauta     VARCHAR2(15) NOT NULL UNIQUE,
    nombre_astronauta     VARCHAR2(80) NOT NULL,
    nacionalidad          VARCHAR2(40) NOT NULL,
    correo_astronauta     VARCHAR2(80) NOT NULL UNIQUE,
    misiones_completadas  NUMBER(3) DEFAULT 0 NOT NULL,

    CONSTRAINT chk_ast_correo
        CHECK (correo_astronauta LIKE '%@%'),

    CONSTRAINT chk_ast_misiones
        CHECK (misiones_completadas >= 0)
);

CREATE TABLE TRIPULACION (
    id_mision_per             NUMBER NOT NULL,
    id_astronauta_per         NUMBER NOT NULL,
    id_rol_tripulacion_per    NUMBER NOT NULL,
    fecha_asignacion          DATE NOT NULL,

    CONSTRAINT pk_tripulacion
        PRIMARY KEY (id_mision_per, id_astronauta_per),

    CONSTRAINT fk_tri_mision
        FOREIGN KEY (id_mision_per)
        REFERENCES MISION(id_mision),

    CONSTRAINT fk_tri_astronauta
        FOREIGN KEY (id_astronauta_per)
        REFERENCES ASTRONAUTA(id_astronauta),

    CONSTRAINT fk_tri_rol
        FOREIGN KEY (id_rol_tripulacion_per)
        REFERENCES ROL_TRIPULACION(id_rol_tripulacion)
);

-- =========================================================
-- INSERTS
-- =========================================================

INSERT INTO TIPO_MISION VALUES (1, 'Exploracion Lunar', 'Misiones lunares');
INSERT INTO TIPO_MISION VALUES (2, 'Exploracion Marciana', 'Misiones a Marte');
INSERT INTO TIPO_MISION VALUES (3, 'Satelital', 'Mantenimiento satelital');

INSERT INTO ESTADO_MISION VALUES (1, 'Planificada', 'Mision planificada');
INSERT INTO ESTADO_MISION VALUES (2, 'En Curso', 'Mision activa');
INSERT INTO ESTADO_MISION VALUES (3, 'Completada', 'Mision finalizada');

INSERT INTO NAVE VALUES (1, 'NAV001', 'Odyssey I', 10, 2020);
INSERT INTO NAVE VALUES (2, 'NAV002', 'Galaxy Runner', 15, 2022);
INSERT INTO NAVE VALUES (3, 'NAV003', 'Nova Explorer', 8, 2024);

INSERT INTO ROL_TRIPULACION VALUES (1, 'Comandante', 'Lider de la mision');
INSERT INTO ROL_TRIPULACION VALUES (2, 'Piloto', 'Control de navegacion');
INSERT INTO ROL_TRIPULACION VALUES (3, 'Ingeniero', 'Mantenimiento tecnico');

INSERT INTO ASTRONAUTA VALUES (1, 'AST001', 'Carlos Vega', 'Ecuatoriana', 'carlos@space.com', 3);
INSERT INTO ASTRONAUTA VALUES (2, 'AST002', 'Laura Mendez', 'Colombiana', 'laura@space.com', 5);
INSERT INTO ASTRONAUTA VALUES (3, 'AST003', 'John Carter', 'Estadounidense', 'john@space.com', 7);

INSERT INTO MISION VALUES (
    1,
    'Luna Alpha',
    'Luna',
    DATE '2026-01-10',
    DATE '2026-02-10',
    31,
    1,
    1,
    1
);

INSERT INTO MISION VALUES (
    2,
    'Mars One',
    'Marte',
    DATE '2026-03-01',
    DATE '2026-08-01',
    153,
    2,
    2,
    2
);

INSERT INTO MISION VALUES (
    3,
    'Orbital Net',
    'Orbita Terrestre',
    DATE '2026-04-05',
    DATE '2026-04-25',
    20,
    3,
    3,
    3
);

INSERT INTO TRIPULACION VALUES (1, 1, 1, DATE '2025-12-01');
INSERT INTO TRIPULACION VALUES (2, 2, 2, DATE '2026-01-15');
INSERT INTO TRIPULACION VALUES (3, 3, 3, DATE '2026-02-20');

COMMIT;

-- =========================================================
-- EJERCICIOS DQL
-- =========================================================

-- =========================================================
-- SELECT + WHERE
-- =========================================================

-- EJERCICIO 1
SELECT nombre_mision, destino
FROM MISION
WHERE destino = 'Marte';

-- EJERCICIO 2
SELECT nombre_astronauta, misiones_completadas
FROM ASTRONAUTA
WHERE misiones_completadas > 4;

-- EJERCICIO 3
SELECT nombre_nave, capacidad_max
FROM NAVE
WHERE capacidad_max >= 10;

-- =========================================================
-- ORDER BY
-- =========================================================

-- EJERCICIO 1
SELECT nombre_mision, duracion_dias
FROM MISION
ORDER BY duracion_dias DESC;

-- EJERCICIO 2
SELECT nombre_astronauta
FROM ASTRONAUTA
ORDER BY nombre_astronauta ASC;

-- EJERCICIO 3
SELECT nombre_nave, anio_fabricacion
FROM NAVE
ORDER BY anio_fabricacion DESC;

-- =========================================================
-- GROUP BY
-- =========================================================

-- EJERCICIO 1
SELECT destino, COUNT(*) AS total_misiones
FROM MISION
GROUP BY destino;

-- EJERCICIO 2
SELECT nacionalidad, COUNT(*) AS total_astronautas
FROM ASTRONAUTA
GROUP BY nacionalidad;

-- EJERCICIO 3
SELECT id_estado_mision_per, AVG(duracion_dias) AS promedio
FROM MISION
GROUP BY id_estado_mision_per;

-- =========================================================
-- HAVING
-- =========================================================

-- EJERCICIO 1
SELECT destino, COUNT(*) AS total
FROM MISION
GROUP BY destino
HAVING COUNT(*) >= 1;

-- EJERCICIO 2
SELECT nacionalidad, COUNT(*) AS total
FROM ASTRONAUTA
GROUP BY nacionalidad
HAVING COUNT(*) >= 1;

-- EJERCICIO 3
SELECT id_nave_per, AVG(duracion_dias) AS promedio
FROM MISION
GROUP BY id_nave_per
HAVING AVG(duracion_dias) > 20;

-- =========================================================
-- INNER JOIN
-- =========================================================

-- EJERCICIO 1
SELECT m.nombre_mision, n.nombre_nave
FROM MISION m
INNER JOIN NAVE n
    ON m.id_nave_per = n.id_nave;

-- EJERCICIO 2
SELECT a.nombre_astronauta, r.nombre_rol
FROM TRIPULACION t
INNER JOIN ASTRONAUTA a
    ON t.id_astronauta_per = a.id_astronauta
INNER JOIN ROL_TRIPULACION r
    ON t.id_rol_tripulacion_per = r.id_rol_tripulacion;

-- EJERCICIO 3
SELECT
    m.nombre_mision,
    a.nombre_astronauta,
    r.nombre_rol
FROM TRIPULACION t
INNER JOIN MISION m
    ON t.id_mision_per = m.id_mision
INNER JOIN ASTRONAUTA a
    ON t.id_astronauta_per = a.id_astronauta
INNER JOIN ROL_TRIPULACION r
    ON t.id_rol_tripulacion_per = r.id_rol_tripulacion;

-- =========================================================
-- SUBCONSULTAS
-- =========================================================

-- EJERCICIO 1
SELECT nombre_mision, duracion_dias
FROM MISION
WHERE duracion_dias > (
    SELECT AVG(duracion_dias)
    FROM MISION
);

-- EJERCICIO 2
SELECT nombre_astronauta, misiones_completadas
FROM ASTRONAUTA
WHERE misiones_completadas = (
    SELECT MAX(misiones_completadas)
    FROM ASTRONAUTA
);

-- EJERCICIO 3
SELECT nombre_nave, capacidad_max
FROM NAVE
WHERE capacidad_max > (
    SELECT AVG(capacidad_max)
    FROM NAVE
);

-- =========================================================
-- DEPURACION DE SENTENCIAS
-- =========================================================

-- ERROR: FALTA COMA
SELECT nombre_mision destino
FROM MISION;

-- ERROR: DATO INVALIDO
SELECT *
FROM MISION
WHERE duracion_dias = 'ABC';

-- ERROR: SINTAXIS INCORRECTA
SELECT nombre_astronauta
FROM ASTRONAUTA
WHERE misiones_completadas >;

