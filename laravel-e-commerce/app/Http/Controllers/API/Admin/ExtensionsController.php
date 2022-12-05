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
        $data = ['type' => 'slider', 'model_id' => 1, 'images' => $request->images];
        $slider = Image::whereType('slider')->first();
        if ($slider) :
            $slider = $slider->update($data);
        else :
            $slider = Image::create($data);
        endif;
        return $this->response($slider, 'Success');
    }
    function slider()
    {
        $slider = Image::whereType('slider')->first();
        if ($slider)
            return $slider->images;
    }
}
