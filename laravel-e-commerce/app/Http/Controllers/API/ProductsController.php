<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Image;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductsController extends MasterAPIController
{

    function productsByCategory($category)
    {
    }

    function categoryWithProducts()
    {
    }

    function create(Request $request)
    {
        $data = $request->all();
        $data['user_id'] = $this->user->id;

        $product = Product::create($data);
        if ($product) {
            $image_data = [
                'type' => 'product',
                'model_id' => $product->id,
                'images' => $request->images
            ];
            $images = Image::create($image_data);
        }

        return $this->response($product, $product);
    }

    function products()
    {
        $products = Product::whereStatus(1)->get();
        return $this->repsonse($products, $products);
    }

    function product($product)
    {
        $product = Product::whereTitle($product)->first();
        return $this->repsonse($product, $product);
    }

    function update()
    {
    }

    function delete()
    {
    }
}
