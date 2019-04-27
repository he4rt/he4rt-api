<?php


namespace App\Http\Controllers\Coupon;


use App\Entities\Coupons\Coupon;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class CouponController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Post(
     *     path="/coupons",
     *     summary="Gera um cupom",
     *     operationId="StoreCoupon",
     *     tags={"coupons"},
     *     @OA\Parameter(
     *         name="value",
     *         in="query",
     *         description="Valor do cupom",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="type_id",
     *         in="query",
     *         description="Tipo do cupom (1-EXP, 2-COIN)",
     *         required=true,
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
    public function store(Request $request)
    {
        $this->validate($request, [
            'value' => 'required',
            'type_id' => 'required|exists:coupon_types,id'
        ]);

        $name = 'HE4RT' . str_random(6) . $request->input('value');

        $data = $request->all();
        $data['name'] = $name;

        return $this->success(Coupon::create($data));
    }
}