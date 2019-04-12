<?php


namespace App\Http\Controllers\Coupon;


use App\Entities\Coupons\Coupon;
use App\Entities\Coupons\Type;
use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class CouponController extends Controller
{
    use ApiResponse;

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