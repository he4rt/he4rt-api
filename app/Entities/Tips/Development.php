<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/24/2019
 * Time: 4:32 PM
 */

namespace App\Entities\Tips;


use Illuminate\Database\Eloquent\Model;

class Development extends Model
{
    protected $table = "development_tips";
    protected $fillable = ['language_id','tip','used'];
}