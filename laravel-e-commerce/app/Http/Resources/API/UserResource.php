<?php

namespace App\Http\Resources\API;

use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        $data = [
            'id'    => $this->id    ?? null,
            'name'  => $this->name  ?? null,
            'email' => $this->email ?? null,
            'phone' => $this->phone ?? null,
            'roles' => $this->getRoleNames(),
            'permissions' => $this->getAllPermissions()->pluck('name')
        ];
        auth('sanctum')->user() ? null : $data['token'] =  $this->createToken('token')->plainTextToken;
        return $data;
    }
}
