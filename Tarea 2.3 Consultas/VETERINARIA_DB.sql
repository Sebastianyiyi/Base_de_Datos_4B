-- =====================================================================
-- SCRIPT DE BASE DE DATOS COMPLETO: VETERINARIA
-- AUTORES: Sebastián Acaro, Santiago Mora, Mauricio Guevara, Erick López
-- ASIGNATURA: Base de Datos | NIVEL: 04 | PARALELO: "A"
-- UNIVERSIDAD TÉCNICA DE AMBATO
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. ELIMINACIÓN DE TABLAS (Garantiza una ejecución limpia)
-- ---------------------------------------------------------------------
DROP TABLE CONSULTA CASCADE CONSTRAINTS;
DROP TABLE VETERINARIO CASCADE CONSTRAINTS;
DROP TABLE ESPECIALIDAD CASCADE CONSTRAINTS;
DROP TABLE MASCOTA CASCADE CONSTRAINTS;
DROP TABLE ESPECIE CASCADE CONSTRAINTS;
DROP TABLE PROPIETARIO CASCADE CONSTRAINTS;

-- ---------------------------------------------------------------------
-- 2. CREACIÓN DE TABLAS (DDL)
-- ---------------------------------------------------------------------

CREATE TABLE PROPIETARIO ( 
    id_propietario NUMBER PRIMARY KEY, 
    cedula VARCHAR2(10) NOT NULL UNIQUE, 
    nombres VARCHAR2(80) NOT NULL, 
    telefono VARCHAR2(15), 
    ciudad VARCHAR2(50) NOT NULL, 
    correo VARCHAR2(100) UNIQUE 
);

CREATE TABLE ESPECIE ( 
    id_especie NUMBER PRIMARY KEY, 
    nombre_especie VARCHAR2(50) NOT NULL UNIQUE 
);

CREATE TABLE MASCOTA ( 
    id_mascota NUMBER PRIMARY KEY, 
    nombre_mascota VARCHAR2(60) NOT NULL, 
    raza VARCHAR2(60), 
    edad NUMBER(3) NOT NULL, 
    peso NUMBER(5,2) NOT NULL, 
    id_propietario NUMBER NOT NULL, 
    id_especie NUMBER NOT NULL, 
    CONSTRAINT fk_mascota_propietario FOREIGN KEY (id_propietario) REFERENCES PROPIETARIO(id_propietario), 
    CONSTRAINT fk_mascota_especie FOREIGN KEY (id_especie) REFERENCES ESPECIE(id_especie) 
);

CREATE TABLE ESPECIALIDAD ( 
    id_especialidad NUMBER PRIMARY KEY, 
    nombre_especialidad VARCHAR2(80) NOT NULL UNIQUE 
);

CREATE TABLE VETERINARIO ( 
    id_veterinario NUMBER PRIMARY KEY, 
    nombres VARCHAR2(80) NOT NULL, 
    cedula VARCHAR2(10) NOT NULL UNIQUE, 
    sueldo NUMBER(8,2) NOT NULL, 
    id_especialidad NUMBER NOT NULL, 
    CONSTRAINT fk_veterinario_especialidad FOREIGN KEY (id_especialidad) REFERENCES ESPECIALIDAD(id_especialidad) 
);

CREATE TABLE CONSULTA ( 
    id_consulta NUMBER PRIMARY KEY, 
    fecha_consulta DATE NOT NULL, 
    diagnostico VARCHAR2(150) NOT NULL, 
    tratamiento VARCHAR2(150) NOT NULL, 
    costo NUMBER(8,2) NOT NULL, 
    estado VARCHAR2(30) NOT NULL, 
    id_mascota NUMBER NOT NULL, 
    id_veterinario NUMBER NOT NULL, 
    CONSTRAINT fk_consulta_mascota FOREIGN KEY (id_mascota) REFERENCES MASCOTA(id_mascota), 
    CONSTRAINT fk_consulta_veterinario FOREIGN KEY (id_veterinario) REFERENCES VETERINARIO(id_veterinario) 
);

-- ---------------------------------------------------------------------
-- 3. INSERCIÓN DE DATOS DE PRUEBA (DML)
-- ---------------------------------------------------------------------

INSERT INTO PROPIETARIO VALUES (1, '1801111111', 'Carlos Pérez', '0991111111', 'Ambato', 'carlos@mail.com');
INSERT INTO PROPIETARIO VALUES (2, '1802222222', 'María López', '0992222222', 'Quito', 'maria@mail.com');
INSERT INTO PROPIETARIO VALUES (3, '1803333333', 'Juan Almeida', '0993333333', 'Ambato', 'juan@mail.com');
INSERT INTO PROPIETARIO VALUES (4, '1704444444', 'Ana Martínez', '0994444444', 'Guayaquil', 'ana@mail.com'); 

INSERT INTO ESPECIE VALUES (1, 'Perro');
INSERT INTO ESPECIE VALUES (2, 'Gato'); 

INSERT INTO MASCOTA VALUES (1, 'Max', 'Labrador', 5, 28.50, 1, 1);
INSERT INTO MASCOTA VALUES (2, 'Luna', 'Siamés', 3, 4.20, 2, 2);
INSERT INTO MASCOTA VALUES (3, 'Rocky', 'Golden', 6, 32.10, 1, 1);
INSERT INTO MASCOTA VALUES (4, 'Michi', 'Angora', 2, 3.80, 3, 2);
INSERT INTO MASCOTA VALUES (5, 'Thor', 'Rottweiler', 1, 15.00, 4, 1); 

INSERT INTO ESPECIALIDAD VALUES (1, 'Medicina General');
INSERT INTO ESPECIALIDAD VALUES (2, 'Cirugía'); 

INSERT INTO VETERINARIO VALUES (1, 'Dr. Andrés Ramos', '1701111111', 1200.00, 1);
INSERT INTO VETERINARIO VALUES (2, 'Dra. Paola Vega', '1702222222', 1500.00, 2);
INSERT INTO VETERINARIO VALUES (3, 'Dr. Luis Ortiz', '1703333333', 1600.00, 1);

INSERT INTO CONSULTA VALUES (1, TO_DATE('2026-05-10', 'YYYY-MM-DD'), 'Infección leve', 'Antibióticos en gotas', 45.00, 'Completada', 1, 1);
INSERT INTO CONSULTA VALUES (2, TO_DATE('2026-05-12', 'YYYY-MM-DD'), 'Fractura de pata', 'Cirugía y vendaje', 150.00, 'Completada', 2, 2);
INSERT INTO CONSULTA VALUES (3, TO_DATE('2026-05-15', 'YYYY-MM-DD'), 'Chequeo general', 'Vitaminas c/24h', 25.00, 'Completada', 3, 1);
INSERT INTO CONSULTA VALUES (4, TO_DATE('2026-05-18', 'YYYY-MM-DD'), 'Parásitos', 'Desparasitante oral', 35.00, 'Completada', 4, 3);
INSERT INTO CONSULTA VALUES (5, TO_DATE('2026-05-19', 'YYYY-MM-DD'), 'Esterilización', 'Reposo y analgésicos', 108.00, 'Completada', 1, 2);

COMMIT;

-- ---------------------------------------------------------------------
-- 4. BLOQUE DE 25 CONSULTAS PRINCIPALES Y ADICIONALES DEL INFORME
-- ---------------------------------------------------------------------

-- 1. Mostrar las mascotas con edad mayor a 4 años.
SELECT * FROM MASCOTA WHERE edad > 4;

-- 2. Mostrar las consultas atendidas ordenadas por costo.
SELECT * FROM CONSULTA ORDER BY costo DESC;

-- 3. Mostrar mascota, propietario y ciudad.
SELECT m.nombre_mascota, p.nombres, p.ciudad 
FROM MASCOTA m 
INNER JOIN PROPIETARIO p ON m.id_propietario = p.id_propietario;

-- 4. Mostrar consulta, mascota, veterinario y especialidad.
SELECT c.id_consulta, m.nombre_mascota, v.nombres AS veterinario, e.nombre_especialidad 
FROM CONSULTA c 
INNER JOIN MASCOTA m ON c.id_mascota = m.id_mascota 
INNER JOIN VETERINARIO v ON c.id_veterinario = v.id_veterinario 
INNER JOIN ESPECIALIDAD e ON v.id_especialidad = e.id_especialidad;

-- 5. Contar mascotas por especie.
SELECT e.nombre_especie, COUNT(*) AS total_mascotas 
FROM MASCOTA m 
INNER JOIN ESPECIE e ON m.id_especie = e.id_especie 
GROUP BY e.nombre_especie;

-- 6. Mostrar especies con más de una mascota.
SELECT e.nombre_especie, COUNT(*) AS total 
FROM MASCOTA m 
INNER JOIN ESPECIE e ON m.id_especie = e.id_especie 
GROUP BY e.nombre_especie 
HAVING COUNT(*) > 1;

-- 7. Mostrar consultas cuyo costo sea mayor al promedio.
SELECT * FROM CONSULTA WHERE costo > (SELECT AVG(costo) FROM CONSULTA);

-- 8. Mostrar cuánto dinero ha generado cada veterinario.
SELECT v.nombres, SUM(c.costo) AS total_generado 
FROM VETERINARIO v 
INNER JOIN CONSULTA c ON v.id_veterinario = c.id_veterinario 
GROUP BY v.nombres;

-- 9. Mostrar veterinarios cuyos ingresos superen el promedio.
SELECT v.nombres, SUM(c.costo) AS total_generado 
FROM VETERINARIO v 
INNER JOIN CONSULTA c ON v.id_veterinario = c.id_veterinario 
GROUP BY v.nombres 
HAVING SUM(c.costo) > (SELECT AVG(SUM(costo)) FROM CONSULTA GROUP BY id_veterinario);

-- 10. Mostrar propietario, mascota, especie, diagnóstico y tratamiento.
SELECT p.nombres AS propietario, m.nombre_mascota, e.nombre_especie, c.diagnostico, c.treatment AS tratamiento 
FROM CONSULTA c 
INNER JOIN MASCOTA m ON c.id_mascota = m.id_mascota 
INNER JOIN PROPIETARIO p ON m.id_propietario = p.id_propietario 
INNER JOIN ESPECIE e ON m.id_especie = e.id_especie;

-- 11. Mostrar mascotas cuyo peso sea mayor a 10 kg.
SELECT * FROM MASCOTA WHERE peso > 10;

-- 12. Mostrar veterinarios con sueldo mayor a 1300.
SELECT * FROM VETERINARIO WHERE sueldo > 1300;

-- 13. Mostrar mascotas ordenadas alfabéticamente.
SELECT * FROM MASCOTA ORDER BY nombre_mascota ASC;

-- 14. Mostrar consultas cuyo costo esté entre 30 y 100 dólares.
SELECT * FROM CONSULTA WHERE costo BETWEEN 30 AND 100;

-- 15. Mostrar propietarios que viven en Ambato.
SELECT * FROM PROPIETARIO WHERE ciudad = 'Ambato';

-- 16. Mostrar el promedio de costo de consultas.
SELECT AVG(costo) AS promedio_costo FROM CONSULTA;

-- 17. Mostrar el costo máximo y mínimo de consultas.
SELECT MAX(costo) AS costo_maximo, MIN(costo) AS costo_minimo FROM CONSULTA;

-- 18. Mostrar cuántas consultas realizó cada mascota.
SELECT m.nombre_mascota, COUNT(c.id_consulta) AS total_consultas 
FROM MASCOTA m 
LEFT JOIN CONSULTA c ON m.id_mascota = c.id_mascota 
GROUP BY m.nombre_mascota;

-- 19. Mostrar veterinarios que hayan generado más de 100 dólares.
SELECT v.nombres, SUM(c.costo) AS total 
FROM VETERINARIO v 
INNER JOIN CONSULTA c ON v.id_veterinario = c.id_veterinario 
GROUP BY v.nombres 
HAVING SUM(c.costo) > 100;

-- 20. Mostrar la mascota con la consulta más costosa.
SELECT m.nombre_mascota 
FROM MASCOTA m 
INNER JOIN CONSULTA c ON m.id_mascota = c.id_mascota 
WHERE c.costo = (SELECT MAX(costo) FROM CONSULTA);

-- 21. Mostrar consultas realizadas por veterinarios de Medicina General.
SELECT c.* FROM CONSULTA c 
INNER JOIN VETERINARIO v ON c.id_veterinario = v.id_veterinario 
INNER JOIN ESPECIALIDAD e ON v.id_especialidad = e.id_especialidad 
WHERE e.nombre_especialidad = 'Medicina General';

-- 22. Mostrar cuántas mascotas tiene cada propietario.
SELECT p.nombres, COUNT(m.id_mascota) AS total_mascotas 
FROM PROPIETARIO p 
LEFT JOIN MASCOTA m ON p.id_propietario = m.id_propietario 
GROUP BY p.nombres;

-- 23. Mostrar consultas junto con el nombre de la mascota y tratamiento.
SELECT m.nombre_mascota, c.tratamiento, c.fecha_consulta 
FROM CONSULTA c 
INNER JOIN MASCOTA m ON c.id_mascota = m.id_mascota;

-- 24. Mostrar consultas cuyo costo sea menor al promedio.
SELECT * FROM CONSULTA WHERE costo < (SELECT AVG(costo) FROM CONSULTA);

-- 25. Mostrar el total de dinero generado por todas las consultas.
SELECT SUM(costo) AS recaudacion_total FROM CONSULTA;


-- ---------------------------------------------------------------------
-- 8. CONSULTAS DE SEBASTIAN ACARO
-- ---------------------------------------------------------------------

-- SA1. Propietarios con más mascotas que el promedio global 
SELECT p.nombres AS propietario, COUNT(m.id_mascota) AS total_mascotas  
FROM PROPIETARIO p  
INNER JOIN MASCOTA m ON p.id_propietario = m.id_propietario  
GROUP BY p.nombres  
HAVING COUNT(m.id_mascota) > (  
    SELECT AVG(COUNT(id_mascota))   
    FROM MASCOTA   
    GROUP BY id_propietario  
); 

-- SA2. Especialidades médicas que han facturado más de 100 dólares en total  
SELECT e.nombre_especialidad, SUM(c.costo) AS total_facturado  
FROM ESPECIALIDAD e  
INNER JOIN VETERINARIO v ON e.id_especialidad = v.id_especialidad  
INNER JOIN CONSULTA c ON v.id_veterinario = c.id_veterinario  
GROUP BY e.nombre_especialidad  
HAVING SUM(c.costo) > 100;  

-- SA3. Especies cuyas mascotas promedian un peso mayor al promedio de toda la veterinaria.  
SELECT es.nombre_especie, AVG(m.peso) AS peso_promedio_especie  
FROM ESPECIE es  
INNER JOIN MASCOTA m ON es.id_especie = m.id_especie  
GROUP BY es.nombre_especie  
HAVING AVG(m.peso) > (SELECT AVG(peso) FROM MASCOTA);  

-- SA4. Clientes con consultas completadas que gastaron más que el costo de la consulta más barata.  
SELECT p.nombres AS propietario, SUM(c.costo) AS total_gastado  
FROM PROPIETARIO p  
INNER JOIN MASCOTA m ON p.id_propietario = m.id_propietario  
INNER JOIN CONSULTA c ON m.id_mascota = c.id_mascota  
WHERE c.estado = 'Completada'  
GROUP BY p.nombres  
HAVING SUM(c.costo) > (SELECT MIN(costo) FROM CONSULTA);  

-- SA5. Veterinarios que han atendido a más de un paciente (mascota) diferente.  
SELECT v.nombres AS nombre_veterinario, COUNT(DISTINCT c.id_mascota) AS pacientes_unicos  
FROM VETERINARIO v  
INNER JOIN CONSULTA c ON v.id_veterinario = c.id_veterinario  
GROUP BY v.nombres  
HAVING COUNT(DISTINCT c.id_mascota) > 1;  


-- ---------------------------------------------------------------------
-- 6. CONSULTAS DE SANTIAGO MORA
-- ---------------------------------------------------------------------

-- SM1. Ciudades con mascotas longevas por encima del peso promedio global 
SELECT p.ciudad,   
       AVG(m.edad) AS promedio_edad_longevas,   
       COUNT(m.id_mascota) AS cantidad_mascotas  
FROM PROPIETARIO p  
INNER JOIN MASCOTA m ON p.id_propietario = m.id_propietario  
WHERE m.peso > (SELECT AVG(peso) FROM MASCOTA)  
GROUP BY p.ciudad  
HAVING AVG(m.edad) > 3;  

-- SM2. Especialidades médicas cuyo costo máximo de consulta supera el promedio general de ingresos por cita  
SELECT e.nombre_especialidad,   
       MAX(c.costo) AS consulta_mas_cara,  
       COUNT(c.id_consulta) AS total_atenciones  
FROM ESPECIALIDAD e  
INNER JOIN VETERINARIO v ON e.id_especialidad = v.id_especialidad  
INNER JOIN CONSULTA c ON v.id_veterinario = c.id_veterinario  
GROUP BY e.nombre_especialidad  
HAVING MAX(c.costo) > (SELECT AVG(costo) FROM CONSULTA);  

-- SM3. Razas de una especie específica que superan el peso máximo de los gatos  
SELECT m.raza,   
       AVG(m.peso) AS peso_promedio_raza,  
       COUNT(*) AS total_ejemplares  
FROM MASCOTA m  
INNER JOIN ESPECIE e ON m.id_especie = e.id_especie  
WHERE e.id_especie = 1  
GROUP BY m.raza  
HAVING AVG(m.peso) > (SELECT MAX(peso) FROM MASCOTA WHERE id_especie = 2);  

-- SM4. Especies con un costo promedio de consulta superior al promedio general de la clínica  
SELECT e.nombre_especie,   
       AVG(c.costo) AS costo_promedio_especie,  
       COUNT(c.id_consulta) AS total_consultas  
FROM ESPECIE e  
INNER JOIN MASCOTA m ON e.id_especie = m.id_especie  
INNER JOIN CONSULTA c ON m.id_mascota = c.id_mascota  
GROUP BY e.nombre_especie  
HAVING AVG(c.costo) > (SELECT AVG(costo) FROM CONSULTA);  

-- SM5. Propietarios cuya mascota más pesada supera el peso promedio de los perros  
SELECT p.nombres AS propietario,   
       MAX(m.peso) AS peso_mascota_mas_pesada,  
       COUNT(m.id_mascota) AS mascotas_registradas  
FROM PROPIETARIO p  
INNER JOIN MASCOTA m ON p.id_propietario = m.id_propietario  
GROUP BY p.nombres  
HAVING MAX(m.peso) > (SELECT AVG(peso) FROM MASCOTA WHERE id_especie = 1);  


-- ---------------------------------------------------------------------
-- 7. CONSULTAS DE MAURICIO GUEVARA
-- ---------------------------------------------------------------------

-- MG1. Mascotas cuyo peso supera el promedio de su propia especie  
SELECT m.nombre_mascota,  
       e.nombre_especie,  
       m.raza,  
       m.peso  
FROM MASCOTA m  
INNER JOIN ESPECIE e ON m.id_especie = e.id_especie  
WHERE m.peso > (  
    SELECT AVG(m2.peso)  
    FROM MASCOTA m2  
    WHERE m2.id_especie = m.id_especie  
);  

-- MG2. Propietarios que gastaron menos que el promedio global  
SELECT p.nombres AS propietario,  
       p.ciudad,  
       SUM(c.costo) AS total_gastado  
FROM PROPIETARIO p  
INNER JOIN MASCOTA m  ON p.id_propietario = m.id_propietario  
INNER JOIN CONSULTA c ON m.id_mascota      = c.id_mascota  
GROUP BY p.nombres, p.ciudad  
HAVING SUM(c.costo) < (  
    SELECT AVG(gasto)  
    FROM (  
        SELECT SUM(c2.costo) AS gasto  
        FROM PROPIETARIO p2  
        INNER JOIN MASCOTA m2  ON p2.id_propietario = m2.id_propietario  
        INNER JOIN CONSULTA c2 ON m2.id_mascota      = c2.id_mascota  
        GROUP BY p2.id_propietario  
    )  
);  

-- MG3. Veterinarios cuya consulta más cara supera el sueldo mínimo  
SELECT v.nombres AS veterinario,  
       e.nombre_especialidad,  
       v.sueldo,  
       MAX(c.costo) AS consulta_mas_cara  
FROM VETERINARIO v  
INNER JOIN ESPECIALIDAD e ON v.id_especialidad = e.id_especialidad  
INNER JOIN CONSULTA     c ON v.id_veterinario  = c.id_veterinario  
GROUP BY v.nombres, e.nombre_especialidad, v.sueldo  
HAVING MAX(c.costo) > (  
    SELECT MIN(sueldo)  
    FROM VETERINARIO  
);  

-- MG4. Mascotas que nunca han tenido una consulta  
SELECT m.nombre_mascota,  
       m.raza,  
       e.nombre_especie,  
       p.nombres AS propietario  
FROM MASCOTA m  
INNER JOIN ESPECIE     e ON m.id_especie      = e.id_especie  
INNER JOIN PROPIETARIO p ON m.id_propietario = p.id_propietario  
WHERE m.id_mascota NOT IN (  
    SELECT DISTINCT id_mascota  
    FROM CONSULTA  
);  

-- MG5. Ciudades cuyo gasto promedio supera el promedio global de la clínica  
SELECT p.ciudad,  
       COUNT(DISTINCT m.id_mascota) AS mascotas_atendidas,  
       ROUND(AVG(c.costo), 2)       AS gasto_promedio_ciudad  
FROM PROPIETARIO p  
INNER JOIN MASCOTA  m ON p.id_propietario = m.id_propietario  
INNER JOIN CONSULTA c ON m.id_mascota      = c.id_mascota  
GROUP BY p.ciudad  
HAVING AVG(c.costo) > (  
    SELECT AVG(costo)  
    FROM CONSULTA  
);  


-- ---------------------------------------------------------------------
-- 8. CONSULTAS DE ERICK LÓPEZ
-- ---------------------------------------------------------------------

-- EL1. Veterinarios cuyo promedio de ingresos por consulta supera el promedio general   
SELECT v.nombres AS veterinario,  
       AVG(c.costo) AS promedio_ingreso_por_consulta,  
       COUNT(c.id_consulta) AS total_consultas_atendidas  
FROM VETERINARIO v  
INNER JOIN CONSULTA c ON v.id_veterinario = c.id_veterinario  
GROUP BY v.nombres  
HAVING AVG(c.costo) > (SELECT AVG(costo) FROM CONSULTA);  

-- EL2. Propietarios cuyas mascotas promedian una edad mayor a la mascota más joven de toda la clínica   
SELECT p.nombres AS propietario,  
       AVG(m.edad) AS edad_promedio_mascotas,  
       COUNT(m.id_mascota) AS cantidad_mascotas  
FROM PROPIETARIO p  
INNER JOIN MASCOTA m ON p.id_propietario = m.id_propietario  
GROUP BY p.nombres  
HAVING AVG(m.edad) > (SELECT MIN(edad) FROM MASCOTA);  

-- EL3. Mascotas que han generado un costo total en consultas superior al promedio de costo de todas las atenciones médicas   
SELECT m.nombre_mascota,  
       m.raza,  
       SUM(c.costo) AS gasto_total_generado  
FROM MASCOTA m  
INNER JOIN CONSULTA c ON m.id_mascota = c.id_mascota  
GROUP BY m.nombre_mascota, m.raza  
HAVING SUM(c.costo) > (SELECT AVG(costo) FROM CONSULTA);  

-- EL4. Especialidades que atienden mascotas con un peso promedio menor al peso promedio de todas las mascotas   
SELECT e.nombre_especialidad,  
       AVG(m.peso) AS peso_promedio_pacientes,  
       COUNT(DISTINCT m.id_mascota) AS pacientes_diferentes  
FROM ESPECIALIDAD e  
INNER JOIN VETERINARIO v ON e.id_especialidad = v.id_especialidad  
INNER JOIN CONSULTA c ON v.id_veterinario = c.id_veterinario  
INNER JOIN MASCOTA m ON c.id_mascota = m.id_mascota  
GROUP BY e.nombre_especialidad  
HAVING AVG(m.peso) < (SELECT AVG(peso) FROM MASCOTA);  

-- EL5. Razas de mascotas cuya consulta más económica es mayor al promedio del costo de consultas de Medicina General   
SELECT m.raza,  
       MIN(c.costo) AS consulta_mas_barata,  
       MAX(c.costo) AS consulta_mas_cara  
FROM MASCOTA m  
INNER JOIN CONSULTA c ON m.id_mascota = c.id_mascota  
GROUP BY m.raza  
HAVING MIN(c.costo) > (  
    SELECT AVG(c2.costo)  
    FROM CONSULTA c2  
    INNER JOIN VETERINARIO v ON c2.id_veterinario = v.id_veterinario  
    INNER JOIN ESPECIALIDAD e ON v.id_especialidad = e.id_especialidad  
    WHERE e.nombre_especialidad = 'Medicina General'  
);