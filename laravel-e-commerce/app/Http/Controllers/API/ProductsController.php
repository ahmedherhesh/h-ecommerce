<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\API\CategoryResource;
use App\Http\Resources\API\ProductResource;
use App\Models\Category;
use App\Models\Image;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductsController extends MasterAPIController
{

    function productsByCategory($category)
    {
        $category = Category::whereName($category)->first();
        if ($category) {
            $products = Product::whereStatus(1)->whereCategoryId($category->id)->paginate(5);
            return $this->response($products, ProductResource::collection($products));
        }
        return response()->json('Not Found', 404);
    }

    function categoryWithProducts()
    {
        $categories = Category::whereParentId(0)->get(['id', 'name']);
        return $this->response($categories, CategoryResource::collection($categories));
    }

    function create(Request $request)
    {
        $data = $request->all();
        $data['user_id'] = $this->user->id;
        $data['status']  = $this->user->hasAnyRole(['super-admin', 'admin']) ? 1 : 0;

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
        $products = Product::whereStatus(1)->paginate(15);
        return $this->response($products, ProductResource::collection($products));
    }

    function product($title)
    {
        $product = Product::whereTitle($title)->whereStatus(1)->first();
        return $this->response($product, new ProductResource($product));
    }

    function update()
    {
    }

    function delete($title)
    {
        $product = Product::whereTitle($title);
        if (!$this->user->hasAnyRole(['super-admin', 'admin']))
            $product->whereUserId($this->user->id);
        $product->first();
        if ($product) $delete_product =  $product->delete();
        return $this->response($delete_product, "product was deleted");
    }
}
