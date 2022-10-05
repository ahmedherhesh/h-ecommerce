<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\MasterAPIController;
use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;

class OrdersController extends MasterAPIController
{
    function payment(){
        
    }
    function create(Request $request){
        $data = $request->all();
        $data['customer_id'] = $this->user->id;
        $order = Order::create($data);
        return $this->response($order,'Your Order In Processing');
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
