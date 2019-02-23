<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/22/2019
 * Time: 11:56 PM
 */

namespace App\Entities\Levelup;


use Illuminate\Database\Eloquent\Model;

class Level extends Model
{
    protected $table = "levelup";
    protected $fillable = ['required_exp'];

    public $timestamps = false;
}