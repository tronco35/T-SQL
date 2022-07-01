SELECT wait_type, waiting_tasks_count, wait_time_ms, max_wait_time_ms
,signal_wait_time_ms
FROM sys.dm_os_wait_stats
ORDER BY wait_time_ms DESC
GO

/*
wait_type: 
Este es el nombre del tipo de espera. Puede haber tres tipos diferentes de tipos de espera: 
recurso, cola y externo.

waiting_tasks_count: 
Este contador incremental es una buena indicación de la frecuencia de la espera que está sucediendo. 
Si este número es muy alto, es una buena indicación para nosotros investigar ese tipo de espera particular. 
Es muy posible que el tiempo de espera sea considerablemente bajo, pero la frecuencia de la espera es muy alta.

wait_time_ms:
Esto es esperar total acumulado para cualquier tipo de espera. Este es el tiempo de espera total e incluye 
singal_wait_time_ms.

max_wait_time_ms:
Esto indica que se ha producido el tipo máximo de espera para ese tipo de espera en particular. Utilizando esto,
se puede estimar la intensidad del tipo de espera en el pasado

signal_wait_time_ms:
Este es el tiempo de espera cuando el hilo se marca como runnable y llega al estado de ejecución. 
Si la cola runnable es muy larga, verá que este tiempo de espera se vuelve alto.
*/