<?php

namespace App\Controllers;

use App\Handlers\ResponseHandler;
use App\Models\PokemonTypes;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class PokemonTypesController
{
    public function countEachTypePokemon(Request $request, Response $response)
    {
        $responseHandler = new ResponseHandler($response);

        try {
            $pokemonTypesModel = new PokemonTypes();
            $pokemonTypes = $pokemonTypesModel->countTypes();

            return $responseHandler->response($pokemonTypes, 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function countBeginningByType(Request $request, Response $response, $args)
    {
        $responseHandler = new ResponseHandler($response);

        try {
            $name = $args['type'];
            $pokemonTypesModel = new PokemonTypes();

            if (!is_string($name)) return $responseHandler->error('The parameter type must be a string value', 400);

            $pokemonTypes = $pokemonTypesModel->countPokemonBeginningByTypes($name);

            return $responseHandler->response($pokemonTypes, 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }
}
