# PRUEBA UNIIDAD 01 - BASE DE DATOS

## Integrantes: Acaro Sebastián, Guevara Mauricio, López Erick, Mora Santiago

### Enunciado

Se desea crear una base de datos para controlar los viajes de las cooperativas de transporte hacia  
las diferentes ciudades del país. De las cooperativas de transporte se conoce código, nombre  
dirección y teléfono. Una cooperativa tiene muchos socios, pero ese socio puede ser solo de una  
cooperativa. Un socio tiene muchas unidades(buses) pero esa unidad le pertenece solo a ese  
socio. De cada socio se conoce cédula, nombre, apellido, dirección, teléfono, fecha de  
nacimiento. De cada unidad(bus) se conoce número de disco(id), marca, año, placa, capacidad  
de pasajeros.  

Una provincia tiene muchos cantones, pero ese cantón le pertenece solo a esa provincia. De cada  
provincia se conoce código, nombre, ubicación. De cada cantón se conocen código, nombre, 
referencia geográfica. Muchos buses viajan a muchos cantones, de cada viaje se conoce número 
de viaje, fecha hora de salida, fecha hora de llegada, costo del asiento, y la cantidad de pasajeros  
que viajan.  

A los buses se les realizan controles de calidad anuales. Un bus pasa varios controles y un control  
se aplica a 1 solo bus. Del control se conoce un código, fecha del control, tipo de control, el id  
del funcionario responsable del control, el resultado del control (puede ser aprobado o  
reprobado). 

Un control puede tener muchos incumplimientos. De cada incumplimiento se conoce id,  
descripción y nivel de gravedad de la novedad.

Secuencia sugerida: 
1. Lea el caso 
2. Identifique entidades 
3. Defina cardinalidades 
4. Convierta a tablas 
5. Revise integridad 

### Desarrolle: 
Hasta el esquema Lógico, utilice herramientas acordes a la solución (coloque el nombre de la  
herramienta utilizada) considere la siguiente figura para la presentación.

---

### 1. Lea el caso 
### 2. Identifique entidades

**Entidades**

* COOPERATIVA
* SOCIO
* UNIDAD
* PROVINCIA
* CANTON
* VIAJE
* CONTROL
* INCUMPLIMIENTO

### 3. Defina cardinalidades
Basado en el análisis del enunciado, las relaciones quedan definidas de la siguiente manera:

* **COOPERATIVA (1:N) SOCIO**: Una cooperativa tiene muchos socios, pero un socio pertenece a una sola cooperativa.
* **SOCIO (1:N) UNIDAD**: Un socio posee muchas unidades, pero cada unidad pertenece a un único socio.
* **UNIDAD (N:M) CANTON**: Muchos buses viajan a muchos cantones. *Nota: Esto genera una tabla intermedia de "VIAJE".*
* **UNIDAD (1:N) CONTROL**: Una unidad pasa por varios controles anuales, pero cada registro de control pertenece a una sola unidad.
* **CONTROL (1:N) INCUMPLIMIENTO**: Un control puede registrar múltiples incumplimientos.
* **PROVINCIA (1:N) CANTON**: Una provincia agrupa muchos cantones, pero un cantón es exclusivo de una provincia.

### 4. MER


### 5. Convierta a tablas 

![WhatsApp Image 2026-03-17 at 8 02 46 PM](https://github.com/user-attachments/assets/39c39431-7647-43c1-8cfc-0a2eb00ac6a9)


### 6. Revise integridad

| Regla de Integridad | Cómo se cumple en este caso |
| :--- | :--- |
| **Integridad de Entidad** | Cada cooperativa tiene un cod_coop único. Cada socio tiene una cedula única. Ninguno de estos campos puede ser NULL. |
| **Integridad Referencial** | El campo cedula_socio en la tabla UNIDAD debe ser una FK válida que apunte a un registro en la tabla SOCIO. |
| **Integridad de Dominio** | El campo nombre en ambas tablas solo debe aceptar caracteres alfabéticos tipo string. |






