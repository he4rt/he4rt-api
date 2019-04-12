<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/23/2019
 * Time: 12:24 AM
 */

namespace App\Http\Controllers\Levelup;


use App\Entities\Auth\User;
use App\Entities\Levelup\Level;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class LevelupController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Post(
     *     path="/users/{discord_id}/levelup",
     *     summary="Mostra as informações de um usuário",
     *     operationId="GetUser",
     *     tags={"users"},
     *     @OA\Parameter(
     *         name="discord_id",
     *         in="path",
     *         description="ID do usuário do Discord",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */

    public function store(Request $request, $discord_id){

        $request->merge(['discord_id' => $discord_id]);
        $this->validate($request,[
            'discord_id' => 'required|exists:users'
        ]);

        $user = User::where('discord_id',$discord_id)->first();
        $user->current_exp += rand(1,5);
        $user->save();

        if($user->level >= Level::count()){
            return $this->success($user);
        }
        if($user->levelup->required_exp <= $user->current_exp){
            $user->current_exp = 0;
            $user->level++;
            $user->save();
            $user->is_levelup = true;
        }else{
            $user->is_levelup = false;
        }

        return $this->success($user->load('levelup'));
    }
}