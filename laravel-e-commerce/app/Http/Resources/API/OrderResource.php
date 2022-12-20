<?php

namespace App\Http\Resources\API;

use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
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
            "id" => $this->id,
            "product_title" => $this->product->title,
            "product_image" => $this->product->myImages->images[0],
            "qty" => $this->qty,
            "price" => $this->price,
            "shipping" => $this->shipping,
            "total_price" => $this->total_price,
            "currency" => $this->currency,
            "payment_method" => $this->payment_method,
            "status" => $this->status,
        ];
    }
}
