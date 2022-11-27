<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\MasterAPIController;
use App\Models\Order;
use Illuminate\Http\Request;

class OrdersController extends MasterAPIController
{
    function create(){        
        $data['customer_id'] = $this->user->id;
        return $data['order_details'];
        $order = Order::create($data);
        if($order) return 200;
    }
    function customerOrders(){
        $orders = Order::whereUserId($this->user->id)->get();
        return $this->response($orders,$orders);
    }
    function sellerOrders(){
        $orders = Order::whereSellerId($this->user->id)->get();
        return $this->response($orders,$orders);
    }
    function update(){

    }
    function delete(){

    }
}
