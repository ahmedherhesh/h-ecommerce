<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    use HasFactory;
    protected $fillable = ['type', 'model_id', 'images'];

    function getImagesAttribute($images)
    {
        $imgs = [];
        $images = json_decode($images);
        if ($images)
            foreach ($images as $image) {
                $imgs[] = asset("uploads/{$this->type}/{$this->model_id}/$image");
            }
        return $this->attributes['images'] = $imgs;
    }

    function setImagesAttribute($images)
    {
        $imgs = [];
        foreach ($images as $image) {
            if (gettype($image) != 'string') {
                $image_name =  rand(1000, 9999) . time() . '.' . $image->extension();
                $image->move(public_path("uploads/{$this->type}/{$this->model_id}"), $image_name);
                $imgs[] = $image_name;
            }
        }
        $this->attributes['images'] = json_encode($imgs);
    }
}
