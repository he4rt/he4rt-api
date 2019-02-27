<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/24/2019
 * Time: 4:07 PM
 */

namespace App\Http\Controllers\Helpers;


use App\Entities\Helpers\Language;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;

class LanguageController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Get(
     *     path="/languages",
     *     summary="Lista todas as linguagens de programação no projeto",
     *     operationId="GetLanguages",
     *     tags={"languages"},
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */

    public function index(){
        return $this->success(Language::paginate(15));
    }

    /**
     * @OA\Get(
     *     path="/languages/{id}",
     *     summary="Lista todas as linguagens de programação no projeto",
     *     operationId="GetLanguages",
     *     tags={"languages"},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID da linguagem",
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

    public function show($id){
        return $this->success(Language::findOrFail($id));
    }
}