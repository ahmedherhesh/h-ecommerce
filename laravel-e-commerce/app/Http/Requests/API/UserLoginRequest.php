<?php

namespace App\Http\Requests\API;

class UserLoginRequest extends MasterRequest
{
    public function rules()
    {
        return [
            'email' => 'required|email',
            'password' => 'required|min:8'
        ];
    }
}
