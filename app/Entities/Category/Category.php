<?php


namespace App\Entities\Category;


use App\Entities\Category\Product\Product;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $fillable = ['name'];

    public function products()
    {
        return $this->hasMany(Product::class, 'category_id', 'id');
    }
}