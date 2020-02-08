<?php

use App\Entities\Coupons\Type;
use Illuminate\Database\Seeder;

class CouponTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $types = ['EXP', 'COIN'];
        Type::truncate();

        foreach ($types as $type)
        {
            Type::create(['name' => $type]);
        }
    }
}
