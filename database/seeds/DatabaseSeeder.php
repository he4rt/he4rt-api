<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
         //$this->call('UserSeeder');
         $this->call('ExpTableSeeder');
         $this->call('LanguagesTableSeeder');
    }
}
