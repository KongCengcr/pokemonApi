<?php

namespace App\Models;

use App\Models\Model as AppModel;

class PokemonTypes extends AppModel
{
    /**
     * Count Types Of Pokemon have
     */
    public function countTypes()
    {
        $sql = $this->pdo->query(
            "SELECT types.name AS `type`, COUNT($this->model.type_id) AS count 
                    FROM $this->model 
                        JOIN types ON $this->model.type_id = types.id 
                            GROUP BY $this->model.type_id;"
        );
        $response = $sql->fetchAll(\PDO::FETCH_ASSOC);
        return $response;
    }

    /**
     * Search by name Type and count Types Of Pokemon have
     * 
     *@param string $type Give name of type
     */
    public function countPokemonBeginningByTypes(string $type)
    {
        $sql = $this->pdo->query(
            "SELECT types.name AS `type`, COUNT($this->model.type_id) AS `count` 
                FROM $this->model
                    JOIN types ON $this->model.type_id = types.id 
                        WHERE types.name LIKE '$type%'
                        GROUP BY $this->model.type_id"
        );
        $response = $sql->fetchAll(\PDO::FETCH_ASSOC);
        return $response;
    }

    public function findRelationTypeWithStock($column, $value)
    {
        $sql = $this->pdo->query(
            "SELECT ROW_NUMBER() OVER(ORDER BY types.id) AS stock, types.id, types.name 
                FROM $this->model 
                    JOIN types ON types.id = $this->model.type_id 
                    WHERE $this->model.$column = $value;"
        );
        $response = $sql->fetchAll(\PDO::FETCH_ASSOC);
        return $response;
    }
}
