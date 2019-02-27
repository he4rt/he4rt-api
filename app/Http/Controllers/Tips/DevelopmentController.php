<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/24/2019
 * Time: 5:01 PM
 */

namespace App\Http\Controllers\Tips;


use App\Entities\Tips\Development;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class DevelopmentController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Get(
     *     path="/tips/development",
     *     summary="Lista todas as dicas armazenadas de desenvolvimento",
     *     operationId="GetDevelopmentTips",
     *     tags={"tips"},
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */

    public function index(){
        return $this->success(Development::paginate(15));
    }


    /**
     * @OA\Post(
     *     path="/tips/development",
     *     summary="Cria uma nova dica para o estudo de programação",
     *     operationId="StoreDevelopmentTip",
     *     tags={"tips"},
     *     @OA\Parameter(
     *         name="tip",
     *         in="query",
     *         description="Dica que vai rolar",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     *
     * )
     */

    public function store(Request $request){
        $this->validate($request, [
            'tip' => 'string|required',
            'language_id' => 'integer|exists:languages,id|required'
        ]);
        return $this->success(Development::create($request->all()));
    }

    /**
     * @OA\Delete(
     *     path="/tips/development/{id}",
     *     summary="Deleta uma dica de desenvolvimento",
     *     operationId="DeleteDevelopmentTip",
     *     tags={"tips"},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID da dica",
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

    public function destroy($id){
        return $this->success(Development::findOrFail($id)->delete());
    }
}