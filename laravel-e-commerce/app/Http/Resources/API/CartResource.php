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
                'id'        => $this->product->id,
                'title'     => $this->product->title,
                'price'     => $this->product->price,
                'currency'  => $this->product->currency,
                'stock'     => $this->product->stock,
                'image'     => $this->product->myImages->images[0]
            ]
        ];
    }
}
