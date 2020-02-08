<?php

namespace App\Http\Middleware;

use Closure;


class Header
{
    /**
     * Handle an incoming request.
     *
     * @param \Illuminate\Http\Request $request
     * @param \Closure $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if (env('KEY_ENABLED') == "TRUE") {
            $apiKey = $request->header('Api-key');
            if (!$apiKey) {
                return response()->json(['error' => 'Chave não encontrada'], 422);
            }

            if ($apiKey !== env('API_KEY')) {
                return response()->json(['error' => 'Chave incorreta'], 422);
            }
        }

        return $next($request);
    }
}
