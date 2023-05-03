<?php

use App\Http\Controllers\Web\UserController;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
Route::get('login', [UserController::class, 'login'])->name('login');
Route::post('login', [UserController::class, '_login'])->name('login_post');

Route::group(['prefix' => 'admin'], function () {
    Route::get('/', function (Request $request) {
        return $request->session()->get('user');
    });
});
