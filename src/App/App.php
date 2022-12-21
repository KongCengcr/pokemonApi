<?php

use App\Middlewares\CorsMiddleware;
use App\Middlewares\JsonBodyParserMiddleware;
use Slim\Factory\AppFactory;

require __DIR__ . '/../../vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable('../');
$dotenv->load();

$app = AppFactory::create();
$app->setBasePath('/pokemon_api');

$app->addRoutingMiddleware();
$errorMiddleware = $app->addErrorMiddleware(true, true, true);

$app->add(new CorsMiddleware);
$app->add(new JsonBodyParserMiddleware);
// Define app routes
require __DIR__ . '/Routes.php';

// Run app
$app->run();
