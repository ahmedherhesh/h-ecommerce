<?php

namespace App\Http\Resources\API;

use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
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
            "id"            => $this->id ,
            "user_id"       => $this->user_id,
            "category_id"   => $this->category_id,
            "title"         => $this->title,
            "description"   => $this->description,
            "price"         => $this->price,
            "currency"      => $this->currency,
            "stock"         => $this->stock,
            "status"        => $this->status,
            'images'        => $this->myImages ? $this->myImages->images : null,
        ];
    }
}
