# Django Boilerplate

Boilerplate para proyectos usando Django y PostgreSQL. Los proyectos estan pensandos para ser desarrollados bajo la metodlogia 12factor http://12factor.net/ y contiene herramientas para facilitar la creación de entornos de desarrollo y producción. Tambien contiene ya incluidos varios modulos de python y django ya listos para su uso.

## Estructura de archivos

En el root del proyecto esta los archivos **makefile** y **dockerfile** que son los que nos ayudan a crearlos los entornos, en **config** estan las opciones de los entornos que crearemos y en **src** esta el código de la aplicación.

La aplicación contiene con directorio **applications** que contiene todas las aplicaciones desarrolladas para el proyecto, un directorio **libraries** para pequeños scripts y **settings** para la configuración del proyecto.

    .
    ├── CONTRIBUTORS.txt
    ├── Dockerfile
    ├── LICENSE.txt
    ├── README.MD
    ├── config
    │   ├── Envfile.example
    │   ├── development.yml
    │   ├── production.yml
    │   └── requirements.txt
    ├── makefile
    └── src
        ├── applications
        │   ├── __init__.py
        │   └── common
        │       ├── __init__.py
        │       ├── admin.py
        │       ├── migrations
        │       │   └── __init__.py
        │       ├── models.py
        │       ├── static
        │       │   ├── fonts
        │       │   │   ├── FontAwesome.otf
        │       │   │   ├── fontawesome-webfont.eot
        │       │   │   ├── fontawesome-webfont.svg
        │       │   │   ├── fontawesome-webfont.ttf
        │       │   │   ├── fontawesome-webfont.woff
        │       │   │   ├── fontawesome-webfont.woff2
        │       │   │   ├── glyphicons-halflings-regular.eot
        │       │   │   ├── glyphicons-halflings-regular.svg
        │       │   │   ├── glyphicons-halflings-regular.ttf
        │       │   │   ├── glyphicons-halflings-regular.woff
        │       │   │   └── glyphicons-halflings-regular.woff2
        │       │   ├── images
        │       │   │   └── index.html
        │       │   ├── scripts
        │       │   │   ├── bootstrap.min.js
        │       │   │   └── jquery.min.js
        │       │   └── styles
        │       │       ├── bootstrap.min.css
        │       │       └── font-awesome.min.css
        │       ├── templates
        │       │   ├── README.md
        │       │   └── layout.html
        │       ├── tests.py
        │       ├── urls.py
        │       └── views.py
        ├── libraries
        │   └── __init__.py
        ├── manage.py
        ├── settings
        │   ├── __init__.py
        │   ├── defaults.py
        │   ├── project.py
        │   ├── s3utils.py
        │   └── urls.py
        └── wsgi.py

## Configurar el boilerplate

- Descargar el Boilerplate desde: https://github.com/nekrox/django-boilerplate
- Editar **config/development.yml** para configurar las variables de entorno necesarias para desarrollo, el nombre del host, puerto, usuario y password para postgre no es necesario cambiarlo.
- Copiar **config/Envfile.example** a **config/Envfile** y editar para tener los datos de producción, por default este archivo no se versiona.
- Editar **config/requirements.txt** para agregar o quitar paquetes de python.

Por default viene con algunos paquetes ya configurados y listos para su uso como **django-allauth**, **django-storages**, **django-suits**, **django-compress** entre otros. Estas configuraciones se encuentan en **src/settings**, el archivo **default.py** es el archivo de configuración general que por lo general no cambia entre proyectos y el archivo **project.py** es el que extiende los settings por default para personalizar cada proyecto.

## Manejo del entorno

Este proyecto cuenta con un **Makefile** con una serie de targets que ayudan al manejo de los entornos y el workflow de desarollo usando el comando **make**, la forma de usarlo es la siguiente:

    make [TARGET 1] [TARGET 2]

Podemos ejecutar un solo target o de forma secuencial varios y tambien asignar variables de la siguiente forma:

    make FOO=BAR [TARGET 1]

#### Variables que podemos usar

- SERVICE: Define el nombre del servicio que queremos manipular, por default **web**.
- PROJECT: Define el nombre del proyecto con el que trabajamos, por default **se usa el directorio del proyecto**.
- FILE: Define que archivo de compose estaremos usando, por default **development**.
- MACHINE: Define el nombre de la maquina donde instalaremos el entorno, por default **dev**.
- PORT: Define el puerto basico de trabajo, por default **8000**.
- DB: Define el nombre de la base de datos, por default **database**.

#### Comandos para manejo de maquina virtual

Por default se usa el valor de la variable **MACHINE** que es opcional.

- machine: Crea la maquina virtual para desarrollo si no existe, de lo contrario ejecuta la existente.

        make machine [MACHINE=nombremaquina]

- env: Devuelve la información para conectar docker con la maquina virtual.

        make env [MACHINE=nombremaquina]

- ip: Devuelve la ip de la maquina virtual.


        make ip [MACHINE=nombremaquina]

#### Comandos para compose

Por default se usan los valores de las variables **PROJECT**, **FILE**, **SERVICE** que son opcionales.


- build: Crea una imagen para docker de un servicio especifico de la información de configuración para compose.

        make build [PROJECT=name] [FILE=name] [SERVICE=name]

- up: Crea un conetendor y lo ejecuta en background para un servicio en especifico.


        make up [PROJECT=name] [FILE=name] [SERVICE=name]

- start: Inicia un servicio en especifico.

        make start [PROJECT=name] [FILE=name] [SERVICE=name]

- stop: Detiene un servicio en especifico.

        make stop [PROJECT=name] [FILE=name] [SERVICE=name]

- rm: Borra contenedores de servicios parados.

        make rm [PROJECT=name] [FILE=name] [SERVICE=name]

- kill: Fuerza la salida de servicios.

        make kill [PROJECT=name] [FILE=name] [SERVICE=name]

- logs: Muestra los logs de un servicio en especifico .

        make logs [PROJECT=name] [FILE=name] [SERVICE=name]

- scale: Aumenta el numero de contenedores para un servicio en especifico.

        make scale INSTANCES=num [PROJECT=name] [FILE=name] [SERVICE=name]

- ps: Muestra información de contenedores que se estan ejecutando.

        make ps [PROJECT=name] [FILE=name]

- port: Muestra informacion de los puertos relacionados con un servicio.

        make port [PORT=port] [PROJECT=name] [FILE=name] [SERVICE=name]

#### Comandos para django

Usan los valores por default de **PROJECT** y **SERVICE**.

- app: Crea los archivos para una nueva aplicación.

        make app NAME=name [PROJECT=name] [SERVICE=name]

- makemigrations: Crea nuevas migraciones para la base de datos.

        make makemigrations [PROJECT=name] [SERVICE=name]

- migrate: Aplica migraciones creadas.

        make migrate [PROJECT=name] [SERVICE=name]

- createsuperuser: Crea un super usuario.

        make createsuperuser [PROJECT=name] [SERVICE=name]

- collectstatic: Colecta archivos estaticos.

        make collectstatic [PROJECT=name] [SERVICE=name]

#### Comandos varios

- postgres: Crea un servidor postgres en caso de no existir uno en la maquina virtual de otro modo ejecuta el existente.

        make postgres

- psql: Ejecuta la terminal psql en una determinada base de datos. Usa el valor de **DB** como nombre de base de datos a conectar.

        make psql [DB=name]

- createdb: Crea una base de datos. Usa el valor de **DB** como nombre de base de datos.

        make createdb [DB=name]

- dropdb: Borra una base de datos. Usa el valor de **DB** como nombre de base de datos.

        make dropdb [DB=name]

- clean: Borra archivos basura.

        make clean

- open: Abre el navegador en la url del proyecto.

        make open [MACHINE=name] [PORT=num]

- shell: Ejecuta una shell bash dentro del contenedor principal de un servicio en especifico.

        make shell [PROJECT=name] [SERVICE=name]

## Creación de entorno de desarrollo

### Dependencias

#### VirtualBox

Sin importar el sistema operativo que estemos usando (Linux u OSX) los contenedores del proyecto y los servicios relacionados correran en una maquina virtual con una version de linux optmizada para funcionar con Docker por lo que es necesario tener virtualbox instalado en el sistema.

Se puede descargar virtualbox de aqui: https://www.virtualbox.org/

#### Docker, Compose y Machine

Se usara Docker, Compose y Machine ( https://www.docker.com/ ) para generar entornos facilmente replicables y distribuibles que puedan correr las aplicaciones y servicios necesarios en desarrollo y producción.

##### En OSX usando brew ( http://brew.sh/ ):

    brew install docker docker-compose docker-machine

##### En Ubuntu (13.10 en adelante):

    wget -qO- https://get.docker.com/ | sh
    curl -L https://github.com/docker/machine/releases/download/v0.3.0/docker-machine_linux-amd64 > /usr/local/bin/docker-machine
    chmod +x /usr/local/bin/docker-machine
    curl -L https://github.com/docker/compose/releases/download/1.3.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

Para instalar en otros sistemas operativos o plataformas ver la documentación: https://docs.docker.com/installation/

### Maquina Virtual

La maquina virtual para correr los contenedores de docker se crea usando **docker-machine** para facilitar la tarea contamos con el siguiente comando que nos creara una maquina llamada **dev**

    make machine

Para poder ver la opciones de conexión con **dev** tenemos el siguiente comando que  nos dara un mensaje con la información para configurar docker y conectar con el servidor de la VM.

    make env

### PostgreSQL

Para poder instalar el servidor postgres basta con correr un solo comando que lanza un contenedor con un servidor que incluya una configuración básica y la base de datos que usaremos.

    make postgres createdb

**NOTA: Si borramos el contenedor se perderan todos los datos guardados**

## Work Flow de desarrollo

#### Configruando nuevo entorno

Dentro del directorio del proyecto procedemos a ejecutar los siguientes comandos para inicializar nuestro entorno de trabajo.

    make machine
    make env
    echo 'eval "$(docker-machine env dev)"' >> ~/.bashrc
    source ~/.bashrc
    make postgres createdb
    make build up
    make migrate
    make createsuperuser
    make open

**NOTA: Si apagamos la maquina de host o la maquina virtual con el comando make machine podemos volver a ejecutarla sin crearla de nuevo y con el comando make postgres podemos ejecutar la base de datos de nuevo sin volver a crearla.**

### Retomando proyecto

Tenemos que iniciar la maquina virtual creada y la base de datos guarda.

    make machine postgres

Lo recomendable es recrear la imagen de docker y volver a ejecutar los contenedores

    make build up
