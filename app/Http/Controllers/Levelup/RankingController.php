<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 3/8/2019
 * Time: 8:27 PM
 */

namespace App\Http\Controllers\Levelup;


use App\Entities\Auth\User;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;

class RankingController extends Controller
{
    use ApiResponse;

    public function index(){
        $data = User::orderBy('level','DESC')
            ->orderBy('current_exp','DESC')
            ->select('discord_id','current_exp','level')
            ->paginate(10);
        return $this->success($data);
    }
}