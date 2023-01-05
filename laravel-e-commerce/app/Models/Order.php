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
        'payment_id',
        'qty',
        'price',
        'shipping',
        'shipping_address_id',
        'currency',
        'total_price',
        'payment_method',
        'status'
    ];
    function product()
    {
        return $this->belongsTo(Product::class);
    }
}
