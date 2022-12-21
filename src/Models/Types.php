<?php

namespace App\Models;

use App\Models\Model as AppModel;

class Types extends AppModel
{
    /**
     * Find Type biginning by name
     * 
     * @param strin $name Give name for search type
     */
    public function findTypeBeginningBy(string $name)
    {
        $sql = $this->pdo->query("SELECT * FROM $this->model WHERE `name` LIKE '$name%'");
        $response = $sql->fetchAll(\PDO::FETCH_ASSOC);
        return $response;
    }
}
