<?php

declare(strict_types=1);

use Phinx\Migration\AbstractMigration;

final class CreatePokemonTypesTableMigration extends AbstractMigration
{
    /**
     * Change Method.
     *
     * Write your reversible migrations using this method.
     *
     * More information on writing migrations is available here:
     * https://book.cakephp.org/phinx/0/en/migrations.html#the-change-method
     *
     * Remember to call "create()" or "update()" and NOT "save()" when working
     * with the Table class.
     */
    public function change()
    {
        $refTable = $this->table('pokemon_types', ['id' => false, 'primary_key' => ['id']]);
        $refTable->addColumn('id', 'integer', ['identity' => true])
            ->addColumn('type_id', 'integer')
            ->addForeignKey('type_id', 'types', 'id', ['delete' => 'CASCADE', 'update' => 'CASCADE'])
            ->addColumn('pokemon_id', 'integer')
            ->addForeignKey('pokemon_id', 'pokemon', 'id', ['delete' => 'CASCADE', 'update' => 'CASCADE'])
            ->create();
    }
}
