<?php

use Illuminate\Database\Seeder;
use App\Entities\Levelup\Level;
class ExpTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $exp_table = [10,30,90,360,1000];
        Level::truncate();
        foreach($exp_table as $data){
            Level::create(['required_exp' => $data]);
        }
    }
}
