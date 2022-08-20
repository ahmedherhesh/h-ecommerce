<?php

use App\Http\Controllers\API\Admin\CategoriesController;
use App\Http\Controllers\API\Admin\RolesController;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\ProductsController;
use App\Http\Resources\API\UserResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::group(['prefix' => 'v1'], function () {
    Route::post('login', [AuthController::class, 'login']);
    Route::post('register', [AuthController::class, 'register']);
    Route::group(['middleware' => ['auth:sanctum']], function () {
        Route::get('/user', function () {
            return new UserResource(auth('sanctum')->user());
        });
        //super-admin
        Route::group(['middleware' => ['role:super-admin']], function () {
            // Roles Controller
            Route::post('role', [RolesController::class, 'createRole'])->name('create-role');
            Route::get('roles', [RolesController::class, 'getRoles']);
            Route::post('permission', [RolesController::class, 'createPermission'])->name('create-permission');
            Route::get('permissions', [RolesController::class, 'getPermissions']);
            Route::post('give-to-role', [RolesController::class, 'givePermissionsToRole']);
            Route::post('give-to-role', [RolesController::class, 'givePermissionsToRole']);
            //Categories Controller
            Route::post('create-category', [CategoriesController::class, 'create']);
            Route::delete('delete-category/{name}', [CategoriesController::class, 'delete']);
        });
        //super-admin, admin, seller
        Route::group(['middleware' => ['role:super-admin|admin|seller']], function () {
            //Products Controller
            Route::post('create-product', [ProductsController::class, 'create']);
            Route::delete('delete-product/{title}', [ProductsController::class, 'delete']);
        });
    });
    Route::get('products', [ProductsController::class, 'products']);
    Route::get('products/{title}', [ProductsController::class, 'product']);
    Route::get('products/categories/{name}', [ProductsController::class, 'productsByCategory']);
    Route::get('category-with-products', [ProductsController::class, 'categoryWithProducts']);
});
