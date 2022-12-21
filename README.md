# Pokemon Api

This is a small application built with the [SlimPHP](https://www.slimframework.com/) framework using [pokeapi.co](https://pokeapi.co/).

You have to modify `APP_ROOT` in the `.env` file with the name of the folder containing the whole application.

## Table of Contents

- [Get Started](#get-started)
- [Working with migrations](#working-with-migrations)
- [Routes](#routes)
  - [Pokemon Route](#pokemon-route)
  - [Scraping Route](#scraping-route)
- [Postman](#postman)

## Get Started

Clone the github repository into your server folder.
Using Xampp you should clone the project inside the folder `htdocs`.

```sh
git clone https://github.com/KongCengcr/pokemonApi.git
```

Open the project folder and open your terminal with the address of the project folder and install the necessary dependencies with:

```sh
composer install
```

Once you have downloaded all the dependencies you must find the `pokemon_api.sql` file inside the DB folder.

```
pokemon_api/
    src/
        DB/
        pokemon_api.sql
```

Import the database with the service of your choice, configure your `.env` file with your database credentials and you are ready to test the application.

The `.env` file must be in the root of the project.

```
pokemon_api/
    .env
```

## Working With Migrations

If you want to use migrations the application uses [Phinx](https://phinx.org/) to do the database migration.

In the `composer.json` file you will have some scripts that will facilitate the use of migrations.

- `migrate:create` create a migration file inside the `src/DB/Migrations` folder.
- `migrate` runs the migrations.
- `rollback` back the last migration executed.
- `rollback:all` back all migrations executed.

To learn more about configuring and creating migrations visit [Phinx](https://phinx.org/).

## Routes

### Pokemon Routes

Estas son las principales rutas para la consulta de la api

### Pokemon

- `GET /v1/pokemon` It will show a list of the pokemon in the database, you also have `/v1/pokemon/page/{page}` which will return the list with a pagination.
- `GET /v1/pokemon/{id}` It will return a pokemon with the specified id.
- `POST /v1/pokemon` Insert a new pokemon.
- `PUT /v1/pokemon/{id}` Update a pokemon.
- `DELETE /v1/pokemon/{id}` Delete a pokemon.

### Types

These routes will show the types of pokemon available.

- `GET /v1/pokemon/types` It will display a list of the types.
- `GET /v1/pokemon/types/{id}` It will return a type with the specified id.
- `GET /v1/pokemon/count/types` It will return a list of the types of pokemosnes available.
- `GET /v1/pokemon/count/types/{type}` It will count the types of pokemon that start with a type.
- `POST /v1/pokemon/types` Inserts a new type.
- `PUT /v1/pokemon/types/{id}` Update a type.
- `DELETE /v1/pokemon/types/{id}` Delete a type.

### Scraping Route

In the application a scraping was used to take some data from [pokeapi.co](https://pokeapi.co/) and insert it into the database, thus facilitating the insertion of data based on [pokeapi.co](https://pokeapi.co/).

For the scraping mainly `Curl` is used.

- `GET /scraping/types` This path will scrape the types from [pokeapi.co](https://pokeapi.co/) and insert it into the database, thus facilitating the insertion of data based on [pokeapi.co](https://pokeapi.co/).
- `GET /scraping/pokemon/{from}/{to}` This path will scrape the pokemon available in [pokeapi.co](https://pokeapi.co/) and insert it into the database, thus facilitating the insertion of data based on [pokeapi.co](https://pokeapi.co/) where `from` will be from how much and `to` to how much you want to do the scraping.

## Postman

In the root folder of the project you will find a collection file for postman queries, the file is named `Api Pokemon.postman_collection`.
