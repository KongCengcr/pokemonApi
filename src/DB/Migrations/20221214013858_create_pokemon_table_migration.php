<?php

declare(strict_types=1);

use Phinx\Migration\AbstractMigration;

final class CreatePokemonTableMigration extends AbstractMigration
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
        $table = $this->table('pokemon', ['id' => false, 'primary_key' => ['id']]);
        $table
            ->addColumn('id', 'integer', ['identity' => true])
            ->addColumn('name', 'string', ['limit' => 20])
            ->addColumn('base_experience', 'integer')
            ->addColumn('height', 'integer')
            ->addColumn('is_default', 'boolean')
            ->addColumn('order', 'integer')
            ->addColumn('weight', 'integer')
            ->addColumn('sprite_front_default', 'text', ['null' => true])
            ->addColumn('sprite_front_shiny', 'text', ['null' => true])
            ->addColumn('sprite_female_default', 'text', ['null' => true])
            ->addColumn('sprite_female_shiny', 'text', ['null' => true])
            ->create();
    }
}
