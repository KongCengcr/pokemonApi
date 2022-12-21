<?php

namespace App\Controllers;

use App\Handlers\ResponseHandler;
use App\Models\Pokemon;
use App\Models\PokemonTypes;
use App\Resources\PokemonResource;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class PokemonController
{

    public function list(Request $request, Response $response, $args)
    {
        $responseHandler = new ResponseHandler($response);
        $page = 0;
        if (isset($args['page'])) {

            $page = $args['page'];

            if (!is_numeric($page)) return $responseHandler->error('The parameter page must be a numeric value', 400);
        }

        try {
            $pokemonModel = new Pokemon();

            if ($page) {
                $list = $pokemonModel->paginate(15, $page);
            } else {
                $list = $pokemonModel->all();
            }

            $pokemonResource = new PokemonResource($list);
            $parse = $pokemonResource->parseData();

            return $responseHandler->response($parse, 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function view(Request $request, Response $response, $args)
    {
        $responseHandler = new ResponseHandler($response);
        $id = $args['id'];

        if (!is_numeric($id)) return $responseHandler->error('The parameter ID must be a numeric value', 400);

        try {
            $pokemonModel = new Pokemon();
            $pokemon = $pokemonModel->find($id);

            if (!$pokemon) return $responseHandler->error('Pokemon not exist!', 404);

            $pokemonResource = new PokemonResource($pokemon);
            $parse = $pokemonResource->parseData();

            return $responseHandler->response($parse, 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function create(Request $request, Response $response)
    {

        $responseHandler = new ResponseHandler($response);
        $params = (array)$request->getParsedBody();
        try {
            $types = $params['types'];

            $pokemonModel = new Pokemon();
            $pokemonTypesModel = new PokemonTypes();

            $pokemon = $pokemonModel->findAllBy('name', $params['name']);

            if ($pokemon) return $responseHandler->error('Pokemon exist!', 404);

            unset($params['types']);
            $pokemonId = $pokemonModel->create($params);

            foreach ($types as $type) {
                $pokemonTypesModel->create(['type_id' => $type, 'pokemon_id' => $pokemonId]);
            }

            return $responseHandler->response('Pokemon Created', 201);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function update(Request $request, Response $response, $args)
    {
        $responseHandler = new ResponseHandler($response);
        $params = (array)$request->getParsedBody();
        $id = $args['id'];
        $proccess = '';
        $count = 0;

        if (!is_numeric($id)) return $responseHandler->error('The parameter ID must be a numeric value', 400);

        try {
            $types = $params['types'];

            $pokemonModel = new Pokemon();
            $pokemonTypesModel = new PokemonTypes();
            $pokemon = $pokemonModel->find($id);

            if (!$pokemon) return $responseHandler->error('Pokemon not exist!', 404);

            unset($params['types']);
            $pokemonId = $pokemonModel->update($id, $params);
            $pokemonTypes = $pokemonTypesModel->findAllBy('pokemon_id', $id);

            if (count($types) >= count($pokemonTypes)) {
                $proccess = 'create';
                $count = count($types);
            } else {
                $proccess = 'delete';
                $count = count($pokemonTypes);
            }


            for ($i = 0; $i < $count; $i++) {
                if (isset($types[$i]) && isset($pokemonTypes[$i])) {
                    $pokemonTypesModel->update(
                        $pokemonTypes[$i]['id'],
                        [
                            'type_id' => $types[$i],
                            'pokemon_id' => $id
                        ]
                    );
                } else {
                    $proccess == 'create' && $pokemonTypesModel->create(['type_id' => $types[$i], 'pokemon_id' => $id]);
                    $proccess == 'delete' && $pokemonTypesModel->delete($pokemonTypes[$i]['id']);
                }
            }

            return $responseHandler->response('Pokemon updated', 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function delete(Request $request, Response $response, $args)
    {
        $responseHandler = new ResponseHandler($response);
        $id = $args['id'];

        if (!is_numeric($id)) return $responseHandler->error('The parameter ID must be a numeric value', 400);

        try {
            $pokemonModel = new Pokemon();
            $pokemon = $pokemonModel->find($id);

            if (!$pokemon) return $responseHandler->error('Pokemon not exist!', 404);

            $pokemonModel->delete($id);

            return $responseHandler->response('Pokemon deleted', 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }
}
