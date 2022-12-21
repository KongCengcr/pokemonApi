<?php

namespace App\Resources;

use App\Models\PokemonTypes;

class PokemonResource
{

    protected $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    /**
     * Format the data inside the resource and return the values you want to display. 
     */
    public function parseData()
    {
        $pokemonTypesModel = new PokemonTypes();

        if (isset($this->data['data']) || isset($this->data[0])) {
            if (isset($this->data['data'])) {
                $list = array_map(fn ($pokemon) => [...$pokemon, "types" => $pokemonTypesModel->findRelationTypeWithStock('pokemon_id', $pokemon['id'])], $this->data['data']);
                unset($this->data['data']);
                return ["pokemons" => $list, ...$this->data];
            } else {
                $list = array_map(fn ($pokemon) => [...$pokemon, "types" => $pokemonTypesModel->findRelationTypeWithStock('pokemon_id', $pokemon['id'])], $this->data);
                return $list;
            }
        } else {
            return [...$this->data, "types" => $pokemonTypesModel->findRelationTypeWithStock('pokemon_id', $this->data['id'])];
        }
    }
}
