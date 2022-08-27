<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Product;
use Illuminate\Http\Request;

class CartController extends MasterAPIController
{
    function index()
    {
        $cart = Cart::whereUserId($this->user->id)->get();
        return $this->response($cart, $cart);
    }
    function createOrUpdate(Request $request)
    {
        $product = Product::find($request->product_id);
        if ($product) {
            $data = $request->all();
            $data['user_id'] = $this->user->id;
            $cart = Cart::whereProductId($product->id)->whereUserId($this->user->id)->first();
            if ($cart) {
                if ($request->qty + $cart->qty > $product->stock)
                    return response()->json(ucwords('this quantity is not avaliable for this product'));
                $updateCart = $cart->update($data);
                return $this->response($updateCart, $cart);
            } else {
                if ($request->qty > $product->stock)
                    return response()->json(ucwords('this quantity is not avaliable for this product'));
                $addToCart = Cart::create($data);
                return $this->response($addToCart, $addToCart);
            }
        }
        return response()->json('This Product Is Not Available');
    }
    function delete($id)
    {
        $cart = Cart::find($id);
        if ($cart) {
            $cart = $cart->delete();
            return response($cart, 'This Cart Was Deleted');
        }
    }
}
