<?php

namespace App\Http\Requests\API;

use App\Http\Requests\API\MasterRequest;

class PaymentRequest extends MasterRequest
{
    public function rules()
    {
        return [
            'shipping_address_id' => 'required',
            'payment_method' => 'required',
            'order_details'  => 'required',
        ];
    }
}
