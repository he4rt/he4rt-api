<?php

namespace App\Traits;

use Tymon\JWTAuth\Facades\JWTAuth;

trait AuthTrait
{

    public function authorize($root,$args)
    {
        return (boolean) JWTAuth::parseToken()->authenticate();
    }

}