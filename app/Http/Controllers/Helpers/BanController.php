<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/26/2019
 * Time: 9:48 PM
 */

namespace App\Http\Controllers\Helpers;


use App\Entities\Helpers\Ban;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class BanController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Get(
     *     path="/bans",
     *     summary="Lista todos os bans até o momento",
     *     operationId="GetBanList",
     *     tags={"bans"},
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */

    public function index()
    {
        return $this->success(Ban::paginate(15));
    }

    /**
     * @OA\Post(
     *     path="/bans",
     *     summary="Cria um novo ban",
     *     operationId="StoreBan",
     *     tags={"bans"},
     *     @OA\Parameter(
     *         name="admin_id",
     *         in="query",
     *         description="ID de quem deu o ban",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="victim_id",
     *         in="query",
     *         description="ID de quem recebeu o ban",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="type",
     *         in="query",
     *         description="Tipo de ban (ban/mute/kick)",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="reason",
     *         in="query",
     *         description="Razão do ban",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="time",
     *         in="query",
     *         description="Duração do ban",
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
    public function store(Request $request)
    {
        $this->validate($request, [
            'admin_id' => 'required|string|exists:users,discord_id',
            'victim_id' => 'required|string|exists:users,discord_id',
            'type' => 'required|string',
            'reason' => 'required|string'
        ]);

        return $this->success(Ban::create($request->all()));
    }

    /**
     * @OA\Get(
     *     path="/bans/{id}/revoke",
     *     summary="Lista todos os bans até o momento",
     *     operationId="GetBanList",
     *     tags={"bans"},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID do usuário",
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

    public function update(Request $request, $id)
    {
        $request->merge(['id' => $id]);
        $this->validate($request, [
            'id' => 'required|exists:bans',
        ]);
        return $this->success(Ban::findOrFail($id)->update(['revoked' => 1]));
    }
}