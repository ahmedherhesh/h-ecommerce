<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    protected $fillable = ['user_id','parent_id','name','image'];
    function products(){
        return $this->hasMany(Product::class);
    }
    function setImageAttribute($image){
        $image_name =  rand(1000, 9999) . time() . '.' . $image->extension();
        $image->move(public_path("uploads/categories"), $image_name);
        $this->attributes['image'] = $image_name;
    }
    function getImageAttribute($image){
        return !empty($image) ? asset("uploads/categories/{$image}") : null;
    }
}
