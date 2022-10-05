<?php

namespace App\Http\Controllers\API\Admin;

use App\Http\Controllers\API\MasterAPIController;
use App\Http\Resources\API\ProductResource;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;

class CategoriesController extends MasterAPIController
{
    function create(Request $request)
    {
        $data = $request->all();
        $data['user_id'] = $this->user->id;
        $category = Category::create($data);
        return $this->response($category, $category);
    }
    function index()
    {
        $categories = Category::all(['name','image','parent_id']);
        return $this->response($categories, $categories);
    }
    function delete($name)
    {
        $category = Category::whereName($name)->first();
        $category_del = $category ? $category->delete() : '';
        return $this->response($category_del, 'Success', 'Category is not found');
    }
}
