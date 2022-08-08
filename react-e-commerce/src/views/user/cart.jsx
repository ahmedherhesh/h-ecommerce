import React, { Component } from 'react';
import moto from '../../moto.jpg';
import { FaPlus, FaMinus, FaTrashAlt } from 'react-icons/fa';

class Cart extends Component {
    state = {}
    render() {
        return (
            <div className='container mt-5'>
                <div className="row">
                    <React.Fragment>
                        <div className="row">
                            <div className="col-9 bg-white p-3 cart-left-col" style={{height:591,overflowY:'auto'}}>
                                <section className='d-flex justify-content-between'>
                                    <h3>Shopping Cart</h3>
                                    <h4>3 Items</h4>
                                </section>
                                <hr />
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Product details</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {
                                            [0, 1, 2, 3, 4].map((item, i) => {
                                                return (
                                                    <tr>
                                                        <td className="row">
                                                            <img className='img col-4' src={moto} alt="" />
                                                            <section className='col-8'>
                                                                <h3 className="title fs-5 fw-normal pt-3">
                                                                    {"Samsung Galaxy A52 - 6.5 256GB/8GB Dual Sim Mobile Phone - Awesome White".slice(0, 30)}
                                                                </h3>
                                                                <span className="trash-btn col-2 text-start" style={{ cursor: 'pointer' }}> <FaTrashAlt /></span>
                                                            </section>
                                                        </td>
                                                        <td className="counter col-2">
                                                            <span className="decrement"><FaMinus /></span>
                                                            <span className="qty m-2">1</span>
                                                            <span className="increment m-1"><FaPlus /></span>
                                                        </td>
                                                        <td className='col-2'>
                                                            <p className="price mb-0">EGP 8,490.00</p>
                                                        </td>
                                                        <td className='col-2'>
                                                            <p className="total mb-0">EGP 8,490.00</p>
                                                        </td>
                                                    </tr>
                                                )
                                            })
                                        }
                                    </tbody>
                                </table>
                            </div>
                            <div className="col-3 bg-light p-3 cart-right-col" style={{height:'fit-content'}}>
                                <h3>Order Summary</h3>
                                <hr />
                                <div className="details row">
                                    <span className="items-count col text-left">Items 3</span>
                                    <span className="total-price col text-end">EGP 8,490.00</span>
                                </div>
                                <div className="shipping mt-4">
                                    <p>Shipping</p>
                                    <select className='w-100 p-2' style={{border: 'none', outline: 'none'}}>
                                        <option selected>Standard Delivery</option>
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
                    </React.Fragment>
                </div>
            </div>
        )
    }
}

export default Cart;