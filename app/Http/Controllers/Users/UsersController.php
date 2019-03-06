<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/23/2019
 * Time: 12:05 AM
 */

namespace App\Http\Controllers\Users;


use App\Entities\Auth\User;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class UsersController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Get(
     *     path="/users",
     *     summary="Lista todos os usuários",
     *     operationId="GetUsers",
     *     tags={"users"},
     *     @OA\Parameter(
     *         name="date",
     *         in="query",
     *         description="Data para filtrar",
     *         required=false,
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

    public function index(Request $request)
    {
        $user = new User();
        if ($request->has('date')) {
            $user = User::whereDate('created_at', '=', $request->input('date'))->get();
        } else {
            $user = User::paginate(15);
        }
        return $this->success($user);
    }

    /**
     * @OA\Get(
     *     path="/users/{discord_id}",
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

    public function show(Request $request, $discord_id)
    {
        $request->merge(['discord_id' => $discord_id]);
        $this->validate($request, [
            'discord_id' => 'required|exists:users'
        ]);

        return $this->success(User::where('discord_id', $request->input('discord_id'))->first());
    }

    /**
     * @OA\Post(
     *     path="/users",
     *     summary="Cria um novo usuário",
     *     operationId="StoreUser",
     *     tags={"users"},
     *     @OA\Parameter(
     *         name="discord_id",
     *         in="query",
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

    public function store(Request $request)
    {
        $this->validate($request, [
            'discord_id' => 'required|unique:users'
        ]);

        return $this->success(User::create(['discord_id' => $request->input('discord_id')]));
    }


    /**
     * @OA\Put(
     *     path="/users",
     *     summary="Cria um novo usuário",
     *     operationId="StoreUser",
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
     *     @OA\Parameter(
     *         name="name",
     *         in="query",
     *         description="Nome da pessoa",
     *         required=false,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="nickname",
     *         in="query",
     *         description="Apelido da pessoa",
     *         required=false,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="git",
     *         in="query",
     *         description="Link do git",
     *         required=false,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="language",
     *         in="query",
     *         description="Linguagem em formato 'Locale'",
     *         required=false,
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

    public function update(Request $request, $discord_id)
    {
        $request->merge(['discord_id' => $discord_id]);
        $this->validate($request, [
            'discord_id' => 'required|exists:users',
            'name' => 'string',
            'nickname' => 'string',
            'language' => 'string',
            'git' => 'string',
        ]);

        $fields = $request->except(['level', 'current_exp', 'money', 'discord_id']);
        $user = User::where('discord_id', $discord_id)->first();
        $user->update($fields);

        return $this->success($user);
    }

    public function wipe(Request $request){

        $this->validate($request, [
            'discord_ids' => 'required|array'
        ]);

        User::truncate();
        foreach($request->input('discord_ids') as $id){
            User::create(['discord_id' => $id]);
        }
        return $this->success(['users' => User::count()]);
    }
}