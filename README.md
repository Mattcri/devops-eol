# Tarea Postulación Desarrollador DevOps. Jr.

## Instrucciones iniciales para correr el proyecto

### Instalaciones necesarias
```
virtualenv --python python3 ./venv
source venv/bin/activate
pip install Django pytest-django
```

### Correr app
```
python manage.py runserver
```

### Correr tests
```
pytest
```

# 💥 Desarrollo Prueba DevOps. Jr. 💥

Una vez clonado el repositorio en nuestro ambiente local para lograr configurar el contenedor con la aplicación de Django se creo un ambiente virtualizado mediante `virtualenv` con las dependencias del proyecto y siguiendo las instrucciones detalles al inicio.

Luego de verificar que el proyecto corriera apropiadamente se creo mediante el comando:

 `pip freeze > requirements.txt`

 Un archivo que contiene todas las dependencias del proyecto, que posteriormete utilizaremos al instante de crear la receta del contenedor con **docker-compose**

 ## Configuración docker-compose
 --- 

 Primero iniciamos un archivo **Dockerfile** sencillo para crear nuestra imagen. En la cual lo más relevante es que copiaremos el archivo `requirements.txt` dentro del directorio de trabajo de nuestro contenedor para luego indicarle que instalé las dependencias con: 

 ```Dockerfile
RUN python -m pip install -r requirements.txt
 ```

Ya creada la configuración de nuestra imagen base procedemos a realizar la receta para **docker-compose** en donde los aspectos más importantes son:

- **build:** Donde le señaláremos a docker-compose que cree la imagen a partir del archivo Dockerfile de nuestro directorio de trabajo.
- **volumes:** Para vincular los archivos de nuestro directorio con los que vivirán en `/app/` del contenedor. De esta manera podemos aplicar los cambios que se iran reflejando también en nuestro contenedor.
- **ports:** Configuramos el puerto de comunicación que existirá entre el equipo host y el contendor. De esta manera entrando a **localhost:3005** seremos capaces de ver corriendo la aplicación.
- **command:** Le indicamos el comando para iniciar la aplicación Django en nuestro contenedor.

> Ahora estamos en condiciones de levantar nuestro contenedor con la aplicación de Django con:


```bash
docker-compose up -d
```

## Configurar pruebas en GitHub Actions
---

Creamos los directorios de trabajo necesarios para configurar un actions en nuestro repositorio de GitHub. En el interior de la carpeta workflows vivirá el archivo `actions-ci.yml` que tendrá los pasos a seguir de nuestro workflow.

Para está configuración seguimos las indicaciones de los actions workflows creados para Django.

Algunas optimizaciones que se efectuarón fue crear un **tag** con la versión estable de nuestra aplicación, que será la que utilizaremos al correr nuestro workflows mediante el paso: 

`uses: actions/checkout@v1` 

Y la segunda optimización será configurar un caché para que nuestro workflows sea más veloz en las ejecuciones posteriores. Durante la configuración del caché hubo algunas complicaciones debido a que en el primer intento de configuración luego de correr el actions guardando la ruta `~/.cache/pip` se perdían las dependencias en las siguientes ejecuciones, provocando que al momento de proceder con el paso **Run tests** lanzará el error: `No module named pytest`.

Para solucionar dicho problema se indagó en algunos foros, llegando a un buen resultado cambiando las rutas y las llaves para guardar caché. 

Si bien, no se lográ visualizar una gran reducción de segundos al correr el  workflows actual si tuviéramos más test corriendo seríamos capaces de ver una diferencia.

## Pull request con Bors GitHub
---

[Caso con merge correcto](https://github.com/Mattcri/devops-eol/pull/5):



[Caso con merge fallido](https://github.com/Mattcri/devops-eol/pull/4), mediante la creación de un conflicto entre las ramas a fucionar:

