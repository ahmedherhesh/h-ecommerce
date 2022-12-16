<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\MasterAPIController;
use App\Http\Resources\API\CustomerOrderResource;
use App\Models\Order;
use App\Models\Payment;
use Illuminate\Http\Request;

class OrdersController extends MasterAPIController
{
    function getOrders(array $conditions)
    {
        $orders = Order::where($conditions)->get();
        return $orders;
    }
    function customerOrders()
    {
        $payments = Payment::where('user_id', $this->user->id)->get();
        return $this->response($payments, CustomerOrderResource::collection($payments));
    }
    function sellerOrders()
    {
        $orders = $this->getOrders(['seller_id' => $this->user->id]);
        return $this->response($orders, $orders);
    }
    function update()
    {
    }
    function delete()
    {
    }
}
