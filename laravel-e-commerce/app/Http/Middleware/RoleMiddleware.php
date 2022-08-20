<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use Spatie\Permission\Exceptions\UnauthorizedException;

class RoleMiddleware
{
    public function handle($request, Closure $next, $role, $guard = null)
    {
        $auth = auth('sanctum')->user();

        $roles = is_array($role)
            ? $role
            : explode('|', $role);

        if (! $auth->hasAnyRole($roles)) {
            return response()->json('Forbidden',403);
        }

        return $next($request);
    }
}
