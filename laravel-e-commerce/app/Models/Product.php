<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'category_id',
        'title',
        'description',
        'price',
        'currency',
        'stock',
        'status'
    ];

    function myImages(){
        return $this->hasOne(Image::class,'model_id');
    }
    function category(){
        return $this->belongsTo(Category::class);
    }
}
