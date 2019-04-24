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
use Illuminate\Http\Request;

class RankingController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Get(
     *     path="/ranking",
     *     summary="Lista o raking de usuários",
     *     operationId="GetRanking",
     *     tags={"ranking"},
     *     @OA\Parameter(
     *         name="reputation",
     *         in="query",
     *         description="Ordenar por reputation (0, 1)",
     *         required=false,
     *         @OA\Schema(
     *           type="integer",
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
        $this->validate($request, [
            'reputation' => 'boolean'
        ]);

        if ($request->input('reputation')) {
            $data = User::orderBy('reputation', 'DESC')
                ->select('discord_id', 'reputation', 'current_exp', 'level')
                ->paginate(10);
        } else {
            $data = User::orderBy('level', 'DESC')
                ->orderBy('current_exp', 'DESC')
                ->select('discord_id', 'current_exp', 'level', 'reputation')
                ->paginate(10);
        }

        return $this->success($data);
    }
}