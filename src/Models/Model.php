<?php

namespace App\Models;

class Model
{
    private $db_host;
    private $db_name;
    private $db_user;
    private $db_pass;
    public  $model;
    public  $pdo;

    public function __construct()
    {
        $this->db_host = $_ENV['DB_HOST'];
        $this->db_name = $_ENV['DB_NAME'];
        $this->db_user = $_ENV['DB_USER'];
        $this->db_pass = $_ENV['DB_PASS'];
        $getClassArr = explode('\\', get_class($this));
        $getClass = end($getClassArr);
        $this->model = strtolower(preg_replace(['/([a-z\d])([A-Z])/', '/([^_])([A-Z][a-z])/'], '$1_$2', $getClass));
        try {
            $pdo = new \PDO("mysql:host=" . $this->db_host . ";dbname=" . $this->db_name, $this->db_user, $this->db_pass);
            $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
            $this->pdo = $pdo;
        } catch (\Exception $err) {
            echo $err->getMessage();
        }
    }

    /**
     * Get all data from the database
     */
    public function all()
    {
        $sql = $this->pdo->query("SELECT * FROM $this->model");
        $all = $sql->fetchAll(\PDO::FETCH_ASSOC);
        return $all;
    }

    /**
     * Get all the data from the database and return it with a pagination
     * 
     * @param int $perPage  Designates the number of items to return
     * @param int $page     You place yourself on the page you want to display data, this depends on the amount per page to display.
     */
    public function paginate(int $perPage, int $page)
    {

        $sqlCount = $this->pdo->query("SELECT COUNT(*) AS count FROM $this->model");
        $count = $sqlCount->fetch(\PDO::FETCH_ASSOC);

        $pages = ceil($count['count'] / $perPage);

        $page = $page > $pages ? $pages : $page;
        $offset = ($page - 1) * $perPage;

        $sql = $this->pdo->query(
            "SELECT * FROM $this->model 
                LIMIT $perPage 
                OFFSET $offset"
        );

        $all = $sql->fetchAll(\PDO::FETCH_ASSOC);

        $result = [
            'data' => $all,
            'page' => $page,
            'nextPage' => $page + 1,
            'prevPage' => $page > 1 ? $page - 1 : 1,
            'maxPage' => $pages
        ];

        return $result;
    }

    /**
     * Find a data from the database by id
     * 
     * @param int $id Give a id for the search 
     */
    public function find(int $id)
    {
        $sql = $this->pdo->query("SELECT * FROM $this->model WHERE id = $id");
        $response = $sql->fetch(\PDO::FETCH_ASSOC);
        return $response;
    }

    /**
     * Find all data from the database by colunm and value of table
     * 
     * @param $column Column of the table you want to find a value(s)
     * @param $value  Value of the table you want to find a value(s)
     */
    public function findAllBy($column, $value)
    {
        $sql = $this->pdo->query("SELECT * FROM $this->model WHERE $column LIKE '$value'");
        $response = $sql->fetchAll(\PDO::FETCH_ASSOC);
        return $response;
    }

    /**
     * Find exact data from the database by colunm and value of table
     * 
     * @param $column Column of the table you want to find a value(s)
     * @param $value  Value of the table you want to find a value(s)
     */
    public function findExactBy($column, $value)
    {
        $sql = $this->pdo->query("SELECT * FROM $this->model WHERE $column LIKE '$value'");
        $response = $sql->fetch(\PDO::FETCH_ASSOC);
        return $response;
    }

    /**
     * Creates a new data in the database
     * 
     * @param array $data Give data to be able to insert in the database, example ['column' => value ]
     */
    public function create(array $data)
    {
        $columns = '';
        $values = '';

        foreach ($data as $key => $val) {
            $columns .= '`' . $key . '`,';
            $values .= ':' . $key . ',';
        }

        $columns = trim($columns, ',');
        $values = trim($values, ',');

        $sql = "INSERT INTO $this->model($columns) VALUE ($values)";
        $insert = $this->pdo->prepare($sql);
        $insert->execute($data);
        // $this->pdo->lastInsertId()
        return $this->pdo->lastInsertId();
    }

    /**
     * Update a data in the database
     * 
     * @param int    $id    Give a id for the update
     * @param array  $data  Give data to be able to update in the database, example ['column' => value ]
     */
    public function update(int $id, array $data)
    {
        $columns = '';

        foreach ($data as $key => $val) {
            $columns .= "`$key` = :$key,";
        }
        $columns = trim($columns, ',');
        $sql = "UPDATE $this->model SET $columns WHERE id = $id;";
        $update = $this->pdo->prepare($sql);
        $update->execute($data);
    }

    /**
     * Delete a data in the database
     * 
     * @param int    $id    Give a id for delete
     */
    public function delete(int $id)
    {
        $sql = "DELETE FROM $this->model WHERE id=$id";
        $this->pdo->exec($sql);
    }
}
