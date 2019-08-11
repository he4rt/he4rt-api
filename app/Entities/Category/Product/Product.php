<?php


namespace App\Entities\Category\Product;


use App\Entities\Auth\User;
use App\Entities\Category\Category;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'name',
        'description',
        'price',
        'category_id'
    ];

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    public function users()
    {
        return $this->belongsToMany(User::class,
            'user_products',
            'product_id',
            'user_id'
        )->withTimestamps();
    }
}