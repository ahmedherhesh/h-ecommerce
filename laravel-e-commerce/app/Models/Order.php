<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;
    protected $fillable = [
        'seller_id',
        'customer_id',
        'product_id',
        'qty',
        'price',
        'shipping',
        'shipping_currency',
        'total_price',
        'status'
    ];
}
