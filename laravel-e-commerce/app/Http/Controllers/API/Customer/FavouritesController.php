<?php

namespace App\Http\Controllers\API\Customer;

use App\Http\Controllers\API\MasterAPIController;
use App\Http\Controllers\Controller;
use App\Models\Favourite;
use App\Models\Product;
use Illuminate\Http\Request;

class FavouritesController extends MasterAPIController
{
    function index()
    {
        $favourites = Favourite::whereUserId($this->user->id)->get(['product_id']);
        $products   = Product::whereIn('id', $favourites)->get();
        return $products;
    }
    function create(Request $request)
    {
        $data               = $request->all();
        $data['user_id']    = $this->user->id;
        $favourite          = Favourite::whereProductId($data['product_id'])->first();
        if ($favourite) return;
        $add_favourite      = Favourite::create($data);
        return $this->response($add_favourite, 'success');
    }
    function delete($id)
    {
        $favourite = Favourite::find($id);
        $del_fav   = false;
        if ($favourite) {
            $del_fav = $favourite->delete();
        }
        return $this->response($del_fav, 'Favourite has been deleted');
    }
}
