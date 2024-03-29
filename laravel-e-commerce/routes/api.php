<?php

use App\Http\Controllers\API\Admin\CategoriesController;
use App\Http\Controllers\API\Admin\BrandsController;
use App\Http\Controllers\API\Admin\ExtensionsController;
use App\Http\Controllers\API\Admin\RolesController;
use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\Customer\CartController;
use App\Http\Controllers\API\Customer\FavouritesController;
use App\Http\Controllers\API\OrdersController;
use App\Http\Controllers\API\PlacesController;
use App\Http\Controllers\API\ProductsController;
use App\Http\Resources\API\UserResource;
use App\Http\Controllers\PaymentController;

use Illuminate\Support\Facades\Route;

Route::group(['prefix' => 'v1'], function () {
    Route::post('login', [UserController::class, 'login']);
    Route::post('register', [UserController::class, 'register']);
    //Routes with required auth
    Route::group(['middleware' => ['auth:sanctum']], function () {
        Route::get('user', function () {
            return new UserResource(auth('sanctum')->user());
        });
        //edit profile for any user
        Route::post('change-password', [UserController::class, 'changePassword']);
        Route::post('edit-profile', [UserController::class, 'editProfile']);

        //super-admin
        Route::group(['middleware' => ['role:super-admin']], function () {
            //Roles Controller
            Route::post('role', [RolesController::class, 'createRole'])->name('create-role');
            Route::get('roles', [RolesController::class, 'getRoles']);
            Route::post('permission', [RolesController::class, 'createPermission'])->name('create-permission');
            Route::get('permissions', [RolesController::class, 'getPermissions']);
            Route::post('give-to-role', [RolesController::class, 'givePermissionsToRole']);
            Route::post('give-to-role', [RolesController::class, 'givePermissionsToRole']);
            //Categories Controller
            Route::post('create-category', [CategoriesController::class, 'create']);
            Route::delete('delete-category/{id}', [CategoriesController::class, 'delete']);
            //Extensions
            //Slider Extension
            Route::post('add-to-slider', [ExtensionsController::class, 'addToSlider']);
        });
        //super-admin, admin, seller
        Route::group(['middleware' => ['role:super-admin|admin|seller']], function () {
            //Products Controller
            Route::group(['prefix' => 'product', 'controller' => ProductsController::class], function () {
                Route::post('create', 'create');
                Route::post('update', 'update');
                Route::delete('delete/{title}', 'delete');
            });
        });
        //Customer
        Route::group(['middleware' => ['role:customer']], function () {
            //Cart Controller
            Route::group(['prefix' => 'cart', 'controller' => CartController::class], function () {
                Route::get('/', 'index');
                Route::post('create-or-update', 'createOrUpdate');
                Route::get('delete/{id}', 'delete');
            });
            //Favourites Controller
            Route::group(['prefix' => 'favourites'], function () {
                Route::get('/', [FavouritesController::class, 'index']);
                Route::post('create-or-delete', [FavouritesController::class, 'createOrDelete']);
            });
            //Customer Orders Controller
            Route::group(['prefix' => 'customer-orders'], function () {
                Route::get('/', [OrdersController::class, 'customerOrders']);
                Route::delete('delete/{id}', [OrdersController::class, 'delete']);
            });
            //Shipping Addresses Controller
            Route::group(['prefix' => 'shipping-addresses'], function () {
                Route::get('/', [UserController::class, 'shippingAddresses']);
                Route::post('create', [UserController::class, 'addShippingAddress']);
                Route::post('update', [UserController::class, 'updateShippingAddress']);
            });
        });
        //Any user
        Route::get('logout', [UserController::class, 'logout']);
    });

    //Routes no need auth
    Route::get('slider', [ExtensionsController::class, 'slider']);
    //Products
    Route::group(['controller' => ProductsController::class], function () {
        Route::get('products', [ProductsController::class, 'products']);
        Route::get('products/{title}', [ProductsController::class, 'product']);
        Route::get('products/categories/{name}', [ProductsController::class, 'productsByCategory']);
        Route::get('category-with-products', [ProductsController::class, 'categoryWithProducts']);
    });
    //Categories
    Route::get('categories', [CategoriesController::class, 'index']);
    Route::get('categories/{name}', [CategoriesController::class, 'show']);
    //Brands
    Route::get('brands', [BrandsController::class, 'index']);
    Route::get('brands/{name}', [BrandsController::class, 'show']);
    //Places
    Route::group(['controller' => PlacesController::class], function () {
        Route::get('countries', 'countries');
        Route::get('regions/{country_name}', 'regions');
        Route::get('cities/{region_name}', 'cities');
    });
    //Payment
    Route::group(['prefix' => 'payment', 'controller' => PaymentController::class], function () {
        Route::get('/', 'payment')->name('payment')->middleware('auth:sanctum');
        Route::get('success', 'success')->name('payment.success');
        Route::get('canceled', 'canceled')->name('payment.cancel');
    });
});
