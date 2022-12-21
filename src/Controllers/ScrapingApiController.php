<?php

namespace App\Controllers;

use App\Handlers\ResponseHandler;
use App\Models\Model;
use App\Models\Pokemon;
use App\Models\Types;
use App\Utils\Curl;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class ScrapingApiController
{

    public function scrapingTypeIntoDB(Request $request, Response $response, $args)
    {
        $responseHandler = new ResponseHandler($response);
        $curl = new Curl('https://pokeapi.co/api/v2/');

        try {
            $db = new Model();
            $typeModel = new Types();
            $values = [];
            $types = $curl->request('type', 'GET');
            $typesDecode = json_decode($types);

            foreach ($typesDecode->results as $type) {
                if (!$typeModel->findExactBy('name', $type->name)) {
                    array_push($values, "('$type->name')");
                }
            }

            $sql = "INSERT INTO types (name) VALUES " . implode(',', $values);
            $db->pdo->exec($sql);

            return $responseHandler->response('Completed', 201);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function scrapingPokemonIntoDB(Request $request, Response $response, $args)
    {
        $responseHandler = new ResponseHandler($response);

        /*Instance Curl to query pokeapi*/
        $curl = new Curl('https://pokeapi.co/api/v2/');

        $from = $args['from'];
        $to = $args['to'];

        if (!is_numeric($from) && !is_numeric($to)) return $responseHandler->error('The parameter from/to must be a numeric value', 400);

        try {
            $db = new Model();
            $typeModel = new Types();
            $pokemonModel = new Pokemon();

            $allPokemon = $pokemonModel->all();
            $types = $typeModel->all();

            if (count($types) == 0) {
                return $responseHandler->response('Not have types Pokemon, pls add types from route scraping or manually', 200);
            }

            $pokemonValues = [];
            $typeValues = [];

            for ($i = $from; $i <= $to; $i++) {

                /*Query pokeapi*/
                $pokemon = $curl->request("pokemon/$i", 'GET');
                $pokemonDecode = json_decode($pokemon);

                /*Searches for a pokemon in the database and if found does not insert the pokemon. */
                $findDBPokemon = array_search($pokemonDecode->name, array_column($allPokemon, 'name'));
                if ($findDBPokemon == "") {
                    $female_default = isset($pokemonDecode->sprites->female_default) ? $pokemonDecode->sprites->female_default : '';
                    $female_shiny = isset($pokemonDecode->sprites->female_shiny) ? $pokemonDecode->sprites->female_shiny : '';

                    /* prepares the value to be inserted into the database */
                    array_push($pokemonValues, "(
                        $pokemonDecode->id,
                        '$pokemonDecode->name',
                        $pokemonDecode->base_experience,
                        $pokemonDecode->height,
                        $pokemonDecode->is_default,
                        $pokemonDecode->order,
                        $pokemonDecode->weight,
                        '" . $pokemonDecode->sprites->front_default . "',
                        '" . $pokemonDecode->sprites->front_shiny . "',
                        '$female_default',
                        '$female_shiny'
                    )");

                    foreach ($pokemonDecode->types as $type) {
                        $findType = array_search($type->type->name, array_column($types, 'name'));
                        if ($findType != "") {
                            $typeId = $types[$findType]['id'];
                            array_push($typeValues, "(
                                $typeId,
                                $pokemonDecode->id
                            )");
                        }
                    }
                }
            }
            $sqlPokemon = "INSERT INTO pokemon 
                        (
                            pokemon.id,                    
                            pokemon.name, 
                            pokemon.base_experience,
                            pokemon.height,
                            pokemon.is_default,
                            pokemon.order,
                            pokemon.weight,
                            pokemon.sprite_front_default,
                            pokemon.sprite_front_shiny,
                            pokemon.sprite_female_default,
                            pokemon.sprite_female_shiny
                        ) 
                            VALUES " .  implode(',', $pokemonValues);

            $sqlPokemonType = "INSERT INTO pokemon_types 
                        (
                            pokemon_types.type_id, 
                            pokemon_types.pokemon_id
                        ) 
                            VALUES " . implode(',', $typeValues);

            $db->pdo->exec($sqlPokemon);
            $db->pdo->exec($sqlPokemonType);

            return $responseHandler->response('Completed', 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }
}
