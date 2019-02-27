<?php

use Illuminate\Database\Seeder;
use App\Entities\Helpers\Language;

class LanguagesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $languages = ['Javascript','Java (MELHOR LINGUAGEM)','PHP','Ruby','Python'];
        Language::truncate();
        foreach($languages as $language){
            Language::create(['name' => $language]);
        }
    }
}
