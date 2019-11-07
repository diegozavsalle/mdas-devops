# Ejercicio 3: Docker compose

Añadir al `docker compose` un **"reverse proxy" (nginx)** usando la configuración proporcionada `./nginx/nginx.conf` para acceder a la aplicación votingapp, exponiendo solo los puertos del reverse proxy.

Mostrar las 2 posibles opciones:

* Creando una nueva imagen basada en la de nginx copiando el fichero de configuración de nginx.
* Usando la imagen original de nginx montando el fichero con la configuración como un volumen.

Recordar que nginx lee por defecto la configuración del fichero `/etc/nginx/nginx.conf`

La entrega se realiza en el repo privado de github de cada estudiante.
