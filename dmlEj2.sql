/*
  PROYECTO: Sistema de Gestión de Lanzamientos Espaciales
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
DELETE FROM TRIPULACION;
DELETE FROM MISION;
DELETE FROM ASTRONAUTA;
DELETE FROM NAVE;
DELETE FROM ROL_TRIPULACION;
DELETE FROM ESTADO_MISION;
DELETE FROM TIPO_MISION;
COMMIT;



-- =============================================
-- 2. INSERCIÓN DE CATÁLOGOS (Tablas Independientes)
-- =============================================

-- TIPO_MISION
INSERT INTO TIPO_MISION VALUES (1, 'Exploración',   'Reconocimiento de nuevos cuerpos celestes');
INSERT INTO TIPO_MISION VALUES (2, 'Abastecimiento', 'Entrega de suministros a estaciones orbitales');
INSERT INTO TIPO_MISION VALUES (3, 'Investigación',  'Experimentos científicos en órbita o superficie');

-- ESTADO_MISION
INSERT INTO ESTADO_MISION VALUES (1, 'Planificada',  'Aprobada y en fase de preparación');
INSERT INTO ESTADO_MISION VALUES (2, 'En curso',     'Misión activamente en progreso');
INSERT INTO ESTADO_MISION VALUES (3, 'Completada',   'Misión finalizada exitosamente');
INSERT INTO ESTADO_MISION VALUES (4, 'Abortada',     'Misión interrumpida por fallo técnico');
INSERT INTO ESTADO_MISION VALUES (5, 'Pospuesta',    'Fecha de lanzamiento diferida');

-- ROL_TRIPULACION
INSERT INTO ROL_TRIPULACION VALUES (1, 'Comandante',  'Responsable máximo de la misión');
INSERT INTO ROL_TRIPULACION VALUES (2, 'Piloto',       'Control de sistemas de navegación');
INSERT INTO ROL_TRIPULACION VALUES (3, 'Especialista', 'Ejecución de tareas científicas');
INSERT INTO ROL_TRIPULACION VALUES (4, 'Ingeniero',    'Mantenimiento de sistemas de la nave');

-- =============================================
-- 3. CARGA DE ENTIDADES PRINCIPALES
-- =============================================

-- NAVES (P1: Registro de Polaris II incluida)
INSERT INTO NAVE VALUES (1, 'NXS-001', 'Aurora Prime',  6, 2021);
INSERT INTO NAVE VALUES (2, 'NXS-002', 'Helios X',      4, 2023);
INSERT INTO NAVE VALUES (3, 'NXS-003', 'Vega Sentinel', 8, 2020);
INSERT INTO NAVE VALUES (4, 'NXS-004', 'Polaris II',    5, 2025);

-- ASTRONAUTAS
INSERT INTO ASTRONAUTA VALUES (1, 'AST-001', 'Valeria Romero', 'México',  'v.romero@orbital.com', 5);
INSERT INTO ASTRONAUTA VALUES (2, 'AST-002', 'James Okafor',   'Nigeria', 'j.okafor@orbital.com', 8);
INSERT INTO ASTRONAUTA VALUES (3, 'AST-003', 'Hina Nakamura',  'Japón',   'h.nakamura@orbital.com', 3);
INSERT INTO ASTRONAUTA VALUES (4, 'AST-004', 'Rafael Solano',  'Ecuador', 'r.solano@orbital.com', 1);
INSERT INTO ASTRONAUTA VALUES (5, 'AST-005', 'Priya Sharma',   'India',   'p.sharma@orbital.com', 2);

-- =============================================
-- 4. OPERACIONES DE MISIONES Y TRIPULACIÓN
-- =============================================

-- MISIONES INICIALES
INSERT INTO MISION VALUES (1, 'Artemis Profundo', 'Cinturón de asteroides', DATE '2025-06-15', DATE '2025-12-10', 178, 1, 1, 2);
INSERT INTO MISION VALUES (2, 'Orbital Supply 07', 'Estación Orbital NX-4', DATE '2025-04-01', DATE '2025-04-22', 21, 2, 2, 3);
INSERT INTO MISION VALUES (3, 'Luna Base Alpha',  'Polo Sur Lunar',        DATE '2025-09-01', DATE '2025-10-15', 44, 3, 3, 1);

-- P2: Nueva Misión usando subconsultas (Sin Hardcoding)
INSERT INTO MISION VALUES (
    6, 'Experimento Gravitacional', 'Órbita Terrestre Baja', DATE '2026-05-10', DATE '2026-05-25', 15,
    (SELECT id_tipo_mision FROM TIPO_MISION WHERE nombre_tipo = 'Investigación'),
    (SELECT id_nave FROM NAVE WHERE nombre_nave = 'Polaris II'),
    (SELECT id_estado_mision FROM ESTADO_MISION WHERE nombre_estado = 'Planificada')
);

-- TRIPULACIÓN
INSERT INTO TRIPULACION VALUES (1, 1, 1, DATE '2025-03-01');
INSERT INTO TRIPULACION VALUES (1, 2, 2, DATE '2025-03-01');
INSERT INTO TRIPULACION VALUES (1, 3, 3, DATE '2025-03-05');
INSERT INTO TRIPULACION VALUES (2, 2, 1, DATE '2025-02-10');
INSERT INTO TRIPULACION VALUES (2, 4, 4, DATE '2025-02-10');
INSERT INTO TRIPULACION VALUES (3, 1, 2, DATE '2025-05-20');

-- =============================================
-- 5. ACTUALIZACIONES (UPDATES)
-- =============================================

-- Finalizar misión Artemis Profundo
UPDATE MISION 
SET id_estado_mision_per = (SELECT id_estado_mision FROM ESTADO_MISION WHERE nombre_estado = 'Completada')
WHERE nombre_mision = 'Artemis Profundo';

-- P4: Pospone Luna Base Alpha
UPDATE MISION 
SET id_estado_mision_per = (SELECT id_estado_mision FROM ESTADO_MISION WHERE nombre_estado = 'Pospuesta')
WHERE nombre_mision = 'Luna Base Alpha';

-- Actualización de contadores de astronautas (Eficiencia IN)
UPDATE ASTRONAUTA 
SET misiones_completadas = misiones_completadas + 1 
WHERE nombre_astronauta IN ('Valeria Romero', 'James Okafor', 'Rafael Solano');

-- =============================================
-- 6. ELIMINACIONES JERÁRQUICAS (DELETES)
-- =============================================

-- P6: Dar de baja Aurora Prime (Eliminando dependencias)
DELETE FROM TRIPULACION WHERE id_mision_per IN (SELECT id_mision FROM MISION WHERE id_nave_per = (SELECT id_nave FROM NAVE WHERE nombre_nave = 'Aurora Prime'));
DELETE FROM MISION WHERE id_nave_per = (SELECT id_nave FROM NAVE WHERE nombre_nave = 'Aurora Prime');
DELETE FROM NAVE WHERE nombre_nave = 'Aurora Prime';

-- P7: Eliminar Rol Ingeniero (Eliminando dependencias)
DELETE FROM TRIPULACION WHERE id_rol_tripulacion_per = (SELECT id_rol_tripulacion FROM ROL_TRIPULACION WHERE nombre_rol = 'Ingeniero');
DELETE FROM ROL_TRIPULACION WHERE nombre_rol = 'Ingeniero';

COMMIT;

-- =============================================
-- 7. SECCIÓN DE PRUEBAS DE ERRORES (Comentadas)
-- =============================================
/*
-- ERROR A: Check fecha_retorno_est > fecha_lanzamiento
INSERT INTO MISION VALUES (55, 'Error Fechas', 'Marte', DATE '2026-01-01', DATE '2025-01-01', 30, 1, 1, 1);

-- ERROR B: Check capacidad_max BETWEEN 1 AND 50
INSERT INTO NAVE VALUES (99, 'NXS-999', 'Titan', 100, 2024);

-- ERROR C: Foreign Key (Astronauta inexistente)
INSERT INTO TRIPULACION VALUES (1, 9999, 1, SYSDATE);
*/

