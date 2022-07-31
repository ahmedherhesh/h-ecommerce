<?php

use App\Http\Controllers\API\UserController;
use App\Http\Resources\API\UserResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return new UserResource(auth('sanctum')->user());
});
Route::group(['prefix'=> 'v1'],function(){
    Route::post('login',[UserController::class,'login']);
    Route::post('register',[UserController::class,'register']);
});

