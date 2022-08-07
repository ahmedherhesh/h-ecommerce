import React, { Component } from 'react';
import moto from '../moto.jpg';
import {Link} from "react-router-dom";
import { FaPlus, FaMinus, FaTrashAlt } from 'react-icons/fa';

class Cart extends Component {
    state = {}
    render() {
        return (
            <div className='container'>
                <div className="row">

                    {
                        [0, 1, 2].map((d, i) => {

                            return (
                                <React.Fragment>

                                    <div className="product row col-9 rounded bg-white justify-content-around p-0 m-1">
                                        <div className='row col-9'>
                                            <img className='img col-1' src={moto} alt="" />
                                            <h3 className="title col">
                                                Samsung Galaxy A52 - 6.5 256GB/8GB Dual Sim Mobile Phone - Awesome White
                                            </h3>
                                        </div>
                                        <div className="price-section col-3 text-end">
                                            <p className="price">EGP 8,490.00</p>
                                            <p className="old-price">EGP 8,990.00</p><span className='discount'> -6%</span>
                                        </div>
                                        <div className="row justify-content-between p-2 p-r-0">
                                            <span className="trash-btn btn col-2 text-start"> <FaTrashAlt /> Remove</span>
                                            <div className="counter col-2 text-end">
                                                <span className="decrement"><FaMinus /></span>
                                                <span className="qty m-2">1</span>
                                                <span className="increment m-1"><FaPlus /></span>
                                            </div>
                                        </div>
                                    </div>
                                    {i === 0 ?
                                        <div className='col-2 bg-white p-2 rounded'>
                                            <h4>Cost</h4>
                                            <hr />
                                            <span> Total : EGP 8,490.00 </span>
                                            <Link to="/register" className="btn btn-secondary d-block m-0">Checkout</Link>
                                        </div>
                                    : ''}

                                </React.Fragment>

                            )
                        })
                    }
                </div>
            </div>
        )
    }
}

export default Cart;