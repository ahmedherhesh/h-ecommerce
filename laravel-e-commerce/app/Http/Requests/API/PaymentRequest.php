<?php

namespace App\Http\Requests\API;

use App\Http\Requests\API\MasterRequest;

class PaymentRequest extends MasterRequest
{
    public function rules()
    {
        return [
            'country' => 'required',
            'region' => 'required',
            'city' => 'required',
            'address' => 'required',
            'payment_method' => 'required',
            'order_details'  => 'required',
        ];
    }
}
