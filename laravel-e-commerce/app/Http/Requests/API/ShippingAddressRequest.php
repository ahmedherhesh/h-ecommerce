<?php

namespace App\Http\Requests\API;

use App\Http\Requests\API\MasterRequest;

class ShippingAddressRequest extends MasterRequest
{

    public function rules()
    {
        return [
            'id'          => 'nullable|exists:shipping_addresses,id',
            'country'     => 'required|exists:countries,name',
            'region'      => 'required|exists:regions,name',
            'city'        => 'required|exists:cities,name',
            'description' => 'required|min:6',
        ];
    }
}
