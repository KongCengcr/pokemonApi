<?php

use App\Controllers\PokemonController;
use App\Controllers\PokemonTypesController;
use App\Controllers\ScrapingApiController;
use App\Controllers\TypesController;
use App\Middlewares\PermissionMiddleware;
use Slim\Routing\RouteCollectorProxy;


$app->group('/v1/pokemon', function (RouteCollectorProxy $group) {

    //Types
    $group->get('/types', TypesController::class . ':list');
    $group->post('/types', TypesController::class . ':create');

    //Count Types
    $group->get('/count/types', PokemonTypesController::class . ':countEachTypePokemon');

    //Pokemon
    $group->get('[/page/{page}]', PokemonController::class . ':list');
    $group->get('/{id}', PokemonController::class . ':view');
    $group->post('', PokemonController::class . ':create');
    $group->put('/{id}', PokemonController::class . ':update');
    $group->delete('/{id}', PokemonController::class . ':delete');

    //Types Params
    $group->get('/types/{id}', TypesController::class . ':view');
    $group->put('/types/{id}', TypesController::class . ':update');
    $group->delete('/types/{id}', TypesController::class . ':delete');

    //Count Type Params
    $group->get('/count/type/{type}', PokemonTypesController::class . ':countBeginningByType');
});


$app->get('/scraping/types', ScrapingApiController::class . ':scrapingTypeIntoDB');
$app->get('/scraping/pokemon/{from}/{to}', ScrapingApiController::class . ':scrapingPokemonIntoDB');
