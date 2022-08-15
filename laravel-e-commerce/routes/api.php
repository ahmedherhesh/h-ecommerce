<?php

use App\Http\Controllers\API\Admin\CategoriesController;
use App\Http\Controllers\API\Admin\RolesController;
use App\Http\Controllers\API\AuthController;
use App\Http\Resources\API\UserResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return new UserResource(auth('sanctum')->user());
});
Route::group(['prefix' => 'v1'],function(){
    Route::post('login',[AuthController::class,'login']);
    Route::post('register',[AuthController::class,'register']);
    //super-admin
    Route::group(['middleware' => ['role:super-admin','auth:sanctum']],function (){
        // Roles Controller
        Route::post('role',[RolesController::class,'createRole'])->name('create-role');
        Route::get('roles',[RolesController::class,'getRoles']);
        Route::post('permission',[RolesController::class,'createPermission'])->name('create-permission');
        Route::get('permissions',[RolesController::class,'getPermissions']);
        Route::post('give-to-role',[RolesController::class,'givePermissionsToRole']);
        Route::post('give-to-role',[RolesController::class,'givePermissionsToRole']);
        //Categories Controller
        Route::post('create-category',[CategoriesController::class,'create']);
        Route::delete('delete-category/{name}',[CategoriesController::class,'delete']);
    });
});

