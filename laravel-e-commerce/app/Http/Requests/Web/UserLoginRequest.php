<?php

namespace App\Http\Requests\Web;

use App\Http\Requests\API\MasterRequest;

class UserLoginRequest extends MasterRequest
{

    public function rules()
    {
        return [
            'email' => 'required|email',
            'password'=> 'required|password'
        ];
    }
}
