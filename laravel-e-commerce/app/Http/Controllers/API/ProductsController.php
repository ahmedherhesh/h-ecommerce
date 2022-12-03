<?php

namespace App\Http\Controllers\API;

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
        $categories = [];
        foreach (Category::whereParentId(0)->get(['id', 'name']) as $cat) {
            if ($cat->products->count()) $categories[] = $cat;
        }
        return $this->response($categories, CategoryResource::collection($categories));
    }

    function create(Request $request)
    {
        $data = $request->all();
        $data['user_id'] = $this->user->id;
        $data['status']  = $this->user->hasAnyRole(['super-admin', 'admin']) ? 1 : 0;
        $data['keyword'] = strtolower(str_replace(' ', '-', $data['title']));
        // return $data;
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

    function product($keyword)
    {
        $product = Product::whereKeyword($keyword)->whereStatus(1)->first();
        return $this->response($product, new ProductResource($product));
    }

    function update(Request $request)
    {
        $data = $request->except('images');
        $product = Product::whereKeyword($request->keyword);
        if (!$this->user->hasAnyRole(['super-admin', 'admin']))
            $product = $product->whereUserId($this->user->id);
        $product = $product->first();
        if ($product) {
            $image_data = [
                'type' => 'product',
                'model_id' => $product->id,
                'images' => $request->images
            ];
            $images = Image::whereType('product')->whereModelId($product->id)->first();
            if ($images) {
                $images->update($image_data);
            } else {
                $images = Image::create($image_data);
            }
            $update_product = $product->update($data);
        }
        return $this->response($update_product, "product was updated");
    }

    function delete($keyword)
    {
        $product = Product::whereKeyword($keyword);
        if (!$this->user->hasAnyRole(['super-admin', 'admin']))
            $product = $product->whereUserId($this->user->id);
        $product = $product->first();
        if ($product)
            $delete_product =  $product->delete();
        return $this->response($delete_product, "product was deleted");
    }
}
