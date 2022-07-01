/*
https://blog.sqlauthority.com/2011/02/07/sql-server-cxpacket-parallelism-advanced-solution-wait-type-day-7-of-28/
Por que se puede presentar esperas de CXPACKET
Si los datos están muy sesgados, hay posibilidades de que el optimizador de consultas pueda estimar la 
cantidad correcta de los datos que conducen a asignar menos hilo a la consulta. 
Esto puede conducir fácilmente a una carga de trabajo desigual en los hilos y puede crear espera CXPAKCET.

Al recuperar los datos de una de la cara proceso de IO, de memoria o CPU cuello de botella y tienen que 
esperar para conseguir esos recursos para ejecutar sus tareas, puede crear CXPACKET esperar también.

Los datos recuperados se encuentran en diferentes sistemas de E / S de velocidad. (Esto no es común y 
difícilmente posible, pero hay posibilidades).

Las fragmentaciones más altas en alguna área de la tabla pueden llevar menos datos por página. Esto puede 
llevar a esperar CXPACKET.
------------------------------------------------------------------------------------------------------------
Buenas Practicas

MAXDOP
Después de hacer que el monitor de cambios no sólo espere tipos, sino también para saber cómo está 
funcionando el sistema. Busque las consultas que se ejecutan en paralelismo y probarlas manualmente usando 
diferentes niveles de DOP usando la sugerencia de consulta OPTION (MAXDOP n) para ver si la reducción del 
paralelismo realmente mejora o perjudica el rendimiento. Es posible que la reducción de una consulta mejore 
el rendimiento mientras que el resto de la carga de trabajo muestra una disminución de rendimiento de la misma 
reducción probada. En ese caso poniendo la sugerencia de consulta en, ya sea como una guía de plan para la 
consulta individual, o cambiando el código si tiene acceso, produciría mejores retornos.

La des-fragmentación del índice puede ayudar a que se puedan obtener más datos por página. 
(Suponiendo un factor de llenado cercano a 100)

Si los datos están en varios archivos que están en la unidad física de velocidad similar, 
la espera CXPACKET puede reducir.

Mantenga actualizadas las estadísticas, ya que esto proporcionará una mejor estimación al optimizador de 
consultas al asignar subprocesos y dividir los datos entre los subprocesos disponibles. La actualización de 
estadísticas puede mejorar significativamente la intensidad del optimizador de consultas para proporcionar un 
plan de ejecución adecuado. Esto puede afectar en general al proceso de paralelismo de manera positiva.
---------------------------------------------------------------------------------------------------------

mALAS pRACTICAS 

Aumentar el numero de Hilos del procesadro por que se estan presentando esperas CXPACKET, ya esto conlleva 
a mas problemas como el aumento de uso de memoria, y aun mayor comutacion en la CPU lo que conduce a una 
degradacion en el rendimiento tampoco significa que se deba reducir el numero de Hilos ya que puede 
generar un bloquoe pro procesos paralelos en los hilos

En otras palabras cuando se presente esperas CXPACKETS no se deben modificar el numero de hilos

*/