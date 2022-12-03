<?php

namespace App\Http\Controllers\API\Admin;

use App\Http\Controllers\API\MasterAPIController;
use App\Models\Brand;
use Illuminate\Http\Request;
class BrandsController extends MasterAPIController
{
    function index(){
        return Brand::get();
    }
}
