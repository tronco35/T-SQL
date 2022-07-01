/*
Problemas de Hardware 

PAGEIOLATCH
Este tipo de espera particular se produce cuando cualquiera de las tareas est� esperando a que los datos del 
disco se muevan a la memoria cach� del b�fer.

PAGEIOLATCH_DT
Se produce cuando una tarea est� esperando en un bloqueo para un b�fer que est� en una solicitud de E / S. 
La solicitud de cierre est� en modo Destruir. Las largas esperas pueden indicar problemas con el subsistema 
de disco.

PAGEIOLATCH_EX
Se produce cuando una tarea est� esperando en un bloqueo para un b�fer que est� en una solicitud de E/S. 
La solicitud de cierre est� en modo Exclusivo. Las largas esperas pueden indicar problemas con el subsistema 
de disco.

PAGEIOLATCH_KP
Se produce cuando una tarea est� esperando en un bloqueo para un b�fer que est� en una solicitud de E / S. 
La solicitud de cierre est� en modo Keep (guardar o tener). Las largas esperas pueden indicar problemas con 
el subsistema de disco.

PAGEIOLATCH_SH
Se produce cuando una tarea est� esperando en un bloqueo para un b�fer que est� en una solicitud de E / S. 
La solicitud de cierre est� en modo compartido. Las largas esperas pueden indicar problemas con el subsistema 
de disco.

PAGEIOLATCH_UP
Se produce cuando una tarea est� esperando en un bloqueo para un b�fer que est� en una solicitud de E / S. 
La solicitud de cierre est� en modo Actualizar. Las largas esperas pueden indicar problemas con el subsistema 
de disco.


reducir problemas 

Este tipo de estad�sticas de espera tambi�n puede suceder debido a la presi�n de la memoria o cualquier 
otro problema de memoria. Dejando de lado la cuesti�n de un subsistema de E / S defectuoso, este tipo de 
espera garantiza un an�lisis adecuado de los contadores de memoria. Si debido a cualquier raz�n, la 
memoria no es �ptima e incapaz de recibir los datos de E / S. Esta situaci�n puede crear este tipo de tipo de 
espera.

*/ 