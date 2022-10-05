<?php

namespace App\Http\Controllers\API\Admin;

use App\Http\Controllers\API\MasterAPIController;
use App\Models\Image;
use Illuminate\Http\Request;

class ExtensionsController extends MasterAPIController
{
    //Slider
    function addToSlider(Request $request)
    {
        $slider = Image::create(['type' => 'slider', 'images' => $request->images, 'model_id' => 1]);
        return $this->response($slider, 'Success');
    }
    function slider(){
        $slider = Image::whereType('slider')->first();
        return $this->response($slider, json_decode($slider->images));
    }
}
