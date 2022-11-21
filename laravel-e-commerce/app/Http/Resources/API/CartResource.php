<?php

namespace App\Http\Resources\API;

use Illuminate\Http\Resources\Json\JsonResource;

class CartResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'qty' => $this->qty,
            'product' => [
                'title'     => $this->product->title,
                'price'     => $this->product->price,
                'currency'  => $this->product->currency,
                'image'     => json_decode($this->product->myImages->images)[0]
            ]
        ];
    }
}