<?php

namespace App\Http\Requests\API;

use App\Http\Requests\API\MasterRequest;

class EditProfileRequest extends MasterRequest
{

    public function rules()
    {
        $user = auth('sanctum')->user();
        return [
            'name'           => 'min:3',
            'username'       => 'min:3|unique:users,username,' . $user->id,
            'email'          => 'email|unique:users,email,' . $user->id,
            'phone'          => 'string|unique:users,phone,' . $user->id,
        ];
    }
}
