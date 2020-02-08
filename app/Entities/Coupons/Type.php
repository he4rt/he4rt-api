<?php


namespace App\Entities\Coupons;


use Illuminate\Database\Eloquent\Model;

class Type extends Model
{
    protected $table = 'coupon_types';

    protected $fillable = ['name'];

    public function coupons()
    {
        return $this->hasMany(Coupon::class);
    }
}