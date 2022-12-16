<?php

namespace App\Http\Requests\API;

use App\Http\Requests\API\MasterRequest;

class ChangePasswordRequest extends MasterRequest
{

    public function rules()
    {
        return [
            'old_password'     => 'required',
            'password'         => 'required|min:8',
            'confirm_password' => 'required|same:password',
        ];
    }
}
