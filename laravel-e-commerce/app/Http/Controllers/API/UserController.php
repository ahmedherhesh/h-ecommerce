<?php

namespace App\Http\Controllers\API;

use App\Http\Requests\API\ChangePasswordRequest;
use App\Http\Requests\API\EditProfileRequest;
use App\Http\Requests\API\ShippingAddressRequest;
use App\Http\Requests\API\UserLoginRequest;
use App\Http\Requests\API\UserRegisterRequest;
use App\Http\Resources\API\UserResource;
use App\Models\ShippingAddress;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends MasterAPIController
{

    function login(UserLoginRequest $request)
    {
        $user = auth()->attempt($request->only('email', 'password'));
        $user = auth()->user();
        if ($user)
            $user->token = true;
        return $this->response($user, new UserResource($user), ['errors' => ['Email and password are not matched']], 422);
    }

    function register(UserRegisterRequest $request)
    {
        $user = User::create($request->all());
        $user->assignRole('customer');
        $user->token = true;
        return $this->response($user, new UserResource($user));
    }
    function changePassword(ChangePasswordRequest $request)
    {
        $user = User::find($this->user->id);
        if ($user)
            if (Hash::check($request->old_password, $user->password)) {
                $user = $user->update(['password' => $request->password]);
                return $this->response($user, 'Your Password has been changed successfully');
            }
        return response()->json(['old_password' => ['The old password is not matched']], 422);
    }
    function editProfile(EditProfileRequest $request)
    {
        $user = User::find($this->user->id);
        $user->update($request->all());
        return $this->response($user, $user);
    }
    function shippingAddresses()
    {
        $addresses = ShippingAddress::orderByDesc('id')->get();
        return $this->response($addresses, $addresses);
    }
    function addShippingAddress(ShippingAddressRequest $request)
    {
        $data = $request->all();
        $data['user_id'] = $this->user->id;
        $create_address = ShippingAddress::create($data);
        return $this->response($create_address, $create_address);
    }
    function updateShippingAddress(ShippingAddressRequest $request)
    {
        $data = $request->all();
        $address = ShippingAddress::find($data['id']);
        $update_address = null;
        if ($address->user_id == $this->user->id) {
            $update_address = $address->update($data);
        }
        $address = ShippingAddress::find($data['id']);
        return $this->response($update_address, $address);
    }
    function logout(Request $request)
    {
        $logout = $request->user('sanctum')->currentAccessToken()->delete();
        return $logout;
    }
}
