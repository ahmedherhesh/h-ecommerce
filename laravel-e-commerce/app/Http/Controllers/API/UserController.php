<?php

namespace App\Http\Controllers\API;

use App\Http\Resources\API\UserAuthResource;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends MasterAPIController
{
    function login(Request $request){
        $user = auth()->attempt($request->only('email','password'));
        return $this->response($user,new UserAuthResource(auth()->user()));
    }
    
    function register(Request $request){
        $user = User::create($request->all());
        return $this->response($user,new UserAuthResource($user));
    }
}
