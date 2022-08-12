<?php

use App\Http\Controllers\API\Admin\RolesController;
use App\Http\Controllers\API\AuthController;
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
// header('Access-Control-Allow-Origin', 'http://localhost:8000/');
// header('Access-Control-Allow-Credentials', true);
// header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
// header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return new UserResource(auth('sanctum')->user());
});
Route::group(['prefix' => 'v1'],function(){
    Route::post('login',[AuthController::class,'login']);
    Route::post('register',[AuthController::class,'register']);
    Route::group(['prefix' => 'admin'],function (){
        Route::post('role',[RolesController::class,'createRole'])->name('create-role');
        Route::get('roles',[RolesController::class,'getRoles']);
        Route::post('permission',[RolesController::class,'createPermission'])->name('create-permission');
        Route::get('permissions',[RolesController::class,'getPermissions']);
        Route::post('give-to-role',[RolesController::class,'givePermissionsToRole']);
    });
});

