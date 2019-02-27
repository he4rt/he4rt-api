<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/26/2019
 * Time: 9:44 PM
 */

namespace App\Entities\Helpers;


use Illuminate\Database\Eloquent\Model;

class Ban extends Model
{
    protected $table = "bans";
    protected $fillable = [
        'admin_id',
        'victim_id',
        'type',
        'reason',
        'time',
        'revoked'
    ];
}