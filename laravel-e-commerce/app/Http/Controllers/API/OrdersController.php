<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\MasterAPIController;
use App\Models\Order;
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
        $orders = $this->getOrders(['customer_id' => $this->user->id]);
        return $this->response($orders, $orders);
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
