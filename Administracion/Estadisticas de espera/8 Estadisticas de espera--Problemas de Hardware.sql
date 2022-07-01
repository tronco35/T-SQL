/*
Problemas de Hardware 

PAGEIOLATCH
Este tipo de espera particular se produce cuando cualquiera de las tareas está esperando a que los datos del 
disco se muevan a la memoria caché del búfer.

PAGEIOLATCH_DT
Se produce cuando una tarea está esperando en un bloqueo para un búfer que está en una solicitud de E / S. 
La solicitud de cierre está en modo Destruir. Las largas esperas pueden indicar problemas con el subsistema 
de disco.

PAGEIOLATCH_EX
Se produce cuando una tarea está esperando en un bloqueo para un búfer que está en una solicitud de E/S. 
La solicitud de cierre está en modo Exclusivo. Las largas esperas pueden indicar problemas con el subsistema 
de disco.

PAGEIOLATCH_KP
Se produce cuando una tarea está esperando en un bloqueo para un búfer que está en una solicitud de E / S. 
La solicitud de cierre está en modo Keep (guardar o tener). Las largas esperas pueden indicar problemas con 
el subsistema de disco.

PAGEIOLATCH_SH
Se produce cuando una tarea está esperando en un bloqueo para un búfer que está en una solicitud de E / S. 
La solicitud de cierre está en modo compartido. Las largas esperas pueden indicar problemas con el subsistema 
de disco.

PAGEIOLATCH_UP
Se produce cuando una tarea está esperando en un bloqueo para un búfer que está en una solicitud de E / S. 
La solicitud de cierre está en modo Actualizar. Las largas esperas pueden indicar problemas con el subsistema 
de disco.


reducir problemas 

Este tipo de estadísticas de espera también puede suceder debido a la presión de la memoria o cualquier 
otro problema de memoria. Dejando de lado la cuestión de un subsistema de E / S defectuoso, este tipo de 
espera garantiza un análisis adecuado de los contadores de memoria. Si debido a cualquier razón, la 
memoria no es óptima e incapaz de recibir los datos de E / S. Esta situación puede crear este tipo de tipo de 
espera.

*/ 