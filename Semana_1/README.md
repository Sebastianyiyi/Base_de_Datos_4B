# Actividad Semana 01 
## **Tema:** Introducción a BD & Caso "Préstamo de Equipos"

### 1. Identificar: Datos vs Información (10 ejemplos del contexto UTA)

| Número | Datos | Información |
|---|---|---|
| 1 | `"Sebastián Acaro"`, `"01-03-2026"`, `"ponchadora"`, `"NULL"` | Sebastián Acaro solicitó una ponchadora el 01-03-2026 y aún no la ha devuelto. |
| 2 | `"0504986532"`, `"1"`, `"prestado"` | El estudiante con número de cédula 0504986532 tiene 1 equipo prestado. |
| 3 | `"05-03-2026"`, `"1 día"` | Los equipos prestados el 05-03-2026 se vencen el 06-03-2026. |
| 4 | `"3"`, `"equipos"`, `"prestado"` | Hay 3 equipos prestados en este momento. |
| 5 | `"0"`, `"stock"`, `"Cable Ethernet"` | El stock del Cable Ethernet es 0, por lo tanto no hay unidades disponibles para préstamo. |
| 6 | `"Laboratorio 8"`, `"15"`, `"préstamos"` | El Laboratorio 8 registró 15 préstamos. |
| 7 | `"NULL"`, `"fecha_devolución"` | La fecha de devolución está vacía, por lo que el equipo aún no ha sido devuelto. |
| 8 | `"Cable Ethernet"`, `"25"`, `"préstamos"`, `"1er Parcial"` | El Cable Ethernet fue prestado 25 veces durante el 1er Parcial. |
| 9 | `"I02"`, `"18"`, `"préstamos"` | El laboratorio con código I02 registró 18 préstamos. |
| 10 | `"Control del Aire acondicionado"`, `"I02"`, `"03-03-2026"`, `"07-03-2026"`, `"NULL"` | El control del aire acondicionado del laboratorio I02 sigue sin devolverse y presenta 4 días de retraso. |

### 2. Listar entidades y atributos del caso (mín. 8 entidades)

| Entidad | Atributos |
| :--- | :--- |
| **Estudiante** | Cédula, Nombre, Apellido, Carrera, Correo_Institucional, Teléfono. |
| **Docente** | ID_Docente, Nombre, Apellido, Facultad, Correo, Especialidad. |
| **Equipo** | Código_Activo, Nombre_Equipo, Marca, Modelo, Estado, Disponibilidad. |
| **Categoría_Equipo** | ID_Categoría, Nombre, Descripción. |
| **Laboratorio** | Código_Aula, Nombre_Laboratorio, Ubicación, Capacidad, Disponibilidad. |
| **Préstamo** | ID_Préstamo, Fecha_Salida, Fecha_Prevista_Devolución, Fecha_Real_Devolución, Observaciones. |
| **Sanción** | ID_Sanción, Motivo, Monto_Multa, Estado_Pago. |
| **Administrador_Lab** | ID_Admin, Nombre, Cargo, Turno. |

### 3. Definir 5 reglas de negocio

1. **Estado del Equipo:** Un equipo solo puede ser prestado si su estado es "Disponible" y su condición física es "Buena" o "Regular".
2. **Plazo de Devolución:** El tiempo máximo de préstamo para herramientas manuales es de 24 horas, mientras que para equipos electrónicos es de 3 días laborables.
3. **Restricción de Préstamo:** Un estudiante no puede solicitar un nuevo préstamo si tiene una sanción económica pendiente o un equipo con fecha de devolución vencida.
4. **Validación de Identidad:** Para retirar cualquier equipo, el solicitante debe presentar su cédula o carnet institucional vigente.
5. **Responsabilidad de Daños:** En caso de que un equipo sea devuelto con daños físicos, se generará automáticamente una sanción que bloquea al usuario del sistema hasta que se cubra el costo de reparación.
