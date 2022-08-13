<?php

namespace App\Http\Controllers\API;

use App\Http\Requests\API\UserLoginRequest;
use App\Http\Requests\API\UserRegisterRequest;
use App\Http\Resources\API\UserResource;
use App\Models\User;
use Illuminate\Http\Request;

class AuthController extends MasterAPIController
{

    function login(UserLoginRequest $request)
    {
        $user = auth()->attempt($request->only('email', 'password'));
        $user = auth()->user(); 
        $user->token = true;
        return $this->response($user, new UserResource($user));
    }

    function register(UserRegisterRequest $request)
    {
        $user = User::create($request->all());
        $user->assignRole('customer');
        $user->token = true; 
        return $this->response($user, new UserResource($user));
    }
}
