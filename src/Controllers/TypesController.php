<?php

namespace App\Controllers;

use App\Handlers\ResponseHandler;
use App\Models\Types;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class TypesController
{

    public function list(Request $request, Response $response)
    {
        $responseHandler = new ResponseHandler($response);

        try {
            $typeModel = new Types();
            $types = $typeModel->all();

            return $responseHandler->response($types, 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function view(Request $request, Response $response, $args)
    {
        $id = $args['id'];
        $responseHandler = new ResponseHandler($response);

        if (!is_numeric($id)) return $responseHandler->error('The parameter ID must be a numeric value', 400);

        try {
            $typeModel = new Types();
            $type = $typeModel->find($id);

            return $responseHandler->response($type, 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function create(Request $request, Response $response)
    {

        $params = (array)$request->getParsedBody();
        $responseHandler = new ResponseHandler($response);

        try {
            $typeModel = new Types();
            $typeModel->create($params);

            return $responseHandler->response('Type Created', 201);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function update(Request $request, Response $response, $args)
    {

        $params = (array)$request->getParsedBody();
        $id = $args['id'];
        $responseHandler = new ResponseHandler($response);

        if (!is_numeric($id)) return $responseHandler->error('The parameter ID must be a numeric value', 400);

        try {
            $typeModel = new Types();
            $type = $typeModel->find($id);
            if (!$type) return $responseHandler->error('Type not exist!', 404);

            $typeModel->update($id, $params);

            return $responseHandler->response('Type updated', 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }

    public function delete(Request $request, Response $response, $args)
    {
        $id = $args['id'];
        $responseHandler = new ResponseHandler($response);

        if (!is_numeric($id)) return $responseHandler->error('The parameter ID must be a numeric value', 400);

        try {
            $typeModel = new Types();
            $type = $typeModel->find($id);

            if (!$type) return $responseHandler->error('Type not exist!', 404);

            $typeModel->delete($id);

            return $responseHandler->response('Type Deleted', 200);
        } catch (\PDOException $e) {
            return $responseHandler->error($e->getMessage(), 500);
        }
    }
}
