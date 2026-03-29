# INFORME DE GUÍA PRÁCTICA: Esquema Conceptual y Esquema Lógico

## I. PORTADA
* **Tema:** Esquema Conceptual y Esquema Lógico 
* **Unidad de Organización Curricular:** PROFESIONAL 
* **Nivel y Paralelo:** 4to - "B" 
* **Asignatura:** Base de Datos 
* **Docente:** Ing. José Caiza, Mg. 
* **Carrera:** Software 
* **Ciclo Académico:** Enero 2026 - Julio 2026 
* **Alumnos Participantes:** 
    * Acaro Ibujes Pedro Sebastián 
    * Guevara López Oscar Mauricio 
    * López Yantalema Erick Alexander 
    * Mora Beltrán Santiago Sebastian 

---

## II. INFORME DE GUÍA PRÁCTICA

### 2.1 Objetivos
* **General:** Aplicar las reglas de conversión del Esquema Conceptual al Esquema Lógico.
* **Específicos:**
    * Diseñar una estructura de datos que permita identificar de forma única cada equipo tecnológico, vinculándolo a su categoría, proveedor y laboratorio físico asignado.
    * Establecer una relación histórica entre los usuarios, los equipos y los eventos de mantenimiento para monitorear el ciclo de vida de la tecnología.

---

### 2.2 Modalidad
Presencial.

---

### 2.3 Tiempo de duración
* **Presenciales:** 12 horas.
* **No presenciales:** 0 horas.

---

### 2.4 Instrucciones
Los estudiantes deben realizar un documento PDF que contenga:
1. Análisis del enunciado del contexto del caso real.
2. Aplicación de los pasos de la Metodología de Diseño Conceptual.
3. Construcción del Esquema Conceptual (Diagrama Entidad/Relación).
4. Aplicación de los pasos de la Metodología de Diseño Lógico y reglas de conversión.
5. Construcción del Esquema Lógico de Tablas Relacionales (Modelo Relacional).

---

### 2.5 Listado de equipos, materiales y recursos
* **Equipos:** PCs.
* **Recursos (TAC):** Plataformas educativas.

---

### 2.6 Actividades por desarrollar

#### Definición de Entidades
* **CATEGORIAS:** Clasifica los tipos de equipos tecnológicos del laboratorio.
* **PROVEEDORES:** Empresas o personas que suministraron los equipos a la universidad.
* **PERSONAS:** Estudiantes y docentes registrados que pueden solicitar equipos en préstamo o reserva.
* **LABORATORIOS:** Espacios físicos donde se almacenan y gestionan los equipos.
* **EQUIPOS:** Recursos tecnológicos disponibles para préstamo.
* **ACCESORIOS:** Complementos asociados a un equipo.
* **PRESTAMOS:** Registro de solicitudes de préstamo de equipos realizadas por personas.
* **RESERVAS:** Registro de reservas previas al préstamo realizadas por personas.
* **MANTENIMIENTOS:** Órdenes generadas cuando un equipo presenta daños o fallas.
* **TECNICOS:** Personal técnico que atiende los mantenimientos de los equipos.
* **ACTAS_NOVEDAD:** Documento generado al finalizar un préstamo con daño o pérdida.
* **Tablas Intermedias:** DETALLE_PRESTAMO, DETALLE_RESERVA y MANTENIMIENTO_TECNICO.

#### Definición de Claves (PK y FK) y Atributos

| Entidad | Primary Key (PK) | Foreign Key (FK) | Atributos Principales |
| :--- | :--- | :--- | :--- |
| **CATEGORIAS** | ID_CAT | - | NOM_CAT, DES_CAT |
| **PROVEEDORES** | ID_PRV | - | NOM_PRV, TEL_PRV, COR_PRV |
| **PERSONAS** | ID_PER | - | CED_PER, NOM_PER, APE_PER, ROL_PER |
| **LABORATORIOS** | ID_LAB | ID_PER_RES | COD_LAB, NOM_LAB, BLO_LAB, PIS_LAB |
| **EQUIPOS** | ID_EQU | ID_CAT, ID_LAB, ID_PRV | COD_EQU, MAR_EQU, MOD_EQU, EST_EQU |
| **ACCESORIOS** | ID_ACC | ID_EQU | NOM_ACC, DES_ACC, EST_ACC|
| **PRESTAMOS** | ID_PRE | ID_PER, ID_RES | FEC_SOL_PRE, FEC_PRE, EST_PRE |
| **RESERVAS** | ID_RES | ID_PER | FEC_RES, HOR_RES, EST_RES |
| **MANTENIMIENTOS** | ID_MAN | ID_EQU| TIP_MAN, FEC_INI_MAN, EST_MAN|
| **TECNICOS** | ID_TEC | - | CED_TEC, NOM_TEC, ESP_TEC |

#### Relaciones y Cardinalidad
*  **CATEGORIAS 1:N EQUIPOS:** Una categoría clasifica muchos equipos.
*  **PROVEEDORES 1:N EQUIPOS:** Un proveedor suministra muchos equipos.
* **LABORATORIOS 1:N EQUIPOS:** Un laboratorio alberga muchos equipos.
*  **PERSONAS 1:N LABORATORIOS:** Un docente administra muchos laboratorios.
*  **PERSONAS 1:N PRESTAMOS:** Una persona realiza muchos préstamos.
* **PRESTAMOS N:M EQUIPOS:** Relación a través de DETALLE_PRESTAMOS.
*  **PERSONAS 1:N RESERVAS:** Una persona efectúa muchas reservas.
*  **RESERVAS N:M EQUIPOS:** Relación a través de DETALLE_RESERVA.
*  **RESERVAS 0..1:0..1 PRESTAMOS:** Una reserva puede originar un préstamo.
* **EQUIPOS 1:N MANTENIMIENTOS:** Un equipo genera muchos mantenimientos.
*  **MANTENIMIENTOS N:M TECNICOS:** Relación a través de MANTENIMIENTO_TECNICO.
* **PRESTAMOS 1:0..1 ACTAS NOVEDAD:** Un préstamo genera cero o un acta de novedad.
*  **EQUIPOS 1:N ACCESORIOS:** Un equipo tiene muchos accesorios.

---

### 2.7 Resultados obtenidos
Diagramas de Esquemas Conceptuales (Diagrama Entidad/Relación) para varios casos reales.  

<img width="5563" height="7592" alt="Academic Resource-2026-03-20-160638" src="https://github.com/user-attachments/assets/23ebe839-ba01-442d-ad42-7568678f29e6" />

Esquemas Lógicos de Tablas Relacionales (Modelo Relacional) para los casos reales. 


<img width="5072" height="7892" alt="Academic Resource-2026-03-20-155917" src="https://github.com/user-attachments/assets/0b2f15e4-c365-44bc-bca4-1789a891807f" />


### Reglas de Integridad del Modelo Relacional

### Integridad de Entidad
Cada tabla posee una clave primaria única y no nula. Entidades como `PERSONAS`, `EQUIPOS` y `LABORATORIOS` usan identificadores únicos (`ID_PER`, `ID_EQU`, `ID_LAB`) para rastrear cada registro sin ambigüedades.

### Integridad Referencial
- Un registro en `PRESTAMOS` requiere que `ID_PER` exista en `PERSONAS`.
- Todo equipo en `EQUIPOS` debe estar vinculado a un `ID_LAB` existente.
- No se puede generar una orden en `MANTENIMIENTOS` para un `ID_EQU` que no figure en el inventario.

### Integridad de Dominio
- `ROL_PER` solo acepta los valores `estudiante` o `docente`.
- `EST_EQU` solo acepta: `bueno`, `dañado` o `en mantenimiento`.
- Las fechas `FEC_PRE` y `FEC_DEV_PRE` deben tener formato `DATE`.

---

### 2.8 Habilidades blandas empleadas
| Habilidad | Aplicada |
|-----------|----------|
| Liderazgo | ☐ |
| Trabajo en equipo | ☑ |
| Comunicación asertiva | ☐ |
| Empatía | ☐ |
| Pensamiento crítico | ☐ |
| Flexibilidad | ☐ |
| Resolución de conflictos | ☐ |
| Adaptabilidad | ☐ |
| Responsabilidad | ☐ |

---

### 2.9 Conclusiones
- La correcta aplicación de la Metodología de Diseño Conceptual y Lógico permite obtener el diagrama del Esquema Conceptual e implementar el Esquema Lógico de Tablas Relacionales para casos reales.
- La centralización de los equipos mediante códigos institucionales únicos y su relación con laboratorios específicos garantiza un control preciso del inventario, evitando pérdidas y facilitando la ubicación física inmediata de cada activo.
- La implementación de un historial vinculado a préstamos y órdenes de trabajo permite medir el desgaste de los equipos y la responsabilidad del usuario, asegurando que el soporte técnico y las actas de novedad actúen como mecanismos eficaces para mantener la operatividad del laboratorio.

---

### 2.10 Recomendaciones
- Se recomienda usar lenguaje claro y técnico en los enunciados.
- Se recomienda proporcionar bibliografía adecuada para el tema.
- Se deben realizar ejercicios prácticos que vinculen la teoría con casos reales.

---

### 2.11 Referencias bibliográficas

---

### 2.12 Anexos
Link de este documento compartido

https://utaedu-my.sharepoint.com/:w:/g/personal/pacaro3350_uta_edu_ec/IQBwPDGwflo1SJVWEp5Z_-oOARQOnGejHPLxCt6lWqUdfE0?e=covaQE
