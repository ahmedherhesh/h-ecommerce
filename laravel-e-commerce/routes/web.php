<?php

use App\Http\Controllers\PaymentController;
use Illuminate\Support\Facades\Route;

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
Route::group(['prefix' => 'payment'], function () {
    Route::get('/', [PaymentController::class, 'payment']);
    Route::get('success', [PaymentController::class, 'success'])->name('payment.success');
    Route::get('canceled', [PaymentController::class, 'canceled'])->name('payment.cancel');
});
