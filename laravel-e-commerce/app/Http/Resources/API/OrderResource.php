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
            "qty" => 1,
            "price" => 350,
            "shipping" => 5,
            "total_price" => 350,
            "currency" => $this->currency,
            "payment_method" => $this->payment_method,
            "status" => $this->status,
        ];
    }
}
