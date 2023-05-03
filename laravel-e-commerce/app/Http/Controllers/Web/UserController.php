<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\API\MasterAPIController;
use Illuminate\Http\Request;
class UserController extends MasterAPIController
{
    public function login(Request $request){
        return view ('auth.login');
    }
}
