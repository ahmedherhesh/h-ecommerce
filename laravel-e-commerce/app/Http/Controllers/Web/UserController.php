<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\API\MasterAPIController;
use App\Http\Requests\Web\UserLoginRequest;
use Illuminate\Http\Request;

class UserController extends MasterAPIController
{
    public function login()
    {
        return view('auth.login');
    }
    public function _login(Request $request)
    {
        $user = auth()->attempt([
            'email' => $request->email, 'password' => $request->password
        ]);
        if ($user) {
            session(['user' => auth()->user()]);
            return redirect('admin');
        }
    }
}
