<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Payment extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id', 'payment_id', 'payer_id', 'payer_email', 
        'amount', 'fee_amount', 'currency', 'payment_status'
    ];
    function orders(){
        return $this->hasMany(Order::class);
    }
}
