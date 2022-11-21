<?php

namespace App\Http\Controllers\API\Customer;

use App\Http\Controllers\API\MasterAPIController;
use App\Http\Requests\API\CartRequest;
use App\Http\Resources\API\CartResource;
use App\Models\Cart;
use App\Models\Product;

class CartController extends MasterAPIController
{
    function index()
    {
        $cart = Cart::whereUserId($this->user->id)->get();
        return $this->response($cart, CartResource::collection($cart));
    }
    function createOrUpdate(CartRequest $request)
    {
        $data = $request->all();
        $data['user_id'] = $this->user->id;
        
        $product = Product::find($request->product_id);
        $cart = Cart::whereProductId($product->id)->whereUserId($this->user->id)->first();
        $success_msg = 'This product has been add to your cart';
        if ($cart) {
            if ($request->qty + $cart->qty > $product->stock)
                return response()->json(ucwords('this quantity is not avaliable for this product'));
            $updateCart = $cart->update($data);
            return $this->response($updateCart, $success_msg);
        } else {
            if ($request->qty > $product->stock)
                return response()->json(ucwords('this quantity is not avaliable for this product'));
            $addToCart = Cart::create($data);
            return $this->response($addToCart, $success_msg);
        }
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
