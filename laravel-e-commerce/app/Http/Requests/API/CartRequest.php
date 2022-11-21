<?php

namespace App\Http\Requests\API;

use Illuminate\Foundation\Http\FormRequest;

class CartRequest extends MasterRequest
{

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'product_id' => 'required|exists:products,id',
            'qty'        => 'required'
        ];
    }
}
