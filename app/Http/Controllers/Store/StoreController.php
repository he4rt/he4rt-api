<?php


namespace App\Http\Controllers\Store;


use App\Entities\Auth\User;
use App\Entities\Category\Product\Product;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class StoreController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Post(
     *     path="/store/{product_id}",
     *     summary="Realiza a compra de um produto",
     *     operationId="PostStore",
     *     tags={"store"},
     *     @OA\Parameter(
     *         name="Api-key",
     *         in="header",
     *         description="Api Key",
     *         required=false,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="product_id",
     *         in="path",
     *         description="ID do produto",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="discord_id",
     *         in="query",
     *         description="ID do usuário do DIscord",
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
    public function store(Request $request, int $productId)
    {
        $request->merge(['product_id' => $productId]);
        $this->validate($request, [
            'discord_id' => 'required|exists:users',
            'product_id' => 'required|exists:products,id'
        ]);

        $user = User::where('discord_id', '=', $request->input('discord_id'))->first();
        $product = Product::find($productId);

        $check = $user->money -= $product->price;
        if ($check < 0) {
            return $this->unprocessable(['error' => 'insufficient funds']);
        }

        $user->products()->attach($product->id);
        $user->save();
        return $this->success($user);
    }
}