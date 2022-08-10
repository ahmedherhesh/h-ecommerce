import React, { Component } from 'react';
import moto from '../../moto.jpg';
import { FaPlus, FaMinus, FaTrashAlt } from 'react-icons/fa';

class Cart extends Component {
    state = {}
    render() {
        return (
            <div className='container mt-5'>
                <div className="row">
                        <div className="row">
                            <div className="col-lg-9 col-sm-12 bg-white p-3 cart-left-col" style={{ height: 591, overflowY: 'auto' }}>
                                <div className='cart-header d-flex justify-content-between'>
                                    <h3>Shopping Cart</h3>
                                    <h4>5 Items</h4>
                                </div>
                                {
                                    [1, 2, 3, 4, 5].map((item, i) => {
                                        return(
                                        <div key={++i} className="row cart-product p-2">
                                            <div className="product-img col-2">
                                                <img className='w-100' src={moto} alt="" />
                                            </div>
                                            <div className="product-details col-10 row">
                                                <p className="title col-5">
                                                    {"Samsung Galaxy A52 - 6.5 256GB/8GB Dual Sim Mobile Phone - Awesome White".slice(0, 50)}
                                                </p>
                                                <div className="qty col-3">
                                                    <span className="decrement"><FaMinus /></span>
                                                    <span className="qty m-2">1</span>
                                                    <span className="increment m-1"><FaPlus /></span>
                                                </div>
                                                <p className='price m-0 col-2'>EGP 8,490.00</p>
                                                <p className='total-price m-0 col-2'>EGP 8,490.00</p>
                                            </div>
                                        </div>
                                        )
                                    })
                                }
                            </div>
                            <div className="col-lg-3 col-sm-12 bg-light p-3 cart-right-col" style={{ height: 'fit-content' }}>
                                <h3>Order Summary</h3>
                                <hr />
                                <div className="details row">
                                    <span className="items-count col text-left">Items 3</span>
                                    <span className="total-price col text-end">EGP 8,490.00</span>
                                </div>
                                <div className="shipping mt-4">
                                    <p>Shipping</p>
                                    <select className='w-100 p-2' style={{ border: 'none', outline: 'none' }}>
                                        <option value='0' defaultValue>Standard Delivery</option>
                                        <option value="1">One</option>
                                        <option value="2">Two</option>
                                        <option value="3">Three</option>
                                    </select>
                                </div>
                                <div className="promo-code mt-4">
                                    <p >Promo Code</p>
                                    <form action="">
                                        <input type="text" className='input-style w-100 mt-0 bg-white' placeholder='Enter your code' />
                                        <button type="submit" className='btn-style mt-3 mb-5 w-50'>Apply</button>
                                    </form>
                                </div>
                                <hr />
                                <div className="checkout">
                                    <div className="total-cost row">
                                        <p className="items-count col">Total Cost</p>
                                        <p className="total-price col text-end">EGP 8,490.00</p>
                                        <button type='submit' className="btn-style mt-2">Checkout</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        )
    }
}

export default Cart;