<?php

namespace App\Handlers;

use Psr\Http\Message\ResponseInterface;

class ResponseHandler
{
    protected $response;

    public function __construct(ResponseInterface $response)
    {
        $this->response = $response;
    }

    /**
     * Make Success response
     * 
     * @param mixed   $data  Give a data response
     * @param int     $code  Give success code Http, for example | 200 | 201 |
     */
    public function response(
        mixed $data,
        int $code
    ): ResponseInterface {
        $response = [
            'code' => $code,
            'status' => 'Success',
            'data' => $data
        ];

        $this->response->getBody()->write(json_encode($response));
        return $this->response->withHeader('Content-Type', 'application/json')->withStatus($code);
    }

    /**
     * Make error response
     * 
     * @param string  $message  Give a message for error
     * @param int     $code     Give error code Http for example | 400 | 401 | 404 | 500 |
     */
    public function error(
        string $message,
        int $code
    ): ResponseInterface {

        $response = [
            'code' => $code,
            'status' => 'Somthing is wrong!',
            'message' => $message
        ];

        $this->response->getBody()->write(json_encode($response));
        return $this->response->withHeader('Content-Type', 'application/json')->withStatus($code);
    }
}
