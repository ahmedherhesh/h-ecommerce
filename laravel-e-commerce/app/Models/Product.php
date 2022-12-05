<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\Sanctum;

class Product extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'category_id',
        'brand_id',
        'title',
        'keyword',
        'description',
        'price',
        'currency',
        'stock',
        'status'
    ];

    function myImages(){
        return $this->hasOne(Image::class,'model_id')->whereType('product');
    }
    function category(){
        return $this->belongsTo(Category::class);
    }
    function inFavourites(){
        return $this->hasMany(Favourite::class);
    }
}
