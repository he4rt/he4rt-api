<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 2/24/2019
 * Time: 4:41 PM
 */

namespace App\Http\Controllers\Tips;


use App\Entities\Tips\English;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class EnglishController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Get(
     *     path="/tips/english",
     *     summary="Lista todas as dicas armazenadas de inglês",
     *     operationId="GetEnglishTips",
     *     tags={"tips"},
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     *
     * )
     *
     */

    public function index(){
        return $this->success(English::paginate(15));
    }

    /**
     * @OA\Post(
     *     path="/tips/english",
     *     summary="Cria uma nova dica para o estudo de inglês",
     *     operationId="StoreEnglishTop",
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
            'tip' => 'string|required'
        ]);
        return $this->success(English::create(['tip' => $request->input('tip')]));
    }

    /**
     * @OA\Delete(
     *     path="/tips/english/{id}",
     *     summary="Deleta uma dica de desenvolvimento",
     *     operationId="DeleteEnglishTip",
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
        return $this->success(English::findOrFail($id)->delete());
    }


    public function getTip(){
        $data = English::where('used',0)->inRandomOrder()->first();
        if($data){
            $data->used = true;
            $data->save();
            return $this->success($data);
        }
        English::where('id','<',1)->update(['used' => false]);
        $data = English::where('used',0)->inRandomOrder()->first();
        $data->used = true;
        $data->save();
        return $this->success($data);
    }

}