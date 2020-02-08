<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/24/2019
 * Time: 4:32 PM
 */

namespace App\Entities\Tips;


use Illuminate\Database\Eloquent\Model;

class English extends Model
{
    protected $table = "english_tips";
    protected $fillable = ['tip','used'];

}