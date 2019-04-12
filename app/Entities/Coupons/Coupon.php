<?php


namespace App\Entities\Coupons;


use App\Entities\Auth\User;
use Illuminate\Database\Eloquent\Model;

class Coupon extends Model
{
    protected $fillable = [
        'name',
        'value',
        'used',
        'type_id',
        'user_id'
    ];

    public function type()
    {
        return $this->belongsTo(Type::class, 'type_id');
    }

    public function user()
    {
        return $this->hasOne(User::class, 'user_id');
    }
}