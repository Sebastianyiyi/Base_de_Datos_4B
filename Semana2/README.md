# Actividad Semana 02

## Tema: Introducción a BD & Caso "Préstamo de Equipos"

### 1. Dibujar ER con cardinalidades y participación (mín. 12 relaciones).

<img width="3330" height="2402" alt="image" src="https://github.com/user-attachments/assets/255be472-0171-49bd-8a02-332b2051ba07" />

### 2. Identificar y resolver 2 relaciones N:M (con entidad asociativa).
  Ejemplo 1: Préstamo ↔ Equipo
	
  Cuando un estudiante o docente solicita un préstamo, no siempre pide un solo equipo. Un docente podría pedir 2 laptops y 1 proyector para una clase. Ese conjunto de equipos forma parte de un único préstamo. Es por eso    que nace la pregunta ¿Cómo registrar que un préstamo tiene varios equipos y que cada equipo puede salir en distintos préstamos a lo largo del tiempo? 
	
  Entidades involucradas
		· PRÉSTAMO
		· EQUIPO
		· DETALLE_PRÉSTAMO
		
  Un préstamo puede incluir muchos equipos → 1 préstamo → N equipos.
  
  Un equipo puede aparecer en muchos préstamos distintos a lo largo del tiempo → 1 equipo → N préstamos
	
  Entonces en base a esto:
  PRESTAMO → DETALLE_PRESTAMO: 1 a muchos, participación total (todo préstamo debe tener al menos un detalle)
	EQUIPO → DETALLE_PRESTAMO: 1 a muchos, participación parcial (un equipo puede existir en el inventario sin haber sido prestado nunca aún)
	
  Ejemplo 2: Administrador ↔ Laboratorio
	
  Una facultad normalmente tiene varios laboratorios y varios administradores que rotan en turnos (mañana, tarde, noche). Un administrador no está atado a un solo laboratorio: hoy puede cubrir el Lab A en turno mañana, y   mañana cubrir el Lab B en turno tarde. A su vez, el Lab A no depende de un solo administrador: distintas personas lo cubren en distintos horarios o fechas. El sistema necesita registrar quién cubre qué laboratorio, en    qué turno y en qué fechas.
	
  Entidades involucradas
		· ADMINSITRADOR_LAB
		· LABORATORIO
		· ASIGNACION_ADMIN
	
  Un administrador puede gestionar varios laboratorios → 1 admin → N laboratorios
	Un laboratorio puede ser gestionado por varios administradores → 1 laboratorio → N admins
	
  Entonces en base a esto:
	
  ADMINISTRADOR_LAB → ASIGNACION_ADMIN: 1 a muchos, participación total (un administrador registrado en el sistema debe tener al menos una asignación; de lo contrario no tendría función)
  
  LABORATORIO → ASIGNACION_ADMIN: 1 a muchos, participación total (todo laboratorio activo debe tener al menos un administrador responsable asignado)

### 3. Proponer 6 atributos con dominios (tipo de dato y restricciones).


