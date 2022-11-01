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
            'id'            => $this->id    ?? null,
            'name'          => $this->name  ?? null,
            'username'      => $this->username  ?? null,
            'email'         => $this->email ?? null,
            'phone'         => $this->phone ?? null,
            'roles'         => $this->getRoleNames() ?? null,
            'permissions'   => $this->getAllPermissions()->pluck('name') ?? null,
        ];
        $this->token ? $data['token'] = $this->createToken('token')->plainTextToken : '';
        return $data;
    }
}
