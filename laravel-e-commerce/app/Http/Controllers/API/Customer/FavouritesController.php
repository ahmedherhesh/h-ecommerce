<?php

namespace App\Http\Controllers\API\Customer;

use App\Http\Controllers\API\MasterAPIController;
use App\Http\Controllers\Controller;
use App\Http\Resources\API\ProductsResource;
use App\Models\Favourite;
use App\Models\Product;
use Illuminate\Http\Request;

class FavouritesController extends MasterAPIController
{
    function index()
    {
        $favourites = Favourite::whereUserId($this->user->id)->get(['product_id']);
        $products   = Product::whereIn('id', $favourites)->get();
        return $this->response($products, ProductsResource::collection($products));
    }

    function createOrDelete(Request $request)
    {
        $data               = $request->all();
        $data['user_id']    = $this->user->id;
        $favourite          = Favourite::whereProductId($data['product_id'])->first();
        if ($favourite)
            return $this->response($favourite->delete(), 'Succefully deleted from favourite');
        $add_favourite      = Favourite::create($data);
        return $this->response($add_favourite, 'Succefully added to favourite');
    }
}
