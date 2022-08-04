<?php

namespace App\Http\Requests\API;

class UserRegisterRequest extends MasterRequest
{
    public function rules()
    {
        return [
            'name'           => 'required|min:3', 
            'username'       => 'nullable|min:3|unique:users,username', 
            'email'          => 'required|email|unique:users,email',
            'phone'          => 'required|unique:users,phone|string', 
            'password'       => 'required|min:8',
            'repeatPassword' => 'required|same:password'
        ];
    }
}
