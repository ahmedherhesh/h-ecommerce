<?php

namespace App\Http\Resources\API;

use App\Models\Favourite;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        $user_id = auth('sanctum')->user()->id ?? null;
        return [
            "id"            => $this->id,
            "title"         => $this->title,
            "keyword"       => $this->keyword ?? null,
            "price"         => $this->price,
            "currency"      => $this->currency,
            'image'         => $this->myImages ? $this->myImages->images[0] : null,
            'in_favourite'  => Favourite::where(['user_id' => $user_id, 'product_id' => $this->id])->first() ? true : false
        ];
    }
}
