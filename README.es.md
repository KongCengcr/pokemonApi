# Pokemon Api

Esta es una pequeña aplicación construida con el framework [SlimPHP](https://www.slimframework.com/) en donde usa [pokeapi.co](https://pokeapi.co/).

## Tabla de Contenido

- [¿Como empezar?](#como-empezar)
- [Trabajando con migraciones](#trabajando-con-migraciones)
- [Routes](#routes)
  - [Pokemon Route](#pokemon-route)
  - [Scraping Route](#scraping-route)
- [Postman](#postman)

## Como Empezar

Clona el repositorio de github en tu carpeta de servidor.
Usando Xampp debes de clonar el proyuecto dentro de la carpeta `htdocs`.

```sh
git clone https://github.com/KongCengcr/pokemonApi.git
```

Abre la carpeta del proyecto y abre tu terminal con la dirección de la carpeta del proyecto e instala las dependencias necesarias con:

```sh
composer install
```

Una vez descargada todas las dependencias debes de buscar el archivo `pokemon_api.sql` dentro de la carpeta DB

```
pokemon_api/
    src/
        DB/
        pokemon_api.sql
```

Importa la base de datos con el servicio que gustes, configura tu archivo `.env` con las credenciales de tu base de datos y ya estarás listo para probar la aplicación.

El archivo `.env` debe de estar en la raiz del proyecto.

```
pokemon_api/
    .env
```

## Trabajando Con Migraciones

Si deseas usar migraciones la aplicación usa [Phinx](https://phinx.org/) para hacer la migración de base de datos.

En el archivo `composer.json` tendrás unos scripts que te facilitara el uso de las migraciones.

- `migrate:create` crea un archivo de migracion dentro de la carpeta `src/DB/Migrations`.
- `migrate` ejecuta las migraciones.
- `rollback` regresa la ultima migracion ejecutada.
- `rollback:all` regresa todas las migraciones.

Para saber más sobre como configurar y creacion de migraciones visite [Phinx](https://phinx.org/).

## Routes

### Pokemon Routes

Estas son las principales rutas para la consulta de la api

### Pokemon

- `GET /v1/pokemon` Mostrará una lista de los pokemones en la base de datos, también dispones de `/v1/pokemon/page/{page}` que te devolvera el listado con una paginación.
- `GET /v1/pokemon/{id}` Devolverá un pokemon con la id especificado.
- `POST /v1/pokemon` Inserta un nuevo pokemon.
- `PUT /v1/pokemon/{id}` Actualiza un pokemon.
- `DELETE /v1/pokemon/{id}` Borra un pokemon.

### Types

Estas rutas mostrará los tipos de pokemon disponibles.

- `GET /v1/pokemon/types` Mostrará una lista de los tipos.
- `GET /v1/pokemon/types/{id}` Devolverá un tipo con la id especificado.
- `GET /v1/pokemon/count/types` Devolverá una lista de los tipos de pokemosnes disponibles.
- `GET /v1/pokemon/count/types/{type}` Contará los tipos de pokemones que inicie por un tipo.
- `POST /v1/pokemon/types` Inserta un nuevo tipo.
- `PUT /v1/pokemon/types/{id}` Actualiza un tipo.
- `DELETE /v1/pokemon/types/{id}` Borra un tipo.

Para un ejemplo más sencillo:

Si vas a crear un nuevo componente o una nueva pagina deberás de crear una rama nueva con el siguiente nombre:

```sh
git checkout -b feat-new-component
```

### Scraping Route

En la aplicación se usó un scraping para poder tomar algunos datos de [pokeapi.co](https://pokeapi.co/) e insertarlo en la base de datos, asi facilitando la insercion de datos en base a [pokeapi.co](https://pokeapi.co/).

- `GET /scraping/types` Esta ruta hará un scraping de los tipos de [pokeapi.co](https://pokeapi.co/) e insertarlo en la base de datos, asi facilitando la insercion de datos en base a [pokeapi.co](https://pokeapi.co/).
- `GET /scraping/pokemon/{from}/{to}` Esta ruta hará un scraping de los pokemones disponibles en [pokeapi.co](https://pokeapi.co/) e insertarlo en la base de datos, asi facilitando la insercion de datos en base a [pokeapi.co](https://pokeapi.co/) en donde `from` va a ser desde cuanto y `to` hasta cuanto quieres hacer el scraping.

## Postman

En la carpeta raiz del proyecto encontrarás un archivo de colección para poder hacer las consultas mediante postman, el archivo tiene como nombre `Api Pokemon.postman_collection`
