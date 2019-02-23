<?php

namespace App\Http\Controllers;

use App\Entities\AccessLog;
use App\Entities\Auth\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['loginPortal','loginAdmin']]);
    }

    /**
     * @OA\Post(
     *     path="/auth/login",
     *     summary="Autenticação de usuário",
     *     operationId="AuthLogin",
     *     tags={"auth"},
     *     @OA\Parameter(
     *         name="email",
     *         in="query",
     *         description="E-mail para autenticação",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="password",
     *         in="query",
     *         description="Senha para autenticação",
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

    public function loginPortal(Request $request)
    {
        $credentials = $request->only(['email', 'password']);
        $user = User::where([
            ['email',$request->input('email')],
            ['is_admin',0]
        ])->first();

        if(! $user ){
            return response()->json(['error' => 'User not found'], 401);
        }

        if(! Hash::check($request->input('password'),$user->password) ){
            return response()->json(['error' => 'Incorrect Password'], 401);
        }

        if (! $token = JWTAuth::attempt($credentials) ) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
        $req = new Request();
        AccessLog::create(['user_id' => Auth::user()->id,"ip" => $req->ip(), "type" => "login"]);
        return response()->json([
            'status' => 'success',
            'token' => $token
        ]);
    }

    /**
     * @OA\Post(
     *     path="/admin/auth/login",
     *     summary="Autenticação da administração",
     *     operationId="AuthAdminLogin",
     *     tags={"auth"},
     *     @OA\Parameter(
     *         name="email",
     *         in="query",
     *         description="E-mail para autenticação",
     *         required=true,
     *         @OA\Schema(
     *           type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="password",
     *         in="query",
     *         description="Senha para autenticação",
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
    public function loginAdmin(Request $request)
    {
        $credentials = $request->only(['email', 'password']);
        $user = User::where([
            ['email',$request->input('email')],
            ['is_admin',1]
        ])->first();

        if(! $user ){
            return response()->json(['error' => 'User not found'], 401);
        }

        if(! Hash::check($request->input('password'),$user->password) ){
            return response()->json(['error' => 'Incorrect Password'], 401);
        }

        if (! $token = JWTAuth::attempt($credentials) ) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
        $req = new Request();
        AccessLog::create(['user_id' => Auth::user()->id,"ip" => $req->ip(), "type" => "login"]);
        return response()->json([
            'status' => 'success',
            'token' => $token
        ]);
    }
    /**
     * @OA\Post(
     *     path="/auth/refresh",
     *     summary="Atualiza o token atual do usuário",
     *     operationId="AuthRefresh",
     *     tags={"auth"},
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     *
     * )
     */
    public function refresh()
    {
        $token = JWTAuth::getToken();
        $new = JWTAuth::refresh($token);
        $req = new Request();
        AccessLog::create(['user_id' => Auth::user()->id,"ip" => $req->ip(), "type" => "refresh"]);
        return response()->json([
            'token' => $new
        ]);
    }

    public function forgot(){

    }
    
}
